-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("grime")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Lasted = 1
local Selected = 1
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	exports["target"]:AddBoxZone("WorkGrime",Init["xyz"],0.75,0.75,{
		name = "WorkGrime",
		heading = Init["w"],
		minZ = Init["z"] - 1.0,
		maxZ = Init["z"] + 1.0
	},{
		Distance = 1.75,
		options = {
			{
				event = "grime:Init",
				label = "Iniciar Entregas",
				tunnel = "client"
			},{
				event = "grime:Package",
				label = "Retirar Encomenda",
				tunnel = "server"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIME:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("grime:Init",function()
	if Active then
		if DoesBlipExist(Blip) then
			RemoveBlip(Blip)
			Blip = nil
		end

		TriggerEvent("Notify","Sucesso","Trabalho finalizado.","verde",5000)
		exports["target"]:LabelText("WorkGrime","Iniciar Entregas")
		Active = false
	else
		TriggerEvent("Notify","Sucesso","Trabalho iniciado.","verde",5000)
		exports["target"]:LabelText("WorkGrime","Finalizar Entregas")
		Active = true

		repeat
			if Lasted == Selected then
				Selected = math.random(#Locations)
			end

			Wait(1)
		until Lasted ~= Selected

		MakeBlips()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if Active and not IsPedInAnyVehicle(Ped) then
			local Vehicle = GetPlayersLastVehicle()
			if GetEntityArchetypeName(Vehicle) == Model then
				local Coords = GetEntityCoords(Ped)
				local Distance = #(Coords - Locations[Selected])

				if Distance <= 10.0 then
					TimeDistance = 1
					DrawText3D(Locations[Selected],"~g~H~w~   ENTREGAR")

					if Distance <= 1.0 and IsControlJustPressed(1,74) and vSERVER.Payment(Selected) then
						Lasted = Selected

						repeat
							if Lasted == Selected then
								Selected = math.random(#Locations)
							end

							Wait(1)
						until Lasted ~= Selected

						MakeBlips()
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(Coords,Text)
	local Screen,x,y = World3dToScreen2d(Coords["x"],Coords["y"],Coords["z"])

	if Screen then
		SetTextFont(4)
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextScale(0.35,0.35)
		SetTextColour(200,200,200,200)

		SetTextEntry("STRING")
		AddTextComponentString(Text)
		EndTextCommandDisplayText(x,y)

		local Width = string.len(Text) / 350
		DrawRect(x,y + 0.0125,Width,0.03,15,15,15,200)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeBlips()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Blip = AddBlipForCoord(Locations[Selected]["x"],Locations[Selected]["y"],Locations[Selected]["z"])
	SetBlipSprite(Blip,1)
	SetBlipDisplay(Blip,4)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,77)
	SetBlipScale(Blip,0.75)
	SetBlipRoute(Blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega")
	EndTextCommandSetBlipName(Blip)
end