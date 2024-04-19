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
Tunnel.bindInterface("inventory",Creative)
vPLAYER = Tunnel.getInterface("player")
vGARAGE = Tunnel.getInterface("garages")
vCLIENT = Tunnel.getInterface("inventory")
vKEYBOARD = Tunnel.getInterface("keyboard")
vPARAMEDIC = Tunnel.getInterface("paramedic")
vSURVIVAL = Tunnel.getInterface("survival")
vDEVICE = Tunnel.getInterface("device")
vFARMER = Tunnel.getInterface("farmer")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Drugs = {}
Drops = {}
Carry = {}
Active = {}
Trashs = {}
Plates = {}
Armors = {}
Trunks = {}
Healths = {}
Property = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
Weapons = {
	["Ammo"] = {},
	["Attach"] = {},
	["Skin"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
Buffs = {
	["Dexterity"] = {},
	["Luck"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
VehicleServices = {
	["bus"] = true,
	["stockade"] = true,
	["ratloader"] = true,
	["trash"] = true,
	["packer"] = true,
	["taxi"] = true,
	["boxville2"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
Objects = {
	["1"] = { Coords = vec3(594.59,146.52,97.30), Heading = 70.04, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["2"] = { Coords = vec3(660.44,268.29,102.04), Heading = 152.09, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["3"] = { Coords = vec3(552.54,-198.45,53.75), Heading = 89.32, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["4"] = { Coords = vec3(339.75,-580.95,73.42), Heading = 67.19, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["5"] = { Coords = vec3(696.12,-965.69,23.26), Heading = 271.33, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["6"] = { Coords = vec3(-2235.42,363.52,173.91), Heading = 23.73, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["7"] = { Coords = vec3(1382.1,-2081.97,51.25), Heading = 220.16, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["8"] = { Coords = vec3(589.32,-2802.73,5.32), Heading = 328.01, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["9"] = { Coords = vec3(-453.19,-2810.47,6.56), Heading = 225.82, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["10"] = { Coords = vec3(-1007.18,-2836.12,13.20), Heading = 149.3, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["11"] = { Coords = vec3(-2018.21,-361.03,47.36), Heading = 324.55, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["12"] = { Coords = vec3(-1727.77,250.26,61.65), Heading = 24.7, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["13"] = { Coords = vec3(-1089.6,2717.05,18.33), Heading = 40.52, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["14"] = { Coords = vec3(321.27,2874.98,42.71), Heading = 27.62, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["15"] = { Coords = vec3(1163.47,2722.09,37.26), Heading = 179.11, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["16"] = { Coords = vec3(1745.86,3326.69,40.30), Heading = 115.55, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["17"] = { Coords = vec3(2013.4,3934.36,31.65), Heading = 236.38, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["18"] = { Coords = vec3(2526.3,4191.6,44.53), Heading = 236.44, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["19"] = { Coords = vec3(2874.05,4861.57,61.35), Heading = 87.57, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["20"] = { Coords = vec3(1985.16,6200.39,41.33), Heading = 330.21, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["21"] = { Coords = vec3(1552.97,6610.24,2.12), Heading = 145.64, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["22"] = { Coords = vec3(-298.32,6392.66,29.87), Heading = 302.99, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["23"] = { Coords = vec3(-813.88,5384.45,33.77), Heading = 356.87, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["24"] = { Coords = vec3(-1606.5,5259.26,1.35), Heading = 114.45, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["25"] = { Coords = vec3(-199.22,3638.8,63.70), Heading = 39.84, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["26"] = { Coords = vec3(-1487.45,2688.99,2.94), Heading = 317.89, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["27"] = { Coords = vec3(-3266.12,1139.82,1.91), Heading = 249.17, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["28"] = { Coords = vec3(170.71,-1070.94,28.5), Heading = 339.6, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["29"] = { Coords = vec3(487.23,-1093.93,28.71), Heading = 0.74, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["30"] = { Coords = vec3(584.63,-1419.69,18.52), Heading = 180.41, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["31"] = { Coords = vec3(694.07,-1453.5,19.03), Heading = 0.45, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["32"] = { Coords = vec3(892.49,-2490.3,28.88), Heading = 175.48, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["33"] = { Coords = vec3(1463.09,-2613.91,48.17), Heading = 76.65, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["34"] = { Coords = vec3(1877.42,-1065.71,80.22), Heading = 97.79, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["35"] = { Coords = vec3(2557.67,-598.5,64.23), Heading = 12.71, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["36"] = { Coords = vec3(2546.8,395.31,107.92), Heading = 268.3, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["37"] = { Coords = vec3(2074.59,1403.29,74.88), Heading = 300.3, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["38"] = { Coords = vec3(2405.44,2903.85,39.67), Heading = 217.41, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["39"] = { Coords = vec3(2895.84,3735.4,43.5), Heading = 289.37, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["40"] = { Coords = vec3(1677.25,4882.36,46.62), Heading = 59.7, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["41"] = { Coords = vec3(-437.08,6339.84,12.06), Heading = 216.59, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["42"] = { Coords = vec3(431.15,6472.57,28.08), Heading = 140.5, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["43"] = { Coords = vec3(-2303.74,3389.16,30.56), Heading = 324.26, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["44"] = { Coords = vec3(-2096.92,3258.17,32.12), Heading = 239.97, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["45"] = { Coords = vec3(-1773.55,2995.46,32.11), Heading = 330.02, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["46"] = { Coords = vec3(-2086.61,2816.89,32.27), Heading = 354.52, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },
	["47"] = { Coords = vec3(-1511.83,1520.27,114.59), Heading = 255.31, Object = "sm_prop_smug_crate_s_medical", Distance = 50, Mode = "Medic", Weight = 0.25 },

	["48"] = { Coords = vec3(574.01,132.56,98.48), Heading = 70.99, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["49"] = { Coords = vec3(344.79,929.2,202.44), Heading = 268.09, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["50"] = { Coords = vec3(-123.8,1896.67,196.34), Heading = 358.95, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["51"] = { Coords = vec3(-1099.85,2703.51,21.99), Heading = 221.35, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["52"] = { Coords = vec3(-2198.91,4243.21,46.92), Heading = 128.84, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["53"] = { Coords = vec3(-1487.02,4983.14,62.67), Heading = 174.11, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["54"] = { Coords = vec3(1346.49,6396.73,32.42), Heading = 90.94, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["55"] = { Coords = vec3(2535.72,4661.39,33.08), Heading = 316.4, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["56"] = { Coords = vec3(1155.62,-1334.48,33.72), Heading = 174.97, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["57"] = { Coords = vec3(1116.06,-2498.07,32.37), Heading = 193.39, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["58"] = { Coords = vec3(261.06,-3135.82,4.8), Heading = 88.83, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["59"] = { Coords = vec3(-1619.81,-1035.0,12.16), Heading = 50.84, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["60"] = { Coords = vec3(-3420.87,977.0,10.91), Heading = 226.29, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["61"] = { Coords = vec3(-1909.53,4624.93,56.07), Heading = 135.57, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["62"] = { Coords = vec3(894.51,3211.45,38.09), Heading = 273.04, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["63"] = { Coords = vec3(1791.71,4602.84,36.69), Heading = 185.86, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["64"] = { Coords = vec3(464.8,6462.03,28.76), Heading = 334.71, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["65"] = { Coords = vec3(63.22,6323.67,37.87), Heading = 301.22, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["66"] = { Coords = vec3(-736.64,5594.98,40.66), Heading = 268.78, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["67"] = { Coords = vec3(720.76,2330.87,50.76), Heading = 179.99, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["68"] = { Coords = vec3(1909.47,611.47,177.41), Heading = 65.57, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["69"] = { Coords = vec3(1796.6,-1350.06,98.75), Heading = 61.5, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["70"] = { Coords = vec3(955.32,-3101.26,4.91), Heading = 266.38, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["71"] = { Coords = vec3(-1306.41,-3387.9,12.95), Heading = 59.92, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["72"] = { Coords = vec3(-1219.66,-2079.82,13.16), Heading = 351.04, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["73"] = { Coords = vec3(-1203.53,-1804.25,2.91), Heading = 245.4, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["74"] = { Coords = vec3(-720.47,-399.49,33.9), Heading = 351.27, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["75"] = { Coords = vec3(-503.39,-1438.17,13.16), Heading = 346.71, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["76"] = { Coords = vec3(1398.24,2117.57,104.02), Heading = 131.36, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["77"] = { Coords = vec3(-1811.62,3104.09,31.85), Heading = 60.36, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["78"] = { Coords = vec3(-1812.86,3101.95,31.85), Heading = 62.1, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["79"] = { Coords = vec3(-1850.29,3156.66,31.82), Heading = 150.22, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["80"] = { Coords = vec3(-2052.86,3173.31,31.82), Heading = 240.03, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["81"] = { Coords = vec3(-2409.94,3355.95,31.83), Heading = 61.29, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },
	["82"] = { Coords = vec3(-2450.39,2946.63,31.97), Heading = 330.0, Object = "prop_mb_crate_01a", Distance = 50, Mode = "Weapons", Weight = 0.35 },

	["83"] = { Coords = vec3(-257.5,-966.54,30.22), Heading = 26.06, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["84"] = { Coords = vec3(-2682.86,2304.87,20.85), Heading = 164.19, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["85"] = { Coords = vec3(-1282.33,2559.98,17.4), Heading = 148.06, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["86"] = { Coords = vec3(159.65,3118.8,42.44), Heading = 16.37, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["87"] = { Coords = vec3(1061.43,3527.62,33.15), Heading = 255.93, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["88"] = { Coords = vec3(2370.22,3156.55,47.21), Heading = 221.77, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["89"] = { Coords = vec3(2520.51,2637.83,36.95), Heading = 314.33, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["90"] = { Coords = vec3(2572.37,477.44,107.68), Heading = 269.49, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["91"] = { Coords = vec3(1223.15,-1079.56,37.53), Heading = 123.38, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["92"] = { Coords = vec3(1048.49,-247.53,68.66), Heading = 149.33, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["93"] = { Coords = vec3(499.41,-529.38,23.76), Heading = 262.13, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["94"] = { Coords = vec3(592.53,-2115.87,4.76), Heading = 100.96, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["95"] = { Coords = vec3(523.43,-2578.67,13.82), Heading = 318.38, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["96"] = { Coords = vec3(-2.98,-1299.67,28.28), Heading = 359.37, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["97"] = { Coords = vec3(183.11,-1086.93,28.28), Heading = 348.57, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["98"] = { Coords = vec3(713.88,-850.95,23.3), Heading = 271.63, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["99"] = { Coords = vec3(-2438.82,2999.82,32.07), Heading = 194.35, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["100"] = { Coords = vec3(-2440.04,2999.46,32.07), Heading = 194.41, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["101"] = { Coords = vec3(-2092.59,3113.14,31.82), Heading = 240.25, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["102"] = { Coords = vec3(-1824.95,3016.0,31.82), Heading = 329.62, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["103"] = { Coords = vec3(-202.03,3651.99,50.74), Heading = 192.39, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["104"] = { Coords = vec3(-203.41,3651.71,50.74), Heading = 192.96, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["105"] = { Coords = vec3(2007.81,4964.86,40.71), Heading = 158.28, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["106"] = { Coords = vec3(1904.26,4930.73,47.97), Heading = 156.61, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["107"] = { Coords = vec3(1702.14,4819.3,40.96), Heading = 97.05, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["108"] = { Coords = vec3(2030.66,4727.43,40.61), Heading = 294.35, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["109"] = { Coords = vec3(2122.12,4784.69,39.98), Heading = 116.71, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["110"] = { Coords = vec3(2177.23,2169.39,116.31), Heading = 229.64, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["111"] = { Coords = vec3(2395.2,2032.72,90.35), Heading = 318.06, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["112"] = { Coords = vec3(2619.31,1691.36,26.6), Heading = 270.01, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["113"] = { Coords = vec3(1454.52,-1680.69,65.03), Heading = 25.31, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["114"] = { Coords = vec3(1453.05,-1681.37,64.96), Heading = 24.93, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["115"] = { Coords = vec3(240.42,-1864.8,25.82), Heading = 49.31, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["116"] = { Coords = vec3(-139.01,-1995.56,21.81), Heading = 181.56, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["117"] = { Coords = vec3(-343.54,-1333.09,36.31), Heading = 89.4, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["118"] = { Coords = vec3(-350.99,-1333.15,36.31), Heading = 269.98, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["119"] = { Coords = vec3(-346.45,-1337.38,36.31), Heading = 359.9, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },
	["120"] = { Coords = vec3(-267.45,-971.56,30.22), Heading = 25.86, Object = "gr_prop_gr_rsply_crate03a", Distance = 50, Mode = "Supplies", Weight = 0.25 },

	-- ROBBERY CLOTHESHOP
	["121"] = { Coords = vec3(70.27,-1389.11,29.13), Heading = 90.28, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["122"] = { Coords = vec3(-706.01,-150.49,37.17), Heading = 28.61, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["123"] = { Coords = vec3(-167.66,-301.67,39.49), Heading = 161.34, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["124"] = { Coords = vec3(-821.69,-1067.22,11.08), Heading = 31.23, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["125"] = { Coords = vec3(-1186.62,-772.55,17.09), Heading = 215.93, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["126"] = { Coords = vec3(-1446.85,-240.38,49.57), Heading = 316.88, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["127"] = { Coords = vec3(5.53,6506.07,31.63), Heading = 222.68, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["128"] = { Coords = vec3(1699.51,4819.72,41.82), Heading = 277.02, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["129"] = { Coords = vec3(117.83,-223.56,54.31), Heading = 70.89, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["130"] = { Coords = vec3(621.58,2765.81,41.84), Heading = 275.02, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["131"] = { Coords = vec3(1200.46,2715.37,37.98), Heading = 0.24, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["132"] = { Coords = vec3(-3178.48,1044.46,20.62), Heading = 66.61, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["133"] = { Coords = vec3(-1102.05,2716.93,18.86), Heading = 40.85, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["134"] = { Coords = vec3(430.72,-810.01,29.25), Heading = 270.35, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },

	-- ROBBERY WEAPONSSHOP
	["135"] = { Coords = vec3(1688.78,3759.13,34.46), Heading = 47.5, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["136"] = { Coords = vec3(256.35,-47.51,69.7), Heading = 249.76, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["137"] = { Coords = vec3(846.13,-1036.62,27.95), Heading = 178.74, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["138"] = { Coords = vec3(-335.18,6083.29,31.21), Heading = 45.57, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["139"] = { Coords = vec3(-665.98,-932.24,21.58), Heading = 358.38, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["140"] = { Coords = vec3(-1301.93,-391.36,36.45), Heading = 255.85, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["141"] = { Coords = vec3(-1122.59,2698.25,18.31), Heading = 42.82, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["142"] = { Coords = vec3(2571.67,291.28,108.49), Heading = 180.02, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["143"] = { Coords = vec3(2571.66,291.29,108.49), Heading = 181.06, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["144"] = { Coords = vec3(19.57,-1103.0,29.55), Heading = 339.07, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["145"] = { Coords = vec3(813.92,-2160.34,29.37), Heading = 179.33, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },

	-- ROBBERY BARBERSHOP
	["146"] = { Coords = vec3(-807.9,-180.83,37.32), Heading = 299.3, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["147"] = { Coords = vec3(139.56,-1704.12,29.05), Heading = 320.25, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["148"] = { Coords = vec3(-1278.11,-1116.66,6.75), Heading = 270.07, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["149"] = { Coords = vec3(1928.89,3734.04,32.6), Heading = 29.2, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["150"] = { Coords = vec3(1217.05,-473.45,65.96), Heading = 255.89, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["151"] = { Coords = vec3(-34.08,-157.01,56.83), Heading = 159.63, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["152"] = { Coords = vec3(-274.5,6225.27,31.45), Heading = 225.27, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },

	-- ROBBERY TATTOOSHOP
	["153"] = { Coords = vec3(1327.98,-1654.78,52.03), Heading = 218.71, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["154"] = { Coords = vec3(-1149.04,-1428.64,4.71), Heading = 215.2, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["155"] = { Coords = vec3(322.01,186.24,103.34), Heading = 339.28, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["156"] = { Coords = vec3(-3175.64,1075.54,20.58), Heading = 65.96, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["157"] = { Coords = vec3(1866.01,3748.07,32.79), Heading = 299.38, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 },
	["158"] = { Coords = vec3(-295.51,6199.21,31.24), Heading = 133.05, Object = "p_v_43_safe_s", Distance = 50, Weight = 0.5 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
Products = {
	["Cemitery"] = {
		["Timer"] = 5,
		["Police"] = true,
		["Animation"] = {
			["Dict"] = "amb@medic@standing@tendtodead@idle_a",
			["Anim"] = "idle_a"
		},
		["Itens"] = {
			{ ["Item"] = "dirtydollar", ["Chance"] = 100, ["Min"] = 225, ["Max"] = 325 }
		}
	},
	["Milkman"] = {
		["Timer"] = 3,
		["Police"] = false,
		["PolyZone"] = true,
		["Necessary"] = {
			["Item"] = "emptybottle",
			["Amount"] = 1
		},
		["Animation"] = {
			["Dict"] = "amb@medic@standing@kneel@base",
			["Anim"] = "base"
		},
		["Itens"] = {
			{ ["Item"] = "milkbottle", ["Chance"] = 100, ["Min"] = 1, ["Max"] = 1 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
StealPeds = {
	{ ["Item"] = "dismantle", ["Chance"] = 100, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "binoculars", ["Chance"] = 100, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "camera", ["Chance"] = 100, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "diagram", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "races", ["Chance"] = 50, ["Min"] = 1, ["Max"] = 2 },
	{ ["Item"] = "postit", ["Chance"] = 100, ["Min"] = 3, ["Max"] = 5 },
	{ ["Item"] = "radio", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "lockpick", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "cellphone", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "scuba", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "pager", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "alliancemale", ["Chance"] = 75, ["Min"] = 1, ["Max"] = 2 },
	{ ["Item"] = "alliancefemale", ["Chance"] = 75, ["Min"] = 1, ["Max"] = 2 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALITENS
-----------------------------------------------------------------------------------------------------------------------------------------
StealItens = {
	{ ["Item"] = "dismantle", ["Chance"] = 100, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "binoculars", ["Chance"] = 100, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "camera", ["Chance"] = 100, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "diagram", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "races", ["Chance"] = 50, ["Min"] = 1, ["Max"] = 2 },
	{ ["Item"] = "postit", ["Chance"] = 100, ["Min"] = 3, ["Max"] = 5 },
	{ ["Item"] = "radio", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "lockpick", ["Chance"] = 25, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "cellphone", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "scuba", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "pager", ["Chance"] = 1, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "alliancemale", ["Chance"] = 75, ["Min"] = 1, ["Max"] = 2 },
	{ ["Item"] = "alliancefemale", ["Chance"] = 75, ["Min"] = 1, ["Max"] = 2 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRASHITENS
-----------------------------------------------------------------------------------------------------------------------------------------
TrashItens = {
	{ ["Item"] = "plastic", ["Chance"] = 100, ["Min"] = 8, ["Max"] = 10, ["Addition"] = 1.5 },
	{ ["Item"] = "glass", ["Chance"] = 100, ["Min"] = 8, ["Max"] = 10, ["Addition"] = 1.5 },
	{ ["Item"] = "rubber", ["Chance"] = 100, ["Min"] = 8, ["Max"] = 10, ["Addition"] = 1.5 },
	{ ["Item"] = "aluminum", ["Chance"] = 50, ["Min"] = 6, ["Max"] = 8, ["Addition"] = 1 },
	{ ["Item"] = "copper", ["Chance"] = 50, ["Min"] = 6, ["Max"] = 8, ["Addition"] = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOTS
-----------------------------------------------------------------------------------------------------------------------------------------
Loots = {
	["Medic"] = {
		["Players"] = {},
		["Cooldown"] = 3600,
		["List"] = {
			{ ["Item"] = "bandage", ["Chance"] = 50, ["Min"] = 3, ["Max"] = 5 },
			{ ["Item"] = "medkit", ["Chance"] = 20, ["Min"] = 3, ["Max"] = 5 },
			{ ["Item"] = "ritmoneury", ["Chance"] = 15, ["Min"] = 3, ["Max"] = 5 },
			{ ["Item"] = "sinkalmy", ["Chance"] = 15, ["Min"] = 3, ["Max"] = 5 },
			{ ["Item"] = "analgesic", ["Chance"] = 50, ["Min"] = 3, ["Max"] = 5 },
			{ ["Item"] = "gauze", ["Chance"] = 100, ["Min"] = 3, ["Max"] = 5 }
		}
	},
	["Weapons"] = {
		["Players"] = {},
		["Cooldown"] = 7200,
		["List"] = {
			{ ["Item"] = "roadsigns", ["Chance"] = 75, ["Min"] = 3, ["Max"] = 5 },
			{ ["Item"] = "techtrash", ["Chance"] = 25, ["Min"] = 3, ["Max"] = 5 },
			{ ["Item"] = "sheetmetal", ["Chance"] = 75, ["Min"] = 3, ["Max"] = 5 },
			{ ["Item"] = "explosives", ["Chance"] = 50, ["Min"] = 2, ["Max"] = 3 },
			{ ["Item"] = "tarp", ["Chance"] = 100, ["Min"] = 3, ["Max"] = 5 },
			{ ["Item"] = "pistolbody", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "smgbody", ["Chance"] = 8, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "riflebody", ["Chance"] = 6, ["Min"] = 1, ["Max"] = 1 }
		}
	},
	["Supplies"] = {
		["Players"] = {},
		["Cooldown"] = 3600,
		["List"] = {
			{ ["Item"] = "nitro", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "plate", ["Chance"] = 50, ["Min"] = 1, ["Max"] = 1 },
			{ ["Item"] = "tyres", ["Chance"] = 75, ["Min"] = 1, ["Max"] = 2 },
			{ ["Item"] = "soap", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Inventory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Inventory = {}
		local Inv = vRP.Inventory(Passport)
		for Index,v in pairs(Inv) do
			if (parseInt(v["amount"]) <= 0 or not ItemExist(v["item"])) then
				vRP.RemoveItem(Passport,v["item"],parseInt(v["amount"]),false)
			else
				v["name"] = ItemName(v["item"])
				v["peso"] = ItemWeight(v["item"])
				v["index"] = ItemIndex(v["item"])
				v["amount"] = parseInt(v["amount"])
				v["key"] = v["item"]
				v["slot"] = Index

				v["desc"] = "<item>"..v["name"].."</item>"

				local Split = splitString(v["item"])
				local Description = ItemDescription(v["item"])
				if Description then
					v["desc"] = v["desc"].."<br><description>"..Description.."</description>"
				else
					if Split[1] == "vehkey" then
						v["desc"] = v["desc"].."<br><description>Placa do Veículo: <green>"..Split[2].."</green></description>"
					end
				end

				local Max = ItemMaxAmount(v["item"])
				if not Max then
					Max = "Ilimitado"
				end

				v["desc"] = v["desc"].."<br><legenda>Tipo: <r>"..ItemType(v["item"]).."</r> <s>|</s> Máximo: <r>"..Max.."</r></legenda>"

				if Split[2] then
					if ItemLoads(v["item"]) then
						v["charges"] = parseInt(Split[2] * 33)
					end

					if ItemDurability(v["item"]) then
						v["durability"] = parseInt(os.time() - Split[2])
						v["days"] = ItemDurability(v["item"])
					end
				end

				Inventory[Index] = v
			end
		end

		return Inventory,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEND
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Send(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	local ClosestPed = vRPC.ClosestPed(source)
	if Passport and not Active[Passport] and ClosestPed and not exports["hud"]:Wanted(Passport) then
		local Inv = vRP.Inventory(Passport)
		if not Inv[Slot] or not Inv[Slot]["item"] then
			return false
		end

		local Item = Inv[Slot]["item"]
		if vRP.CheckDamaged(Item) or BlockDelete(Item) then
			return false
		end

		Active[Passport] = os.time() + 100
		local OtherPassport = vRP.Passport(ClosestPed)

		if not vRP.MaxItens(OtherPassport,Item,Amount) then
			if vRP.CheckWeight(OtherPassport,Item,Amount) then
				Active[Passport] = os.time() + 3
				Player(source)["state"]["Cancel"] = true
				Player(source)["state"]["Buttons"] = true
				Player(ClosestPed)["state"]["Cancel"] = true
				Player(ClosestPed)["state"]["Buttons"] = true
				vRPC.CreateObjects(source,"mp_safehouselost@","package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						vRPC.Destroy(source)
						Active[Passport] = nil
						Player(source)["state"]["Cancel"] = false
						Player(source)["state"]["Buttons"] = false
						Player(ClosestPed)["state"]["Cancel"] = false
						Player(ClosestPed)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
							vRP.GiveItem(OtherPassport,Item,Amount,true)
							TriggerClientEvent("inventory:Update",source,"Backpack")
							TriggerClientEvent("inventory:Update",ClosestPed,"Backpack")
						end
					end

					Wait(100)
				until not Active[Passport]
			else
				TriggerClientEvent("Notify",source,"Aviso","Mochila cheia.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"Aviso","Limite atingido.","amarelo",5000)
		end

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Deliver(Work)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = os.time() + 100

		if Work == "Lumberman" then
			if not vRPC.LastVehicle(source,"ratloader") then
				TriggerClientEvent("Notify",source,"Atenção","Precisa utilizar o veículo do <b>Lenhador</b>.","amarelo",5000)
				Active[Passport] = nil

				return false
			end

			if vRP.TakeItem(Passport,"woodlog",5,false,Slot) then
				local Experience = vRP.GetExperience(Passport,"Lumberman")
				local Level = ClassCategory(Experience)
				local Valuation = 200 + (Level * 10)

				if exports["party"]:DoesExist(Passport) then
					local Members = exports["party"]:Room(Passport,source,10)
					if parseInt(#Members) >= 2 then
						Valuation = Valuation + (Valuation * 0.1)
					end
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if vRP.UserPremium(Passport) then
					local Bonification = 0.05
					local Hierarchy = vRP.LevelPremium(source)
		
					if Hierarchy == 1 then
						Bonification = 0.1
					elseif Hierarchy == 2 then
						Bonification = 0.2
					end
		
					Valuation = Valuation + (Valuation * Bonification)
				end

				vRP.GenerateItem(Passport,"dollar",Valuation,true)
				vRP.PutExperience(Passport,"Lumberman",3)
				Active[Passport] = nil

				return true
			end
		elseif Work == "Milkman" then
			if not vRPC.LastVehicle(source,"youga2") then
				TriggerClientEvent("Notify",source,"Atenção","Precisa utilizar o veículo do <b>Leiteiro</b>.","amarelo",5000)
				Active[Passport] = nil

				return false
			end

			if vRP.TakeItem(Passport,"milkbottle",3,false,Slot) then
				local Experience = vRP.GetExperience(Passport,"Milkman")
				local Level = ClassCategory(Experience)
				local Valuation = 105 + (Level * 5)

				if exports["party"]:DoesExist(Passport) then
					local Members = exports["party"]:Room(Passport,source,10)
					if parseInt(#Members) >= 2 then
						Valuation = Valuation + (Valuation * 0.1)
					end
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if vRP.UserPremium(Passport) then
					local Bonification = 0.05
					local Hierarchy = vRP.LevelPremium(source)
		
					if Hierarchy == 1 then
						Bonification = 0.1
					elseif Hierarchy == 2 then
						Bonification = 0.2
					end
		
					Valuation = Valuation + (Valuation * Bonification)
				end

				vRP.GenerateItem(Passport,"dollar",Valuation,true)
				vRP.PutExperience(Passport,"Milkman",2)
				Active[Passport] = nil

				return true
			end
		elseif Work == "Transporter" then
			if not vRPC.LastVehicle(source,"stockade") then
				TriggerClientEvent("Notify",source,"Atenção","Precisa utilizar o veículo do <b>Transportador</b>.","amarelo",5000)
				Active[Passport] = nil

				return false
			end

			if vRP.TakeItem(Passport,"pouch",1,false,Slot) then
				local Experience = vRP.GetExperience(Passport,"Transporter")
				local Level = ClassCategory(Experience)
				local Valuation = 65 + (Level * 2)

				if exports["party"]:DoesExist(Passport) then
					local Members = exports["party"]:Room(Passport,source,10)
					if parseInt(#Members) >= 2 then
						Valuation = Valuation + (Valuation * 0.1)
					end
				end

				if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
					Valuation = Valuation + (Valuation * 0.1)
				end

				if vRP.UserPremium(Passport) then
					local Bonification = 0.05
					local Hierarchy = vRP.LevelPremium(source)
		
					if Hierarchy == 1 then
						Bonification = 0.1
					elseif Hierarchy == 2 then
						Bonification = 0.2
					end
		
					Valuation = Valuation + (Valuation * Bonification)
				end

				vRP.GenerateItem(Passport,"dollar",Valuation,true)
				vRP.PutExperience(Passport,"Transporter",1)
				Active[Passport] = nil

				return true
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WATERS
-----------------------------------------------------------------------------------------------------------------------------------------
local Waters = {
	["soap"] = true,
	["scuba"] = true,
	["fishingrod"] = true,
	["dirtydollar"] = true,
	["fishingrodplus"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Use(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		local Inv = vRP.Inventory(Passport)
		if not Inv[Slot] or not Inv[Slot]["item"] then
			return
		end

		local Split = splitString(Inv[Slot]["item"])
		local Full = Inv[Slot]["item"]
		local Item = Split[1]

		if Player(source)["state"]["Handcuff"] and Item ~= "lockpick" then
			return
		end

		if ItemDurability(Full) and vRP.CheckDamaged(Full) then
			TriggerClientEvent("Notify",source,"Aviso","<b>"..ItemName(Item).."</b> danificado.","amarelo",5000)

			return
		end

		if Item ~= "rope" and ((Waters[Item] and not vCLIENT.Water(source)) or (not Waters[Item] and vCLIENT.Water(source))) then
			return
		end

		if ItemType(Full) == "Armamento" and parseInt(Slot) <= 5 then
			if vRP.InsideVehicle(source) and not ItemVehicle(Full) then
				return
			end

			if vCLIENT.ReturnWeapon(source) then
				local Check,AmmoClip,Weapon = vCLIENT.StoreWeapon(source)

				if Check then
					local Ammunation = WeaponAmmo(Weapon)
					if Ammunation then
						if AmmoClip > 0 then
							if not Weapons["Ammo"][Passport] then
								Weapons["Ammo"][Passport] = {}
							end

							Weapons["Ammo"][Passport][Ammunation] = AmmoClip
						else
							if Weapons["Ammo"][Passport] and Weapons["Ammo"][Passport][Ammunation] then
								Weapons["Ammo"][Passport][Ammunation] = nil
							end
						end
					end

					TriggerClientEvent("NotifyItens",source,{ "-",ItemIndex(Weapon),1,ItemName(Weapon) })
					exports["inventory"]:CleanWeapons(Passport,false)
				end
			else
				local Skin = nil
				local Attach = {}
				local AmmoClip = 0
				local Ammunation = WeaponAmmo(Item)
				if Ammunation and Weapons["Ammo"][Passport] and Weapons["Ammo"][Passport][Ammunation] then
					AmmoClip = Weapons["Ammo"][Passport][Ammunation]
				end

				if Weapons["Skin"][Passport] and Weapons["Skin"][Passport][Item] and Weapons["Skin"][Passport][Item]["Active"] then
					Skin = Weapons["Skin"][Passport][Item]["Active"]
				end

				if Weapons["Attach"][Passport] and Weapons["Attach"][Passport][Item] then
					Attach = Weapons["Attach"][Passport][Item]
				end

				if vCLIENT.TakeWeapon(source,Item,AmmoClip,Attach,false,Skin) then
					TriggerClientEvent("NotifyItens",source,{ "+",ItemIndex(Full),1,ItemName(Full) })
				end
			end
		elseif ItemType(Full) == "Munição" then
			local Weapon,AmmoClip = vCLIENT.InfoWeapon(source,Item)

			if Weapon ~= "" and WeaponAmmo(Weapon) and Item == WeaponAmmo(Weapon) then
				if Weapon == "WEAPON_PETROLCAN" then
					if (AmmoClip + Amount) > 4500 then
						Amount = 4500 - AmmoClip
					end
				else
					if (AmmoClip + Amount) > 250 then
						Amount = 250 - AmmoClip
					end
				end

				if Amount > 0 and vRP.TakeItem(Passport,Full,Amount,false,Slot) then
					if not Weapons["Ammo"][Passport] then
						Weapons["Ammo"][Passport] = {}
					end

					Weapons["Ammo"][Passport][Item] = AmmoClip + Amount

					TriggerClientEvent("NotifyItens",source,{ "+",ItemIndex(Full),Amount,ItemName(Full) })
					TriggerClientEvent("inventory:Update",source,"Backpack")
					vCLIENT.Reloading(source,Weapon,Amount)
				end
			end
		elseif ItemType(Full) == "Throwing" then
			if vCLIENT.ReturnWeapon(source) then
				local Check,AmmoClip,Weapon = vCLIENT.StoreWeapon(source)

				if Check then
					local Amunnation = WeaponAmmo(Weapon)
					if Amunnation then
						if AmmoClip > 0 then
							if not Weapons["Ammo"][Passport] then
								Weapons["Ammo"][Passport] = {}
							end

							Weapons["Ammo"][Passport][Amunnation] = AmmoClip
						else
							if Weapons["Ammo"][Passport] and Weapons["Ammo"][Passport][Amunnation] then
								Weapons["Ammo"][Passport][Amunnation] = nil
							end
						end
					end

					TriggerClientEvent("NotifyItens",source,{ "-",ItemIndex(Weapon),1,ItemName(Weapon) })
					exports["inventory"]:CleanWeapons(Passport,false)
				end
			else
				if vCLIENT.TakeWeapon(source,Item,1,nil,Full) then
					TriggerClientEvent("NotifyItens",source,{ "+",ItemIndex(Full),1,ItemName(Full) })
				end
			end
		elseif Item == "ATTACH_FLASHLIGHT" or Item == "ATTACH_CROSSHAIR" or Item == "ATTACH_SILENCER" or Item == "ATTACH_MAGAZINE" or Item == "ATTACH_GRIP" then
			local Weapon = vCLIENT.ReturnWeapon(source)
			if Weapon then
				local Component = WeaponAttach(Item,Weapon)
				if Component then
					if not Weapons["Attach"][Passport] then
						Weapons["Attach"][Passport] = {}
					end

					if not Weapons["Attach"][Passport][Weapon] then
						Weapons["Attach"][Passport][Weapon] = {}
					end

					if not Weapons["Attach"][Passport][Weapon][Item] then
						if vRP.TakeItem(Passport,Full,1,false,Slot) then
							TriggerClientEvent("NotifyItens",source,{ "+",ItemIndex(Full),1,ItemName(Full) })
							TriggerClientEvent("inventory:Update",source,"Backpack")
							Weapons["Attach"][Passport][Weapon][Item] = true
							vCLIENT.GiveComponent(source,Component)
						end
					else
						TriggerClientEvent("Notify",source,"Aviso","O armamento já possui um componente equipado.","amarelo",5000)
					end
				else
					TriggerClientEvent("Notify",source,"Aviso","O armamento não possui suporte ao componente.","amarelo",5000)
				end
			end
		elseif Use[Item] then
			Use[Item](source,Passport,Amount,Slot,Full,Item,Split)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] then
			Active[Passport] = nil
			vGARAGE.UpdateHotwired(source,false)
			Player(source)["state"]["Buttons"] = false
			TriggerClientEvent("Progress",source,"Cancelando",1000)
		end

		if Carry[Passport] then
			if vRP.Passport(Carry[Passport]) then
				TriggerClientEvent("inventory:Carry",Carry[Passport],nil,"Detach")
				Player(Carry[Passport])["state"]["Carry"] = false
				vRPC.Destroy(Carry[Passport])
			end
	
			Carry[Passport] = nil
		end

		if Player(source)["state"]["Camera"] then
			TriggerClientEvent("inventory:Camera",source)
		end

		vRP.FreezePlayer(source,false)
		vRPC.Destroy(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.VerifyWeapon(Item,Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not vRP.ConsultItem(Passport,Item,1) then
		local Ammunation = WeaponAmmo(Item)
		if Ammunation and Weapons["Ammo"][Passport] and Weapons["Ammo"][Passport][Ammunation] then
			if Ammo and Ammo > 0 then
				Weapons["Ammo"][Passport][Ammunation] = Ammo
			end

			if Weapons["Ammo"][Passport][Ammunation] > 0 then
				vRP.GenerateItem(Passport,Ammunation,Weapons["Ammo"][Passport][Ammunation])
				Weapons["Ammo"][Passport][Ammunation] = nil
			end
		end

		if Weapons["Attach"][Passport] and Weapons["Attach"][Passport][Item] then
			for Component,_ in pairs(Weapons["Attach"][Passport][Item]) do
				vRP.GenerateItem(Passport,Component,1)
			end

			Weapons["Attach"][Passport][Item] = nil
		end

		TriggerClientEvent("inventory:Update",source,"Backpack")
		exports["inventory"]:CleanWeapons(Passport,false)

		return false
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKEXISTWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckExistWeapons(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item and not vRP.ConsultItem(Passport,Item,1) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETHROWING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RemoveThrowing(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item ~= nil then
		vRP.TakeItem(Passport,Item)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVENTWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.PreventWeapons(Item,Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Weapons["Ammo"][Passport] then
		local Ammunation = WeaponAmmo(Item)

		if Ammunation and Weapons["Ammo"][Passport][Ammunation] then
			if Ammo > 0 then
				Weapons["Ammo"][Passport][Ammunation] = Ammo
			else
				Weapons["Ammo"][Passport][Ammunation] = nil
				exports["inventory"]:CleanWeapons(Passport,false)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:TRASHER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Trasher")
AddEventHandler("inventory:Trasher",function(Entity)
	local source = source
	local Coords = Entity[4]
	local Number = parseInt(#Trashs + 1)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Coords then
		Active[Passport] = os.time() + 10

		if not vRPC.LastVehicle(source,"trash") then
			TriggerClientEvent("Notify",source,"Atenção","Precisa utilizar o veículo do <b>Lixeiro</b>.","amarelo",5000)
			Active[Passport] = nil

			return false
		end

		for Index = 1,#Trashs do
			if #(Trashs[Index]["Coords"] - Coords) <= 0.5 then
				if os.time() <= Trashs[Index]["Timer"] then
					TriggerClientEvent("Notify",source,"Atenção","Aguarde <b>"..Dotted(Trashs[Index]["Timer"] - os.time()).."</b> segundos.","amarelo",5000)
					Active[Passport] = nil

					return false
				else
					Number = Index

					break
				end
			end
		end

		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress",source,"Vasculhando",10000)
		vRPC.playAnim(source,false,{"amb@prop_human_bum_bin@base","base"},true)
		Trashs[Number] = { ["Coords"] = Coords, ["Timer"] = os.time() + 1800, ["Passport"] = Passport }

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if Trashs[Number]["Passport"] == Passport then
					local Result = RandPercentage(TrashItens)
					local Experience = vRP.GetExperience(Passport,"Garbageman")
					local Valuation = math.random(Result["Min"],Result["Max"]) + (ClassCategory(Experience) * Result["Addition"])

					if Buffs["Luck"][Passport] and Buffs["Luck"][Passport] > os.time() then
						Valuation = Valuation + (Valuation * 0.1)
					end

					if vRP.UserPremium(Passport) then
						local Bonification = 0.05
						local Hierarchy = vRP.LevelPremium(source)
			
						if Hierarchy == 1 then
							Bonification = 0.1
						elseif Hierarchy == 2 then
							Bonification = 0.2
						end
			
						Valuation = Valuation + (Valuation * Bonification)
					end

					if exports["party"]:DoesExist(Passport) then
						local Consult = exports["party"]:Room(Passport,source,25)
						for Number = 1,#Consult do
							if vRP.Passport(Consult[Number]["Source"]) and vRPC.LastVehicle(Consult[Number]["Source"],"trash") then
								if not vRP.MaxItens(Consult[Number]["Passport"],Result["Item"],Valuation) and vRP.CheckWeight(Consult[Number]["Passport"],Result["Item"],Valuation) then
									vRP.GenerateItem(Consult[Number]["Passport"],Result["Item"],Valuation,true)
									vRP.PutExperience(Consult[Number]["Passport"],"Garbageman",1)
									vRP.UpgradeStress(Consult[Number]["Passport"],1)
								else
									TriggerClientEvent("Notify",Consult[Number]["Source"],"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
									exports["inventory"]:Drops(Consult[Number]["Passport"],Consult[Number]["Source"],Result["Item"],Valuation)
								end
							end
						end
					else
						if not vRP.MaxItens(Passport,Result["Item"],Amount) and vRP.CheckWeight(Passport,Result["Item"],Amount) then
							vRP.GenerateItem(Passport,Result["Item"],Valuation,true)
							vRP.PutExperience(Passport,"Garbageman",1)
							vRP.UpgradeStress(Passport,1)
						else
							TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
							exports["inventory"]:Drops(Passport,source,Result["Item"],Valuation)
						end
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Loot")
AddEventHandler("inventory:Loot",function(Number,Box)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Loots[Box] then
		if not Loots[Box]["Players"][Number] then
			Loots[Box]["Players"][Number] = {}
		end

		if Loots[Box]["Players"][Number][Passport] then
			if os.time() <= Loots[Box]["Players"][Number][Passport] then
				TriggerClientEvent("Notify",source,"Aviso","Aguarde <b>"..Dotted(Loots[Box]["Players"][Number][Passport] - os.time()).."</b> segundos.","amarelo",5000)

				return false
			end
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress",source,"Vasculhando",10000)
		Loots[Box]["Players"][Number][Passport] = os.time() + Loots[Box]["Cooldown"]
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				local Result = RandPercentage(Loots[Box]["List"])
				local Amount = math.random(Result["Min"],Result["Max"])
				if not vRP.MaxItens(Passport,Result["Item"],Amount) and vRP.CheckWeight(Passport,Result["Item"],Amount) then
					vRP.GenerateItem(Passport,Result["Item"],Amount,true)
				else
					TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
					exports["inventory"]:Drops(Passport,source,Result["Item"],Amount)
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Delete")
AddEventHandler("garages:Delete",function(Network,Plate)
	if Plates[Plate] then
		Plates[Plate] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CHANGEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:ChangePlate")
AddEventHandler("inventory:ChangePlate",function(Entitys)
	local source = source
	local Plate = Entitys[1]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and not Plates[Plate] then
		if not vRP.ConsultItem(Passport,"plate",1) then
			TriggerClientEvent("Notify",source,"Atenção","Precisa de <b>1x "..ItemName("plate").."</b>.","amarelo",5000)

			return false
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress",source,"Trocando",10000)
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,"plate",1,true) then
					local Vehicle = NetworkGetEntityFromNetworkId(Entitys[4])
					if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
						local NewPlate = vRP.GeneratePlate()
						SetVehicleNumberPlateText(Vehicle,NewPlate)
						Plates[NewPlate] = true

						TriggerEvent("garages:ChangePlate",Plate,NewPlate)

						if not vRP.PassportPlate(NewPlate) then
							Entity(Vehicle)["state"]:set("Lockpick",Passport,true)
						else
							Entity(Vehicle)["state"]:set("Lockpick",true,true)
						end
					end
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:StealTrunk")
AddEventHandler("inventory:StealTrunk",function(Entity)
	local source = source
	local Plate = Entity[1]
	local Model = Entity[2]
	local Network = Entity[4]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not vCLIENT.CheckWeapon(source,"WEAPON_CROWBAR") then
			TriggerClientEvent("Notify",source,"Aviso","<b>Pé de Cabra</b> não encontrado.","amarelo",5000)

			return false
		end

		if not vRP.PassportPlate(Plate) then
			if not Trunks[Plate] or os.time() >= Trunks[Plate] then
				vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
				Active[Passport] = os.time() + 100

				if vRP.Task(source,5,7500) then
					Active[Passport] = os.time() + 20
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("Progress",source,"Vasculhando",20000)
					TriggerClientEvent("player:Residuals",source,"Resíduo de Ferro.")

					local Players = vRPC.Players(source)
					for _,v in pairs(Players) do
						async(function()
							TriggerClientEvent("player:VehicleDoors",v,Network,"open")
						end)
					end

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							vRPC.Destroy(source)
							Active[Passport] = nil
							Player(source)["state"]["Buttons"] = false

							for _,v in pairs(Players) do
								async(function()
									TriggerClientEvent("player:VehicleDoors",v,Network,"close")
								end)
							end

							if not Trunks[Plate] or os.time() >= Trunks[Plate] then
								Trunks[Plate] = os.time() + 3600

								local Result = RandPercentage(StealItens)
								local Amount = math.random(Result["Min"],Result["Max"])
								if not vRP.MaxItens(Passport,Result["Item"],Amount) and vRP.CheckWeight(Passport,Result["Item"],Amount) then
									vRP.GenerateItem(Passport,Result["Item"],Amount,true)
								else
									TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
									exports["inventory"]:Drops(Passport,source,Result["Item"],Amount)
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				else
					TriggerEvent("Wanted",source,Passport,30)
					vRPC.stopAnim(source,false)
					Active[Passport] = nil

					local Coords = vRP.GetEntityCoords(source)
					local Service = vRP.NumPermission("Policia")
					for Passports,Sources in pairs(Service) do
						async(function()
							vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
							TriggerClientEvent("NotifyPush",Sources,{ code = 31, title = "Roubo de Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(Model).." - "..Plate, color = 44 })
						end)
					end
				end
			end
		else
			TriggerClientEvent("Notify",source,"Aviso","Veículo protegido pela seguradora.","amarelo",1000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Animals")
AddEventHandler("inventory:Animals",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Entity[5] then
		local MyEntity,Mode = vCLIENT.Animals(source)

		if MyEntity == Entity[1] then
			if vCLIENT.CheckWeapon(source,"WEAPON_SWITCHBLADE") then
				if vRP.CheckWeight(Passport,"deer1star") then
					Active[Passport] = os.time() + 30
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("Progress",source,"Esfolando",30000)
					vRPC.playAnim(source,false,{"amb@medic@standing@kneel@base","base"},true)
					vRPC.playAnim(source,true,{"anim@gangops@facility@servers@bodysearch@","player_search"},true)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							vRPC.Destroy(source)
							Active[Passport] = nil
							Player(source)["state"]["Buttons"] = false

							vRP.UpgradeStress(Passport,1)
							TriggerEvent("DeletePed",Entity[3])
							vRP.PutExperience(Passport,"Hunting",1)
							vRP.GenerateItem(Passport,Mode..math.random(3).."star",1,true)
						end

						Wait(100)
					until not Active[Passport]
				else
					TriggerClientEvent("Notify",source,"Aviso","Mochila cheia.","amarelo",5000)
				end
			else
				TriggerClientEvent("Notify",source,"Atenção","Você precisa colocar o <b>Canivete</b> em mãos.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,false,"Esta carcaça animal não é sua.","amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:StoreObjects")
AddEventHandler("inventory:StoreObjects",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Objects[Number] and Objects[Number]["Item"] then
		Active[Passport] = true

		if vRP.CheckWeight(Passport,Objects[Number]["Item"]) then
			vRP.GiveItem(Passport,Objects[Number]["Item"],1,true)
			TriggerClientEvent("objects:Remover",-1,Number)
			Objects[Number] = nil
		else
			TriggerClientEvent("Notify",source,"Aviso","Mochila cheia.","amarelo",5000)
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Products")
AddEventHandler("inventory:Products",function(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Products[Service] then
		if Products[Service]["PolyZone"] and not vFARMER.PolyZone(source,Service) then
			exports["megazord"]:Discord("**Passaporte:** "..Passport.."\n**Função:** Farmer do "..Service,source)
		end

		if Products[Service]["Necessary"] and not vRP.ConsultItem(Passport,Products[Service]["Necessary"]["Item"],Products[Service]["Necessary"]["Amount"]) then
			TriggerClientEvent("Notify",source,"Atenção","Precisa de <b>"..Products[Service]["Necessary"]["Amount"].."x "..ItemName(Products[Service]["Necessary"]["Item"]).."</b>.","amarelo",5000)

			return false
		end

		if Products[Service]["Police"] and not vRP.Task(source,3,7500) then
			vRP.CallPolice(source,Passport,false,"Policia","Roubo de Pertences",false,60,31,22)
		end

		Player(source)["state"]["Buttons"] = true
		Active[Passport] = os.time() + Products[Service]["Timer"]
		TriggerClientEvent("Progress",source,"Produzindo",Products[Service]["Timer"] * 1000)

		if Products[Service]["Animation"] then
			vRPC.playAnim(source,false,{Products[Service]["Animation"]["Dict"],Products[Service]["Animation"]["Anim"]},true)
		end

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Player(source)["state"]["Buttons"] = false
				Active[Passport] = nil
				vRPC.Destroy(source)

				local Result = RandPercentage(Products[Service]["Itens"])
				local Amount = math.random(Result["Min"],Result["Max"])
				if not vRP.MaxItens(Passport,Result["Item"],Amount) and vRP.CheckWeight(Passport,Result["Item"],Amount) then
					vRP.GenerateItem(Passport,Result["Item"],Amount,true)
				else
					TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
					exports["inventory"]:Drops(Passport,source,Result["Item"],Amount)
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:RemoveTyres")
AddEventHandler("inventory:RemoveTyres",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Entity[2] ~= "veto" and Entity[2] ~= "veto2" then
		if not vCLIENT.CheckWeapon(source,"WEAPON_WRENCH") then
			TriggerClientEvent("Notify",source,"Aviso","<b>Chave Inglesa</b> não encontrada.","amarelo",5000)

			return false
		end

		local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
		if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
			if vCLIENT.tyreHealth(source,Entity[4],Entity[6]) == 1000.0 then
				if vRP.MaxItens(Passport,"tyres",1) then
					TriggerClientEvent("Notify",source,"Aviso","Limite atingido.","amarelo",5000)

					return false
				end

				if vRP.PassportPlate(Entity[1]) then
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

					if vRP.Task(source,3,5000) then
						Active[Passport] = os.time() + 10
						TriggerClientEvent("Progress",source,"Removendo",10000)

						repeat
							if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil

								local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
								if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
									if vCLIENT.tyreHealth(source,Entity[4],Entity[6]) == 1000.0 then
										local Players = vRPC.Players(source)
										for _,v in pairs(Players) do
											async(function()
												TriggerClientEvent("inventory:explodeTyres",v,Entity[4],Entity[1],Entity[6])
											end)
										end

										vRP.GenerateItem(Passport,"tyres",1,true)
									end
								end
							end

							Wait(100)
						until not Active[Passport]
					end

					Player(source)["state"]["Buttons"] = false
					vRPC.Destroy(source)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:RollVehicle")
AddEventHandler("player:RollVehicle",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 60
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Desvirando",60000)
		vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				vRPC.Destroy(source)
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				local Players = vRPC.Players(source)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("target:RollVehicle",v,Entity[4])
					end)
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BUFFSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:BuffServer",function(source,Passport,Name,Amount)
	if not Buffs[Name][Passport] then
		Buffs[Name][Passport] = 0
	end

	if os.time() >= Buffs[Name][Passport] then
		Buffs[Name][Passport] = os.time() + Amount
	else
		Buffs[Name][Passport] = Buffs[Name][Passport] + Amount

		if (Buffs[Name][Passport] - os.time()) >= 3600 then
			Buffs[Name][Passport] = os.time() + 3600
		end
	end

	TriggerClientEvent("hud:"..Name,source,Buffs[Name][Passport] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Buffs",function(Mode,Passport)
	return Buffs[Mode] and Buffs[Mode][Passport] and Buffs[Mode][Passport] > os.time() and (Mode ~= "Luck" or (Mode == "Luck" and math.random(100) >= 50)) and true or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("CleanWeapons",function(Passport,Clean)
	local source = vRP.Source(Passport)
	if source then
		if vRP.DoesEntityExist(source) then
			local Ped = GetPlayerPed(source)
			local Weapon = GetSelectedPedWeapon(Ped)

			RemoveWeaponFromPed(Ped,Weapon)
			RemoveAllPedWeapons(Ped,true)
			SetPedAmmo(Ped,Weapon,0)
		end

		if Clean then
			Weapons["Attach"][Passport] = {}
			Weapons["Ammo"][Passport] = {}
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StealPeds()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Result = RandPercentage(StealPeds)
		local Amount = math.random(Result["Min"],Result["Max"])
		if not vRP.MaxItens(Passport,Result["Item"],Amount) and vRP.CheckWeight(Passport,Result["Item"],Amount) then
			vRP.GenerateItem(Passport,Result["Item"],Amount,true)
		else
			TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
			exports["inventory"]:Drops(Passport,source,Result["Item"],Amount)
		end

		if math.random(100) >= 75 and vRP.DoesEntityExist(source) then
			vRP.CallPolice(source,Passport,false,"Policia","Assalto a mão armada",false,60,32,16)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ShotsFired(Vehicle)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Vehicle then
			Vehicle = "Disparos de um veículo"
		else
			Vehicle = "Disparos com arma de fogo"
		end

		if vRP.DoesEntityExist(source) then
			vRP.CallPolice(source,Passport,false,"Policia",Vehicle,false,false,10,6)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer",function(Silenced)
	local List = vRP.Players()
	for Passport,_ in pairs(List) do
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Ammos", Information = json.encode(Weapons["Ammo"][Passport]) })
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Attachs", Information = json.encode(Weapons["Attach"][Passport]) })
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Skins", Information = json.encode(Weapons["Skin"][Passport]) })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Weapons["Ammo"][Passport] and Weapons["Attach"][Passport] and Weapons["Skin"][Passport] then
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Skins", Information = json.encode(Weapons["Skin"][Passport]) })
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Attachs", Information = json.encode(Weapons["Attach"][Passport]) })
		vRP.Query("playerdata/SetData",{ Passport = Passport, Name = "Ammos", Information = json.encode(Weapons["Ammo"][Passport]) })

		Weapons["Skin"][Passport] = nil
		Weapons["Attach"][Passport] = nil
		Weapons["Ammo"][Passport] = nil
	end

	if Active[Passport] then
		Active[Passport] = nil
	end

	if Healths[Passport] then
		Healths[Passport] = nil
	end

	if Armors[Passport] then
		Armors[Passport] = nil
	end

	if Drugs[Passport] then
		Drugs[Passport] = nil
	end

	if Carry[Passport] then
		if vRP.Passport(Carry[Passport]) then
			TriggerClientEvent("inventory:Carry",Carry[Passport],nil,"Detach")
			Player(Carry[Passport])["state"]["Carry"] = false
			vRPC.Destroy(Carry[Passport])
		end

		Carry[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	Weapons["Ammo"][Passport] = vRP.UserData(Passport,"Ammos")
	Weapons["Attach"][Passport] = vRP.UserData(Passport,"Attachs")
	Weapons["Skin"][Passport] = vRP.UserData(Passport,"Skins")

	TriggerClientEvent("objects:Table",source,Objects)
	TriggerClientEvent("inventory:Drops",source,Drops)

	for Name,_ in pairs(Buffs) do
		if Buffs[Name] and Buffs[Name][Passport] and os.time() < Buffs[Name][Passport] then
			TriggerClientEvent("hud:"..Name,source,Buffs[Name][Passport] - os.time())
		end
	end
end)