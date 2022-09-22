-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SERVERMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("hud:ServerMessage")
AddEventHandler("hud:ServerMessage",function(Message)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Identity = vRP.Identity(Passport)
		local Messages = Message:gsub("[<>]","")
		TriggerClientEvent("hud:ClientMessage",source,Identity["name"].." "..Identity["name2"],Messages)

		local Players = vRPC.ClosestPeds(source,10)
		for _,v in pairs(Players) do
			async(function()
				TriggerClientEvent("hud:ClientMessage",v[2],Identity["name"].." "..Identity["name2"],Messages)
			end)
		end
	end
end)