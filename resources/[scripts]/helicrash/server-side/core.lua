-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Boxes = 0
local Selected = false
local Date = false
local Cooldown = os.time()
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local Timers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPONETS
-----------------------------------------------------------------------------------------------------------------------------------------
local Components = {
	{
		["Objects"] = {
			["1"] = { 2611.75,4476.32,37.69,0.0,"prop_crashed_heli" },
			["2"] = { 2616.68,4472.48,37.96,218.27,"prop_mil_crate_01" },
			["3"] = { 2605.93,4468.87,38.33,127.56,"prop_mil_crate_01" },
			["4"] = { 2605.56,4481.69,37.39,8.51,"prop_mil_crate_01" }
		},
	},
	{
		["Objects"] = {
			["1"] = { -1756.5,-3047.85,14.14,317.49,"prop_crashed_heli" },
			["2"] = { -1748.37,-3040.2,14.14,136.07,"prop_mil_crate_01" },
			["3"] = { -1773.2,-3047.84,14.14,314.65,"prop_mil_crate_01" },
			["4"] = { -1768.87,-3037.05,14.14,246.62,"prop_mil_crate_01" }
		}
	},
	{
		["Objects"] = {
			["1"] = { -1978.82,-616.56,7.3,289.14,"prop_crashed_heli" },
			["2"] = { -1971.66,-607.31,9.0,155.91,"prop_mil_crate_01" },
			["3"] = { -1983.42,-607.55,7.94,206.93,"prop_mil_crate_01" },
			["4"] = { -1975.17,-626.51,6.77,351.5,"prop_mil_crate_01" }
		}
	},
	{
		["Objects"] = {
			["1"] = { 1430.55,6347.11,23.98,280.63,"prop_crashed_heli" },
			["2"] = { 1434.14,6341.27,23.98,90.71,"prop_mil_crate_01" },
			["3"] = { 1435.11,6355.5,23.98,187.09,"prop_mil_crate_01" },
			["4"] = { 1420.73,6348.72,24.25,263.63,"prop_mil_crate_01" }
		}
	},
	{
		["Objects"] = {
			["1"] = { 1992.33,1930.11,92.12,189.93,"prop_crashed_heli" },
			["2"] = { 1998.27,1930.37,92.44,93.55,"prop_mil_crate_01" },
			["3"] = { 1984.34,1937.08,91.97,252.29,"prop_mil_crate_01" },
			["4"] = { 1993.27,1940.6,91.81,181.42,"prop_mil_crate_01" }
		}
	},
	{
		["Objects"] = {
			["1"] = { 746.64,1204.22,326.84,238.12,"prop_crashed_heli" },
			["2"] = { 753.39,1209.68,327.73,116.23,"prop_mil_crate_01" },
			["3"] = { 744.31,1192.79,326.33,343.0,"prop_mil_crate_01" },
			["4"] = { 738.53,1207.17,326.94,252.29,"prop_mil_crate_01" }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Loots = {
	{
		["1"] = { item = "WEAPON_PISTOL", amount = 1 },
		["2"] = { item = "energetic", amount = 1 },
		["3"] = { item = "backpack", amount = 2 },
		["4"] = { item = "hamburger2", amount = 5 },
		["5"] = { item = "gauze", amount = 5 }
	},{
		["1"] = { item = "WEAPON_PISTOL", amount = 1 },
		["2"] = { item = "backpack", amount = 2 },
		["3"] = { item = "bananajuice", amount = 5 },
		["4"] = { item = "hamburger2", amount = 5 },
		["5"] = { item = "bandage", amount = 5 }
	},{
		["1"] = { item = "backpack", amount = 1 },
		["2"] = { item = "dollars", amount = 2000 },
		["3"] = { item = "medkit", amount = 3 },
		["4"] = { item = "vest", amount = 1 },
		["5"] = { item = "WEAPON_KATANA", amount = 1 }
	},{
		["1"] = { item = "explosives", amount = 5 },
		["2"] = { item = "tarp", amount = 10 },
		["3"] = { item = "techtrash", amount = 10 },
		["4"] = { item = "WEAPON_KARAMBIT", amount = 1 },
		["5"] = { item = "blocksignal", amount = 2 }
	},{
		["1"] = { item = "advtoolbox", amount = 2 },
		["2"] = { item = "tyres", amount = 5 },
		["3"] = { item = "repairkit01", amount = 3 },
		["4"] = { item = "dollars", amount = 1000 },
		["5"] = { item = "WEAPON_WRENCH", amount = 5 }
	},{
		["1"] = { item = "advtoolbox", amount = 1 },
		["2"] = { item = "tyres", amount = 5 },
		["3"] = { item = "notebook", amount = 1 },
		["4"] = { item = "nitro", amount = 2 },
		["5"] = { item = "WEAPON_CROWBAR", amount = 1 }
	},{
		["1"] = { item = "dismantle", amount = 2 },
		["2"] = { item = "transmissiona", amount = 1 },
		["3"] = { item = "firecracker", amount = 3 },
		["4"] = { item = "oxy", amount = 8 },
		["5"] = { item = "dildo", amount = 1 }
	},{
		["1"] = { item = "spray04", amount = 1 },
		["2"] = { item = "soap", amount = 1 },
		["3"] = { item = "brush", amount = 1 },
		["4"] = { item = "spray03", amount = 1 },
		["5"] = { item = "spray01", amount = 1 }
	},{
		["1"] = { item = "blender", amount = 1 },
		["2"] = { item = "pan", amount = 1 },
		["3"] = { item = "dish", amount = 1 },
		["4"] = { item = "cup", amount = 1 },
		["5"] = { item = "switch", amount = 1 }
	},{
		["1"] = { item = "domino", amount = 1 },
		["2"] = { item = "floppy", amount = 1 },
		["3"] = { item = "playstation", amount = 1 },
		["4"] = { item = "legos", amount = 1 },
		["5"] = { item = "ominitrix", amount = 1 }
	},{
		["1"] = { item = "watch", amount = 1 },
		["2"] = { item = "goldcoin", amount = 1 },
		["3"] = { item = "goldring", amount = 1 },
		["4"] = { item = "bracelet", amount = 1 },
		["5"] = { item = "rimel", amount = 1 }
	},{
		["1"] = { item = "watch", amount = 1 },
		["2"] = { item = "goldcoin", amount = 1 },
		["3"] = { item = "goldring", amount = 1 },
		["4"] = { item = "bracelet", amount = 1 },
		["5"] = { item = "rimel", amount = 1 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Timers[os.date("%H:%M")] and os.time() >= Cooldown then
			Date = os.date("%H:%M")
			Boxes = 0
			Selected = math.random(#Components)
			local Crashed = Components[Selected]

			for Number,v in pairs(Crashed["Objects"]) do
				if Number ~= "1" then
					Boxes = Boxes + 1

					local Loot = math.random(#Loots)
					vRP.RemSrvData("Chest:Helicrash"..Number,false)
					vRP.SetSrvData("Chest:Helicrash"..Number,Loots[Loot],false)
				end
			end

			TriggerClientEvent("Notify",-1,"amarelo","Mayday! Mayday! Tivemos problemas técnicos em nossos motores e estamos em queda livre.",30000)
			TriggerClientEvent("helicrash:Active",-1,Selected)
			Cooldown = os.time() + 3600
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELICRASH:AMOUNTBOXES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("helicrash:AmountBoxes")
AddEventHandler("helicrash:AmountBoxes",function()
	Boxes = Boxes - 1

	if Boxes <= 0 then
		TriggerClientEvent("helicrash:ClearEvent",-1)
		Selected = false
		Boxes = 0

		if Timers[Date] then
			Timers[Date] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELICRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("helicrash",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			if not Timers[Message[1]..":"..Message[2]] then
				Timers[Message[1]..":"..Message[2]] = true

				TriggerClientEvent("Notify",source,"verde","Helicrash definido para às "..Message[1]..":"..Message[2]..".",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("helicrash:Table",source,Components,Selected)
end)