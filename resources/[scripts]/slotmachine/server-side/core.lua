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
Creative = {}
Tunnel.bindInterface("slotmachine",Creative)
vCLIENT = Tunnel.getInterface("slotmachine")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Players = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MACHINES
-----------------------------------------------------------------------------------------------------------------------------------------
local Machines = {
	["1"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1121.13,230.99,-50.84),
		["prop"] = "vw_prop_casino_slot_04a_reels"
	},
	["2"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1117.13,230.28,-50.84),
		["prop"] = "vw_prop_casino_slot_04a_reels"
	},
	["3"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1113.63,233.67,-50.84),
		["prop"] = "vw_prop_casino_slot_04a_reels"
	},
	["4"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1110.97,238.64,-50.84),
		["prop"] = "vw_prop_casino_slot_04a_reels"
	},
	["5"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1108.48,235.31,-50.84),
		["prop"] = "vw_prop_casino_slot_04a_reels"
	},
	["6"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1104.57,229.44,-50.84),
		["prop"] = "vw_prop_casino_slot_04a_reels"
	},
	["7"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1100.48,230.40,-50.84),
		["prop"] = "vw_prop_casino_slot_04a_reels"
	},
	["8"] = {
		["win"] = {},
		["bet"] = 750,
		["use"] = false,
		["Coords"] = vec3(1100.93,231.00,-50.84),
		["prop"] = "vw_prop_casino_slot_05a_reels"
	},
	["9"] = {
		["win"] = {},
		["bet"] = 750,
		["use"] = false,
		["Coords"] = vec3(1104.30,230.31,-50.84),
		["prop"] = "vw_prop_casino_slot_05a_reels"
	},
	["10"] = {
		["win"] = {},
		["bet"] = 750,
		["use"] = false,
		["Coords"] = vec3(1109.21,234.76,-50.84),
		["prop"] = "vw_prop_casino_slot_05a_reels"
	},
	["11"] = {
		["win"] = {},
		["bet"] = 750,
		["use"] = false,
		["Coords"] = vec3(1111.71,238.73,-50.84),
		["prop"] = "vw_prop_casino_slot_05a_reels"
	},
	["12"] = {
		["win"] = {},
		["bet"] = 750,
		["use"] = false,
		["Coords"] = vec3(1113.36,234.54,-50.84),
		["prop"] = "vw_prop_casino_slot_05a_reels"
	},
	["13"] = {
		["win"] = {},
		["bet"] = 750,
		["use"] = false,
		["Coords"] = vec3(1117.87,229.74,-50.84),
		["prop"] = "vw_prop_casino_slot_05a_reels"
	},
	["14"] = {
		["win"] = {},
		["bet"] = 750,
		["use"] = false,
		["Coords"] = vec3(1121.59,230.41,-50.84),
		["prop"] = "vw_prop_casino_slot_05a_reels"
	},
	["15"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1120.85,231.68,-50.84),
		["prop"] = "vw_prop_casino_slot_03a_reels"
	},
	["16"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1114.55,233.66,-50.84),
		["prop"] = "vw_prop_casino_slot_03a_reels"
	},
	["17"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1110.22,238.74,-50.84),
		["prop"] = "vw_prop_casino_slot_03a_reels"
	},
	["18"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1105.48,229.43,-50.84),
		["prop"] = "vw_prop_casino_slot_03a_reels"
	},
	["19"] = {
		["win"] = {},
		["bet"] = 500,
		["use"] = false,
		["Coords"] = vec3(1101.22,231.69,-50.84),
		["prop"] = "vw_prop_casino_slot_06a_reels"
	},
	["20"] = {
		["win"] = {},
		["bet"] = 500,
		["use"] = false,
		["Coords"] = vec3(1108.91,233.90,-50.84),
		["prop"] = "vw_prop_casino_slot_06a_reels"
	},
	["21"] = {
		["win"] = {},
		["bet"] = 500,
		["use"] = false,
		["Coords"] = vec3(1112.40,239.02,-50.84),
		["prop"] = "vw_prop_casino_slot_06a_reels"
	},
	["22"] = {
		["win"] = {},
		["bet"] = 500,
		["use"] = false,
		["Coords"] = vec3(1117.57,228.87,-50.84),
		["prop"] = "vw_prop_casino_slot_06a_reels"
	},
	["23"] = {
		["win"] = {},
		["bet"] = 1000,
		["use"] = false,
		["Coords"] = vec3(1120.75,232.42,-50.84),
		["prop"] = "vw_prop_casino_slot_02a_reels"
	},
	["24"] = {
		["win"] = {},
		["bet"] = 1000,
		["use"] = false,
		["Coords"] = vec3(1114.84,234.52,-50.84),
		["prop"] = "vw_prop_casino_slot_02a_reels"
	},
	["25"] = {
		["win"] = {},
		["bet"] = 1000,
		["use"] = false,
		["Coords"] = vec3(1109.53,239.02,-50.84),
		["prop"] = "vw_prop_casino_slot_02a_reels"
	},
	["26"] = {
		["win"] = {},
		["bet"] = 1000,
		["use"] = false,
		["Coords"] = vec3(1105.78,230.29,-50.84),
		["prop"] = "vw_prop_casino_slot_02a_reels"
	},
	["27"] = {
		["win"] = {},
		["bet"] = 1250,
		["use"] = false,
		["Coords"] = vec3(1120.85,233.16,-50.84),
		["prop"] = "vw_prop_casino_slot_01a_reels"
	},
	["28"] = {
		["win"] = {},
		["bet"] = 1250,
		["use"] = false,
		["Coords"] = vec3(1114.11,235.07,-50.84),
		["prop"] = "vw_prop_casino_slot_01a_reels"
	},
	["29"] = {
		["win"] = {},
		["bet"] = 1250,
		["use"] = false,
		["Coords"] = vec3(1108.93,239.47,-50.84),
		["prop"] = "vw_prop_casino_slot_01a_reels"
	},
	["30"] = {
		["win"] = {},
		["bet"] = 1250,
		["use"] = false,
		["Coords"] = vec3(1105.04,230.84,-50.84),
		["prop"] = "vw_prop_casino_slot_01a_reels"
	},
	["31"] = {
		["win"] = {},
		["bet"] = 1000,
		["use"] = false,
		["Coords"] = vec3(1101.32,232.43,-50.84),
		["prop"] = "vw_prop_casino_slot_07a_reels"
	},
	["32"] = {
		["win"] = {},
		["bet"] = 1000,
		["use"] = false,
		["Coords"] = vec3(1108.00,233.91,-50.84),
		["prop"] = "vw_prop_casino_slot_07a_reels"
	},
	["33"] = {
		["win"] = {},
		["bet"] = 1000,
		["use"] = false,
		["Coords"] = vec3(1112.99,239.47,-50.84),
		["prop"] = "vw_prop_casino_slot_07a_reels"
	},
	["34"] = {
		["win"] = {},
		["bet"] = 1000,
		["use"] = false,
		["Coords"] = vec3(1116.66,228.88,-50.84),
		["prop"] = "vw_prop_casino_slot_07a_reels"
	},
	["35"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1116.39,229.76,-50.84),
		["prop"] = "vw_prop_casino_slot_08a_reels"
	},
	["36"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1107.73,234.79,-50.84),
		["prop"] = "vw_prop_casino_slot_08a_reels"
	},
	["37"] = {
		["win"] = {},
		["bet"] = 250,
		["use"] = false,
		["Coords"] = vec3(1101.22,233.17,-50.84),
		["prop"] = "vw_prop_casino_slot_08a_reels"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINTABLE
-----------------------------------------------------------------------------------------------------------------------------------------
local winTable = { "2","3","6","2","4","1","6","5","2","1","3","6","7","1","4","5" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- MULTABLE
-----------------------------------------------------------------------------------------------------------------------------------------
local mulTable = {
	["1"] = 2,
	["2"] = 4,
	["3"] = 6,
	["4"] = 8,
	["5"] = 10,
	["6"] = 12,
	["7"] = 14
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkTable(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Machines[Table] then
		if not Machines[Table]["use"] then
			Machines[Table]["use"] = true
			Players[Passport] = Table
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANTABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.cleanTable(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Machines[Table] then
		if Machines[Table]["use"] then
			Machines[Table]["win"] = {}
			Machines[Table]["use"] = false
		end

		if Players[Passport] then
			Players[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Players[Passport] then
		local Table = Players[Passport]
		if Machines[Table] then
			if Machines[Table]["use"] then
				Machines[Table]["win"] = {}
				Machines[Table]["use"] = false
			end
		end

		Players[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Payment(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Machines[Table] then
		if vRP.PaymentFull(source,Passport,Machines[Table]["bet"]) then
			return true
		else
			TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSLOTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StartSlots(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Machines[Table] then
		local Result = {
			["a"] = math.random(16),
			["b"] = math.random(16),
			["c"] = math.random(16)
		}

		Machines[Table]["win"] = Result
		vCLIENT.MachineSlots(source,Result)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SLOTSCHECKWIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckWin(Table,Result)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Machines[Table] then
		if Machines[Table]["win"] then
			if Machines[Table]["win"]["a"] == Result["a"] and Machines[Table]["win"]["b"] == Result["b"] and Machines[Table]["win"]["c"] == Result["c"] then
				local Total = 0
				local Spin01 = winTable[Result["a"]]
				local Spin02 = winTable[Result["b"]]
				local Spin03 = winTable[Result["c"]]

				if Spin01 == Spin02 and Spin01 == Spin03 then
					if mulTable[Spin01] then
						Total = Machines[Table]["bet"] * mulTable[Spin01]
					end
				elseif Spin01 == Spin02 or Spin02 == Spin03 or Spin01 == Spin03 then
					Total = Machines[Table]["bet"] * 2
				end

				if Total > 0 then
					vRP.GiveBank(Passport,Total)
				end
			end

			Machines[Table]["win"] = {}
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	vCLIENT.UpdateMachines(source,Machines)
end)