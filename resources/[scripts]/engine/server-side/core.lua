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
Tunnel.bindInterface("engine",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RechargeFuel(Price)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Price and vRP.PaymentFull(Passport,Price) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE:SYNCFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("engine:SyncFuel")
AddEventHandler("engine:SyncFuel",function(Network,Fuel)
	local Vehicle = NetworkGetEntityFromNetworkId(Network)
	if DoesEntityExist(Vehicle) then
		Entity(Vehicle).state:set("Fuel",Fuel,true)
	end
end)