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
Tunnel.bindInterface("police",Creative)
vCLIENT = Tunnel.getInterface("police")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPRARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("prison/cleanRecords","DELETE FROM prison WHERE nuser_id = @Passport")
vRP.Prepare("prison/getRecords","SELECT * FROM prison WHERE nuser_id = @Passport ORDER BY id DESC")
vRP.Prepare("prison/insertPrison","INSERT INTO prison(police,nuser_id,services,fines,text,date) VALUES(@Police,@Passport,@Services,@Fines,@Text,@Date)")
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
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Actived = {}
local Reduces = {}
local PrisonMarkers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local Preset = {
	["mp_m_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 148, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 24, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 417, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 49, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 158, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 24, texture = 0 },
		["tshirt"] = { item = 14, texture = 0 },
		["torso"] = { item = 459, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 54, texture = 0 },
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
			TriggerClientEvent("skinshop:Apply",entity[1],Preset[mHash])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANREC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cleanrec",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		local OtherPassport = parseInt(Message[1])
		if vRP.HasGroup(Passport,"Police",1) and OtherPassport > 0 then
			vRP.Query("prison/cleanRecords",{ Passport = OtherPassport })
			TriggerClientEvent("Notify",source,"verde","Limpeza efetuada.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANSRV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cleansrv",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		local OtherPassport = parseInt(Message[1])
		if vRP.HasGroup(Passport,"Police",1) and OtherPassport > 0 then
			local OtherSource = vRP.Source(OtherPassport)
			if OtherSource then
				local Consult = vRP.Query("characters/Fugitive",{ id = OtherPassport })
				if Consult[1]["fugitive"] == 1 then
					vRP.Query("characters/setFugitive",{ Passport = OtherPassport, Fugitive = 0 })
				end

				if exports["hud"]:Wanted(OtherPassport) then
					TriggerEvent("Wanted:Remove",source,OtherPassport)
				end

				vRP.Query("characters/resetPrison",{ id = OtherPassport })
				vCLIENT.SyncPrison(OtherSource,false,false)
				TriggerClientEvent("Notify",source,"verde","Liberação efetuada.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.initPrison(OtherPassport,Services,Value,Message)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Actived[Passport] then
			Actived[Passport] = true

			local Identity = vRP.Identity(Passport)
			if Identity then
				local OtherSource = vRP.Source(OtherPassport)
				if OtherSource then
					vCLIENT.SyncPrison(OtherSource,true,true)
					TriggerClientEvent("radio:RadioClean",OtherSource)

					if Player(OtherSource)["state"]["Handcuff"] then
						Player(OtherSource)["state"]["Handcuff"] = false
						Player(OtherSource)["state"]["Commands"] = false
						vRPC.removeObjects(OtherSource)
					end
				end

				vRP.Query("prison/insertPrison",{ Police = Identity["name"].." "..Identity["name2"], Passport = parseInt(OtherPassport), Services = Services, Fines = Value, Text = Message, Date = os.date("%d/%m/%Y").." às "..os.date("%H:%M") })
				vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",source,"verde","Prisão efetuada.",5000)
				TriggerClientEvent("police:Update",source,"reloadPrison")
				vRP.InitPrison(OtherPassport,Identity["prison"] + Services)

				if Value > 0 then
					exports["bank"]:AddFines(OtherPassport,Passport,Value,Message)
				end

				local Consult = vRP.Query("characters/Fugitive",{ id = Passport })
				if Consult[1]["fugitive"] == 1 then
					vRP.Query("characters/setFugitive",{ Passport = Passport, Fugitive = 0 })
				end

				if exports["hud"]:Wanted(Passport) then
					TriggerEvent("Wanted:Remove",source,Passport)
				end

				TriggerEvent("Discord","Polices","**Policial:** "..Passport.."\n**Passaporte:** "..OtherPassport.."\n**Serviços:** "..parseFormat(Services).."\n**Multa:** $"..parseFormat(Value).."\n**Motivo:** "..Message,13541152)
			end

			Actived[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.searchUser(Passport)
	local source = source
	if Passport then
		local Identity = vRP.Identity(Passport)
		if Identity then
			local Fines = exports["bank"]:Fines(Passport)
			local Value = 0

			for _,v in pairs(Fines) do
				Value = Value + v["value"]
			end

			local Wanted = "Não"
			if exports["hud"]:Wanted(Passport) then
				Wanted = "Sim"
			end
			
			local Runaway = "Não"
			local Consult = vRP.Query("characters/Fugitive",{ id = Passport })
			if Consult[1]["fugitive"] == 1 and Identity["prison"] > 0 then
				Runaway = "Sim, deve "..Identity["prison"].." serviços"
			end

			local Records = vRP.Query("prison/getRecords",{ Passport = Passport })
			return { true,Identity["name"].." "..Identity["name2"],Identity["phone"],Value,Wanted,Runaway,Records }
		end
	end

	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.initFine(OtherPassport,Value,Message)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Value > 0 then
		if not Actived[Passport] then
			Actived[Passport] = true

			TriggerEvent("Discord","Polices","**Policial:** "..Passport.."\n**Passaporte:** "..OtherPassport.."\n**Multa:** $"..parseFormat(Value).."\n**Motivo:** "..Message,2316674)
			TriggerClientEvent("Notify",source,"verde","Multa aplicada.",5000)
			TriggerClientEvent("police:Update",source,"reloadFine")
			exports["bank"]:AddFines(OtherPassport,Passport,Value,Message)

			Actived[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISONSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for Passports,_ in pairs(PrisonMarkers) do
			if PrisonMarkers[Passports] > 0 then
				local Source = vRP.Source(Passports)
				if Source then
					PrisonMarkers[Passports] = PrisonMarkers[Passports] - 1

					if PrisonMarkers[Passports] <= 0 then
						TriggerEvent("blipsystem:Exit",Source)

						PrisonMarkers[Passports] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Wanted()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Query("characters/setFugitive",{ Passport = Passport, Fugitive = 1 })
		PrisonMarkers[Passport] = 600
		TriggerEvent("Wanted",source,Passport,600)

		local Service = vRP.NumPermission("Police")
		for Passports,Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("Notify",Sources,"amarelo","Recebemos a informação de um fugitivo da Penitenciária.",5000)
			end)
		end

		TriggerEvent("blipsystem:Enter",source,"Prisioneiro")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:REDUCES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Reduces")
AddEventHandler("police:Reduces",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Identity = vRP.Identity(Passport)
		if Identity["prison"] > 0 then
			if not Reduces[Number] then
				Reduces[Number] = {}
			end

			if Reduces[Number][Passport] then
				if os.time() > Reduces[Number][Passport] then
					reduceFunction(source,Passport,Number)
				else
					TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
				end
			else
				reduceFunction(source,Passport,Number)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEFUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function reduceFunction(source,Passport,Number)
	vRPC.playAnim(source,false,{"amb@prop_human_bum_bin@base","base"},true)
	TriggerClientEvent("Progress",source,"Vasculhando",10000)
	Reduces[Number][Passport] = os.time() + 180
	Player(source)["state"]["Buttons"] = true
	Player(source)["state"]["Cancel"] = true
	local timeProgress = 10

	repeat
		Wait(1000)
		timeProgress = timeProgress - 1
	until timeProgress <= 0

	local Reduce = 5
	local Identity = vRP.Identity(Passport)
	if Identity["prison"] - Reduce <= 0 then
		vCLIENT.SyncPrison(source,false,false)
		vRP.Query("characters/resetPrison",{ id = Passport })

		if exports["hud"]:Wanted(Passport) then
			TriggerEvent("Wanted:Remove",source,Passport)
		end

		local Consult = vRP.Query("characters/Fugitive",{ id = Passport })
		if Consult[1]["fugitive"] == 1 then
			vRP.Query("characters/setFugitive",{ Passport = Passport, Fugitive = 0 })
		end
	end

	vRP.UpdatePrison(Passport,Reduce)
	Player(source)["state"]["Buttons"] = false
	Player(source)["state"]["Cancel"] = false
	vRPC.removeObjects(source)
end
--------------------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	local Identity = vRP.Identity(Passport)
	if Identity["prison"] > 0 then
		TriggerClientEvent("Notify",source,"azul","Restam <b>"..Identity["prison"].." serviços</b>.",5000)

		local Consult = vRP.Query("characters/Fugitive",{ id = Passport })
		if Consult[1]["fugitive"] == 0 then
			vCLIENT.SyncPrison(source,true,false)
		else
			if PrisonMarkers[Passport] then
				PrisonMarkers[Passport] = 600
				TriggerEvent("Wanted",source,Passport,600)

				local Service = vRP.NumPermission("Police")
				for Passports,Sources in pairs(Service) do
					async(function()
						TriggerClientEvent("Notify",Sources,"amarelo","Recebemos a informação de um fugitivo da Penitenciária.",5000)
					end)
				end

				TriggerEvent("blipsystem:Enter",source,"Prisioneiro")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if PrisonMarkers[Passport] then
		TriggerEvent("blipsystem:Exit",source)
	end
end)