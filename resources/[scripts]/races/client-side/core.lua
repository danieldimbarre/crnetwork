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
local Blips = {}
local Tyres = {}
local Select = 1
local Points = 0
local Progress = 0
local Circuits = {}
local Start = false
local SpeedTyres = 0
local Checkpoint = 1
local Inative = false
local Ranking = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRACES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if not Inative then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			if Start then
				TimeDistance = 100
				Points = GetGameTimer() - Saved
				SendNUIMessage({ Action = "Progress", Points = Points, Timer = Progress - GetGameTimer() })

				if GetGameTimer() >= Progress then
					Leave()
				end

				local Distance = #(Coords - vec3(Circuits[Select]["Coords"][Checkpoint][1][1],Circuits[Select]["Coords"][Checkpoint][1][2],Circuits[Select]["Coords"][Checkpoint][1][3]))
				if Distance <= 5 then
					if Checkpoint >= #Circuits[Select]["Coords"] then
						SendNUIMessage({ Action = "Display", Status = false })
						vSERVER.finishRace(Select,Points)
						CleanObjects()
						CleanBlips()

						Saved = 0
						Tyres = {}
						Points = 0
						Select = 1
						Start = false
						Checkpoint = 1
						Ranking = false
					else
						if DoesBlipExist(Blips[Checkpoint]) then
							RemoveBlip(Blips[Checkpoint])
							Blips[Checkpoint] = nil
						end

						SetBlipRoute(Blips[Checkpoint + 1],true)
						SendNUIMessage({ Action = "Checkpoint" })
						Checkpoint = Checkpoint + 1
						MakeObjects()
					end
				end
			else
				for Number,v in pairs(Circuits) do
					local Distance = #(Coords - v["Init"])
					if Distance <= 25 then
						local Vehicle = GetVehiclePedIsUsing(Ped)
						if GetPedInVehicleSeat(Vehicle,-1) == Ped then
							DrawMarker(5,v["Init"]["x"],v["Init"]["y"],v["Init"]["z"] - 0.4,0.0,0.0,5.0,0.0,0.0,0.0,10.0,10.0,10.0,162,124,219,100,0,0,0,0)
							TimeDistance = 1

							if Distance <= 5 then
								if IsControlJustPressed(1,47) then
									if not Ranking then
										SendNUIMessage({ Action = "Ranking", Ranking = vSERVER.requestRanking(Number) })
										Ranking = true
									else
										SendNUIMessage({ Action = "Ranking", Ranking = false })
										Ranking = false
									end
								end

								if IsControlJustPressed(1,38) then
									if vSERVER.checkPermission(Number) then
										if Ranking then
											SendNUIMessage({ Action = "Ranking", Ranking = false })
											Ranking = false
										end

										SendNUIMessage({ Action = "Display", Status = true, Max = #Circuits[Number]["Coords"] })
										Progress = GetGameTimer() + (v["Timer"] * 1000)
										Saved = GetGameTimer()
										Select = Number
										Checkpoint = 1
										Points = 0

										MakeBlips()
										SetBlipRoute(Blips[Checkpoint],true)

										MakeObjects()
										Start = true
									end
								end
							else
								if Ranking then
									SendNUIMessage({ Action = "Ranking", Ranking = false })
									Ranking = false
								end
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeBlips()
	for Number = 1,#Circuits[Select]["Coords"] do
		Blips[Number] = AddBlipForCoord(Circuits[Select]["Coords"][Number][1][1],Circuits[Select]["Coords"][Number][1][2],Circuits[Select]["Coords"][Number][1][3])
		SetBlipSprite(Blips[Number],1)
		SetBlipColour(Blips[Number],60)
		SetBlipScale(Blips[Number],0.85)
		ShowNumberOnBlip(Blips[Number],Number)
		SetBlipAsShortRange(Blips[Number],true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeObjects()
	for Number,Object in pairs(Tyres) do
		if DoesEntityExist(Object) then
			DeleteEntity(Object)
			Tyres[Number] = nil
		end
	end

	if LoadModel("prop_offroad_tyres02") then
		Tyres[1] = CreateObjectNoOffset("prop_offroad_tyres02",Circuits[Select]["Coords"][Checkpoint][2][1],Circuits[Select]["Coords"][Checkpoint][2][2],Circuits[Select]["Coords"][Checkpoint][2][3],false,false,false)
		Tyres[2] = CreateObjectNoOffset("prop_offroad_tyres02",Circuits[Select]["Coords"][Checkpoint][3][1],Circuits[Select]["Coords"][Checkpoint][3][2],Circuits[Select]["Coords"][Checkpoint][3][3],false,false,false)

		PlaceObjectOnGroundProperly(Tyres[1])
		PlaceObjectOnGroundProperly(Tyres[2])

		SetEntityCollision(Tyres[1],false,false)
		SetEntityCollision(Tyres[2],false,false)

		SetEntityLodDist(Tyres[1],0xFFFF)
		SetEntityLodDist(Tyres[2],0xFFFF)

		SetModelAsNoLongerNeeded("prop_offroad_tyres02")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanBlips()
	for Num,Blipes in pairs(Blips) do
		if DoesBlipExist(Blipes) then
			RemoveBlip(Blipes)
			Blips[Num] = nil
		end
	end

	Blips = {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanObjects()
	for Num,Object in pairs(Tyres) do
		if DoesEntityExist(Object) then
			DeleteEntity(Object)
			Tyres[Num] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Leave()
	SendNUIMessage({ Action = "Display", Status = false })
	Ranking = false
	Checkpoint = 1
	Start = false
	Progress = 0
	Select = 1
	Points = 0
	Tyres = {}
	Saved = 0

	vSERVER.exitRace()
	CleanObjects()
	CleanBlips()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES:INATIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("races:Inative")
AddEventHandler("races:Inative",function(Status)
	Inative = Status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("races:Table")
AddEventHandler("races:Table",function(Table)
	Circuits = Table

	for _,Info in pairs(Circuits) do
		local Inits = AddBlipForRadius(Info["Init"]["x"],Info["Init"]["y"],Info["Init"]["z"],10.0)
		SetBlipAlpha(Inits,200)
		SetBlipColour(Inits,59)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKES
-----------------------------------------------------------------------------------------------------------------------------------------
local Bikes = {
	[1131912276] = true,
	[448402357] = true,
	[-836512833] = true,
	[-186537451] = true,
	[1127861609] = true,
	[-1233807380] = true,
	[-400295096] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if not Start then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				TimeDistance = 1

				DisableControlAction(0,345,true)

				local Vehicle = GetVehiclePedIsUsing(Ped)
				if GetPedInVehicleSeat(Vehicle,-1) == Ped then
					if GetVehicleDirtLevel(Vehicle) ~= 0.0 then
						SetVehicleDirtLevel(Vehicle,0.0)
					end

					local Speed = GetEntitySpeed(Vehicle) * 3.6
					if Speed ~= SpeedTyres then
						if (SpeedTyres - Speed) >= 125 then
							TyreBurst(Vehicle)
						end

						SpeedTyres = Speed
					end
				end
			else
				if SpeedTyres ~= 0 then
					SpeedTyres = 0
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
function TyreBurst(Vehicle)
	if Bikes[GetEntityModel(Vehicle)] == nil then
		local Tyre = math.random(4)
		if Tyre == 1 then
			if GetTyreHealth(Vehicle,0) == 1000.0 then
				SetVehicleTyreBurst(Vehicle,0,true,1000.0)
			end
		elseif Tyre == 2 then
			if GetTyreHealth(Vehicle,1) == 1000.0 then
				SetVehicleTyreBurst(Vehicle,1,true,1000.0)
			end
		elseif Tyre == 3 then
			if GetTyreHealth(Vehicle,4) == 1000.0 then
				SetVehicleTyreBurst(Vehicle,4,true,1000.0)
			end
		elseif Tyre == 4 then
			if GetTyreHealth(Vehicle,5) == 1000.0 then
				SetVehicleTyreBurst(Vehicle,5,true,1000.0)
			end
		end
	end
end