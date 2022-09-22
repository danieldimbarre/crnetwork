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
Creative = {}
Tunnel.bindInterface("engine",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Vehicles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.paymentFuel(Price,vehPlate,vehFuel,LastFuel,vehNet)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Players = vRPC.Players(source)

		if vRP.PaymentFull(Passport,source,Price) then
			for _,v in ipairs(Players) do
				async(function()
					TriggerClientEvent("engine:syncFuel",v,vehPlate,vehFuel,vehNet)
				end)
			end

			return true
		else
			for _,v in ipairs(Players) do
				async(function()
					TriggerClientEvent("engine:syncFuel",v,vehPlate,LastFuel,vehNet)
				end)
			end

			TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.vehicleFuel(vehPlate)
	if not Vehicles[vehPlate] and vehPlate then
		Vehicles[vehPlate] = 50
	end

	return Vehicles[vehPlate]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("engine:tryFuel")
AddEventHandler("engine:tryFuel",function(vehPlate,vehFuel)
	if vehPlate ~= nil then
		Vehicles[vehPlate] = vehFuel
	end
end)