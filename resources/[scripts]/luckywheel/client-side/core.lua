-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("luckywheel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Wheel = nil
local Vehicle = nil
local Active = false
LocalPlayer["state"]["Cassino"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUCKYWHEEL:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("luckywheel:Active")
AddEventHandler("luckywheel:Active",function()
	if LocalPlayer["state"]["Cassino"] then
		Active = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCASSINO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)
			local Distance = #(Coords - vec3(981.75,34.61,71.46))
			if Distance <= 100 then
				if not LocalPlayer["state"]["Cassino"] then
					LocalPlayer["state"]["Cassino"] = true

					if LoadModel("silvias15") and LoadModel("vw_prop_vw_luckywheel_02a") then
						Wheel = CreateObjectNoOffset("vw_prop_vw_luckywheel_02a",990.48,43.31,71.26,false,false,false)
						SetEntityHeading(Wheel,0.0)

						Vehicle = CreateVehicle("silvias15",975.6,40.62,72.15,195.6,false,false)
						SetVehicleNumberPlateText(Vehicle,"PDMSPORT")
						SetVehicleOnGroundProperly(Vehicle)
						FreezeEntityPosition(Vehicle,true)
						SetEntityInvincible(Vehicle,true)
						SetVehicleDoorsLocked(Vehicle,2)
						SetVehicleColours(Vehicle,29,1)

						SetModelAsNoLongerNeeded("vw_prop_vw_luckywheel_02a")
						SetModelAsNoLongerNeeded("silvias15")
					end
				end
			else
				if LocalPlayer["state"]["Cassino"] then
					LocalPlayer["state"]["Cassino"] = false

					if DoesEntityExist(Vehicle) then
						DeleteEntity(Vehicle)
					end

					if DoesEntityExist(Wheel) then
						DeleteEntity(Wheel)
					end

					Vehicle = nil
					Wheel = nil
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUCKYWHEEL:START
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("luckywheel:Start")
AddEventHandler("luckywheel:Start",function(Result)
	if Result ~= nil then
		if LocalPlayer["state"]["Cassino"] then
			if DoesEntityExist(Wheel) then
				SetEntityRotation(Wheel,0.0,0.0,0.0,2,true)
			end

			CreateThread(function()
				local rollingRatio = 1
				local rollingSpeed = 1.0
				local rollingAngle = (Result - 1) * 18
				local wheelAngles = rollingAngle + (360 * 8)
				local middleResult = (wheelAngles / 2)

				while rollingRatio > 0 do
					local xRot = GetEntityRotation(Wheel,2)
					if wheelAngles > middleResult then
						rollingRatio = rollingRatio + 1
					else
						rollingRatio = rollingRatio - 1

						if rollingRatio <= 0 then
							rollingRatio = 0

							if Active then
								TriggerServerEvent("luckywheel:Payment")
								Active = false
							end
						end
					end

					rollingSpeed = rollingRatio / 200
					local yRot = xRot["y"] - rollingSpeed
					wheelAngles = wheelAngles - rollingSpeed
					SetEntityRotation(Wheel,0.0,yRot,0.0,2,true)

					Wait(0)
				end
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETROLL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("luckywheel:Target")
AddEventHandler("luckywheel:Target",function()
	if LocalPlayer["state"]["Cassino"] then
		if vSERVER.checkRolling() then
			TriggerServerEvent("luckywheel:Rolling")
		end
	end
end)