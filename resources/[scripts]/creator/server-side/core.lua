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
		vRP.Execute("playerdata/SetData",{ Passport = Passport, dkey = "Barbershop", dvalue = json.encode(Face) })

		Wait(500)

		vRP.Execute("playerdata/SetData",{ Passport = Passport, dkey = "Creator", dvalue = 1 })

		Wait(500)

		SetPlayerRoutingBucket(source,0)
		TriggerClientEvent("spawn:justSpawn",source,false,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("creator:newCharacter")
AddEventHandler("creator:newCharacter",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Creator = vRP.UserData(Passport,"Creator") or nil
		if not Creator then
			SetPlayerRoutingBucket(source,source)
			TriggerClientEvent("creator:displayCreator",source,true)
		else
			TriggerClientEvent("spawn:justSpawn",source,true,true)
		end
	end
end)