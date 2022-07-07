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
vCLIENT = Tunnel.getInterface("chat")
-----------------------------------------------------------------------------------------------------------------------------------------
-- MESSAGEENTERED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:messageEntered")
AddEventHandler("chat:messageEntered",function(Message)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Identity = vRP.Identity(Passport)
		TriggerClientEvent("chatME",source,"^3OOC^9"..Identity["name"].." "..Identity["name2"].."^0"..Message)

		local Players = vRPC.ClosestPeds(source,10)
		for _,v in pairs(Players) do
			async(function()
				TriggerClientEvent("chatME",v[2],"^3OOC^9"..Identity["name"].." "..Identity["name2"].."^0"..Message)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDFALLBACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("__cfx_internal:commandFallback")
AddEventHandler("__cfx_internal:commandFallback",function(Command)
	if not Command then
		return
	end

	CancelEvent()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSCHAT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("statusChat",function(source)
	return vCLIENT.statusChat(source)
end)