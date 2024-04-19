-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Rpm = 0
local Fuel = 0
local Speed = 0
local Nitro = 0
local LastSpeed = 0
local Locked = false
local Loadout = false
local EngineHealth = 0
local ActualVehicle = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
local NitroFuel = 0
local NitroActive = false
local NitroButton = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local SeatbeltSpeed = 0
local SeatbeltLock = false
local SeatbeltVelocity = vec3(0,0,0)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	LoadPtfxAsset("veh_xs_vehicle_mods")

	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				TimeDistance = 100

				if not Loadout then
					if LoadTexture("circleminimap") then
						AddReplaceTexture("platform:/textures/graphics","radarmasksm","circleminimap","radarmasksm")

						SetMinimapComponentPosition("minimap","L","B",0.005,-0.025,0.175,0.225)
						SetMinimapComponentPosition("minimap_mask","L","B",0.02,0.39,0.1135,0.5)
						SetMinimapComponentPosition("minimap_blur","L","B",-0.02,-0.01,0.265,0.225)

						SetBigmapActive(true,false)

						repeat
							Wait(100)

							SetMinimapClipType(1)
							SetBigmapActive(false,false)
						until not IsBigmapActive()

						SetRadarZoom(1100)
						Loadout = true
					end
				end

				if Display and not IsMinimapRendering() then
					SetBigmapActive(false,false)
					DisplayRadar(true)
				end

				local Vehicle = GetVehiclePedIsUsing(Ped)
				local VRpm = GetVehicleCurrentRpm(Vehicle)
				local VFuel = GetVehicleFuelLevel(Vehicle)
				local VSpeed = GetEntitySpeed(Vehicle) * 2.236936
				local VLocked = GetVehicleDoorLockStatus(Vehicle)
				local VEngineHealth = GetVehicleEngineHealth(Vehicle)

				if GetPedInVehicleSeat(Vehicle,-1) == Ped then
					if GetVehicleDirtLevel(Vehicle) > 0.0 then
						SetVehicleDirtLevel(Vehicle,0.0)
					end

					if not LocalPlayer["state"]["Races"] and VSpeed ~= LastSpeed then
						if (LastSpeed - VSpeed) >= 60 then
							VehicleTyreBurst(Vehicle)
						end

						LastSpeed = VSpeed
					end
				end

				if ActualVehicle ~= Vehicle then
					SendNUIMessage({ name = "Vehicle", payload = true })
					ActualVehicle = Vehicle
				end

				if VEngineHealth ~= EngineHealth then
					SendNUIMessage({ name = "EngineHealth", payload = VEngineHealth })
					VEngineHealth = EngineHealth
				end

				if Locked ~= VLocked then
					SendNUIMessage({ name = "Locked", payload = VLocked })
					Locked = VLocked
				end

				if LocalPlayer["state"]["Nitro"] then
					SendNUIMessage({ name = "Nitro", payload = NitroFuel })
					Nitro = NitroFuel
				else
					if (Entity(Vehicle)["state"]["Nitro"] or 0) ~= Nitro then
						SendNUIMessage({ name = "Nitro", payload = Entity(Vehicle)["state"]["Nitro"] or 0 })
						Nitro = Entity(Vehicle)["state"]["Nitro"] or 0
					end
				end

				if Fuel ~= VFuel then
					SendNUIMessage({ name = "Fuel", payload = VFuel })
					Fuel = VFuel
				end

				if Speed ~= VSpeed then
					SendNUIMessage({ name = "Speed", payload = parseInt(VSpeed) })
					Speed = VSpeed
				end

				if not GetIsVehicleEngineRunning(Vehicle) then
					VRpm = 0.0
				end

				if Rpm ~= VRpm then
					SendNUIMessage({ name = "Rpm", payload = VRpm })
					Rpm = VRpm
				end
			else
				if IsMinimapRendering() then
					DisplayRadar(false)
				end

				if ActualVehicle then
					ActualVehicle = nil
					SendNUIMessage({ name = "Vehicle", payload = false })

					Locked = false
					SendNUIMessage({ name = "Locked", payload = false })

					Nitro = 0
					SendNUIMessage({ name = "Nitro", payload = 0 })

					Speed = 0
					SendNUIMessage({ name = "Speed", payload = 0 })
				end

				if LastSpeed ~= 0 then
					LastSpeed = 0
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleTyreBurst(Vehicle)
	local WheelAffect = 0
	local NumWheels = GetVehicleNumberOfWheels(Vehicle)

	if NumWheels == 2 then
		WheelAffect = (math.random(2) - 1) * 4
	elseif NumWheels == 4 then
		WheelAffect = (math.random(4) - 1)

		if WheelAffect > 1 then
			WheelAffect = WheelAffect + 2
		end
	elseif NumWheels == 6 then
		WheelAffect = (math.random(6) - 1)
	end

	if GetTyreHealth(Vehicle,WheelAffect) == 1000.0 then
		SetVehicleTyreBurst(Vehicle,WheelAffect,true,1000.0)
	end

	if math.random(100) <= 25 then
		VehicleTyreBurst(Vehicle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITROENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function NitroEnable()
	if GetGameTimer() >= NitroButton and not IsPauseMenuActive() then
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			NitroButton = GetGameTimer() + 1000

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle,-1) == Ped and GetVehicleTopSpeedModifier(Vehicle) < 50.0 then
				NitroFuel = Entity(Vehicle)["state"]["Nitro"] or 0

				if NitroFuel >= 1 and (GetEntitySpeed(Vehicle) * 2.236936) > 10 then
					NitroActive = true

					while NitroActive do
						if NitroFuel >= 1 then
							NitroFuel = NitroFuel - 1

							if not LocalPlayer["state"]["Nitro"] then
								LocalPlayer["state"]:set("Nitro",true,false)
								Entity(Vehicle)["state"]:set("NitroFlame",true,false)

								SetVehicleRocketBoostActive(Vehicle,true)
								SetVehicleBoostActive(Vehicle,true)
								ModifyVehicleTopSpeed(Vehicle,50.0)
							end
						else
							if LocalPlayer["state"]["Nitro"] then
								LocalPlayer["state"]:set("Nitro",false,false)
								Entity(Vehicle)["state"]:set("NitroFlame",false,false)
								Entity(Vehicle)["state"]:set("Nitro",NitroFuel,true)
							end

							SetVehicleRocketBoostActive(Vehicle,false)
							SetVehicleBoostActive(Vehicle,false)
							ModifyVehicleTopSpeed(Vehicle,0.0)
							NitroActive = false
						end

						Wait(1)
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRODISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function NitroDisable()
	if LocalPlayer["state"]["Nitro"] then
		LocalPlayer["state"]:set("Nitro",false,false)

		local Vehicle = GetLastDrivenVehicle()
		if DoesEntityExist(Vehicle) then
			Entity(Vehicle)["state"]:set("Nitro",NitroFuel,true)
			Entity(Vehicle)["state"]:set("NitroFlame",false,false)

			SetVehicleRocketBoostActive(Vehicle,false)
			SetVehicleBoostActive(Vehicle,false)
			ModifyVehicleTopSpeed(Vehicle,0.0)
		end
	end

	NitroActive = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("NitroFlame",nil,function(Name,Key,Value)
	local Network = parseInt(Name:gsub("entity:",""))
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToVeh(Network)
		if DoesEntityExist(Vehicle) then
			SetVehicleNitroEnabled(Vehicle,Value)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+activeNitro",NitroEnable)
RegisterCommand("-activeNitro",NitroDisable)
RegisterKeyMapping("+activeNitro","Ativação do nitro.","keyboard","LMENU")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBELT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				if not IsPedOnAnyBike(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyPlane(Ped) then
					TimeDistance = 1

					local Vehicle = GetVehiclePedIsUsing(Ped)
					local Speed = GetEntitySpeed(Vehicle) * 2.236936
					if GetVehicleDoorLockStatus(Vehicle) >= 2 or SeatbeltLock then
						DisableControlAction(0,75,true)
						DisableControlAction(27,75,true)
					end

					if Speed ~= SeatbeltSpeed then
						if (SeatbeltSpeed - Speed) >= 60 then
							if not SeatbeltLock then
								ApplyDamageToPed(Ped,25,false)
							end

							if not Entity(Vehicle)["state"]["Seatbelt"] then
								SetEntityNoCollisionEntity(Ped,Vehicle,false)
								SetEntityNoCollisionEntity(Vehicle,Ped,false)
								TriggerServerEvent("hud:VehicleEject",SeatbeltVelocity)

								Wait(500)

								SetEntityNoCollisionEntity(Ped,Vehicle,true)
								SetEntityNoCollisionEntity(Vehicle,Ped,true)
							end
						end

						SeatbeltVelocity = GetEntityVelocity(Vehicle)
						SeatbeltSpeed = Speed
					end
				end
			else
				if SeatbeltSpeed ~= 0 then
					SeatbeltSpeed = 0
				end

				if SeatbeltLock then
					SendNUIMessage({ name = "Seatbelt", payload = false })
					SeatbeltLock = false
				end

				if LocalPlayer["state"]["Nitro"] then
					NitroDisable()
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELTZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Seatbeltz",function(source)
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyPlane(Ped) then
		if SeatbeltLock then
			TriggerEvent("sounds:Private","beltoff",0.5)
			SendNUIMessage({ name = "Seatbelt", payload = false })
			SeatbeltLock = false
		else
			TriggerEvent("sounds:Private","belton",0.5)
			SendNUIMessage({ name = "Seatbelt", payload = true })
			SeatbeltLock = true

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if Entity(Vehicle)["state"]["Seatbelt"] then
				TriggerEvent("Notify","Cinto de Segurança","Ativou o módulo de corrida.","azul",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Seatbeltz","Colocar/Retirar o cinto.","keyboard","G")