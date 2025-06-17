-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("engine")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Price = 0
local Lasted = 0
local Display = false
local VehicleFuel = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Event,Message)
	if Event ~= "CEventNetworkPlayerEnteredVehicle" then
		return
	end

	local Vehicle = Message[2]
	if Message[1] == PlayerId() then
		local Ped = PlayerPedId()
		if not Entity(Vehicle)["state"]["Fuel"] then
			Entity(Vehicle)["state"]:set("Fuel",100,true)
		end

		SetPedConfigFlag(Ped,35,false)

		if not IsPedInAnyHeli(Ped) then
			TriggerEvent("inventory:CleanWeapons")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:FUELADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:FuelAdmin")
AddEventHandler("engine:FuelAdmin",function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		Entity(Vehicle)["state"]:set("Fuel",100,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASS
-----------------------------------------------------------------------------------------------------------------------------------------
local Class = {
	[13] = 0.0,
	[14] = 0.0,
	[15] = 1.5,
	[21] = 0.0
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
local Consume = {
	[1.0] = 0.575,
	[0.9] = 0.525,
	[0.8] = 0.475,
	[0.7] = 0.425,
	[0.6] = 0.375,
	[0.5] = 0.325,
	[0.4] = 0.275,
	[0.3] = 0.225,
	[0.2] = 0.175,
	[0.1] = 0.125,
	[0.0] = 0.000
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLOOR
-----------------------------------------------------------------------------------------------------------------------------------------
function floor(Number)
	local Mult = 10 ^ 1
	return math.floor(Number * Mult + 0.5) / Mult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			local Multiplier = Class[GetVehicleClass(Vehicle)]
			if Multiplier and Multiplier ~= 0.0 then
				if GetVehicleFuelLevel(Vehicle) >= 1 then
					if GetPedInVehicleSeat(Vehicle,-1) == Ped and (GetEntitySpeed(Vehicle) * 3.6) >= 1 then
						local EntityState = Entity(Vehicle).state

						if not EntityState.Fuel then
							EntityState:set("Fuel",100.0,true)
						end

						local RPM = floor(GetVehicleCurrentRpm(Vehicle))
						local NewFuel = EntityState.Fuel - (Consume[RPM] or 1.0) * Multiplier / 10

						EntityState:set("Fuel",NewFuel,true)
						SetVehicleFuelLevel(Vehicle,NewFuel)
					end
				else
					SetVehicleEngineOn(Vehicle,false,true,true)
					TimeDistance = 1
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:SUPPLY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("engine:Supply",function(Entitys)
	if VehicleFuel then
		return false
	end

	local Ped = PlayerPedId()
	local Vehicle = Entitys[3]
	local Gallons = Entitys[6]
	local VehicleState = Entity(Vehicle).state

	if not VehicleState.Fuel then
		VehicleState:set("Fuel",100.0,true)
	end

	Lasted = VehicleState.Fuel
	if Lasted > 99.980 then
		return false
	end

	local Coords = GetEntityCoords(Vehicle)

	if not Display and not Gallons then
		SendNUIMessage({ Action = "Open" })
		TriggerEvent("hud:Active",false)
		Display = true
	end

	if not VehicleFuel then
		TaskTurnPedToFaceEntity(Ped,Vehicle,5000)
		VehicleFuel = Lasted
	end

	while VehicleFuel do
		for _,v in ipairs({ 18,22,23,24,29,30,31,140,141,142,143,257,263 }) do
			DisableControlAction(0,v,true)
		end

		if not Gallons then
			Price += 0.2
			VehicleFuel += 0.02
			SendNUIMessage({ Action = "Tank", Payload = { floor(VehicleFuel),Price,0.8 } })
		else
			local Ammo = GetAmmoInPedWeapon(Ped,883325847)
			if Ammo > 2 then
				SetPedAmmo(Ped,883325847,math.floor(Ammo - 2))
				VehicleFuel += 0.02
			end
		end

		SetDrawOrigin(Coords.x,Coords.y,Coords.z)
		DrawSprite("Textures","E",0.0,0.0,0.02,0.02 * GetAspectRatio(false),0.0,255,255,255,255)
		ClearDrawOrigin()

		if not IsEntityPlayingAnim(Ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) and LoadAnim("timetable@gardener@filling_can") then
			TaskPlayAnim(Ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",8.0,8.0,-1,50,1,0,0,0)
		end

		if (VehicleFuel >= 100.0 or GetEntityHealth(Ped) <= 100 or (Gallons and GetAmmoInPedWeapon(Ped,883325847) <= 2) or IsControlJustPressed(1,38)) then
			if not Gallons and not vSERVER.RechargeFuel(Price) then
				VehicleState:set("Fuel",Lasted,true)
				TriggerEvent("Notify","Aviso","Dinheiro insuficiente.","amarelo",5000)
			else
				VehicleState:set("Fuel",VehicleFuel,true)

				if Display then
					SendNUIMessage({ Action = "Close" })
					TriggerEvent("hud:Active",true)
				end
			end

			VehicleFuel = false
			Display = false
			vRP.Destroy()
			Lasted = 0
			Price = 0
		end

		Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:VEHRIFY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("engine:Vehrify",function(Entitys)
	local Vehicle = Entitys[3]

	local Mods = {
		{ Number = 11, Name = "Motor" },
		{ Number = 12, Name = "Freios" },
		{ Number = 13, Name = "Transmissão" },
		{ Number = 15, Name = "Suspensão" },
		{ Number = 16, Name = "Blindagem" }
	}

	for _,v in ipairs(Mods) do
		local CurrentMod = GetVehicleMod(Vehicle,v.Number)
		if CurrentMod ~= -1 then
			local Total = GetNumVehicleMods(Vehicle,v.Number)
			exports["dynamic"]:AddButton(v.Name,("Modificação atual instalada: <rare>%d</rare> / %d"):format(CurrentMod + 1,Total),"","",false,false)
		end
	end

	local Force = parseInt(GetVehicleEngineHealth(Vehicle) / 10)
	exports["dynamic"]:AddButton("Potência",("Potência do motor se encontra em <rare>%d%%</rare>."):format(Force),"","",false,false)

	local Body = parseInt(GetVehicleBodyHealth(Vehicle) / 10)
	exports["dynamic"]:AddButton("Lataria",("Qualidade da lataria se encontra em <rare>%d%%</rare>."):format(Body),"","",false,false)

	local Health = parseInt(GetEntityHealth(Vehicle) / 10)
	exports["dynamic"]:AddButton("Chassi",("Rigidez do chassi se encontra em <rare>%d%%</rare>."):format(Health),"","",false,false)

	exports["dynamic"]:Open()
end)