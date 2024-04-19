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
RegisterNUICallback("Close",function(Data,Callback)
	SendNUIMessage({ Action = "Close" })
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Request",function(Data,Callback)
	local inventoryShop,inventoryUser,invPeso,invMaxpeso,shopSlots = vSERVER.Request(Data["shop"])
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
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Update(Action)
	SendNUIMessage({ Action = Action })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	{ 24.51,-1346.75,29.49,"Departament",true },
	{ 2556.77,380.87,108.61,"Departament",true },
	{ 1164.81,-323.61,69.2,"Departament",true },
	{ -706.16,-914.55,19.21,"Departament",true },
	{ -47.35,-1758.59,29.42,"Departament",true },
	{ 372.7,326.89,103.56,"Departament",true },
	{ -3242.7,1000.05,12.82,"Departament",true },
	{ 1728.08,6415.6,35.03,"Departament",true },
	{ 549.09,2670.89,42.16,"Departament",true },
	{ 1959.87,3740.44,32.33,"Departament",true },
	{ 2677.65,3279.66,55.23,"Departament",true },
	{ 1697.32,4923.46,42.06,"Departament",true },
	{ -1819.52,793.48,138.08,"Departament",true },
	{ 1391.62,3605.95,34.98,"Departament",true },
	{ -2966.41,391.52,15.05,"Departament",true },
	{ -3039.42,584.42,7.9,"Departament",true },
	{ 1134.32,-983.09,46.4,"Departament",true },
	{ 1165.32,2710.79,38.15,"Departament",true },
	{ -1486.72,-377.61,40.15,"Departament",true },
	{ -1221.48,-907.93,12.32,"Departament",true },
	{ 1692.27,3760.91,34.69,"Ammunation",false },
	{ 253.80,-50.47,69.94,"Ammunation",false },
	{ 842.54,-1035.25,28.19,"Ammunation",false },
	{ -331.67,6084.86,31.46,"Ammunation",false },
	{ -662.37,-933.58,21.82,"Ammunation",false },
	{ -1304.12,-394.56,36.7,"Ammunation",false },
	{ -1118.98,2699.73,18.55,"Ammunation",false },
	{ 2567.98,292.62,108.73,"Ammunation",false },
	{ -3173.51,1088.35,20.84,"Ammunation",false },
	{ 22.53,-1105.52,29.79,"Ammunation",false },
	{ 810.22,-2158.99,29.62,"Ammunation",false },
	{ -1816.64,-1193.73,14.31,"Fishing",false },
	{ -1593.08,5202.9,4.31,"Hunting",false },
	{ -679.13,5839.52,17.32,"Hunting2",false },
	{ -172.89,6381.32,31.48,"Pharmacy",false },
	{ 1690.07,3581.68,35.62,"Pharmacy",false },
	{ 114.49,-5.03,67.82,"Pharmacy",false },
	{ 348.7,-1420.72,32.67,"Paramedico",false },
	{ -428.54,-1728.29,19.78,"Recycle",false },
	{ 180.07,2793.29,45.65,"Recycle",false },
	{ -195.42,6264.62,31.49,"Recycle",false },
	{ 466.08,-998.86,30.59,"Policia",false },
	{ -628.79,-238.7,38.05,"Miners",false },
	{ -351.65,-1566.27,25.22,"Lixeiro",false },
	{ 287.77,2843.9,44.7,"Lixeiro",false },
	{ -413.97,6171.58,31.48,"Lixeiro",false }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Open",function(Number)
	if not exports["hud"]:Wanted() and vSERVER.Permission(List[Number][4]) then
		SetNuiFocus(true,true)
		SendNUIMessage({ Action = "Open", name = List[Number][4], type = vSERVER.ShopType(List[Number][4]) })

		if List[Number][5] then
			TriggerEvent("sounds:Private","shop",0.5)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MEDIC
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Medic",function()
	if not exports["hud"]:Wanted() and vSERVER.Permission("Paramedico") then
		SetNuiFocus(true,true)
		SendNUIMessage({ Action = "Open", name = "Paramedico", type = "Buy" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:FUEL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Fuel",function()
	SendNUIMessage({ Action = "Open", name = "Fuel", type = "Buy" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	for Number,v in pairs(List) do
		exports["target"]:AddBoxZone("Shops:"..Number,vec3(v[1],v[2],v[3]),0.75,0.75,{
			name = "Shops:"..Number,
			heading = 0.0,
			minZ = v[3] - 1.0,
			maxZ = v[3] + 1.0
		},{
			shop = Number,
			Distance = v[6] or 2.0,
			options = {
				{
					event = "shops:Open",
					label = "Abrir",
					tunnel = "shop"
				}
			}
		})
	end
end)