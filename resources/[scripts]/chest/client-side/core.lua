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
	{ ["Name"] = "Police", ["Coords"] = vec3(360.43,-1600.48,25.83), ["Mode"] = "1", ["Distance"] = 1.0 },
	{ ["Name"] = "Police", ["Coords"] = vec3(473.13,-990.69,26.27), ["Mode"] = "1", ["Distance"] = 1.0 },
	{ ["Name"] = "Police-2", ["Coords"] = vec3(486.46,-994.94,31.07), ["Mode"] = "1", ["Distance"] = 1.0 },
	{ ["Name"] = "Police-2", ["Coords"] = vec3(475.34,-1004.67,26.27), ["Mode"] = "1", ["Distance"] = 1.0 },
	{ ["Name"] = "Police-3", ["Coords"] = vec3(1836.96,3685.16,34.80), ["Mode"] = "1", ["Distance"] = 1.0 },
	{ ["Name"] = "Police-4", ["Coords"] = vec3(-445.38,6019.65,37.38), ["Mode"] = "1", ["Distance"] = 1.0 },
	-- { ["Name"] = "Police-5", ["Coords"] = vec3(386.72,800.09,187.47), ["Mode"] = "1", ["Distance"] = 1.0 },
	{ ["Name"] = "Police-6", ["Coords"] = vec3(1844.31,2573.84,46.26), ["Mode"] = "1", ["Distance"] = 1.0 },
	{ ["Name"] = "Paramedic", ["Coords"] = vec3(-681.02,328.9,88.01), ["Mode"] = "2", ["Distance"] = 1.0 },
	-- { ["Name"] = "Paramedic-2", ["Coords"] = vec3(306.17,-601.98,43.25), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Paramedic-3", ["Coords"] = vec3(-258.00,6332.62,32.72), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Paramedic-4", ["Coords"] = vec3(-470.38,6291.05,13.61), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Mechanic", ["Coords"] = vec3(-223.98,-1339.9,31.29), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Mechanic-2", ["Coords"] = vec3(145.68,-3007.79,7.04), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "BurgerShot", ["Coords"] = vec3(-1203.11,-895.47,13.99), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "BurgerShot-2", ["Coords"] = vec3(-1175.56,-897.91,13.99), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "BurgerShot-3", ["Coords"] = vec3(-1197.42,-894.77,13.99), ["Mode"] = "4", ["Distance"] = 1.0 },
	{ ["Name"] = "PizzaThis", ["Coords"] = vec3(802.22,-756.78,26.77), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "PizzaThis-2", ["Coords"] = vec3(796.55,-749.32,31.26), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "PizzaThis-3", ["Coords"] = vec3(814.24,-752.69,26.77), ["Mode"] = "4", ["Distance"] = 1.0 },
	{ ["Name"] = "UwuCoffee", ["Coords"] = vec3(-595.65,-1065.59,22.34), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "UwuCoffee-2", ["Coords"] = vec3(-597.34,-1048.95,22.34), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "UwuCoffee-3", ["Coords"] = vec3(-585.98,-1055.26,22.34), ["Mode"] = "4", ["Distance"] = 1.0 },
	{ ["Name"] = "BeanMachine", ["Coords"] = vec3(122.67,-1040.42,29.27), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "BeanMachine-2", ["Coords"] = vec3(123.78,-1037.63,29.27), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "BeanMachine-3", ["Coords"] = vec3(124.59,-1036.88,29.27), ["Mode"] = "4", ["Distance"] = 1.0 },
	{ ["Name"] = "Ballas", ["Coords"] = vec3(-1.29,-1811.82,25.34), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Ballas-2", ["Coords"] = vec3(-2.09,-1811.84,29.15), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Families", ["Coords"] = vec3(-162.64,-1613.1,33.65), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Families-2", ["Coords"] = vec3(-164.06,-1619.39,33.65), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Vagos", ["Coords"] = vec3(326.17,-2000.24,24.2), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Vagos-2", ["Coords"] = vec3(339.75,-1980.68,24.2), ["Mode"] = "2", ["Distance"] = 1.5 },
	{ ["Name"] = "Aztecas", ["Coords"] = vec3(495.7,-1527.89,29.28), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Aztecas-2", ["Coords"] = vec3(484.71,-1533.11,29.28), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "YoungBoys", ["Coords"] = vec3(-817.01,-716.14,23.78), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "YoungBoys-2", ["Coords"] = vec3(-816.52,-695.53,32.13), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Triads", ["Coords"] = vec3(-653.01,-1230.54,11.54), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Triads-2", ["Coords"] = vec3(-644.49,-1244.69,11.54), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Razors", ["Coords"] = vec3(502.55,-70.36,58.15), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Razors-2", ["Coords"] = vec3(499.67,-73.47,58.15), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Tribo", ["Coords"] = vec3(-1111.09,4946.13,218.36), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Tribo-2", ["Coords"] = vec3(-1103.89,4938.57,218.36), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Marabunta", ["Coords"] = vec3(1254.15,-1571.59,58.74), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Marabunta-2", ["Coords"] = vec3(1251.24,-1580.96,58.35), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Lost", ["Coords"] = vec3(103.18,3604.63,40.49), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Lost-2", ["Coords"] = vec3(101.31,3619.81,40.49), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Dracing", ["Coords"] = vec3(815.31,-889.37,25.68), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Dracing-2", ["Coords"] = vec3(835.31,-886.31,25.68), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "trayShot-1", ["Coords"] = vec3(-1193.89,-894.34,14.41), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-2", ["Coords"] = vec3(-1194.94,-892.87,14.41), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-3", ["Coords"] = vec3(-1188.89,-880.56,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-4", ["Coords"] = vec3(-1186.95,-882.44,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-5", ["Coords"] = vec3(-1191.87,-881.81,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-6", ["Coords"] = vec3(-1194.18,-883.41,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-7", ["Coords"] = vec3(-1192.16,-886.15,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-8", ["Coords"] = vec3(-1193.48,-888.13,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-9", ["Coords"] = vec3(-1190.9,-892.0,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-10", ["Coords"] = vec3(-1190.13,-896.12,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-11", ["Coords"] = vec3(-1186.87,-894.59,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-12", ["Coords"] = vec3(-1188.51,-891.44,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-13", ["Coords"] = vec3(-1184.58,-892.98,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-14", ["Coords"] = vec3(-1182.02,-890.59,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayShot-15", ["Coords"] = vec3(-1183.12,-888.18,13.99), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayDesserts-1", ["Coords"] = vec3(-584.01,-1059.30,22.41), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayDesserts-2", ["Coords"] = vec3(-584.04,-1061.97,22.41), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayDesserts-3", ["Coords"] = vec3(-573.63,-1067.3,22.49), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayDesserts-4", ["Coords"] = vec3(-573.78,-1063.41,22.49), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayDesserts-5", ["Coords"] = vec3(-573.73,-1059.75,22.49), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-1", ["Coords"] = vec3(811.10,-752.78,26.74), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-1", ["Coords"] = vec3(811.06,-754.02,26.74), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-2", ["Coords"] = vec3(799.53,-759.77,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-3", ["Coords"] = vec3(799.46,-757.56,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-4", ["Coords"] = vec3(801.41,-754.81,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-5", ["Coords"] = vec3(803.48,-754.65,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-6", ["Coords"] = vec3(805.61,-754.9,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-7", ["Coords"] = vec3(807.78,-754.68,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-8", ["Coords"] = vec3(795.35,-751.66,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-9", ["Coords"] = vec3(797.91,-748.86,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-10", ["Coords"] = vec3(799.01,-751.59,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-11", ["Coords"] = vec3(803.11,-751.6,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-12", ["Coords"] = vec3(807.08,-751.51,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayPizza-13", ["Coords"] = vec3(799.27,-755.07,26.77), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayBean-1", ["Coords"] = vec3(121.8,-1037.27,29.25), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayBean-2", ["Coords"] = vec3(120.54,-1040.72,29.25), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayBean-3", ["Coords"] = vec3(119.98,-1029.44,29.27), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayBean-4", ["Coords"] = vec3(118.82,-1034.01,29.27), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayBean-5", ["Coords"] = vec3(117.47,-1047.41,29.27), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayBean-6", ["Coords"] = vec3(115.09,-1044.68,28.91), ["Mode"] = "3", ["Distance"] = 1.5 },
	{ ["Name"] = "trayBean-6", ["Coords"] = vec3(124.26,-1029.18,28.91), ["Mode"] = "3", ["Distance"] = 1.5 },

	{ ["Name"] = "Favela01", ["Coords"] = vec3(1346.05,-198.07,120.58), ["Mode"] = "2", ["Distance"] = 1.0 },
	{ ["Name"] = "Favela01-2", ["Coords"] = vec3(1337.5,-199.09,123.49), ["Mode"] = "2", ["Distance"] = 1.0 }
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
	},
	["4"] = {
		{
			event = "chest:Open",
			label = "Abrir",
			tunnel = "shop",
			service = "Restaurants"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Name,v in pairs(Chests) do
		exports["target"]:AddCircleZone("Chest:"..Name,v["Coords"],0.5,{
			name = "Chest:"..Name,
			heading = 3374176
		},{
			Distance = v["Distance"],
			shop = v["Name"],
			options = Labels[v["Mode"]]
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:Open",function(Name,Init)
	if LocalPlayer["state"]["Route"] < 900000 and GetEntityHealth(PlayerPedId()) > 100 then
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