-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("towdriver",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local userList = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.toggleService()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if userList[Passport] then
			userList[Passport] = nil
		else
			userList[Passport] = source
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWDRIVER:CALL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("towdriver:Call",function(source,vehName,vehPlate)
	local Ped = GetPlayerPed(source)
	local Coords = GetEntityCoords(Ped)

	for k,v in pairs(userList) do
		async(function()
			TriggerClientEvent("NotifyPush",v,{ code = 51, title = "Registro de Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 33 })
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentMethod()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if (vRP.inventoryWeight(Passport) + 3) <= vRP.getWeights(Passport) then
			local VehParts = math.random(4)
			local VehSelected = "suspension"
			local AmountItens = math.random(4,5)
			local Tow = vRP.GetExperience(Passport,"Tows")
			local Class = ClassCategory(Tow)
			local VehRandom = 1000

			if Class == "B" or Class == "B+" then
				VehRandom = math.random(4500)
			elseif Class == "A" or Class == "A+" then
				VehRandom = math.random(3500)
			elseif Class == "S" or Class == "S+" then
				VehRandom = math.random(2500)
			end

			if VehParts <= 1 then
				VehSelected = "engine"
			elseif VehParts == 2 then
				VehSelected = "transmission"
			elseif VehParts == 3 then
				VehSelected = "brake"
			end

			if VehRandom <= 10 then
				vRP.generateItem(Passport,VehSelected.."e",1,true)
			elseif VehRandom >= 10 and VehRandom <= 30 then
				vRP.generateItem(Passport,VehSelected.."d",1,true)
			elseif VehRandom >= 31 and VehRandom <= 60 then
				vRP.generateItem(Passport,VehSelected.."c",1,true)
			elseif VehRandom >= 61 and VehRandom <= 100 then
				vRP.generateItem(Passport,VehSelected.."b",1,true)
			elseif VehRandom >= 101 and VehRandom <= 150 then
				vRP.generateItem(Passport,VehSelected.."a",1,true)
			end

			vRP.generateItem(Passport,"plastic",AmountItens,true)
			vRP.generateItem(Passport,"glass",AmountItens,true)
			vRP.generateItem(Passport,"rubber",AmountItens,true)
			vRP.generateItem(Passport,"copper",AmountItens,true)
			vRP.generateItem(Passport,"aluminum",AmountItens,true)

			vRP.PutExperience(Passport,"Tows",1)
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWDRIVER:SERVERTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("towdriver:ServerTow")
AddEventHandler("towdriver:ServerTow",function(veh01,veh02,mode)
	local source = source
	local Players = vRPC.Players(source)
	for _,v in ipairs(Players) do
		async(function()
			TriggerClientEvent("towdriver:ClientTow",v,veh01,veh02,mode)
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if userList[Passport] then
		userList[Passport] = nil
	end
end)