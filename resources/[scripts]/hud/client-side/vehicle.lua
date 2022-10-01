-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Fuel = 0
local Speed = 0
local Nitro = 0
local Tyres = 0
local Drift = false
local Locked = false
local Handbrake = false
local Headbeams = false
local Headlights = false
local ActualVehicle = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
local NitroFuel = 0
local NitroFlame = false
local NitroActive = false
local NitroButton = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIGHTTRAILS
-----------------------------------------------------------------------------------------------------------------------------------------
local LightTrails = {}
local LightParticles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
local PurgeSprays = {}
local PurgeParticles = {}
local PurgeActive = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Active"] and Display then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				TimeDistance = 100

				if not IsMinimapRendering() then
					DisplayRadar(true)
				end

				local Vehicle = GetVehiclePedIsUsing(Ped)
				local Rpm = GetVehicleCurrentRpm(Vehicle)
				local VFuel = GetVehicleFuelLevel(Vehicle)
				local Gear = GetVehicleCurrentGear(Vehicle)
				local VSpeed = GetEntitySpeed(Vehicle) * 3.6
				local VDrift = GetDriftTyresEnabled(Vehicle)
				local Plate = GetVehicleNumberPlateText(Vehicle)
				local VLocked = GetVehicleDoorLockStatus(Vehicle)
				local _,VHeadlight,VHighBeam = GetVehicleLightsState(Vehicle)

				if ActualVehicle ~= Vehicle then
					SendNUIMessage({ Action = "Vehicle", Status = true })
					ActualVehicle = Vehicle
				end

				if Drift ~= VDrift then
					SendNUIMessage({ Action = "Drift", Status = VDrift })
					Drift = VDrift
				end

				if Locked ~= VLocked then
					SendNUIMessage({ Action = "Locked", Status = VLocked })
					Locked = VLocked
				end

				if Headlights ~= VHeadlight or Headbeams ~= VHighBeam then
					SendNUIMessage({ Action = "Headlight", Status = VHeadlight, Beam = VHighBeam })
					Headlights = VHeadlight
					Headbeams = VHighBeam
				end

				local Tyre = 0
				for i = 0,5 do
					if IsVehicleTyreBurst(Vehicle,i,true) then
						Tyre = Tyre + 1
					end
				end

				if Tyres ~= Tyre then
					SendNUIMessage({ Action = "Tyres", Number = Tyre })
					Tyres = Tyre
				end

				if NitroActive then
					SendNUIMessage({ Action = "Nitro", Number = NitroFuel })
					Nitro = NitroFuel
				else
					if (GlobalState["Nitro"][Plate] or 0) ~= Nitro then
						SendNUIMessage({ Action = "Nitro", Number = GlobalState["Nitro"][Plate] or 0 })
						Nitro = GlobalState["Nitro"][Plate] or 0
					end
				end

				if Fuel ~= VFuel then
					SendNUIMessage({ Action = "Fuel", Number = VFuel })
					Fuel = VFuel
				end

				if Speed ~= VSpeed then
					SendNUIMessage({ Action = "Speed", Number = VSpeed })
					Speed = VSpeed
				end

				if (VSpeed == 0 and Gear == 0) or (VSpeed == 0 and Gear == 1) then
					Gear = "N"
				elseif (VSpeed > 0 and Gear == 0) then
					Gear = "R"
				end

				SendNUIMessage({ Action = "Rpm", Number = Rpm, Gear = Gear })
			else
				if ActualVehicle then
					ActualVehicle = nil
					SendNUIMessage({ Action = "Vehicle", Status = false })

					Drift = false
					SendNUIMessage({ Action = "Drift", Status = false })

					Locked = false
					SendNUIMessage({ Action = "Locked", Status = false })

					if Handbrake then
						Handbrake = false
						SendNUIMessage({ Action = "Handbrake", Status = false })
					end

					Headbeams = false
					Headlights = false
					SendNUIMessage({ Action = "Headlight", Status = 0, Beam = 0 })

					Nitro = 0
					SendNUIMessage({ Action = "Nitro", Number = 0 })

					Tyres = 0
					SendNUIMessage({ Action = "Tyres", Number = 0 })

					Speed = 0
					SendNUIMessage({ Action = "Speed", Number = 0 })

					if IsMinimapRendering() then
						DisplayRadar(false)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITROENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function nitroEnable()
	if GetGameTimer() >= NitroButton and not IsPauseMenuActive() then
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			NitroButton = GetGameTimer() + 1000

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle,-1) == Ped then
				if GetVehicleTopSpeedModifier(Vehicle) < 50.0 then
					local Plate = GetVehicleNumberPlateText(Vehicle)
					NitroFuel = GlobalState["Nitro"][Plate] or 0

					if NitroFuel >= 1 then
						if GetIsVehicleEngineRunning(Vehicle) then
							local Speed = GetEntitySpeed(Vehicle) * 3.6
							if Speed > 10 then
								NitroActive = true

								while NitroActive do
									if NitroFuel >= 1 then
										NitroFuel = NitroFuel - 1

										if not NitroFlame then
											vSERVER.activeNitro(VehToNet(Vehicle),true)
											SetVehicleRocketBoostActive(Vehicle,true)
											SetVehicleBoostActive(Vehicle,true)
											ModifyVehicleTopSpeed(Vehicle,50.0)
											SetLightTrail(Vehicle,true)
											NitroFlame = Plate
										end
									else
										if NitroFlame then
											vSERVER.activeNitro(VehToNet(Vehicle),false)
											SetVehicleRocketBoostActive(Vehicle,false)
											vSERVER.updateNitro(NitroFlame,NitroFuel)
											SetVehicleBoostActive(Vehicle,false)
											ModifyVehicleTopSpeed(Vehicle,0.0)
											SetLightTrail(Vehicle,false)
											NitroActive = false
											NitroFlame = false
										end
									end

									Wait(1)
								end
							else
								SetPurgeSprays(Vehicle,true)
								PurgeActive = true
							end
						else
							SetPurgeSprays(Vehicle,true)
							PurgeActive = true
						end
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRODISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function nitroDisable()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)

		if NitroFlame then
			vSERVER.activeNitro(VehToNet(Vehicle),false)
			SetVehicleRocketBoostActive(Vehicle,false)
			vSERVER.updateNitro(NitroFlame,NitroFuel)
			SetVehicleBoostActive(Vehicle,false)
			ModifyVehicleTopSpeed(Vehicle,0.0)
			SetLightTrail(Vehicle,false)
			NitroActive = false
			NitroFlame = false
		end

		if PurgeActive then
			SetPurgeSprays(Vehicle,false)
			PurgeActive = false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+activeNitro",nitroEnable)
RegisterCommand("-activeNitro",nitroDisable)
RegisterKeyMapping("+activeNitro","Ativação do nitro.","keyboard","LMENU")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETLIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function SetLightTrail(Vehicle,Enable)
	if LightTrails[Vehicle] == Enable then
		return
	end

	if Enable then
		local Particles = {}
		local LeftTrail = CreateLightTrail(Vehicle,GetEntityBoneIndexByName(Vehicle,"taillight_l"))
		local RightTrail = CreateLightTrail(Vehicle,GetEntityBoneIndexByName(Vehicle,"taillight_r"))

		table.insert(Particles,LeftTrail)
		table.insert(Particles,RightTrail)

		LightTrails[Vehicle] = true
		LightParticles[Vehicle] = Particles
	else
		if LightParticles[Vehicle] and #LightParticles[Vehicle] > 0 then
			for _,v in ipairs(LightParticles[Vehicle]) do
				StopLightTrail(v)
			end
		end

		LightTrails[Vehicle] = nil
		LightParticles[Vehicle] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATELIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateLightTrail(Vehicle,Bone)
	UseParticleFxAssetNextCall("core")
	local Particle = StartParticleFxLoopedOnEntityBone("veh_light_red_trail",Vehicle,0.0,0.0,0.0,0.0,0.0,0.0,Bone,1.0,false,false,false)
	SetParticleFxLoopedEvolution(Particle,"speed",1.0,false)

	return Particle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPLIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function StopLightTrail(Particle)
	CreateThread(function()
		local endTime = GetGameTimer() + 500
		while GetGameTimer() < endTime do 
			Wait(0)
			local now = GetGameTimer()
			local Scale = (endTime - now) / 500
			SetParticleFxLoopedScale(Particle,Scale)
			SetParticleFxLoopedAlpha(Particle,Scale)
		end

		StopParticleFxLooped(Particle)
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
function SetPurgeSprays(Vehicle,Enable)
	if PurgeSprays[Vehicle] == Enable then
		return
	end

	if Enable then
		local Particles = {}
		local Bone = GetEntityBoneIndexByName(Vehicle,"bonnet")
		local Position = GetWorldPositionOfEntityBone(Vehicle,Bone)
		local Offset = GetOffsetFromEntityGivenWorldCoords(Vehicle,Position["x"],Position["y"],Position["z"])

		for i = 0,3 do
			local LeftPurge = CreatePurgeSprays(Vehicle,Offset["x"] - 0.5,Offset["y"] + 0.05,Offset["z"],40.0,-20.0,0.0,0.5)
			local RightPurge = CreatePurgeSprays(Vehicle,Offset["x"] + 0.5,Offset["y"] + 0.05,Offset["z"],40.0,20.0,0.0,0.5)

			table.insert(Particles,LeftPurge)
			table.insert(Particles,RightPurge)
		end

		PurgeSprays[Vehicle] = true
		PurgeParticles[Vehicle] = Particles
	else
		if PurgeParticles[Vehicle] then
			RemoveParticleFxFromEntity(Vehicle)
		end

		PurgeSprays[Vehicle] = nil
		PurgeParticles[Vehicle] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
function CreatePurgeSprays(Vehicle,xOffset,yOffset,zOffset,xRot,yRot)
	UseParticleFxAssetNextCall("core")
	return StartNetworkedParticleFxNonLoopedOnEntity("ent_sht_steam",Vehicle,xOffset,yOffset,zOffset,xRot,yRot,0.0,0.5,false,false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ACTIVENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:activeNitro")
AddEventHandler("hud:activeNitro",function(Network,Status)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			SetVehicleNitroEnabled(Vehicle,Status)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPACEENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function spaceEnable()
	if not Handbrake then
		SendNUIMessage({ Action = "Handbrake", Status = true })
		Handbrake = true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPACEDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function spaceDisable()
	if Handbrake then
		SendNUIMessage({ Action = "Handbrake", Status = false })
		Handbrake = false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+SpaceVehicle",spaceEnable)
RegisterCommand("-SpaceVehicle",spaceDisable)
RegisterKeyMapping("+SpaceVehicle","Freio do veículo.","keyboard","SPACE")