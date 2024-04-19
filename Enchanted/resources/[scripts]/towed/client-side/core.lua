-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("towed")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Destiny = 1
local Vehicle = nil
local Service = false
local ModelSelected = ""
local TimeDistance = 999
local VehiclePlate = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	exports["target"]:AddCircleZone("WorkTowed",Init,0.15,{
		name = "WorkTowed",
		heading = 0.0,
		useZ = true
	},{
		Distance = 1.0,
		options = {
			{
				event = "towed:Init",
				label = "Trabalhar",
				tunnel = "client"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWED:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("towed:Init",function()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	if Service then
		TriggerEvent("Notify","Impound","Trabalho finalizado.","verde",5000)
		exports["target"]:LabelText("WorkTowed","Trabalhar")
		Service = false
	else
		TriggerEvent("Notify","Impound","Trabalho iniciado.","verde",5000)
		exports["target"]:LabelText("WorkTowed","Finalizar")
		ModelSelected = Models[math.random(#Models)]
		Destiny = math.random(#Locations)
		VehiclePlate = nil
		MarkedVehicle()
		Service = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWED:INATIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("towed:Inative")
AddEventHandler("towed:Inative",function(Plate)
	if VehiclePlate == Plate then
		ModelSelected = Models[math.random(#Models)]
		Destiny = math.random(#Locations)
		VehiclePlate = false
		TimeDistance = 999
		MarkedVehicle()
		Vehicle = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Service then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			if not Vehicle then
				if #(Coords - Locations[Destiny]["xyz"]) <= 100 then
					Vehicle,Plate = vSERVER.CreateVehicle(ModelSelected,Destiny)
					TimeDistance = 1999

					SetTimeout(1000,function()
						if DoesBlipExist(Blip) then
							RemoveBlip(Blip)
							Blip = nil
						end

						VehiclePlate = Plate
						Vehicle = NetToEnt(Vehicle)

						SetVehicleEngineHealth(Vehicle,10.0)
						SetVehicleHasBeenOwnedByPlayer(Vehicle,true)
						SetVehicleNeedsToBeHotwired(Vehicle,false)
						DecorSetInt(Vehicle,"Player_Vehicle",-1)
						SetVehicleOnGroundProperly(Vehicle)
						SetVehRadioStation(Vehicle,"OFF")
						SetEntityHealth(Vehicle,10)

						SetModelAsNoLongerNeeded(ModelSelected)
					end)
				end
			elseif DoesEntityExist(Vehicle) and not Entity(Vehicle)["state"]["Tow"] then
				TimeDistance = 1

				local OtherCoords = GetEntityCoords(Vehicle)
				DrawMarker(22,OtherCoords["x"],OtherCoords["y"],OtherCoords["z"] + 2.5,0.0,0.0,0.0,0.0,180.0,0.0,2.5,2.5,1.5,65,130,226,100,0,0,0,1)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKEDPASSENGER
-----------------------------------------------------------------------------------------------------------------------------------------
function MarkedVehicle()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Blip = AddBlipForCoord(Locations[Destiny]["x"],Locations[Destiny]["y"],Locations[Destiny]["z"])
	SetBlipSprite(Blip,1)
	SetBlipDisplay(Blip,4)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,77)
	SetBlipScale(Blip,0.75)
	SetBlipRoute(Blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veiculo Quebrado")
	EndTextCommandSetBlipName(Blip)
end