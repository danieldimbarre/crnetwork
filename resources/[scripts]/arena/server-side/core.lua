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
Tunnel.bindInterface("arena",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Players = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("arena:Enter")
AddEventHandler("arena:Enter",function(Route)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.SaveTemporary(Passport,source,Route)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:EXIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("arena:Exit")
AddEventHandler("arena:Exit",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerEvent("arena:Cancel",source,Passport)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("arena:Cancel")
AddEventHandler("arena:Cancel",function(source,Passport)
	local Route = GetPlayerRoutingBucket(source)

	TriggerEvent("arena:Players","-",Route)
	TriggerClientEvent("arena:Exit",source)
	vRP.ApplyTemporary(Passport,source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA:PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("arena:Players")
AddEventHandler("arena:Players",function(Mode,Route)
	if Mode == "+" then
		if not Players[Route] then
			SetRoutingBucketEntityLockdownMode(Route,"relaxed")
			SetRoutingBucketPopulationEnabled(Route,false)
			Players[Route] = 0
		end

		Players[Route] = Players[Route] + 1
	else
		if Players[Route] then
			Players[Route] = Players[Route] - 1

			if Players[Route] < 0 then
				Players[Route] = 0
			end
		end
	end

	TriggerClientEvent("arena:Players",-1,Route,Players[Route])
end)