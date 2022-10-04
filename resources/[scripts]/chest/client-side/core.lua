-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local chestCoords = {
	{ "Police",360.43,-1600.48,25.83,"3" },
	{ "Police",486.46,-994.94,31.07,"3" },
	-- { "Police",1836.96,3685.16,34.80,"3" },
	{ "Police",-445.38,6019.65,37.38,"3" },
	-- { "Police",386.72,800.09,187.47,"3" },
	{ "Police",1844.31,2573.84,46.26,"3" },
	{ "Paramedic",306.17,-601.98,43.25,"3" },
	{ "Paramedic",-258.00,6332.62,32.72,"3" },
	{ "BurgerShot",-1203.11,-895.47,13.99,"1" },
	{ "PizzaThis",796.55,-749.32,31.26,"1" },
	{ "UwuCoffee",-572.65,-1049.74,26.61,"1" },
	{ "BeanMachine",123.04,-1043.76,29.27,"1" },
	{ "Ballas",-1.29,-1811.82,25.34,"1" },
	{ "Families",-162.64,-1613.1,33.65,"1" },
	{ "Vagos",326.17,-2000.24,24.2,"1" },
	{ "Aztecas",495.7,-1527.89,29.28,"1" },
	{ "Altruists",-1111.09,4946.13,218.36,"1" },
	{ "Triads",-816.51,-696.17,32.13,"1" },
	{ "Marabunta",1254.15,-1571.59,58.74,"1" },
	{ "TheLost",103.18,3604.63,40.49,"1" },
	{ "Triads",-653.47,-1229.82,11.54,"1" },
	{ "trayShot",-1195.20,-893.13,14.41,"2" },
	{ "trayDesserts",-584.01,-1059.30,22.41,"2" },
	{ "trayPizza",811.10,-752.78,26.74,"2" },
	{ "trayBean",121.8,-1037.27,29.25,"2" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTINFOS
-----------------------------------------------------------------------------------------------------------------------------------------
local chestInfos = {
	["1"] = {
		{
			event = "chest:openSystem",
			label = "Abrir",
			tunnel = "shop"
		},{
			event = "chest:Upgrade",
			label = "Aumentar",
			tunnel = "shopserver"
		}
	},
	["2"] = {
		{
			event = "chest:openSystem",
			label = "Bandeja",
			tunnel = "shop"
		}
	},
	["3"] = {
		{
			event = "chest:openSystem",
			label = "Compartimento Geral",
			tunnel = "shop"
		},{
			event = "chest:openPersonal",
			label = "Compartimento Pessoal",
			tunnel = "shop"
		},{
			event = "chest:Upgrade",
			label = "Aumentar",
			tunnel = "shopserver"
		}
	},
	["4"] = {
		{
			event = "chest:openCustom",
			label = "Abrir",
			tunnel = "shop"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for k,v in pairs(chestCoords) do
		exports["target"]:AddCircleZone("Chest:"..k,vec3(v[2],v[3],v[4]),1.0,{
			name = "Chest:"..k,
			heading = 3374176
		},{
			shop = v[1],
			Distance = 1.5,
			options = chestInfos[v[5]]
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:openSystem",function(Name)
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.Permissions(Name,"Chest") then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showMenu" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPENPERSONAL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:openPersonal",function(Name)
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.Permissions(Name,"Personal") then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showMenu" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPENCUSTOM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:openCustom",function(Name)
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.Permissions(Name,"Custom") then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showMenu" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(Data,Callback)
	SendNUIMessage({ action = "hideMenu" })
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(Data,Callback)
	if LocalPlayer["state"]["Network"] then
		vSERVER.takeItem(Data["item"],Data["slot"],Data["amount"],Data["target"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(Data,Callback)
	if LocalPlayer["state"]["Network"] then
		vSERVER.storeItem(Data["item"],Data["slot"],Data["amount"],Data["target"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateChest",function(Data,Callback)
	if LocalPlayer["state"]["Network"] then
		vSERVER.updateChest(Data["slot"],Data["target"],Data["amount"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestChest",function(Data,Callback)
	local Inventory,Chest,invPeso,invMaxpeso,chestPeso,chestMaxpeso = vSERVER.openChest()
	if Inventory then
		Callback({ Inventory = Inventory, Chest = Chest, invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Update")
AddEventHandler("chest:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPDATEWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:UpdateWeight")
AddEventHandler("chest:UpdateWeight",function(invPeso,invMaxpeso,chestPeso,chestMaxpeso)
	SendNUIMessage({ action = "updateWeight", invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Close")
AddEventHandler("chest:Close",function(action)
	SendNUIMessage({ action = "hideMenu" })
	SetNuiFocus(false,false)
end)