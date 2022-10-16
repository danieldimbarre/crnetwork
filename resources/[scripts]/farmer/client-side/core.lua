-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Objects = {}
local initObjects = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INPUTTARGETPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function InputTargetPosition(Number,v)
	if v["prop"] == "prop_money_bag_01" then
		exports["target"]:AddBoxZone("Farmer:"..Number,vec3(v["x"],v["y"],v["z"]),v["width"],v["width"],{
			name = "Farmer:"..Number,
			heading = v["heading"],
			minZ = v["z"] - 1.0,
			maxZ = v["z"] - 0.5
		},{
			shop = Number,
			Distance = v["Distance"],
			options = {
				{
					event = v["event"],
					label = v["label"],
					tunnel = "server"
				}
			}
		})
	else
		exports["target"]:AddCircleZone("Farmer:"..Number,vec3(v["x"],v["y"],v["z"]),v["width"],{
			name = "Farmer:"..Number,
			heading = v["heading"]
		},{
			shop = Number,
			Distance = v["Distance"],
			options = {
				{
					event = v["event"],
					label = v["label"],
					tunnel = "server"
				}
			}
		})
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number,v in pairs(Objects) do
			local Distance = #(Coords - vec3(v["x"],v["y"],v["z"]))
			if Distance <= v["show"] and GlobalState["Work"] >= v["time"] then
				if not initObjects[Number] then
					if LoadModel(v["prop"]) then
						initObjects[Number] = CreateObjectNoOffset(v["prop"],v["x"],v["y"],v["z"] - v["height"],false,false,false)
						FreezeEntityPosition(initObjects[Number],true)
						SetModelAsNoLongerNeeded(v["prop"])
						InputTargetPosition(Number,v)

						if v["heading"] then
							SetEntityHeading(initObjects[Number],v["heading"])
						end
					end
				end
			else
				if initObjects[Number] then
					exports["target"]:RemCircleZone("Farmer:"..Number)

					if DoesEntityExist(initObjects[Number]) then
						DeleteEntity(initObjects[Number])
						initObjects[Number] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FARMER:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("farmer:Remover")
AddEventHandler("farmer:Remover",function(Number,Timers)
	if Objects[Number] then
		Objects[Number]["time"] = Timers

		if initObjects[Number] then
			exports["target"]:RemCircleZone("Farmer:"..Number)

			if DoesEntityExist(initObjects[Number]) then
				DeleteEntity(initObjects[Number])
				initObjects[Number] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FARMER:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("farmer:Table")
AddEventHandler("farmer:Table",function(Table)
	Objects = Table
end)