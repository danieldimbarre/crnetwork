-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Boxes = 0
local Cooldown = os.time()
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Helicrash"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Timers[os.date("%H:%M")] and os.time() >= Cooldown then
			Boxes = 0
			local Selected = math.random(#Components)
			for Number,v in pairs(Components[Selected]) do
				if Number ~= "1" then
					Boxes = Boxes + 1

					local Loot = math.random(#Loots)
					vRP.RemSrvData("Chest:Helicrash"..Number,false)
					vRP.SetSrvData("Chest:Helicrash"..Number,Loots[Loot],false)
				end
			end

			TriggerClientEvent("Notify",-1,"azul","Mayday! Mayday! Tivemos problemas técnicos em nossos motores e estamos em queda livre.",30000)
			GlobalState["Helicrash"] = Selected
			Cooldown = os.time() + 3600
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOX
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Box",function()
	if GlobalState["Helicrash"] then
		Boxes = Boxes - 1

		if Boxes <= 0 then
			GlobalState["Helicrash"] = false
			Boxes = 0
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELICRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("helicrash",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and Message[2] then
			local Hours = parseInt(Message[1])
			local Minutes = parseInt(Message[2])

			if Hours <= 9 then
				Hours = "0"..Hours
			end

			if Minutes <= 9 then
				Minutes = "0"..Minutes
			end

			if not Timers[Hours..":"..Minutes] then
				Timers[Hours..":"..Minutes] = true
				TriggerClientEvent("Notify",source,"verde","Helicrash definido para às "..Hours..":"..Minutes..".",5000)
			else
				Timers[Hours..":"..Minutes] = nil
				TriggerClientEvent("Notify",source,"verde","Helicrash das "..Hours..":"..Minutes.." removido.",5000)
			end
		end
	end
end)