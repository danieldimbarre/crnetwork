-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("radio",cRP)
vCLIENT = Tunnel.getInterface("radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.activeFrequency(freq)
	local source = source
	local user_id = vRP.Passport(source)
	if user_id then
		if parseInt(freq) >= 1 and parseInt(freq) <= 999 then
			if parseInt(freq) >= 911 and parseInt(freq) <= 920 then
				if vRP.HasGroup(user_id,"Police") then
					vCLIENT.startFrequency(source,parseInt(freq))
					TriggerClientEvent("hud:Radio",source,parseInt(freq))
					TriggerClientEvent("Notify",source,"verde","<b>"..parseInt(freq)..".0Mhz</b>",5000)
				end
			elseif parseInt(freq) >= 112 and parseInt(freq) <= 114 then
				if vRP.HasGroup(user_id,"Paramedic") then
					vCLIENT.startFrequency(source,parseInt(freq))
					TriggerClientEvent("hud:Radio",source,parseInt(freq))
					TriggerClientEvent("Notify",source,"verde","<b>"..parseInt(freq)..".0Mhz</b>",5000)
				end
			else
				vCLIENT.startFrequency(source,parseInt(freq))
				TriggerClientEvent("hud:Radio",source,parseInt(freq))
				TriggerClientEvent("Notify",source,"verde","<b>"..parseInt(freq)..".0Mhz</b>",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkRadio()
	local source = source
	local user_id = vRP.Passport(source)
	if user_id then
		local Consult = vRP.InventoryItemAmount(user_id,"radio")
		if Consult[1] <= 0 then
			return true
		end

		return false
	end
end