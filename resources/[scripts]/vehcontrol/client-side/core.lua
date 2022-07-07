---------------------------------------------------------------------
local CountSend = 0
local TimerSend = 0
local DelaySend = 1000
local SirenTemporary = 0
local MuteTemporary = false
---------------------------------------------------------------------
local LxSound = {}
local LxStatus = {}
---------------------------------------------------------------------
local AirSound = {}
local AirStatus = {}
---------------------------------------------------------------------
function TogMuteDfltSrnForVeh(Vehicle,Status)
	if DoesEntityExist(Vehicle) and not IsEntityDead(Vehicle) then
		DisableVehicleImpactExplosionActivation(Vehicle,Status)
	end
end
---------------------------------------------------------------------
function SetLxSirenStateForVeh(Vehicle,Status)
	if DoesEntityExist(Vehicle) and not IsEntityDead(Vehicle) then
		if Status ~= LxStatus[Vehicle] then
			if LxSound[Vehicle] ~= nil then
				StopSound(LxSound[Vehicle])
				ReleaseSoundId(LxSound[Vehicle])
				LxSound[Vehicle] = nil
			end

			if Status == 1 then
				LxSound[Vehicle] = GetSoundId()	
				PlaySoundFromEntity(LxSound[Vehicle],"RESIDENT_VEHICLES_SIREN_WAIL_03",Vehicle,0,0,0)
				TogMuteDfltSrnForVeh(Vehicle,true)
			elseif Status == 2 then
				LxSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(LxSound[Vehicle],"RESIDENT_VEHICLES_SIREN_QUICK_03",Vehicle,0,0,0)
				TogMuteDfltSrnForVeh(Vehicle,true)
			elseif Status == 3 then
				LxSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(LxSound[Vehicle],"RESIDENT_VEHICLES_SIREN_FIRETRUCK_QUICK_01",Vehicle,0,0,0)
				TogMuteDfltSrnForVeh(Vehicle,true)
			elseif Status == 4 then
				LxSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(LxSound[Vehicle],"RESIDENT_VEHICLES_SIREN_WAIL_01",Vehicle,0,0,0)
				TogMuteDfltSrnForVeh(Vehicle,true)
			elseif Status == 5 then
				LxSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(LxSound[Vehicle],"RESIDENT_VEHICLES_SIREN_WAIL_02",Vehicle,0,0,0)
				TogMuteDfltSrnForVeh(Vehicle,true)
			elseif Status == 6 then
				LxSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(LxSound[Vehicle],"RESIDENT_VEHICLES_SIREN_QUICK_01",Vehicle,0,0,0)
				TogMuteDfltSrnForVeh(Vehicle,true)
			elseif Status == 7 then
				LxSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(LxSound[Vehicle],"RESIDENT_VEHICLES_SIREN_QUICK_02",Vehicle,0,0,0)
				TogMuteDfltSrnForVeh(Vehicle,true)
			else
				TogMuteDfltSrnForVeh(Vehicle,true)
			end

			LxStatus[Vehicle] = Status
		end
	end
end
---------------------------------------------------------------------
function SetAirManuStateForVeh(Vehicle,Status)
	if DoesEntityExist(veVehicleh) and not IsEntityDead(Vehicle) then
		if Status ~= AirStatus[Vehicle] then
			if AirSound[Vehicle] ~= nil then
				StopSound(AirSound[Vehicle])
				ReleaseSoundId(AirSound[Vehicle])
				AirSound[Vehicle] = nil
			end

			if Status == 1 then
				AirSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(AirSound[Vehicle],"RESIDENT_VEHICLES_SIREN_WAIL_03",Vehicle,0,0,0)
			elseif Status == 2 then
				AirSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(AirSound[Vehicle],"RESIDENT_VEHICLES_SIREN_QUICK_03",Vehicle,0,0,0)
			elseif Status == 3 then
				AirSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(AirSound[Vehicle],"RESIDENT_VEHICLES_SIREN_FIRETRUCK_QUICK_01",Vehicle,0,0,0)
			elseif Status == 4 then
				AirSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(AirSound[Vehicle],"RESIDENT_VEHICLES_SIREN_WAIL_01",Vehicle,0,0,0)
			elseif Status == 5 then
				AirSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(AirSound[Vehicle],"RESIDENT_VEHICLES_SIREN_WAIL_02",Vehicle,0,0,0)
			elseif Status == 6 then
				AirSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(AirSound[Vehicle],"RESIDENT_VEHICLES_SIREN_QUICK_01",Vehicle,0,0,0)
			elseif Status == 7 then
				AirSound[Vehicle] = GetSoundId()
				PlaySoundFromEntity(AirSound[Vehicle],"RESIDENT_VEHICLES_SIREN_QUICK_02",Vehicle,0,0,0)
			end

			AirStatus[Vehicle] = Status
		end
	end
end
---------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if CountSend > 400 then
			CountSend = 0

			for k,v in pairs(LxStatus) do
				if v > 0 then
					if not DoesEntityExist(k) or IsEntityDead(k) then
						if LxSound[k] ~= nil then
							StopSound(LxSound[k])
							ReleaseSoundId(LxSound[k])
							LxSound[k] = nil
							LxStatus[k] = nil
						end
					end
				end
			end

			for k,v in pairs(AirStatus) do
				if v then
					if not DoesEntityExist(k) or IsEntityDead(k) or IsVehicleSeatFree(k,-1) then
						if AirSound[k] ~= nil then
							StopSound(AirSound[k])
							ReleaseSoundId(AirSound[k])
							AirSound[k] = nil
							AirStatus[k] = nil
						end
					end
				end
			end
		else
			CountSend = CountSend + 1
		end

		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle,-1) == Ped then
				if GetVehicleClass(Vehicle) == 18 then
					TimeDistance = 1
					local ActiveHorn = false
					local ActiveManual = false

					SetVehRadioStation(Vehicle,"OFF")
					DisableControlAction(1,86,true)
					DisableControlAction(1,19,true)
					DisableControlAction(1,85,true)
					DisableControlAction(1,80,true)
					SetVehicleRadioEnabled(Vehicle,false)

					if LxStatus[Vehicle] ~= 1 and LxStatus[Vehicle] ~= 2 and LxStatus[Vehicle] ~= 3 and LxStatus[Vehicle] ~= 4 and LxStatus[Vehicle] ~= 5 and LxStatus[Vehicle] ~= 6 and LxStatus[Vehicle] ~= 7 then
						LxStatus[Vehicle] = 0
					end

					if AirStatus[Vehicle] ~= 1 and AirStatus[Vehicle] ~= 2 and AirStatus[Vehicle] ~= 3 and AirStatus[Vehicle] ~= 4 and AirStatus[Vehicle] ~= 5 and AirStatus[Vehicle] ~= 6 and AirStatus[Vehicle] ~= 7 then
						AirStatus[Vehicle] = 0
					end

					TogMuteDfltSrnForVeh(Vehicle,true)

					if not IsVehicleSirenOn(Vehicle) and LxStatus[Vehicle] > 0 then
						SetLxSirenStateForVeh(Vehicle,0)
						TimerSend = DelaySend
					end

					if not IsPauseMenuActive() then
						if IsDisabledControlJustReleased(0,85) then
							if IsVehicleSirenOn(Vehicle) then
								SetVehicleSiren(Vehicle,false)
							else
								SetVehicleSiren(Vehicle,true)
								TimerSend = DelaySend
							end
						elseif IsDisabledControlJustReleased(0,19) then
							if LxStatus[Vehicle] == 0 then
								if IsVehicleSirenOn(Vehicle) then
									SetLxSirenStateForVeh(Vehicle,1)
									TimerSend = DelaySend
								end
							else
								SetLxSirenStateForVeh(Vehicle,0)
								TimerSend = DelaySend
							end
						end

						if LxStatus[Vehicle] > 0 then
							if IsDisabledControlJustReleased(0,80) then
								if IsVehicleSirenOn(Vehicle) then
									local Status = 1

									if LxStatus[Vehicle] == 1 then
										Status = 2
									elseif LxStatus[Vehicle] == 2 then
										Status = 3
									elseif LxStatus[Vehicle] == 3 then
										Status = 4
									elseif LxStatus[Vehicle] == 4 then
										Status = 5
									elseif LxStatus[Vehicle] == 5 then
										Status = 6
									elseif LxStatus[Vehicle] == 6 then
										Status = 7
									end

									SetLxSirenStateForVeh(Vehicle,Status)
									TimerSend = DelaySend
								end
							end
						end

						if LxStatus[Vehicle] < 1 then
							if IsDisabledControlPressed(1,80) then
								ActiveManual = true
							else
								ActiveManual = false
							end
						else
							ActiveManual = false
						end

						if IsDisabledControlPressed(1,86) then
							ActiveHorn = true
						else
							ActiveHorn = false
						end
					end

					local HornStatus = 0
					if ActiveHorn and not ActiveManual then
						HornStatus = 1
					elseif not ActiveHorn and ActiveManual then
						HornStatus = 2
					elseif ActiveHorn and ActiveManual then
						HornStatus = 3
					end

					if HornStatus == 1 then
						if LxStatus[Vehicle] > 0 and not MuteTemporary then
							SirenTemporary = LxStatus[Vehicle]
							SetLxSirenStateForVeh(Vehicle,0)
							MuteTemporary = true
						end
					else
						if MuteTemporary then
							SetLxSirenStateForVeh(Vehicle,SirenTemporary)
							MuteTemporary = false
						end
					end

					if AirStatus[Vehicle] ~= HornStatus then
						SetAirManuStateForVeh(Vehicle,HornStatus)
						TimerSend = DelaySend
					end

					if TimerSend > DelaySend then
						TimerSend = 0
						TriggerServerEvent("vehcontrol:Server",LxStatus[Vehicle],AirStatus[Vehicle],VehToNet(Vehicle))
					else
						TimerSend = TimerSend + 1
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
---------------------------------------------------------------------
RegisterNetEvent("vehcontrol:Client")
AddEventHandler("vehcontrol:Client",function(Siren,Air,vehNet,source)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			local Player = GetPlayerFromServerId(source)
			local Ped = GetPlayerPed(Player)

			if Ped ~= PlayerPedId() then
				TogMuteDfltSrnForVeh(Vehicle,true)
				SetAirManuStateForVeh(Vehicle,Air)
				SetLxSirenStateForVeh(Vehicle,Siren)
			end
		end
	end
end)