-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Select = ""
local Active = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
local Crafting = {
	{ vec3(1272.51,-1713.05,54.63),"Black",0.1 },
	{ vec3(-345.63,-124.74,38.95),"Mecanico",0.1 },
	{ vec3(-1141.22,-2004.85,13.12),"Mecanico",0.1 },
	{ vec3(1189.48,2636.54,38.34),"Mecanico",0.1 },
	{ vec3(97.65,6619.09,32.38),"Mecanico",0.1 },
	{ vec3(738.23,-1077.99,22.13),"Mecanico",0.1 },
	{ vec3(-216.72,-1318.99,30.81),"Mecanico",0.1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	for Number = 1,#Crafting do
		exports["target"]:AddCircleZone("Crafting:"..Number,Crafting[Number][1],Crafting[Number][3],{
			name = "Crafting:"..Number,
			heading = 0.0,
			useZ = true
		},{
			shop = Number,
			Distance = 1.0,
			options = {
				{
					event = "crafting:Open",
					label = "Abrir",
					tunnel = "shop"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OWNED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Owned",function(Data,Callback)
	Callback(vSERVER.Owned(Data["id"],Data["key"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Cancel",function(Data,Callback)
	Active = nil

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Crafting",function(Data,Callback)
	if not Active then
		if vSERVER.CheckWeight(Select,Data["key"],Data["amount"]) then
			Active = GetGameTimer() + Data["time"] * 1000
			Callback(true)

			repeat
				if Active and GetGameTimer() >= Active then
					Active = nil
					vSERVER.Crafting(Data["id"],Data["key"],Data["amount"])
				end

				Wait(100)
			until not Active
		end
	else
		TriggerEvent("Notify","Aviso","Produção em andamento.","amarelo",5000)
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:Open",function(Number)
	if Crafting[Number] then
		if Crafting[Number][2] ~= Select and Active and GetGameTimer() < Active then
			TriggerEvent("Notify","Aviso","Produção em andamento.","amarelo",5000)

			return false
		end

		if vSERVER.Permission(Crafting[Number][2]) then
			SetNuiFocus(true,true)
			Select = Crafting[Number][2]
			SendNUIMessage({ action = "OpenCraft", data = vSERVER.Request(Select) })
		end
	end
end)