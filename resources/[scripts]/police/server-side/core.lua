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
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Reduces = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHTTPHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
SetHttpHandler(function(Request,Callback)
	local ReturnVar = "Ok"
	if Request["path"] == "/prison" then
		if Request["headers"]["auth"] == "creAuthMdtInfos" then
			local Fines = parseInt(Request["headers"]["fines"])
			local Services = parseInt(Request["headers"]["services"])
			local Passport = parseInt(Request["headers"]["passport"])
			local source = vRP.Source(Passport)

			if Services > 0 then
				vRP.InitPrison(source,Passport,Services)

				if source then
					vRP.Teleport(source,1691.53,2565.91,45.56)
				end
			end

			if Fines > 0 then
				vRP.GiveFine(Passport,Fines,source)
			end
		end
	end

	if Request["path"] == "/services" then
		if Request["headers"]["auth"] == "creAuthMdtInfos" then
			local Passport = parseInt(Request["headers"]["passport"])
			local Identity = vRP.Identity(Passport)
			if Identity then
				ReturnVar = Identity["name"].."-"..Identity["name2"].."-"..Identity["phone"].."-"..Identity["sex"].."-"..Identity["fines"].."-"..Identity["prison"]
			end
		end
	end

	if Request["path"] == "/cops" then
		if Request["headers"]["auth"] == "creAuthMdtInfos" then
			local Service = vRP.NumPermission("Police")
			ReturnVar = json.encode(Service)
		end
	end

	Callback.writeHead(200,{
		["Content-Type"] = "application/json",
		["Access-Control-Allow-Origin"] = "*",
		["Access-Control-Allow-Headers"] = "*",
		["Access-Control-Request-Headers"] = "*",
		["Access-Control-Allow-Methods"] = "GET,HEAD,PUT,PATCH,POST,DELETE"
	})

	Callback.send(ReturnVar)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local Preset = {
	["mp_m_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 145, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 395, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 83, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 152, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 14, texture = 0 },
		["torso"] = { item = 418, texture = 0 },
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
-- POLICE:REDUCES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Reduces")
AddEventHandler("police:Reduces",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Identity = vRP.Identity(Passport)
		if parseInt(Identity["prison"]) > 0 then
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
	Reduces[Number][Passport] = os.time() + 600
	Player(source)["state"]["Buttons"] = true
	Player(source)["state"]["Cancel"] = true
	local timeProgress = 10

	repeat
		Wait(1000)
		timeProgress = timeProgress - 1
	until timeProgress <= 0

	vRP.UpdatePrison(Passport,source,math.random(2))
	Player(source)["state"]["Buttons"] = false
	Player(source)["state"]["Cancel"] = false
	vRPC.removeObjects(source)
end