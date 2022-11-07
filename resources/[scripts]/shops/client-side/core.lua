-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("shops",Creative)
vSERVER = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(Data,Callback)
	SendNUIMessage({ action = "hideNUI" })
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop",function(Data,Callback)
	local inventoryShop,inventoryUser,invPeso,invMaxpeso,shopSlots = vSERVER.requestShop(Data["shop"])
	if inventoryShop then
		Callback({ inventoryShop = inventoryShop, inventoryUser = inventoryUser, invPeso = invPeso, invMaxpeso = invMaxpeso, shopSlots = shopSlots })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionShops",function(Data,Callback)
	vSERVER.functionShops(Data["shop"],Data["item"],Data["amount"],Data["slot"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(Data,Callback)
	TriggerServerEvent("shops:populateSlot",Data["item"],Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(Data,Callback)
	TriggerServerEvent("shops:updateSlot",Data["item"],Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.updateShops(action)
	SendNUIMessage({ action = action })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	{ -542.87,-198.35,38.23,"Identity",false,2.75 },
	{ -551.27,-203.09,38.23,"Identity",false,2.75 },
	{ -544.76,-185.81,52.2,"Identity2",false,2.75 },
	{ 253.35,216.72,106.37,"Bank",false },
	{ 257.24,227.78,106.33,"Bank",false },
	{ -1271.55,-1411.49,4.36,"Digital",true },
	{ -1232.05,-1439.69,4.36,"Digital",true },
	{ -1207.87,-1502.59,4.36,"Digital",true },
	{ -1271.89,-1418.5,4.36,"Brewery",true },
	{ -1225.06,-1439.93,4.36,"Brewery",true },
	{ -1208.13,-1509.62,4.36,"Brewery",true },
	{ -1253.94,-1444.82,4.36,"Organic",true },
	{ -1206.44,-1460.05,4.36,"Organic",true },
	{ -1225.76,-1485.01,4.36,"Organic",true },
	{ -1249.01,-1449.3,4.36,"Weeds",true },
	{ -1211.01,-1464.93,4.36,"Weeds",true },
	{ -1220.88,-1489.58,4.36,"Weeds",true },
	{ -1245.36,-1454.24,4.36,"Beans",true },
	{ -1215.81,-1468.6,4.36,"Beans",true },
	{ -1217.2,-1494.39,4.36,"Beans",true },
	{ -1253.68,-1437.09,4.36,"Pills",false },
	{ -1255.58,-1434.39,4.36,"Pills",false },
	{ -1195.99,-1458.47,4.38,"Pills",false },
	{ -1198.76,-1460.3,4.36,"Pills",false },
	{ -1225.6,-1477.02,4.36,"Pills",false },
	{ -1227.28,-1474.8,4.36,"Pills",false },
	{ 24.9,-1346.8,29.49,"Departament",true },
	{ 2556.74,381.24,108.61,"Departament",true },
	{ 1164.82,-323.65,69.2,"Departament",true },
	{ -706.15,-914.53,19.21,"Departament",true },
	{ -47.38,-1758.68,29.42,"Departament",true },
	{ 373.1,326.81,103.56,"Departament",true },
	{ -3242.75,1000.46,12.82,"Departament",true },
	{ 1728.47,6415.46,35.03,"Departament",true },
	{ 1960.2,3740.68,32.33,"Departament",true },
	{ 2677.8,3280.04,55.23,"Departament",true },
	{ 1697.31,4923.49,42.06,"Departament",true },
	{ -1819.52,793.48,138.08,"Departament",true },
	{ 1391.69,3605.97,34.98,"Departament",true },
	{ -2966.41,391.55,15.05,"Departament",true },
	{ -3039.54,584.79,7.9,"Departament",true },
	{ 1134.33,-983.11,46.4,"Departament",true },
	{ 1165.28,2710.77,38.15,"Departament",true },
	{ -1486.72,-377.55,40.15,"Departament",true },
	{ -1221.45,-907.92,12.32,"Departament",true },
	{ 161.2,6641.66,31.69,"Departament",true },
	{ -160.62,6320.93,31.58,"Departament",true },
	{ 548.7,2670.73,42.16,"Departament",true },
	{ 812.88,-782.08,26.17,"Departament",true },
	{ 1696.88,3758.39,34.69,"Ammunation",false },
	{ 248.17,-51.78,69.94,"Ammunation",false },
	{ 841.18,-1030.12,28.19,"Ammunation",false },
	{ -327.07,6082.22,31.46,"Ammunation",false },
	{ -659.18,-938.47,21.82,"Ammunation",false },
	{ -1309.43,-394.56,36.7,"Ammunation",false },
	{ -1113.41,2698.19,18.55,"Ammunation",false },
	{ 2564.83,297.46,108.73,"Ammunation",false },
	{ -3168.32,1087.46,20.84,"Ammunation",false },
	{ 16.91,-1107.56,29.79,"Ammunation",false },
	{ 814.84,-2155.14,29.62,"Ammunation",false },
	{ -1083.15,-245.88,37.76,"Premium",false,2.75 },
	{ -1816.64,-1193.73,14.31,"Fishing",false },
	{ 1522.88,3783.63,34.47,"Fishing2",true,2.25 },
	{ -695.56,5802.12,17.32,"Hunting",false },
	{ -679.13,5839.52,17.32,"Hunting2",false },
	{ -665.78,321.34,83.09,"Pharmacy",false },
	-- { -172.89,6381.32,31.48,"Pharmacy",false },
	-- { 1690.07,3581.68,35.62,"Pharmacy",false },
	-- { 326.5,-1074.43,29.47,"Pharmacy",false },
	-- { 114.39,-4.85,67.82,"Pharmacy",false },
	{ -674.38,339.24,83.09,"Paramedic",false },
	-- { 311.97,-597.66,43.29,"Paramedic",false },
	-- { 1822.70,3686.64,34.26,"Paramedic",false },
	-- { -254.64,6326.95,32.82,"Paramedic",false },
	{ 82.98,-1553.55,29.59,"Recycle",false },
	{ 287.77,2843.9,44.7,"Recycle",false },
	{ -413.97,6171.58,31.48,"Recycle",false },
	{ 487.3,-997.08,30.68,"Police",false },
	-- { 1838.43,3686.29,34.19,"Police",false },
	{ -447.15,6016.51,36.99,"Police",false },
	-- { 385.5,799.94,190.49,"Police",false },
	{ 362.37,-1603.12,25.44,"Police",false },
	{ -622.43,-229.71,38.05,"Miners",false },
	{ -1403.52,-628.62,28.68,"Criminal",false },
	-- { 112.41,3373.68,35.25,"Criminal2",false },
	-- { 2013.95,4990.88,41.21,"Criminal3",false },
	-- { 186.9,6374.75,32.33,"Criminal4",false },
	-- { -653.12,-1502.67,5.22,"Criminal",false },
	-- { 389.71,-942.61,29.42,"Criminal2",false },
	-- { 154.98,-1472.47,29.35,"Criminal3",false },
	-- { 488.1,-1456.11,29.28,"Criminal4",false },
	-- { 169.76,-1535.88,29.25,"Weapons",false },
	-- { 301.14,-195.75,61.57,"Weapons",false },
	{ 836.58,-808.25,26.35,"Mechanic",false },
	{ 836.72,-823.26,26.34,"Tools",false },
	{ -1636.74,-1092.17,13.08,"Oxy",false },
	{ -1196.9,-901.58,13.99,"BurgerShot",false },
	{ 806.22,-761.68,26.77,"PizzaThis",false },
	{ -588.5,-1066.23,22.34,"UwuCoffee",false },
	{ 124.01,-1036.72,29.27,"BeanMachine",false },
	-- { -1127.26,-1439.35,5.22,"Clothes",false },
	{ 78.26,-1388.91,29.37,"Clothes",false },
	{ -706.73,-151.38,37.41,"Clothes",false },
	{ -166.69,-301.55,39.73,"Clothes",false },
	{ -817.5,-1074.03,11.32,"Clothes",false },
	{ -1197.33,-778.98,17.32,"Clothes",false },
	{ -1447.84,-240.03,49.81,"Clothes",false },
	{ -0.07,6511.8,31.88,"Clothes",false },
	{ 1691.6,4818.47,42.06,"Clothes",false },
	{ 123.21,-212.34,54.56,"Clothes",false },
	{ 621.24,2753.37,42.09,"Clothes",false },
	{ 1200.68,2707.35,38.22,"Clothes",false },
	{ -3172.39,1055.31,20.86,"Clothes",false },
	{ -1096.53,2711.1,19.11,"Clothes",false },
	{ 422.7,-810.25,29.49,"Clothes",false },
	{ 963.34,19.26,71.46,"Clothes",false },
	{ -1174.54,-1571.4,4.35,"Weeds",false },
	{ 1569.67,-2129.67,78.33,"Dismantle",false }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:openSystem",function(shopId)
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.requestPerm(List[shopId][4]) then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = List[shopId][4], type = vSERVER.getShopType(List[shopId][4]) })

			if List[shopId][5] then
				TriggerEvent("sounds:Private","shop",0.5)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "coffeeMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "sodaMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "donutMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "burgerMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "hotdogMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:CHIHUAHUA
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Chihuahua",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "Chihuahua", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "waterMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MEDICBAG
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:medicBag",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.requestPerm("Paramedic") then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = "Paramedic", type = "Buy" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:FUEL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Fuel",function()
	SendNUIMessage({ action = "showNUI", name = "Fuel", type = "Buy" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(List) do
		exports["target"]:AddCircleZone("Shops:"..Number,vec3(v[1],v[2],v[3]),0.35,{
			name = "Shops:"..Number,
			heading = 3374176
		},{
			shop = Number,
			Distance = v[6] or 1.75,
			options = {
				{
					event = "shops:openSystem",
					label = "Abrir",
					tunnel = "shop"
				}
			}
		})
	end
end)
