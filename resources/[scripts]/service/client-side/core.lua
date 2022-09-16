-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("service")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if GetCurrentResourceName() == Resource then
		SetNuiFocus(false,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local serviceList = {
	{ 441.81,-982.05,30.83,"Lspd",1.0 },
	{ 1833.75,3678.34,34.27,"Sheriff-1",1.0 },
	{ -447.28,6013.01,32.41,"Sheriff-2",1.0 },
	{ 1840.20,2578.48,46.07,"Corrections",1.0 },
	{ 385.43,794.42,187.48,"Ranger",1.0 },
	{ 382.01,-1596.39,29.91,"State",1.0 },
	{ 310.23,-597.54,43.29,"Paramedic-1",1.0 },
	{ -254.77,6331.03,32.79,"Paramedic-2",1.5 },
	{ 1188.05,-1468.31,34.66,"Paramedic-3",1.5 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for k,v in pairs(serviceList) do
		exports["target"]:AddCircleZone("Service:"..v[4],vec3(v[1],v[2],v[3]),0.10,{
			name = "Service:"..v[4],
			heading = 3374176,
			useZ = true
		},{
			shop = k,
			Distance = v[5],
			options = {
				{
					label = "Entrar em Serviço",
					event = "service:Toggle",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Toggle")
AddEventHandler("service:Toggle",function(Service)
	if LocalPlayer["state"]["Route"] < 900000 then
		TriggerServerEvent("service:Toggle",serviceList[Service][4])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:LABEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Label")
AddEventHandler("service:Label",function(Service,Text)
	if Service == "Sheriff" then
		exports["target"]:LabelText("Service:Sheriff-1",Text)
		exports["target"]:LabelText("Service:Sheriff-2",Text)
	elseif Service == "Paramedic" then
		exports["target"]:LabelText("Service:Paramedic-1",Text)
		exports["target"]:LabelText("Service:Paramedic-2",Text)
		exports["target"]:LabelText("Service:Paramedic-3",Text)
	else
		exports["target"]:LabelText("Service:"..Service,Text)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Open")
AddEventHandler("service:Open",function(Title)
	SetNuiFocus(true,true)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "openSystem", title = Title })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(Data,Callback)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "closeSystem" })

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Request",function(Data,Callback)
	if LocalPlayer["state"]["Network"] then
		Callback({ Result = vSERVER.Request() })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Remove",function(Data,Callback)
	if LocalPlayer["state"]["Network"] then
		TriggerServerEvent("service:Remove",Data["passport"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Add",function(Data,Callback)
	if LocalPlayer["state"]["Network"] then
		TriggerServerEvent("service:Add",Data["passport"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Update")
AddEventHandler("service:Update",function()
	SendNUIMessage({ action = "updateSystem" })
end)