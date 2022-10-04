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
Tunnel.bindInterface("creator",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEFACE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.updateFace(Face)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Query("playerdata/SetData",{ Passport = Passport, dkey = "Barbershop", dvalue = json.encode(Face) })
		vRP.Query("playerdata/SetData",{ Passport = Passport, dkey = "Creator", dvalue = 1 })

		Player(source)["state"]["Route"] = 0
		SetPlayerRoutingBucket(source,0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	local Creator = vRP.UserData(Passport,"Creator")
	if Creator ~= 1 then
		TriggerClientEvent("spawn:Close",source)
		TriggerClientEvent("creator:Open",source)
	end
end)