-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Doors"] = {
	[1] = { Coords = vec3(833.08,-1286.84,28.22), Hash = 1734343003, Lock = true, Distance = 1.5, Perm = "Police" },
	[2] = { Coords = vec3(855.28,-1286.55,26.93), Hash = 836255965, Lock = true, Distance = 7, Perm = "Police" },
	[3] = { Coords = vec3(848.97,-1284.29,28.22), Hash = -502195954, Lock = true, Distance = 1.5, Perm = "Police" },
	[4] = { Coords = vec3(847.07,-1314.83,26.45), Hash = -703073730, Lock = true, Distance = 1.5, Perm = "Police" },
	[5] = { Coords = vec3(830.33,-1310.49,28.26), Hash = -1920147247, Lock = true, Distance = 1.5, Perm = "Police" },
	[6] = { Coords = vec3(1845.35,2608.36,45.58), Hash = 741314661, Lock = true, Distance = 7, Perm = "Police" },
	[7] = { Coords = vec3(1818.62,2608.32,45.6), Hash = 741314661, Lock = true, Distance = 7, Perm = "Police" },
	[8] = { Coords = vec3(1690.57,2591.06,45.92), Hash = 320433149, Lock = true, Distance = 1.5, Perm = "Police" },
	[9] = { Coords = vec3(1690.62,2582.05,45.92), Hash = 631614199, Lock = true, Distance = 1.5, Perm = "Police" },
	[10] = { Coords = vec3(1690.61,2576.17,45.92), Hash = 631614199, Lock = true, Distance = 1.5, Perm = "Police" },

	[50] = { Coords = vec3(-1886.47,2050.54,141.0), Hash = 1077118233, Lock = true, Distance = 7, Perm = "Mafia1" },
	[51] = { Coords = vec3(-1889.16,2051.61,141.0), Hash = 1077118233, Lock = true, Distance = 7, Perm = "Mafia1" },
	
	[52] = { Coords = vec3(1384.49,-2080.12,52.6), Hash = 1466379709, Lock = true, Distance = 1.5, Perm = "Mafia2" },
	[53] = { Coords = vec3(1356.84,-2088.72,52.0), Hash = 844544730, Lock = true, Distance = 7, Perm = "Mafia2" },
	[54] = { Coords = vec3(1351.56,-2093.47,52.0), Hash = 844544730, Lock = true, Distance = 7, Perm = "Mafia2" },	

	[101] = { Coords = vec3(805.03,-747.97,27.25), Hash = 95403626, Lock = true, Distance = 1.5, Perm = "PizzaThis", Other = 102 },
	[102] = { Coords = vec3(803.98,-747.97,27.25), Hash = -49173194, Lock = true, Distance = 1.5, Perm = "PizzaThis", Other = 101 },
	[103] = { Coords = vec3(794.29,-757.62,27.25), Hash = 95403626, Lock = true, Distance = 1.5, Perm = "PizzaThis", Other = 104 },
	[104] = { Coords = vec3(794.28,-758.82,27.25), Hash = -49173194, Lock = true, Distance = 1.5, Perm = "PizzaThis", Other = 103 },
	[105] = { Coords = vec3(814.51,-763.74,27.25), Hash = -420112688, Lock = true, Distance = 1.5, Perm = "PizzaThis" },
	[106] = { Coords = vec3(809.54,-756.22,27.25), Hash = 1984391163, Lock = true, Distance = 1.5, Perm = "PizzaThis" },
	[107] = { Coords = vec3(811.95,-763.28,27.25), Hash = 1984391163, Lock = true, Distance = 1.5, Perm = "PizzaThis" },
	[108] = { Coords = vec3(807.00,-765.66,27.25), Hash = 1984391163, Lock = true, Distance = 1.5, Perm = "PizzaThis" },
	[109] = { Coords = vec3(805.30,-759.26,27.25), Hash = -357301147, Lock = true, Distance = 1.5, Perm = "PizzaThis" },
	[110] = { Coords = vec3(804.42,-767.12,31.75), Hash = 1984391163, Lock = true, Distance = 1.5, Perm = "PizzaThis" },
	[111] = { Coords = vec3(797.81,-763.26,31.75), Hash = 1984391163, Lock = true, Distance = 1.5, Perm = "PizzaThis" },
	[112] = { Coords = vec3(797.92,-758.19,31.75), Hash = 1984391163, Lock = true, Distance = 1.5, Perm = "PizzaThis" },
	[113] = { Coords = vec3(806.83,-764.04,31.75), Hash = 1984391163, Lock = true, Distance = 1.5, Perm = "PizzaThis" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.DoorsPermission(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if GlobalState["Doors"][Number]["Perm"] ~= nil then
			if vRP.HasGroup(Passport,GlobalState["Doors"][Number]["Perm"]) then
				local Doors = GlobalState["Doors"]

				Doors[Number]["Lock"] = not Doors[Number]["Lock"]

				if Doors[Number]["Other"] ~= nil then
					local Second = Doors[Number]["Other"]
					Doors[Second]["Lock"] = not Doors[Second]["Lock"]
				end

				GlobalState:set("Doors",Doors,true)

				TriggerClientEvent("hud:DoorsUpdate",-1,Number,Doors[Number]["Lock"])

				vRPC.playAnim(source,true,{"anim@heists@keycard@","exit"},false)
				Wait(350)
				vRPC.stopAnim(source)
			end
		end
	end
end