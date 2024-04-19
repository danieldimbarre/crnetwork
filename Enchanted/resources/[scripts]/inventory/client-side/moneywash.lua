-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Selects = {}
local Active = false
local Cooldown = GetGameTimer()
local Init = vec3(95.03,-1557.74,29.51)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local Locations = {
	vec3(149.83,-1041.33,29.59),
	vec3(314.17,-279.7,54.39),
	vec3(-350.98,-50.51,49.26),
	vec3(-2961.98,483.07,15.92),
	vec3(1174.91,2707.4,38.31),
	vec3(-1212.25,-331.17,38.0),
	vec3(25.16,-1347.97,29.52),
	vec3(1163.97,-322.05,69.21),
	vec3(373.06,325.62,103.59),
	vec3(-3241.53,1000.6,12.85),
	vec3(548.31,2671.95,42.18),
	vec3(2678.96,3279.67,55.26),
	vec3(-1821.11,794.37,138.1)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	exports["target"]:AddCircleZone("MoneyWash",Init,0.15,{
		name = "MoneyWash",
		heading = 0.0,
		useZ = true
	},{
		Distance = 1.75,
		options = {
			{
				event = "moneywash:Init",
				label = "Iniciar",
				tunnel = "client"
			},{
				event = "moneywash:Swap",
				label = "Trocar",
				tunnel = "server"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEYWASH:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("moneywash:Init",function()
	if Active then
		TriggerEvent("Notify","Sucesso","Trabalho finalizado.","verde",5000)
		exports["target"]:LabelText("MoneyWash","Iniciar")
		Active = false
		CleanBlips()
	else
		if Cooldown <= GetGameTimer() then
			TriggerEvent("Notify","Sucesso","Trabalho iniciado.","verde",5000)
			exports["target"]:LabelText("MoneyWash","Finalizar")
			Cooldown = GetGameTimer() + (5 * 60000)
			Active = true
			MakeBlips()
		else
			TriggerEvent("Notify","Aviso","Aguarde seu tempo de descanso.","amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEYWASH:SEND
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("moneywash:Send",function(Number,Service)
	if Selects[Number] and vSERVER.Washers(Service) then
		if DoesBlipExist(Selects[Number]) then
			RemoveBlip(Selects[Number])
		end

		exports["target"]:RemCircleZone("MoneyWash:"..Number)
		Selects[Number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanBlips()
	for Selected,Blips in pairs(Selects) do
		if DoesBlipExist(Blips) then
			RemoveBlip(Blips)
		end

		exports["target"]:RemCircleZone("MoneyWash:"..Selected)
		Selects[Selected] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeBlips()
	for Index = 1,7 do
		local Selected = math.random(#Locations)
		local Number = tostring(Selected)
		if Selects[Number] then
			repeat
				Selected = math.random(#Locations)
				Number = tostring(Selected)
			until not Selects[Number]
		end

		exports["target"]:AddCircleZone("MoneyWash:"..Selected,Locations[Selected],0.15,{
			name = "MoneyWash:"..Selected,
			heading = 0.0,
			useZ = true
		},{
			shop = Number,
			Distance = 1.0,
			options = {
				{
					event = "moneywash:Send",
					label = "Entregar",
					tunnel = "shop"
				},{
					event = "moneywash:Send",
					label = "Entrega Segura",
					tunnel = "shop",
					service = true
				}
			}
		})

		Selects[Number] = AddBlipForCoord(Locations[Selected])
		SetBlipSprite(Selects[Number],434)
		SetBlipDisplay(Selects[Number],4)
		SetBlipAsShortRange(Selects[Number],true)
		SetBlipColour(Selects[Number],2)
		SetBlipScale(Selects[Number],0.75)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Entrega")
		EndTextCommandSetBlipName(Selects[Number])
	end
end