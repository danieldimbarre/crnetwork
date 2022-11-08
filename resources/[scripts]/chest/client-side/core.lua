-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Chests = {
	{ ["Name"] = "Police", ["Coords"] = vec3(360.43,-1600.48,25.83), ["Mode"] = "1" },
	{ ["Name"] = "Police", ["Coords"] = vec3(486.46,-994.94,31.07), ["Mode"] = "1" },
	{ ["Name"] = "Police", ["Coords"] = vec3(1836.96,3685.16,34.80), ["Mode"] = "1" },
	{ ["Name"] = "Police", ["Coords"] = vec3(-445.38,6019.65,37.38), ["Mode"] = "1" },
	-- { ["Name"] = "Police", ["Coords"] = vec3(386.72,800.09,187.47), ["Mode"] = "1" },
	{ ["Name"] = "Police", ["Coords"] = vec3(1844.31,2573.84,46.26), ["Mode"] = "1" },
	{ ["Name"] = "Paramedic", ["Coords"] = vec3(-681.02,328.9,88.01), ["Mode"] = "2" },
	-- { ["Name"] = "Paramedic", ["Coords"] = vec3(306.17,-601.98,43.25), ["Mode"] = "2" },
	{ ["Name"] = "Paramedic", ["Coords"] = vec3(-258.00,6332.62,32.72), ["Mode"] = "2" },
	{ ["Name"] = "BurgerShot", ["Coords"] = vec3(-1203.11,-895.47,13.99), ["Mode"] = "2" },
	{ ["Name"] = "PizzaThis", ["Coords"] = vec3(796.55,-749.32,31.26), ["Mode"] = "2" },
	{ ["Name"] = "UwuCoffee", ["Coords"] = vec3(-572.65,-1049.74,26.61), ["Mode"] = "2" },
	{ ["Name"] = "BeanMachine", ["Coords"] = vec3(122.67,-1040.42,29.27), ["Mode"] = "2" },
	{ ["Name"] = "Ballas", ["Coords"] = vec3(-1.29,-1811.82,25.34), ["Mode"] = "2" },
	{ ["Name"] = "Families", ["Coords"] = vec3(-162.64,-1613.1,33.65), ["Mode"] = "2" },
	{ ["Name"] = "Vagos", ["Coords"] = vec3(326.17,-2000.24,24.2), ["Mode"] = "2" },
	{ ["Name"] = "Aztecas", ["Coords"] = vec3(495.7,-1527.89,29.28), ["Mode"] = "2" },
	{ ["Name"] = "Bloods", ["Coords"] = vec3(231.62,-1752.92,28.98), ["Mode"] = "2" },
	{ ["Name"] = "Triads", ["Coords"] = vec3(-653.47,-1229.82,11.54), ["Mode"] = "2" },
	{ ["Name"] = "Razors", ["Coords"] = vec3(502.55,-70.36,58.15), ["Mode"] = "2" },
	{ ["Name"] = "Altruists", ["Coords"] = vec3(-1111.09,4946.13,218.36), ["Mode"] = "2" },
	{ ["Name"] = "Marabunta", ["Coords"] = vec3(1254.15,-1571.59,58.74), ["Mode"] = "2" },
	{ ["Name"] = "Lost", ["Coords"] = vec3(103.18,3604.63,40.49), ["Mode"] = "2" },
	{ ["Name"] = "trayShot", ["Coords"] = vec3(-1195.20,-893.13,14.41), ["Mode"] = "3" },
	{ ["Name"] = "trayDesserts", ["Coords"] = vec3(-584.01,-1059.30,22.41), ["Mode"] = "3" },
	{ ["Name"] = "trayPizza", ["Coords"] = vec3(811.10,-752.78,26.74), ["Mode"] = "3" },
	{ ["Name"] = "trayBean", ["Coords"] = vec3(121.8,-1037.27,29.25), ["Mode"] = "3" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Labels = {
	["1"] = {
		{
			event = "chest:Open",
			label = "Compartimento Geral",
			tunnel = "shop",
			service = "Normal"
		},{
			event = "chest:Open",
			label = "Compartimento Pessoal",
			tunnel = "shop",
			service = "Personal"
		},{
			event = "chest:Open",
			label = "Compartimento Evidências",
			tunnel = "shop",
			service = "Evidences"
		},{
			event = "chest:Upgrade",
			label = "Aumentar",
			tunnel = "server"
		}
	},
	["2"] = {
		{
			event = "chest:Open",
			label = "Abrir",
			tunnel = "shop",
			service = "Normal"
		},{
			event = "chest:Upgrade",
			label = "Aumentar",
			tunnel = "server"
		}
	},
	["3"] = {
		{
			event = "chest:Open",
			label = "Bandeja",
			tunnel = "shop",
			service = "Normal"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Name,v in pairs(Chests) do
		exports["target"]:AddCircleZone("Chest:"..Name,v["Coords"],1.0,{
			name = "Chest:"..Name,
			heading = 3374176
		},{
			Distance = 1.5,
			shop = v["Name"],
			options = Labels[v["Mode"]]
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:Open",function(Name,Init)
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.Permissions(Name,Init) then
			SetNuiFocus(true,true)
			SendNUIMessage({ Action = "Open" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SendNUIMessage({ Action = "Close" })
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Take",function(Data,Callback)
	vSERVER.Take(Data["item"],Data["slot"],Data["amount"],Data["target"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Store",function(Data,Callback)
	vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	vSERVER.Update(Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Chest",function(Data,Callback)
	local Inventory,Chest,invPeso,invMaxpeso,chestPeso,chestMaxpeso = vSERVER.Chest()
	if Inventory then
		Callback({ Inventory = Inventory, Chest = Chest, invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Update")
AddEventHandler("chest:Update",function(Action,invPeso,invMaxpeso,chestPeso,chestMaxpeso)
	SendNUIMessage({ Action = Action, invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Close")
AddEventHandler("chest:Close",function(Action)
	SendNUIMessage({ Action = "Close" })
	SetNuiFocus(false,false)
end)