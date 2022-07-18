-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("spawn",cRP)
vCLIENT = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local charActived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getCharacters()
	local source = source
	local characterList = {}
	local License = vRP.Identities(source)
	local consult = vRP.Query("characters/Characters",{ license = License })

	SetPlayerRoutingBucket(source,source)

	if consult[1] then
		for k,v in pairs(consult) do
			local Datatable = vRP.userData(v["id"],"Datatable")
			if Datatable then
				table.insert(characterList,{
					["Passport"] = v["id"],
					["skin"] = Datatable["Skin"],
					["name"] = v["name"].." "..v["name2"],
					["clothes"] = vRP.userData(v["id"],"Clothings"),
					["barber"] = vRP.userData(v["id"],"Barbershop"),
					["tattoos"] = vRP.userData(v["id"],"Tatuagens")
				})
			end
		end
	end

	return characterList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.characterChosen(Passport)
	local source = source
	local License = vRP.Identities(source)
	local Consult = vRP.Query("characters/UserLicense",{ id = Passport, license = License })
	if Consult[1] then
		SetPlayerRoutingBucket(source,0)
		vRP.CharacterChosen(source,Passport,nil)
	else
		DropPlayer(source,"Conectando em personagem irregular.")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.newCharacter(name,name2,sex)
	local source = source
	if charActived[source] == nil then
		charActived[source] = true

		local License = vRP.Identities(source)
		local Account = vRP.Account(License)
		local amountCharacters = parseInt(Account["chars"])
		local myChars = vRP.Query("characters/countPersons",{ license = License })

		if vRP.LicensePremium(License) then
			amountCharacters = amountCharacters + 2
		end

		if parseInt(amountCharacters) <= parseInt(myChars[1]["qtd"]) then
			TriggerClientEvent("Notify",source,"amarelo","Limite de personagens atingido.",3000)
			charActived[source] = nil
			return
		end

		if sex == "mp_m_freemode_01" then
			vRP.Execute("characters/newCharacter",{ license = License, name = name, name2 = name2, sex = "M", phone = vRP.GeneratePhone(), blood = math.random(4) })
		else
			vRP.Execute("characters/newCharacter",{ license = License, name = name, name2 = name2, sex = "F", phone = vRP.GeneratePhone(), blood = math.random(4) })
		end

		local consult = vRP.Query("characters/lastCharacters",{ license = License })
		if consult[1] then
			vRP.Execute("bank/newAccount",{ Passport = consult[1]["id"], dvalue = 2000, mode = "Private", owner = 1 })
			vRP.CharacterChosen(source,consult[1]["id"],sex)
			SetPlayerRoutingBucket(source,0)
			vCLIENT.closeNew(source)
		end

		charActived[source] = nil
	end
end