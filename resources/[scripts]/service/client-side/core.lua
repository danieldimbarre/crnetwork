-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	{ 441.81,-982.05,30.83,"Police-1",1.0 },
	{ 1833.75,3678.34,34.27,"Police-2",1.0 },
	{ -447.28,6013.01,32.41,"Police-3",1.0 },
	{ 1840.20,2578.48,46.07,"Police-4",1.0 },
	-- { 385.43,794.42,187.48,"Police-5",1.0 },
	{ 382.01,-1596.39,29.91,"Police-6",1.0 },
	-- { 310.23,-597.54,43.29,"Paramedic-1",1.0 },
	{ -254.77,6331.03,32.79,"Paramedic-2",1.5 },
	-- { 1188.05,-1468.31,34.66,"Paramedic-3",1.5 },
	{ -675.47,326.85,83.09,"Paramedic-4",1.0 },
	{ 804.62,-830.33,26.34,"Mechanic",1.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for k,v in pairs(List) do
		exports["target"]:AddCircleZone("Service:"..v[4],vec3(v[1],v[2],v[3]),0.10,{
			name = "Service:"..v[4],
			heading = 3374176
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
		TriggerServerEvent("service:Toggle",List[Service][4])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:LABEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Label")
AddEventHandler("service:Label",function(Service,Text)
	if Service == "Police" then
		exports["target"]:LabelText("Service:Police-1",Text)
		exports["target"]:LabelText("Service:Police-2",Text)
		exports["target"]:LabelText("Service:Police-3",Text)
		exports["target"]:LabelText("Service:Police-4",Text)
		-- exports["target"]:LabelText("Service:Police-5",Text)
		exports["target"]:LabelText("Service:Police-6",Text)
	elseif Service == "Paramedic" then
		-- exports["target"]:LabelText("Service:Paramedic-1",Text)
		exports["target"]:LabelText("Service:Paramedic-2",Text)
		-- exports["target"]:LabelText("Service:Paramedic-3",Text)
		exports["target"]:LabelText("Service:Paramedic-4",Text)
	else
		exports["target"]:LabelText("Service:"..Service,Text)
	end
end)