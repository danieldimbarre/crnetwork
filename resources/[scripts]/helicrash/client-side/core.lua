-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Objects = {}
local Active = false
local Components = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Active and Components[Active] then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			local Crashed = Components[Active]["Objects"]
			local Distance = #(Coords - vec3(Crashed["1"][1],Crashed["1"][2],Crashed["1"][3]))

			if Distance <= 250 then
				for Number,v in pairs(Crashed) do
					if not Objects[Number] then
						if LoadModel(v[5]) then
							Objects[Number] = CreateObjectNoOffset(v[5],v[1],v[2],v[3],false,false,false)
							PlaceObjectOnGroundProperly(Objects[Number])
							FreezeEntityPosition(Objects[Number],true)
							SetEntityLodDist(Objects[Number],0xFFFF)
							SetEntityHeading(Objects[Number],v[4])
							SetModelAsNoLongerNeeded(v[4])

							if Number ~= "1" then
								exports["target"]:AddCircleZone("Helicrash:"..Number,vec3(v[1],v[2],v[3]),0.5,{
									name = "Helicrash:"..Number,
									heading = 3374176
								},{
									shop = "Helicrash"..Number,
									Distance = 1.75,
									options = {
										{
											event = "chest:Open",
											label = "Abrir",
											tunnel = "shop",
											service = "Custom"
										}
									}
								})
							end
						end
					end
				end
			else
				if Objects["1"] then
					for Number,v in pairs(Objects) do
						DeleteEntity(Objects[Number])
						Objects[Number] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELICRASH:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("helicrash:Active")
AddEventHandler("helicrash:Active",function(Number)
	Active = Number
	HeliBlip(Active)

	if Objects["1"] then
		for Number,v in pairs(Objects) do
			exports["target"]:RemCircleZone("Helicrash:"..Number)

			if DoesEntityExist(Objects[Number]) then
				DeleteEntity(Objects[Number])
			end

			Objects[Number] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELICRASH:REMOVEBOX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("helicrash:RemoveBox")
AddEventHandler("helicrash:RemoveBox",function(Number)
	if Objects[Number] then
		exports["target"]:RemCircleZone("Helicrash:"..Number)

		if DoesEntityExist(Objects[Number]) then
			DeleteEntity(Objects[Number])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELICRASH:CLEAREVENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("helicrash:ClearEvent")
AddEventHandler("helicrash:ClearEvent",function()
	Active = false

	if Objects["1"] then
		for Number,_ in pairs(Objects) do
			if Number ~= "1" then
				exports["target"]:RemCircleZone("Helicrash:"..Number)

				if DoesEntityExist(Objects[Number]) then
					DeleteEntity(Objects[Number])
				end

				Objects[Number] = nil
			end
		end
	end

	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELICRASH:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("helicrash:Table")
AddEventHandler("helicrash:Table",function(Table,Number)
	Active = Number
	Components = Table

	if Active then
		HeliBlip(Active)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELIBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function HeliBlip(Number)
	Blip = AddBlipForCoord(Components[Number]["Objects"]["1"][1],Components[Number]["Objects"]["1"][2],Components[Number]["Objects"]["1"][3])
	SetBlipSprite(Blip,43)
	SetBlipDisplay(Blip,4)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,5)
	SetBlipScale(Blip,0.8)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Helicrash")
	EndTextCommandSetBlipName(Blip)
end