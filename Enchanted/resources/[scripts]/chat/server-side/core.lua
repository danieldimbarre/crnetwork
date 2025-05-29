-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT:SERVERMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chat:ServerMessage")
AddEventHandler("chat:ServerMessage", function(Mode,Message)
	local source = source
	local Passport = vRP.Passport(source)

	if not Passport then
		return false
	end

	local Name = vRP.FullName(Passport)
	local Messages = Message:gsub("[<>]","")

	if Groups[Mode] then
		if vRP.GetHealth(source) > 100 and vRP.HasService(Passport,Mode) then
			for _,Sources in pairs(vRP.NumPermission(Mode)) do
				async(function()
					TriggerClientEvent("chat:ClientMessage",Sources,Name,Messages,Mode)
				end)
			end
		end
	else
		if Mode == "OOC" then
			TriggerClientEvent("chat:ClientMessage",source,Name,Messages,Mode)

			for _,Sources in pairs(vRPC.ClosestPeds(source,10)) do
				async(function()
					TriggerClientEvent("chat:ClientMessage",Sources,Name,Messages,Mode)
				end)
			end
		else
			TriggerClientEvent("chat:ClientMessage",-1,Name,Messages,Mode)
		end
	end
end)