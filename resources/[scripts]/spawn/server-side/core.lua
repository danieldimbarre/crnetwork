-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("spawn",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Selected = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNCHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Characters()
	local Character = {}
	local source = source
	local License = vRP.Identities(source)
	local Consult = vRP.Query("characters/Characters",{ license = License })

	TriggerEvent("vRP:BucketServer",source,"Enter",source)

	if Consult[1] then
		for _,v in pairs(Consult) do
			local Datatable = vRP.UserData(v["id"],"Datatable")
			if Datatable then
				table.insert(Character,{
					["Passport"] = v["id"],
					["Skin"] = Datatable["Skin"],
					["Nome"] = v["name"].." "..v["name2"],
					["Sexo"] = v["sex"],
					["Banco"] = v["bank"],
					["Clothes"] = vRP.UserData(v["id"],"Clothings"),
					["Barber"] = vRP.UserData(v["id"],"Barbershop"),
					["Tattoos"] = vRP.UserData(v["id"],"Tatuagens")
				})
			end
		end
	end

	return Character
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CharacterChosen(Passport)
	local source = source
	local License = vRP.Identities(source)
	local Consult = vRP.Query("characters/UserLicense",{ id = Passport, license = License })
	if Consult[1] then
		TriggerEvent("vRP:BucketServer",source,"Exit")
		vRP.CharacterChosen(source,Passport)
	else
		DropPlayer(source,"Conectando em personagem irregular.")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.NewCharacter(Name,Name2,Sex)
	local source = source
	if not Selected[source] then
		Selected[source] = true

		local License = vRP.Identities(source)
		local Account = vRP.Account(License)
		local AmountCharacters = parseInt(Account["chars"])
		local Characters = vRP.Query("characters/countPersons",{ license = License })

		if vRP.LicensePremium(License) then
			AmountCharacters = AmountCharacters + 2
		end

		if parseInt(AmountCharacters) <= parseInt(Characters[1]["qtd"]) then
			TriggerClientEvent("Notify",source,"amarelo","Limite de personagem atingido.",3000)
			Selected[source] = nil
			return
		end

		local Sexo = "F"
		if Sex == "mp_m_freemode_01" then
			Sexo = "M"
		end

		vRP.Query("characters/newCharacter",{ license = License, name = Name, name2 = Name2, sex = Sexo, phone = vRP.GeneratePhone(), blood = math.random(4) })

		local Consult = vRP.Query("characters/lastCharacters",{ license = License })
		if Consult[1] then
			TriggerEvent("vRP:BucketServer",source,"Exit")
			vRP.CharacterChosen(source,Consult[1]["id"],Sex)
			TriggerClientEvent("spawn:Close",source)
		end

		Selected[source] = nil
	end
end