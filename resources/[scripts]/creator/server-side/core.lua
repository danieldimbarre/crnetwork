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

		TriggerEvent("vRP:BucketServer",source,"Exit")
	end
end