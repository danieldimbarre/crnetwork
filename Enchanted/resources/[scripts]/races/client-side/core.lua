-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("races")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Saved = 0
local Blip = nil
local Objects = {}
local Selected = 1
local Markers = {}
local Checkpoint = 1
local Ranking = false
local ExplodeTimers = false
local ExplodeCooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRACES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetGhostedEntityAlpha(254)
	LoadModel("prop_beachflag_01")
	LoadModel("prop_offroad_tyres02")

	for _,v in pairs(Races) do
		local Blip = AddBlipForCoord(v["Init"])
		SetBlipSprite(Blip,38)
		SetBlipDisplay(Blip,4)
		SetBlipAsShortRange(Blip,true)
		SetBlipColour(Blip,4)
		SetBlipScale(Blip,0.6)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Circuito")
		EndTextCommandSetBlipName(Blip)
	end

	while true do
		local TimeDistance = 999
		if not LocalPlayer["state"]["TestDrive"] then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			local Vehicle = GetPlayersLastVehicle()

			if LocalPlayer["state"]["Races"] then
				TimeDistance = 1
				local Points = GetGameTimer() - Saved

				if ExplodeTimers and GetGameTimer() >= ExplodeCooldown then
					ExplodeTimers = ExplodeTimers - 1
					ExplodeCooldown = GetGameTimer() + 1000
				end

				SendNUIMessage({ name = "Progress", payload = { Points,ExplodeTimers } })

				if not IsPedInAnyVehicle(Ped) or GetPedInVehicleSeat(Vehicle,-1) ~= Ped or (ExplodeTimers and ExplodeTimers <= 0) then
					SetNetworkVehicleAsGhost(Vehicle,false)
					SetLocalPlayerAsGhost(false)
					StopCircuit()
				end

				local Distance = #(Coords - Races[Selected]["Coords"][Checkpoint]["Center"])
				if Distance <= (Races[Selected]["Coords"][Checkpoint]["Distance"] + 1.0) then
					if Checkpoint >= #Races[Selected]["Coords"] then
						SendNUIMessage({ name = "Display", payload = { false } })
						vSERVER.Finish(Selected,Points)
						CleanObjects()
						CleanMarker()

						Saved = 0
						Checkpoint = 1
						ExplodeTimers = false
						SetLocalPlayerAsGhost(false)
						SetNetworkVehicleAsGhost(Vehicle,false)
						LocalPlayer["state"]:set("Races",false,false)
						SendNUIMessage({ name = "Ranking", payload = { true,vSERVER.Ranking(Selected) } })
						Selected = 1

						SetTimeout(5000,function()
							SendNUIMessage({ name = "Ranking", payload = { false } })
						end)
					else
						if DoesBlipExist(Markers[Checkpoint]) then
							RemoveBlip(Markers[Checkpoint])
							Markers[Checkpoint] = nil
						end

						Checkpoint = Checkpoint + 1
						SetBlipRoute(Markers[Checkpoint],true)
						SendNUIMessage({ name = "Checkpoint" })
						CreatedTyres()
					end
				end
			else
				if IsPedInAnyVehicle(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyBoat(Ped) and not IsPedInAnyPlane(Ped) then
					for Number,v in pairs(Races) do
						local Distance = #(Coords - v["Init"])
						if Distance <= 25 and GetPedInVehicleSeat(Vehicle,-1) == Ped then
							DrawMarker(23,v["Init"]["x"],v["Init"]["y"],v["Init"]["z"] - 0.35,0.0,0.0,0.0,0.0,0.0,0.0,10.0,10.0,10.0,93,161,248,175,0,0,0,0)
							TimeDistance = 1

							if Distance <= 5 then
								if IsControlJustPressed(1,47) then
									if not Ranking then
										Ranking = true
										SendNUIMessage({ name = "Ranking", payload = { true,vSERVER.Ranking(Number) } })
									else
										Ranking = false
										SendNUIMessage({ name = "Ranking", payload = { false } })
									end
								end

								if IsControlJustPressed(1,38) then
									ExplodeTimers = vSERVER.Start(Number)
									SendNUIMessage({ name = "Display", payload = { true,#Races[Number]["Coords"],ExplodeTimers } })

									if ExplodeTimers then
										ExplodeCooldown = GetGameTimer() + 1000
									end

									SetNetworkVehicleAsGhost(Vehicle,true)
									SetLocalPlayerAsGhost(true)

									Saved = GetGameTimer()
									Selected = Number
									Checkpoint = 1

									LocalPlayer["state"]:set("Races",true,false)
									CreatedTyres()
									InitCircuit()
								end
							elseif Ranking then
								Ranking = false
								SendNUIMessage({ name = "Ranking", payload = { false } })
							end
						end
					end
				elseif Ranking then
					Ranking = false
					SendNUIMessage({ name = "Ranking", payload = { false } })
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITCIRCUIT
-----------------------------------------------------------------------------------------------------------------------------------------
function InitCircuit()
	for Number = 1,#Races[Selected]["Coords"] do
		Markers[Number] = AddBlipForCoord(Races[Selected]["Coords"][Number]["Center"]["x"],Races[Selected]["Coords"][Number]["Center"]["y"],Races[Selected]["Coords"][Number]["Center"]["z"])
		SetBlipSprite(Markers[Number],1)
		SetBlipColour(Markers[Number],77)
		SetBlipScale(Markers[Number],0.85)
		ShowNumberOnBlip(Markers[Number],Number)
		SetBlipAsShortRange(Markers[Number],true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEDTYRES
-----------------------------------------------------------------------------------------------------------------------------------------
function CreatedTyres()
	CleanObjects()

	local Prop = "prop_offroad_tyres02"
	if Checkpoint >= #Races[Selected]["Coords"] then
		Prop = "prop_beachflag_01"
	end

	local Coords = Races[Selected]["Coords"][Checkpoint]
	Objects["Left"] = CreateObjectNoOffset(Prop,Coords["Left"]["x"],Coords["Left"]["y"],Coords["Left"]["z"],false,false,false)
	Objects["Right"] = CreateObjectNoOffset(Prop,Coords["Right"]["x"],Coords["Right"]["y"],Coords["Right"]["z"],false,false,false)

	PlaceObjectOnGroundProperly(Objects["Left"])
	SetEntityCollision(Objects["Left"],false,false)

	PlaceObjectOnGroundProperly(Objects["Right"])
	SetEntityCollision(Objects["Right"],false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANMARKER
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanMarker()
	for Index,v in pairs(Markers) do
		if DoesBlipExist(v) then
			RemoveBlip(v)
		end

		Markers[Index] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanObjects()
	for Index,v in pairs(Objects) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end

		Objects[Index] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPCIRCUIT
-----------------------------------------------------------------------------------------------------------------------------------------
function StopCircuit()
	SendNUIMessage({ name = "Display", payload = { false } })
	LocalPlayer["state"]:set("Races",false,false)
	vSERVER.Cancel()
	CleanObjects()
	CleanMarker()

	if ExplodeTimers then
		ExplodeTimers = false

		SetTimeout(5000,function()
			local Vehicle = GetPlayersLastVehicle()

			if Vehicle == 0 then
				local Ped = PlayerPedId()
				local Coords = GetEntityCoords(Ped)

				AddExplosion(Coords,2,0.5,false,false,false)
			else
				NetworkExplodeVehicle(Vehicle,true,false,true)
			end
		end)
	end
end