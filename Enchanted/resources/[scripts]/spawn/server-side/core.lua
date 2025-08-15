-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("spawn",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Playing = {}
local Creating = {}
local Connected = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Characters()
	local List = {}
	local source = source

	local License = vRP.Identities(source)
	if not License or Connected[License] then
		DropPlayer(source,"Não foi possível efetuar conexão com a "..(BaseMode == "steam" and "Steam" or "Rockstar")..".")

		return List
	end

	exports.vrp:Bucket(source,"Enter",50000 + source)

	local Consult = vRP.Query("characters/Characters",{ License = License })
	for _,v in ipairs(Consult) do
		local Passport = tonumber(v.id)

		table.insert(List,{
			Passport = Passport,
			Skin = v.Skin,
			Nome = v.Name.." "..v.Lastname,
			Sexo = v.Sex,
			Banco = v.Bank,
			Blood = Sanguine(v.Blood),
			Clothes = vRP.UserData(Passport,"Clothings"),
			Barber = vRP.UserData(Passport,"Barbershop"),
			Tattoos = vRP.UserData(Passport,"Tattooshop")
		})
	end

	return List
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CharacterChosen(Passport)
	local source = source
	if not Playing[source] and Passport then
		Playing[source] = true

		local License = vRP.Identities(source)
		if not License or Connected[License] then
			DropPlayer(source,"Não foi possível efetuar conexão com a "..(BaseMode == "steam" and "Steam" or "Rockstar")..".")

			return false
		end

		local Consult = vRP.SingleQuery("characters/UserLicense",{ Passport = Passport, License = License })
		if Consult and not Connected[Consult.License] then
			vRP.CharacterChosen(source,Passport)
			Connected[Consult.License] = true

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.NewCharacter(Name,Lastname,Sex)
	local source = source
	if not Creating[source] then
		Creating[source] = true

		local License = vRP.Identities(source)
		if not License or Connected[License] then
			DropPlayer(source,"Não foi possível efetuar conexão com a "..(BaseMode == "steam" and "Steam" or "Rockstar")..".")
			Creating[source] = nil

			return false
		end

		local Account = vRP.Account(License)
		if Account and Account.Characters <= vRP.Scalar("characters/Count",{ License = License }) then
			TriggerClientEvent("Notify",source,"Atenção","Limite de personagem atingido.","amarelo",5000)
			Creating[source] = nil

			return false
		end

		local Name = FirstName(Name)
		local Lastname = FirstName(Lastname)
		local Sexo = (Sex == "mp_f_freemode_01") and "F" or "M"
		local Consult = exports.oxmysql:insert_async("INSERT INTO characters (License,Name,Lastname,Sex,Skin,Blood,Created) VALUES (@License,@Name,@Lastname,@Sex,@Skin,@Blood,UNIX_TIMESTAMP() + (86400 * 3))",{ License = License, Name = Name, Lastname = Lastname, Sex = Sexo, Skin = Sex, Blood = math.random(4) })
		if Consult then
			Creating[source] = nil
			vRPC.DoScreenFadeOut(source)
			vRP.CharacterChosen(source,Consult,Sex)

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source,License)
	Connected[License] = nil
	Active[source] = nil
end)