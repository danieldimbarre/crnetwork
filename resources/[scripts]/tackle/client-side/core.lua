-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 100
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) and IsPedJumping(Ped) then
				TimeDistance = 1

				if IsControlJustReleased(1,51) then
					local tackled = {}
					local Coords = GetEntityForwardVector(Ped)

					SetPedToRagdollWithFall(Ped,2500,1500,0,Coords,1.0,0.0,0.0,0.0,0.0,0.0,0.0)

					while IsPedRagdoll(Ped) do
						for _,v in ipairs(touchedPlayers()) do
							if not tackled[v] then
								tackled[v] = true
								TriggerServerEvent("inventory:Cancel")
								TriggerServerEvent("tackle:Update",GetPlayerServerId(v),{ Coords["x"],Coords["y"],Coords["z"] })
							end
						end

						Wait(1)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TACKLE:PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tackle:Player")
AddEventHandler("tackle:Player",function(Coords)
	SetPedToRagdollWithFall(PlayerPedId(),5000,5000,0,Coords[1],Coords[2],Coords[3],10.0,0.0,0.0,0.0,0.0,0.0,0.0)
	TriggerServerEvent("inventory:Cancel")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOUCHEDPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function touchedPlayers()
	local players = {}
	local Ped = PlayerPedId()
	for k,v in ipairs(GetActivePlayers()) do
		local uPed = GetPlayerPed(v)
		if IsEntityTouchingEntity(Ped,uPed) and not IsPedInAnyVehicle(uPed) then
			table.insert(players,v)
		end
	end

	return players
end