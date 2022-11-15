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
Tunnel.bindInterface("player",Creative)
vCLIENT = Tunnel.getInterface("player")
vSKINSHOP = Tunnel.getInterface("skinshop")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DUITEXTURES
-----------------------------------------------------------------------------------------------------------------------------------------
local DuiTextures = {
	["MRPD"] = {
		["Distance"] = 1.50,
		["Dimension"] = 1.25,
		["Label"] = "Quadro Branco",
		["Permission"] = "Police",
		["Coords"] = vec3(439.47,-985.85,35.99),
		["Link"] = "https://i.imgur.com/A5v5SoM.png",
		["Dict"] = "prop_planning_b1",
		["Texture"] = "prop_base_white_01b",
		["Width"] = 550,
		["Weight"] = 450
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:TEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Texture")
AddEventHandler("player:Texture",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if (DuiTextures[Name]["Permission"] and vRP.HasGroup(Passport,DuiTextures[Name]["Permission"],1)) or not DuiTextures[Name]["Permission"] then
			local Keyboard = vKEYBOARD.keySingle(source,"Link:")
			if Keyboard then
				DuiTextures[Name]["Link"] = Keyboard[1]
				TriggerClientEvent("player:DuiUpdate",-1,Name,DuiTextures[Name])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Stress")
AddEventHandler("player:Stress",function(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.DowngradeStress(Passport,Number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		local message = string.sub(History:sub(4),1,100)

		local Players = vRPC.Players(source)
		for _,v in ipairs(Players) do
			async(function()
				TriggerClientEvent("showme:pressMe",v,source,message,10)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if Message[2] == "friend" then
			local ClosestPed = vRPC.ClosestPed(source,2)
			if ClosestPed then
				if vRP.GetHealth(ClosestPed) > 100 and not Player(ClosestPed)["state"]["Handcuff"] then
					local Identity = vRP.Identity(Passport)
					if vRP.Request(ClosestPed,"Pedido de <b>"..Identity["name"].."</b> da animação <b>"..Message[1].."</b>?","Sim, iniciar animação","Não, sai fora") then
						TriggerClientEvent("emotes",ClosestPed,Message[1])
						TriggerClientEvent("emotes",source,Message[1])
					end
				end
			end
		else
			TriggerClientEvent("emotes",source,Message[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e2",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			if vRP.HasService(Passport,"Paramedic") then
				TriggerClientEvent("emotes",ClosestPed,Message[1])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E3
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e3",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Players = vRPC.ClosestPeds(source,50)
			for _,v in pairs(Players) do
				async(function()
					TriggerClientEvent("emotes",v[2],Message[1])
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Doors")
AddEventHandler("player:Doors",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicle,Network = vRPC.VehicleList(source,5)
		if Vehicle then
			local Players = vRPC.Players(source)
			for _,v in ipairs(Players) do
				async(function()
					TriggerClientEvent("player:syncDoors",v,Network,Number)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("911",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and vRP.GetHealth(source) > 100 then
		if vRP.HasService(Passport,"Police") then
			local Identity = vRP.Identity(Passport)
			local Service = vRP.NumPermission("Police")
			for Passports,Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("chat:ClientMessage",Sources,"<blue>"..Identity["name"].."</blue>",History:sub(4))
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("112",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and vRP.GetHealth(source) > 100 then
		if vRP.HasService(Passport,"Paramedic") then
			local Identity = vRP.Identity(Passport)
			local Service = vRP.NumPermission("Paramedic")
			for Passports,Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("chat:ClientMessage",Sources,"<red>"..Identity["name"].." "..Identity["name2"].."</red>",History:sub(4))
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- P
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("p",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and vRP.GetHealth(source) > 100 then
		if vRP.HasService(Passport,"Police") then
			TriggerClientEvent('smartphone:createSMS',-1,'Polícia',History:sub(2))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- H
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("h",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and vRP.GetHealth(source) > 100 then
		if vRP.HasService(Passport,"Paramedic") then
			TriggerClientEvent('smartphone:createSMS',-1,'Centro Médico',History:sub(2))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.shotsFired(Vehicle)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Vehicle then
			Vehicle = "Disparos de um veículo"
		else
			Vehicle = "Disparos com arma de fogo"
		end

		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		local Service = vRP.NumPermission("Police")
		for Passports,Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("NotifyPush",Sources,{ code = 10, title = Vehicle, x = Coords["x"], y = Coords["y"], z = Coords["z"], blipColor = 6 })
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CARRYPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = {}
RegisterServerEvent("player:carryPlayer")
AddEventHandler("player:carryPlayer",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not vRPC.inVehicle(source) then
			if playerCarry[Passport] then
				TriggerClientEvent("player:playerCarry",playerCarry[Passport],source)
				TriggerClientEvent("player:Commands",playerCarry[Passport],false)
				playerCarry[Passport] = nil
			else
				local ClosestPed = vRPC.ClosestPed(source,2)
				if ClosestPed then
					playerCarry[Passport] = ClosestPed

					TriggerClientEvent("player:playerCarry",playerCarry[Passport],source)
					TriggerClientEvent("player:Commands",playerCarry[Passport],true)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:WINSFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:winsFunctions")
AddEventHandler("player:winsFunctions",function(Mode)
	local source = source
	local vehicle,Network = vRPC.VehicleList(source,10)
	if vehicle then
		TriggerClientEvent("player:syncWins",source,Network,Mode)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CVFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:cvFunctions")
AddEventHandler("player:cvFunctions",function(Mode)
	local Distance = 1
	local source = source

	if Mode == "rv" then
		Distance = 10
	end

	local ClosestPed = vRPC.ClosestPed(source,Distance)
	if ClosestPed then
		local Passport = vRP.Passport(source)
		local Consult = vRP.InventoryItemAmount(Passport,"rope")
		if vRP.HasService(Passport,"Emergency") or Consult[1] >= 1 then
			local Vehicle,Network = vRPC.VehicleList(source,5)
			if Vehicle then
				local Networked = NetworkGetEntityFromNetworkId(Network)
				local Door = GetVehicleDoorLockStatus(Networked)

				if parseInt(Door) <= 1 then
					if Mode == "rv" then
						vCLIENT.removeVehicle(ClosestPed)
					elseif Mode == "cv" then
						vCLIENT.putVehicle(ClosestPed,Network)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["1"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 164, texture = 0 },
			["vest"] = { item = 58, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 200, texture = 0 },
			["torso"] = { item = 489, texture = 0 },
			["accessory"] = { item = 173, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 178, texture = 0 },
			["vest"] = { item = 57, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 247, texture = 0 },
			["torso"] = { item = 504, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 14, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["2"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 164, texture = 0 },
			["vest"] = { item = 59, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 201, texture = 0 },
			["torso"] = { item = 489, texture = 2 },
			["accessory"] = { item = 173, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 30, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 178, texture = 0 },
			["vest"] = { item = 58, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 243, texture = 0 },
			["torso"] = { item = 504, texture = 2 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 44, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["3"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 201, texture = 0 },
			["pants"] = { item = 164, texture = 0 },
			["vest"] = { item = 58, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 203, texture = 0 },
			["torso"] = { item = 489, texture = 1 },
			["accessory"] = { item = 173, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 30, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 184, texture = 0 },
			["pants"] = { item = 178, texture = 0 },
			["vest"] = { item = 57, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 245, texture = 0 },
			["torso"] = { item = 504, texture = 1 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 44, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["4"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 164, texture = 0 },
			["vest"] = { item = 58, texture = 2 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 203, texture = 0 },
			["torso"] = { item = 489, texture = 3 },
			["accessory"] = { item = 173, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 30, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 178, texture = 0 },
			["vest"] = { item = 57, texture = 2 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 245, texture = 0 },
			["torso"] = { item = 504, texture = 3 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 44, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	-- ["5"] = {
	-- 	["mp_m_freemode_01"] = {
	-- 		["hat"] = { item = 10, texture = 0 },
	-- 		["pants"] = { item = 144, texture = 1 },
	-- 		["vest"] = { item = 57, texture = 0 },
	-- 		["bracelet"] = { item = -1, texture = 0 },
	-- 		["backpack"] = { item = 0, texture = 0 },
	-- 		["decals"] = { item = 0, texture = 0 },
	-- 		["mask"] = { item = 121, texture = 0 },
	-- 		["shoes"] = { item = 25, texture = 0 },
	-- 		["tshirt"] = { item = 15, texture = 0 },
	-- 		["torso"] = { item = 394, texture = 0 },
	-- 		["accessory"] = { item = 152, texture = 0 },
	-- 		["watch"] = { item = -1, texture = 0 },
	-- 		["arms"] = { item = 20, texture = 0 },
	-- 		["glass"] = { item = 0, texture = 0 },
	-- 		["ear"] = { item = -1, texture = 0 }
	-- 	},
	-- 	["mp_f_freemode_01"] = {
	-- 		["hat"] = { item = 10, texture = 0 },
	-- 		["pants"] = { item = 151, texture = 1 },
	-- 		["vest"] = { item = 57, texture = 0 },
	-- 		["bracelet"] = { item = -1, texture = 0 },
	-- 		["backpack"] = { item = 0, texture = 0 },
	-- 		["decals"] = { item = 0, texture = 0 },
	-- 		["mask"] = { item = 121, texture = 0 },
	-- 		["shoes"] = { item = 106, texture = 0 },
	-- 		["tshirt"] = { item = 15, texture = 0 },
	-- 		["torso"] = { item = 416, texture = 0 },
	-- 		["accessory"] = { item = 121, texture = 0 },
	-- 		["watch"] = { item = -1, texture = 0 },
	-- 		["arms"] = { item = 23, texture = 0 },
	-- 		["glass"] = { item = 0, texture = 0 },
	-- 		["ear"] = { item = -1, texture = 0 }
	-- 	}
	-- },
	["6"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 164, texture = 0 },
			["vest"] = { item = 58, texture = 3 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 35, texture = 1 },
			["tshirt"] = { item = 203, texture = 0 },
			["torso"] = { item = 489, texture = 4 },
			["accessory"] = { item = 173, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 30, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 178, texture = 0 },
			["vest"] = { item = 57, texture = 3 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 36, texture = 1 },
			["tshirt"] = { item = 245, texture = 0 },
			["torso"] = { item = 504, texture = 4 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 44, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	-- ["7"] = {
	-- 	["mp_m_freemode_01"] = {
	-- 		["hat"] = { item = -1, texture = 0 },
	-- 		["pants"] = { item = 96, texture = 1 },
	-- 		["vest"] = { item = 0, texture = 0 },
	-- 		["bracelet"] = { item = -1, texture = 0 },
	-- 		["backpack"] = { item = 0, texture = 0 },
	-- 		["decals"] = { item = 57, texture = 0 },
	-- 		["mask"] = { item = 121, texture = 0 },
	-- 		["shoes"] = { item = 25, texture = 0 },
	-- 		["tshirt"] = { item = 94, texture = 0 },
	-- 		["torso"] = { item = 249, texture = 0 },
	-- 		["accessory"] = { item = 127, texture = 0 },
	-- 		["watch"] = { item = -1, texture = 0 },
	-- 		["arms"] = { item = 86, texture = 0 },
	-- 		["glass"] = { item = 0, texture = 0 },
	-- 		["ear"] = { item = -1, texture = 0 }
	-- 	},
	-- 	["mp_f_freemode_01"] = {
	-- 		["hat"] = { item = -1, texture = 0 },
	-- 		["pants"] = { item = 151, texture = 1 },
	-- 		["vest"] = { item = 0, texture = 0 },
	-- 		["bracelet"] = { item = -1, texture = 0 },
	-- 		["backpack"] = { item = 0, texture = 0 },
	-- 		["decals"] = { item = 65, texture = 0 },
	-- 		["mask"] = { item = 121, texture = 0 },
	-- 		["shoes"] = { item = 106, texture = 0 },
	-- 		["tshirt"] = { item = 71, texture = 1 },
	-- 		["torso"] = { item = 257, texture = 0 },
	-- 		["accessory"] = { item = 97, texture = 0 },
	-- 		["watch"] = { item = -1, texture = 0 },
	-- 		["arms"] = { item = 104, texture = 0 },
	-- 		["glass"] = { item = 0, texture = 0 },
	-- 		["ear"] = { item = -1, texture = 0 }
	-- 	}
	-- },
	["8"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 20, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 1, texture = 1 },
			["tshirt"] = { item = 72, texture = 0 },
			["torso"] = { item = 486, texture = 0 },
			["accessory"] = { item = 171, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 77, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 23, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 1, texture = 0 },
			["tshirt"] = { item = 67, texture = 0 },
			["torso"] = { item = 501, texture = 0 },
			["accessory"] = { item = 133, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 88, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["9"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 96, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 57, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 94, texture = 0 },
			["torso"] = { item = 249, texture = 0 },
			["accessory"] = { item = 127, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 86, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 99, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 65, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 107, texture = 0 },
			["tshirt"] = { item = 71, texture = 1 },
			["torso"] = { item = 257, texture = 0 },
			["accessory"] = { item = 97, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 104, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["10"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 20, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 1, texture = 1 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 146, texture = 6 },
			["accessory"] = { item = 127, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 85, texture = 1 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 23, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 1, texture = 0 },
			["tshirt"] = { item = 2, texture = 0 },
			["torso"] = { item = 141, texture = 1 },
			["accessory"] = { item = 97, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 109, texture = 1 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["11"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 144, texture = 1 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 129, texture = 0 },
			["torso"] = { item = 396, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 83, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 151, texture = 1 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 106, texture = 0 },
			["tshirt"] = { item = 159, texture = 0 },
			["torso"] = { item = 417, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 88, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["12"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 94, texture = 2 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 67, texture = 2 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 243, texture = 2 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 86, texture = 1 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 97, texture = 2 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 70, texture = 2 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 251, texture = 2 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 88, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Preset")
AddEventHandler("player:Preset",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasService(Passport,"Emergency") then
			local Model = vRP.ModelPlayer(source)

			if Model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",source,preset[Number][Model])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrunk",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrash",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
local UniqueShoes = {}
RegisterServerEvent("player:checkShoes")
AddEventHandler("player:checkShoes",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not UniqueShoes[Entity] then
			UniqueShoes[Entity] = os.time()
		end

		if os.time() >= UniqueShoes[Entity] then
			if vSKINSHOP.checkShoes(Entity) then
				vRP.GenerateItem(Passport,"WEAPON_SHOES",2,true)
				UniqueShoes[Entity] = os.time() + 300
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT - REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
local removeFit = {
	["homem"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mulher"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Outfit")
AddEventHandler("player:Outfit",function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Reposed(Passport) and not exports["hud"]:Wanted(Passport) then
		if Mode == "aplicar" then
			local result = vRP.GetSrvData("Outfit:"..Passport)
			if result["pants"] ~= nil then
				TriggerClientEvent("updateRoupas",source,result)
				TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.",3000)
			else
				TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.",3000)
			end
		elseif Mode == "salvar" then
			local custom = vSKINSHOP.getCustomization(source)
			if custom then
				vRP.SetSrvData("Outfit:"..Passport,custom)
				TriggerClientEvent("Notify",source,"verde","Roupas salvas.",3000)
			end
		elseif Mode == "remover" then
			local Model = vRP.ModelPlayer(source)
			if Model == "mp_m_freemode_01" then
				TriggerClientEvent("updateRoupas",source,removeFit["homem"])
			elseif Model == "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",source,removeFit["mulher"])
			end
		else
			TriggerClientEvent("skinshop:set"..Mode,source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Death")
AddEventHandler("player:Death",function(nsource)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and source ~= nsource then
		local OtherPassport = vRP.Passport(nsource)
		if OtherPassport then
			if GetPlayerRoutingBucket(source) < 900000 then
				TriggerEvent("Discord","Deaths","**Matou:** "..Passport.."\n**Morreu:** "..OtherPassport,3092790)
			else
				local Name = "Individuo Indigente"
				local Name2 = "Individuo Indigente"
				local Identity = vRP.Identity(Passport)
				local nIdentity = vRP.Identity(OtherPassport)

				if Identity and nIdentity then
					Name = Identity["name"].." "..Identity["name2"]
					Name2 = nIdentity["name"].." "..nIdentity["name2"]

					TriggerClientEvent("Notify",source,"amarelo","<b>"..Name.."</b> matou <b>"..Name2.."</b>",10000)
					TriggerClientEvent("Notify",nsource,"amarelo","<b>"..Name.."</b> matou <b>"..Name2.."</b>",10000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKEPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Bikepack()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local amountWeight = 10
		local myWeight = vRP.GetWeight(Passport)

		if parseInt(myWeight) < 45 then
			amountWeight = 15
		elseif parseInt(myWeight) >= 45 and parseInt(myWeight) <= 79 then
			amountWeight = 10
		elseif parseInt(myWeight) >= 80 and parseInt(myWeight) <= 99 then
			amountWeight = 5
		elseif parseInt(myWeight) >= 100 and parseInt(myWeight) <= 149 then
			amountWeight = 2
		elseif parseInt(myWeight) >= 150 then
			amountWeight = 1
		end

		vRP.SetWeight(Passport,amountWeight)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:SPENDING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Spending")
AddEventHandler("player:Spending",function(_,Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Identity = vRP.Identity(Passport)
		if Identity then
			local Split = splitString(Mode,"-")
			if Split[1] == "upgrade" then
				local Amount = 10000

				if Split[2] == "2" then
					Amount = 50000
				end
				
				vRP.UpgradeCardlimit(Passport,Amount)
				TriggerClientEvent("Notify",source,"verde","Aumentou seu limite do cartão de débito.",5000)
			elseif Split[1] == "downgrade" then
				local Amount = 10000

				if Split[2] == "2" then
					Amount = 50000
				end

				if Identity["cardlimit"] >= Amount then
					vRP.DowngradeCardlimit(Passport,Amount)
					TriggerClientEvent("Notify",source,"verde","Diminuiu seu limite do cartão de débito.",5000)
				else
					TriggerClientEvent("Notify",source,"amarelo","Limite insuficiente no cartão.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("player:DuiTable",source,DuiTextures)

	local Groups = vRP.Groups()
	for Permission,_ in pairs(Groups) do
		if vRP.HasGroup(Passport,Permission) then
			TriggerClientEvent("player:Relationship",source,Permission)
		end
	end

	local Identity = vRP.Identity(Passport)
	if Identity then
		vRP.Query("accounts/dateLogin",{ license = Identity["license"], login = os.date("%d/%m/%Y") })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if playerCarry[Passport] then
		TriggerClientEvent("player:Commands",playerCarry[Passport],false)
		playerCarry[Passport] = nil
	end
end)