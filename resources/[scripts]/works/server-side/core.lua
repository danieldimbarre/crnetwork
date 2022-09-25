-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("works",Creative)
vCLIENT = Tunnel.getInterface("works")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local works = {
	["Municao"] = {
		["coords"] = { 1379.03,-2090.65,52.6,320.32 },
		["upgradeStress"] = 2,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = false,
		["perm"] = "Mafia2",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 30,
		["collectConsume"] = {
			["min"] = 2,
			["max"] = 5
		},
		["collectCoords"] = {
			{ 902.42,-2273.14,32.54,90.71 },
			{ 434.81,-1906.68,25.93,36.86 },
			{ -296.08,-1347.46,31.31,107.72 },
			{ -416.61,-186.8,37.46,303.31 },
			{ -1790.24,-369.49,45.11,147.41 },
			{ -3050.04,624.88,7.28,107.72 },
			{ -1829.01,801.08,138.54,223.94 },
			{ -1235.76,379.02,76.41,198.43 },
			{ -506.51,300.62,83.71,167.25 },
			{ 389.41,-74.98,68.17,345.83 },
			{ 479.71,-1553.47,29.47,144.57 },
			{ 672.0,-2667.36,6.27,269.3 },
			{ -1105.92,-1287.71,5.43,354.34 },
			{ -115.7,-373.13,38.11,246.62 },
			{ 1223.42,-503.02,66.39,62.37 },
			{ 1454.68,-1652.22,66.99,189.93 }
		},
		["deliveryItem"] = "polvora"
	},
	["Armas"] = {
		["coords"] = { -1866.39,2061.14,135.44,184.26 },
		["upgradeStress"] = 2,
		["routeCollect"] = true,
		["routeDelivery"] = false,
		["usingVehicle"] = false,
		["collectRandom"] = true,
		["perm"] = "Mafia1",
		["collectButtonDistance"] = 1,
		["collectShowDistance"] = 30,
		["collectConsume"] = {
			["min"] = 1,
			["max"] = 1
		},
		["collectCoords"] = {
			{ -1100.46,2722.19,18.8,221.11 },
			{ -324.23,2818.25,59.45,240.95 },
			{ 257.9,3091.42,42.8,266.46 },
			{ 1532.64,3722.23,34.81,215.44 },
			{ 2507.06,4097.07,38.7,260.79 },
			{ 1789.88,4602.66,37.68,201.26 },
			{ -552.31,5348.55,74.75,246.62 },
			{ -1490.45,4981.24,63.36,269.3 },
			{ -2175.36,4295.12,49.05,59.53 },
			{ -2543.92,2316.04,33.21,192.76 }
		},
		["deliveryItem"] = {
			"pistolbody",
			"smgbody",
			"riflebody"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEWORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local activeWorks = {
	["Municao"] = {},
	["Armas"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collectAmount = {}
local paymentAmount = {}
local deliveryAmount = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.collectConsume(serviceName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if works[serviceName]["collectRandom"] then
			local amountItem = 0
			local selectItem = ""

			if serviceName == "Minerador" then
				local randomItem = math.random(100)
				
				if randomItem <= 1 then
					amountItem = math.random(2,4)
					selectItem = "emerald"
				elseif randomItem >= 2 and randomItem <= 3 then
					selectItem = "diamond"
					amountItem = math.random(2,4)
				elseif randomItem >= 4 and randomItem <= 8 then
					selectItem = "ruby"
					amountItem = math.random(2,4)
				elseif randomItem >= 9 and randomItem <= 16 then
					selectItem = "sapphire"
					amountItem = math.random(3,5)
				elseif randomItem >= 17 and randomItem <= 27 then
					selectItem = "amethyst"
					amountItem = math.random(3,5)
				elseif randomItem >= 28 and randomItem <= 44 then
					selectItem = "amber"
					amountItem = math.random(3,5)
				elseif randomItem >= 45 and randomItem <= 60 then
					selectItem = "turquoise"
					amountItem = math.random(3,5)
				elseif randomItem >= 61 and randomItem <= 79 then
					selectItem = "aluminum"
					amountItem = math.random(5,8)
				elseif randomItem >= 80 then
					selectItem = "copper"
					amountItem = math.random(5,8)
				end
			else
				local randomItem = math.random(#works[serviceName]["deliveryItem"])
				selectItem = works[serviceName]["deliveryItem"][randomItem]
				amountItem = math.random(works[serviceName]["collectConsume"]["min"],works[serviceName]["collectConsume"]["max"])
			end

			if (vRP.InventoryWeight(Passport) + (itemWeight(selectItem) * parseInt(amountItem))) <= vRP.GetWeight(Passport) then
				vRP.GenerateItem(Passport,selectItem,amountItem,true)

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.UpgradeStress(Passport,works[serviceName]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify",source,'vermelho','Mochila cheia.',5000)
			end
		else
			if collectAmount[Passport] == nil then
				collectAmount[Passport] = math.random(works[serviceName]["collectConsume"]["min"],works[serviceName]["collectConsume"]["max"])
			end

			local deliveryItem = works[serviceName]["deliveryItem"]
			if (vRP.InventoryWeight(Passport) + (itemWeight(deliveryItem) * parseInt(collectAmount[Passport]))) <= vRP.GetWeight(Passport) then
				vRP.GenerateItem(Passport,deliveryItem,collectAmount[Passport],true)
				collectAmount[Passport] = nil

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.UpgradeStress(Passport,works[serviceName]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify",source,'vermelho','Mochila cheia.',5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERYCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.deliveryConsume(serviceName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if deliveryAmount[Passport] == nil then
			deliveryAmount[Passport] = math.random(works[serviceName]["deliveryConsume"]["min"],works[serviceName]["deliveryConsume"]["max"])
		end

		if paymentAmount[Passport] == nil then
			paymentAmount[Passport] = math.random(works[serviceName]["deliveryPayment"]["min"],works[serviceName]["deliveryPayment"]["max"])
		end

		local deliveryItem = works[serviceName]["deliveryPayment"]["item"]
		if (vRP.InventoryWeight(Passport) + (itemWeight(deliveryItem) * parseInt(paymentAmount[Passport]))) <= vRP.GetWeight(Passport) then
			if vRP.RemoveItem(Passport,works[serviceName]["deliveryItem"],deliveryAmount[Passport]) then
				local paymentPrice = parseInt(paymentAmount[Passport] * deliveryAmount[Passport])

				vRP.GenerateItem(Passport,deliveryItem,paymentPrice,true)

				if deliveryItem == "dollars" or deliveryItem == "dollarsz" then
					if vRP.UserPremium(Passport) then
						vRP.GenerateItem(Passport,deliveryItem,paymentPrice * 0.1,true)
					end
				end

				deliveryAmount[Passport] = nil
				paymentAmount[Passport] = nil

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.UpgradeStress(Passport,works[serviceName]["upgradeStress"])
				end

				if serviceName == "Contrabandista" then
					TriggerClientEvent("player:Residuals",source,"Resíduo de Pólvora.")

					if math.random(1000) >= 500 then
						local ped = GetPlayerPed(source)
						local coords = GetEntityCoords(ped)

						local policeResult = vRP.NumPermission("Police")
						for k,v in pairs(policeResult) do
							async(function()
								TriggerClientEvent("NotifyPush",v,{ code = "QRU", title = "Contrabando de Munições", x = coords["x"], y = coords["y"], z = coords["z"], time = "Recebido às "..os.date("%H:%M"), blipColor = 5 })
							end)
						end
					end
				end

				return true
			else
				TriggerClientEvent("Notify",source,'amarelo','Precisa de <b>'..parseFormat(deliveryAmount[Passport])..'x '..itemName(works[serviceName]["deliveryItem"])..'</b> para entregar.',5000)
			end
		else
			TriggerClientEvent("Notify",source,'vermelho','Mochila cheia.',5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkPermission(serviceName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if works[serviceName]["perm"] == nil then
			return true
		end

		if vRP.HasGroup(Passport,works[serviceName]["perm"]) then
			if activeWorks[serviceName] then
				if parseInt(#activeWorks[serviceName]) < 5 then
					activeWorks[serviceName][Passport] = true
					return true
				else
					TriggerClientEvent("Notify",source,'amarelo','Limite de trabalhadores atingido.',3000)
				end
			else
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.finishService(serviceName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and activeWorks[serviceName] then
		if activeWorks[serviceName][Passport] then
			activeWorks[serviceName][Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS:BULLGUERJUICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("works:bullguerJuice")
AddEventHandler("works:bullguerJuice",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.MaxItens(Passport,"bullguerjuice",1) then
			TriggerClientEvent("Notify",source,'amarelo','Limite de trabalhadores atingido.',3000)
			return
		end

		vRP.GenerateItem(Passport,"bullguerjuice",1,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS:BULLGUERFOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("works:bullguerFood")
AddEventHandler("works:bullguerFood",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.MaxItens(Passport,"bullguerfood",1) then
			TriggerClientEvent("Notify",source,'amarelo','Limite de trabalhadores atingido.',3000)
			return
		end

		vRP.GenerateItem(Passport,"bullguerfood",1,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS:BULLGUERBOX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("works:bullguerBox")
AddEventHandler("works:bullguerBox",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.MaxItens(Passport,"bullguerbox",1) then
			TriggerClientEvent("Notify",source,'amarelo','Limite de trabalhadores atingido.',3000)
			return
		end

		local consultFood = vRP.InventoryItemAmount(Passport,"bullguerfood")
		if consultFood[1] <= 0 then
			TriggerClientEvent("Notify",source,'amarelo','Precisa de <b>1x '..itemName("bullguerfood")..'</b>.',5000)
			return
		end

		local consultJuice = vRP.InventoryItemAmount(Passport,"bullguerjuice")
		if consultJuice[1] <= 0 then
			TriggerClientEvent("Notify",source,'amarelo','Precisa de  <b>1x '..itemName("bullguerjuice")..'</b> para roubar.',5000)
			return
		end

		vRP.RemoveItem(Passport,"bullguerjuice",1,false)
		vRP.RemoveItem(Passport,"bullguerfood",1,false)
		vRP.GenerateItem(Passport,"bullguerbox",1,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	vCLIENT.updateWorks(source,works)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if activeWorks["Municao"][Passport] then
		activeWorks["Municao"][Passport] = nil
	end

	if activeWorks["Armas"][Passport] then
		activeWorks["Armas"][Passport] = nil
	end
end)