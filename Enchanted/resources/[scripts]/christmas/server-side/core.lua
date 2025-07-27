-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["ChristmasBox"] = 0
GlobalState["Christmas"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
for Number in pairs(Components) do
	GlobalState["ChristmasBlock:"..Number] = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTICK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local CurrentTime = os.date("%H:%M")
		if Timers[CurrentTime] and not GlobalState["Christmas"] then
			for Number in pairs(Components) do
				local LootRandom = math.random(Multiplier[1],Multiplier[2])
				if vRP.MountContainer(1,"Christmas:"..Number,Loots,LootRandom) then
					GlobalState["ChristmasBlock:"..Number] = false
				end
			end

			TriggerClientEvent("Notify",-1,EventName,MessageStart,"vermelho",30000)
			GlobalState["ChristmasBox"] = CountTable(Components)
			GlobalState["Christmas"] = true

			SetTimeout(EventDuration,function()
				if GlobalState["Christmas"] then
					TriggerClientEvent("Notify",-1,EventName,MessageFinish,"vermelho",10000)
					GlobalState["Christmas"] = false
				end
			end)
		end

		Wait(30000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("ChristmasBox",nil,function(Name,Key,Value)
	if Value <= 0 then
		TriggerClientEvent("Notify",-1,EventName,MessageFinish,"vermelho",10000)
		GlobalState["Christmas"] = false
	end
end)