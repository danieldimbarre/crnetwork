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
		["Coords"] = vec3(-42.39,-1101.32,25.98),
		["heading"] = 19.85,
		["Model"] = "r1200",
		["Distance"] = 100
	},{
		["Coords"] = vec3(-54.61,-1096.86,25.98),
		["heading"] = 31.19,
		["Model"] = "nissangtr",
		["Distance"] = 100
	},{
		["Coords"] = vec3(-47.57,-1092.05,25.98),
		["heading"] = 283.47,
		["Model"] = "subaruimpreza",
		["Distance"] = 100
	},{
		["Coords"] = vec3(-37.02,-1093.42,25.98),
		["heading"] = 206.93,
		["Model"] = "skyliner34",
		["Distance"] = 100
	},{
		["Coords"] = vec3(-49.78,-1083.86,25.98),
		["heading"] = 65.2,
		["Model"] = "silvias15",
		["Distance"] = 100
	},{
		["Coords"] = vec3(808.28,-905.06,25.68),
		["heading"] = 308.98,
		["Model"] = "gtrpit",
		["Distance"] = 30,
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
							SetVehicleMod(initVehicles[k],11,GetNumVehicleMods(initVehicles[k],11)-1,false)
							SetVehicleMod(initVehicles[k],12,GetNumVehicleMods(initVehicles[k],12)-1,false)
							SetVehicleMod(initVehicles[k],13,GetNumVehicleMods(initVehicles[k],13)-1,false)
							SetVehicleMod(initVehicles[k],15,GetNumVehicleMods(initVehicles[k],15)-1,false)
							ToggleVehicleMod(initVehicles[k],18,true)

							local Livery = GetVehicleLiveryCount(initVehicles[k])
							if Livery > 0 then
								SetVehicleLivery(initVehicles[k],#Livery)
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