-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = "Santos"
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:Open")
AddEventHandler("tablet:Open",function(Select)
	if LocalPlayer["state"]["Route"] < 900000 then
		local Ped = PlayerPedId()
		if not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and GetEntityHealth(Ped) > 100 then
			Open = Select
			SetNuiFocus(true,true)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "Open" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "Close" })

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Carros",function(Data,Callback)
	Callback({ result = GlobalState["Cars"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Motos",function(Data,Callback)
	Callback({ result = GlobalState["Bikes"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALUGUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Aluguel",function(Data,Callback)
	Callback({ result = GlobalState["Rental"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Buy",function(Data,Callback)
	vSERVER.Buy(Data["name"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENTAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rental",function(Data,Callback)
	vSERVER.Rental(Data["name"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:Update")
AddEventHandler("tablet:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVEABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehDrive = nil
local benDrive = false
local benCoords = { 0.0,0.0,0.0 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Drive",function(Data,Callback)
	if vSERVER.startDrive() then
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "Close" })

		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		benCoords = { Coords["x"],Coords["y"],Coords["z"] }

		LocalPlayer["state"]["Race"] = true
		LocalPlayer["state"]["Commands"] = true
		TriggerEvent("Notify","azul","Teste iniciado, para finalizar saia do veículo.",5000)

		Wait(1000)

		vehCreate(Data["name"])

		Wait(1000)

		SetPedIntoVehicle(Ped,vehDrive,-1)
		benDrive = true
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vehCreate(vehName)
	if LoadModel(vehName) then
		if Open == "Santos" then
			vehDrive = CreateVehicle(vehName,-56.83,-1109.15,26.44,70.87,false,false)
		elseif Open == "Sandy" then
			vehDrive = CreateVehicle(vehName,1209.74,2713.49,37.81,175.75,false,false)
		end

		SetModelAsNoLongerNeeded(vehName)
		SetEntityInvincible(vehDrive,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if benDrive then
			TimeDistance = 1
			DisableControlAction(1,69,false)

			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				Wait(1000)

				benDrive = false
				vSERVER.removeDrive()
				LocalPlayer["state"]["Race"] = false
				LocalPlayer["state"]["Commands"] = false
				SetEntityCoords(Ped,benCoords[1],benCoords[2],benCoords[3],false,false,false,false)

				if DoesEntityExist(vehDrive) then
					DeleteEntity(vehDrive)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local initVehicles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Vehicles = {
	{
		["Coords"] = vec3(-37.06,-1093.26,27.3),
		["heading"] = 19.85,
		["Model"] = "r1200",
		["Distance"] = 100
	},{
		["Coords"] = vec3(-42.34,-1101.39,27.27),
		["heading"] = 31.19,
		["Model"] = "nissangtr",
		["Distance"] = 100
	},{
		["Coords"] = vec3(-47.55,-1092.03,27.3),
		["heading"] = 283.47,
		["Model"] = "subaruimpreza",
		["Distance"] = 100
	},{
		["Coords"] = vec3(-49.87,-1083.75,27.27),
		["heading"] = 206.93,
		["Model"] = "skyliner34",
		["Distance"] = 100
	},{
		["Coords"] = vec3(-54.65,-1096.91,27.27),
		["heading"] = 65.2,
		["Model"] = "silvias15",
		["Distance"] = 100
	},{
		["Coords"] = vec3(808.28,-905.06,25.68),
		["heading"] = 308.98,
		["Model"] = "er34h",
		["Distance"] = 40,
		["Tuning"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for k,v in pairs(Vehicles) do
			local Distance = #(Coords - v["Coords"])
			if Distance <= v["Distance"] then
				if not initVehicles[k] then
					if LoadModel(v["Model"]) then
						local Color = math.random(112)
						initVehicles[k] = CreateVehicle(v["Model"],v["Coords"],v["heading"],false,false)
						SetVehicleNumberPlateText(initVehicles[k],"PDMSPORT")
						SetVehicleColours(initVehicles[k],Color,Color)
						FreezeEntityPosition(initVehicles[k],true)
						SetVehicleDoorsLocked(initVehicles[k],2)
						SetModelAsNoLongerNeeded(v["Model"])

						if v["Tuning"] then
							SetVehicleModKit(initVehicles[k],0)
							SetVehicleWheelType(initVehicles[k],7)
							SetVehicleMod(initVehicles[k],0,GetNumVehicleMods(initVehicles[k],0)-1,false)
							SetVehicleMod(initVehicles[k],1,GetNumVehicleMods(initVehicles[k],1)-1,false)
							SetVehicleMod(initVehicles[k],2,GetNumVehicleMods(initVehicles[k],2)-1,false)
							SetVehicleMod(initVehicles[k],3,GetNumVehicleMods(initVehicles[k],3)-1,false)
							SetVehicleMod(initVehicles[k],4,GetNumVehicleMods(initVehicles[k],4)-1,false)
							SetVehicleMod(initVehicles[k],5,GetNumVehicleMods(initVehicles[k],5)-1,false)
							SetVehicleMod(initVehicles[k],6,GetNumVehicleMods(initVehicles[k],6)-1,false)
							SetVehicleMod(initVehicles[k],7,GetNumVehicleMods(initVehicles[k],7)-1,false)
							SetVehicleMod(initVehicles[k],8,GetNumVehicleMods(initVehicles[k],8)-1,false)
							SetVehicleMod(initVehicles[k],9,GetNumVehicleMods(initVehicles[k],9)-1,false)
							SetVehicleMod(initVehicles[k],10,GetNumVehicleMods(initVehicles[k],10)-1,false)
							SetVehicleMod(initVehicles[k],11,GetNumVehicleMods(initVehicles[k],11)-1,false)
							SetVehicleMod(initVehicles[k],12,GetNumVehicleMods(initVehicles[k],12)-1,false)
							SetVehicleMod(initVehicles[k],13,GetNumVehicleMods(initVehicles[k],13)-1,false)
							SetVehicleMod(initVehicles[k],14,16,false)
							SetVehicleMod(initVehicles[k],15,GetNumVehicleMods(initVehicles[k],15)-2,false)
							SetVehicleMod(initVehicles[k],16,GetNumVehicleMods(initVehicles[k],16)-1,false)
							ToggleVehicleMod(initVehicles[k],17,true)
							ToggleVehicleMod(initVehicles[k],18,true)
							ToggleVehicleMod(initVehicles[k],19,true)
							ToggleVehicleMod(initVehicles[k],20,true)
							ToggleVehicleMod(initVehicles[k],21,true)
							ToggleVehicleMod(initVehicles[k],22,true)
							SetVehicleMod(initVehicles[k],23,1,false)
							SetVehicleMod(initVehicles[k],24,1,false)
							SetVehicleMod(initVehicles[k],25,GetNumVehicleMods(initVehicles[k],25)-1,false)
							SetVehicleMod(initVehicles[k],27,GetNumVehicleMods(initVehicles[k],27)-1,false)
							SetVehicleMod(initVehicles[k],28,GetNumVehicleMods(initVehicles[k],28)-1,false)
							SetVehicleMod(initVehicles[k],30,GetNumVehicleMods(initVehicles[k],30)-1,false)
							SetVehicleMod(initVehicles[k],33,GetNumVehicleMods(initVehicles[k],33)-1,false)
							SetVehicleMod(initVehicles[k],34,GetNumVehicleMods(initVehicles[k],34)-1,false)
							SetVehicleMod(initVehicles[k],35,GetNumVehicleMods(initVehicles[k],35)-1,false)
							SetVehicleMod(initVehicles[k],38,GetNumVehicleMods(initVehicles[k],38)-1,true)
							SetVehicleTyreSmokeColor(initVehicles[k],0,0,0)
							SetVehicleWindowTint(initVehicles[k],1)
							SetVehicleTyresCanBurst(initVehicles[k],false)
							SetVehicleNumberPlateTextIndex(initVehicles[k],5)
							SetVehicleModColor_1(initVehicles[k],0,0,0)
							SetVehicleModColor_2(initVehicles[k],0,0)
							SetVehicleExtraColours(initVehicles[k],0,0)
							SetVehicleNeonLightsColour(initVehicles[k],0,0,0)

							local Livery = GetVehicleLiveryCount(initVehicles[k])
							if Livery > 0 then
								SetVehicleLivery(initVehicles[k],Livery)
							end
						end
					end
				end
			else
				if initVehicles[k] then
					if DoesEntityExist(initVehicles[k]) then
						DeleteEntity(initVehicles[k])
						initVehicles[k] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)