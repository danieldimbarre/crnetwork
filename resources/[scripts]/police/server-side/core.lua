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
cRP = {}
Tunnel.bindInterface("police",cRP)
vCLIENT = Tunnel.getInterface("police")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPRARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("prison/cleanRecords","DELETE FROM prison WHERE nuser_id = @nuser_id")
vRP.Prepare("prison/getRecords","SELECT * FROM prison WHERE nuser_id = @nuser_id ORDER BY id DESC")
vRP.Prepare("prison/insertPrison","INSERT INTO prison(police,nuser_id,services,fines,text,date) VALUES(@police,@nuser_id,@services,@fines,@text,@date)")
vRP.Prepare('prison/create',[[CREATE TABLE IF NOT EXISTS `prison` (
		`id` int(11) NOT NULL AUTO_INCREMENT,
		`police` varchar(255) DEFAULT '0',
		`nuser_id` int(11) NOT NULL DEFAULT '0',
		`services` int(11) NOT NULL DEFAULT '0',
		`fines` int(20) NOT NULL DEFAULT '0',
		`text` longtext,
		`date` text,
		PRIMARY KEY (`id`),
		KEY `id` (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
]])
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATETABLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	vRP.Query('prison/create')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local prisonMarkers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local Preset = {
	["mp_m_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 149, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 421, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 83, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 159, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 14, texture = 0 },
		["torso"] = { item = 462, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 86, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PRISONCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:prisonClothes")
AddEventHandler("police:prisonClothes",function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		local mHash = vRP.ModelPlayer(entity[1])
		if mHash == "mp_m_freemode_01" or mHash == "mp_f_freemode_01" then
			TriggerClientEvent("updateRoupas",entity[1],Preset[mHash])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANREC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cleanrec",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		if vRP.HasPermission(Passport,"Police",1) then
			local OtherPassport = parseInt(Message[1])
			if OtherPassport > 0 then
				vRP.Query("prison/cleanRecords",{ nuser_id = OtherPassport })
				TriggerClientEvent("Notify",source,"verde","Limpeza efetuada.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initPrison(OtherPassport,Services,Value,Message)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if actived[Passport] == nil then
			actived[Passport] = true

			local Identity = vRP.Identity(Passport)
			if Identity then
				local OtherSource = vRP.Source(OtherPassport)
				if OtherSource then
					vCLIENT.syncPrison(OtherSource,true,false)
					TriggerClientEvent("hud:RadioClean",OtherSource)
				end

				vRP.Query("prison/insertPrison",{ police = Identity["name"].." "..Identity["name2"], nuser_id = parseInt(OtherPassport), services = Services, fines = Value, text = Message, date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M") })
				vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",source,"verde","Prisão efetuada.",5000)
				TriggerClientEvent("police:Update",source,"reloadPrison")
				vRP.InitPrison(OtherPassport,Services)

				if Value > 0 then
					exports["bank"]:AddFines(OtherPassport,Passport,Value,Message)
				end

				TriggerEvent("Discord","Police","**Policial:** "..parseFormat(Passport).."\n**Passaporte:** "..parseFormat(OtherPassport).."\n**Serviços:** "..parseFormat(Services).."\n**Multa:** $"..parseFormat(Value).."\n**Motivo:** "..Message,13541152)
			end

			actived[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchUser(Passport)
	local source = source
	if Passport then
		local Identity = vRP.Identity(Passport)
		if Identity then
			local Fines = exports["bank"]:Fines(Passport)
			local Value = 0

			for _,v in pairs(Fines) do
				Value = Value + v["value"]
			end

			local Records = vRP.Query("prison/getRecords",{ nuser_id = Passport })
			return { true,Identity["name"].." "..Identity["name2"],Identity["phone"],Value,Records }
		end
	end

	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initFine(OtherPassport,Value,Message)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Value > 0 then
		if actived[Passport] == nil then
			actived[Passport] = true

			TriggerEvent("Discord","Police","**Por:** "..parseFormat(Passport).."\n**Passaporte:** "..parseFormat(OtherPassport).."\n**Multa:** $"..parseFormat(Value).."\n**Motivo:** "..Message,2316674)
			TriggerClientEvent("Notify",source,"verde","Multa aplicada.",5000)
			TriggerClientEvent("police:Update",source,"reloadFine")
			exports["bank"]:AddFines(OtherPassport,Passport,Value,Message)

			actived[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISONSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		for k,v in pairs(prisonMarkers) do
-- 			if prisonMarkers[k][1] > 0 then
-- 				prisonMarkers[k][1] = prisonMarkers[k][1] - 1

-- 				if prisonMarkers[k][1] <= 0 then
-- 					if vRP.Source(prisonMarkers[k][2]) then
-- 						TriggerEvent("blipsystem:serviceExit",k)
-- 					end

-- 					prisonMarkers[k] = nil
-- 				end
-- 			end
-- 		end

-- 		Citizen.Wait(1000)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.reducePrison()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.UpdatePrison(Passport,math.random(2))

		local Identity = vRP.Identity(Passport)
		if parseInt(Identity["prison"]) <= 0 then
			vCLIENT.syncPrison(source,false,true)
		else
			vCLIENT.asyncServices(source)
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	local Identity = vRP.Identity(Passport)
	if parseInt(Identity["prison"]) > 0 then
		TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(Identity["prison"]).." serviços</b>.",5000)
		vCLIENT.syncPrison(source,true,true)
	end
end)