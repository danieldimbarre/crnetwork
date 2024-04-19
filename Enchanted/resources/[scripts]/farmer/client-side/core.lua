-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("farmer",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Poly = {}
local Displayed = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INPUTTARGETPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function InputTargetPosition(Number,v)
	if v["Model"] == "prop_money_bag_01" then
		exports["target"]:AddBoxZone("Farmer:"..Number,v["Coords"],v["Width"],v["Width"],{
			name = "Farmer:"..Number,
			heading = v["Heading"],
			minZ = v["Coords"]["z"],
			maxZ = v["Coords"]["z"] + 0.50
		},{
			shop = Number,
			Distance = v["Distance"],
			options = {
				{
					event = v["Event"],
					label = v["Label"],
					tunnel = "server"
				}
			}
		})
	else
		exports["target"]:AddCircleZone("Farmer:"..Number,v["Coords"],v["Width"],{
			name = "Farmer:"..Number,
			heading = v["Heading"],
			useZ = true
		},{
			shop = Number,
			Distance = v["Distance"],
			options = {
				{
					event = v["Event"],
					label = v["Label"],
					tunnel = "server"
				}
			}
		})
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	for Service,_ in pairs(FastFarmer) do
		for Number,v in pairs(FastFarmer[Service]["Coords"]) do
			exports["target"]:AddCircleZone(Service..":"..Number,v,FastFarmer[Service]["Width"],{
				name = Service..":"..Number,
				heading = 0.0,
				useZ = true
			},{
				Distance = FastFarmer[Service]["Distance"],
				options = FastFarmer[Service]["Options"]
			})
		end

		if FastFarmer[Service]["PolyZone"] and not Poly[Service] then
			Poly[Service] = PolyZone:Create(FastFarmer[Service]["PolyZone"],{ name = Service })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number,v in pairs(Objects) do
			if #(Coords - v["Coords"]) <= v["Show"] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
				if not Displayed[Number] and LoadModel(v["Model"]) then
					Displayed[Number] = CreateObjectNoOffset(v["Model"],v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"] - v["Height"],false,false,false)
					SetEntityHeading(Displayed[Number],v["Heading"])
					FreezeEntityPosition(Displayed[Number],true)
					SetModelAsNoLongerNeeded(v["Model"])
					InputTargetPosition(Number,v)
				end
			else
				if Displayed[Number] then
					if DoesEntityExist(Displayed[Number]) then
						DeleteEntity(Displayed[Number])
					end

					exports["target"]:RemCircleZone("Farmer:"..Number)
					Displayed[Number] = nil
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
for Number = 1,#Objects do
	AddStateBagChangeHandler("Farmer:"..Number,nil,function(Name,Key,Value)
		if Displayed[Number] then
			if DoesEntityExist(Displayed[Number]) then
				DeleteEntity(Displayed[Number])
			end

			exports["target"]:RemCircleZone("Farmer:"..Number)
			Displayed[Number] = nil
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLYZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.PolyZone(Service)
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	return Poly[Service] and Poly[Service]:isPointInside(Coords)
end