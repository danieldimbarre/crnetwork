-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Objects = {
	["1"] = { x = 2119.2, y = 5084.76, z = 44.84, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["2"] = { x = 2109.66, y = 5068.44, z = 42.82, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["3"] = { x = 2093.25, y = 5061.21, z = 42.26, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["4"] = { x = 2070.85, y = 5045.16, z = 41.59, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["5"] = { x = 2059.65, y = 5057.95, z = 41.67, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["6"] = { x = 2074.84, y = 5073.35, z = 42.92, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["7"] = { x = 2090.34, y = 5086.86, z = 44.2, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["8"] = { x = 2098.11, y = 5104.5, z = 45.54, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["9"] = { x = 2101.43, y = 5084.17, z = 44.31, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["10"] = { x = 2077.39, y = 5057.99, z = 42.07, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["11"] = { x = 2059.51, y = 5074.25, z = 42.09, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["12"] = { x = 2071.15, y = 5089.27, z = 43.42, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["13"] = { x = 2081.41, y = 5104.78, z = 44.85, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["14"] = { x = 2077.64, y = 5122.9, z = 46.39, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["15"] = { x = 2058.41, y = 5104.29, z = 45.43, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["16"] = { x = 2040.45, y = 5083.23, z = 42.66, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["17"] = { x = 2041.4, y = 5103.3, z = 44.5, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["18"] = { x = 2060.3, y = 5121.8, z = 45.38, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["19"] = { x = 2062.81, y = 5143.47, z = 47.74, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["20"] = { x = 2040.35, y = 5128.36, z = 46.19, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["21"] = { x = 2020.92, y = 5107.65, z = 44.06, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["22"] = { x = 2017.53, y = 5125.19, z = 45.26, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["23"] = { x = 2043.34, y = 5146.59, z = 47.38, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["24"] = { x = 2036.87, y = 5160.81, z = 48.8, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["25"] = { x = 2022.78, y = 5149.14, z = 47.52, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["26"] = { x = 1999.98, y = 5134.99, z = 45.17, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["27"] = { x = 2026.46, y = 5137.55, z = 46.57, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["28"] = { x = 2024.05, y = 5089.22, z = 42.75, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["29"] = { x = 2045.23, y = 5064.06, z = 41.45, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["30"] = { x = 2115.17, y = 5104.75, z = 46.17, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["31"] = { x = 2099.65, y = 5128.21, z = 48.7, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["32"] = { x = 2081.11, y = 5143.14, z = 50.2, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },
	["33"] = { x = 2063.54, y = 5166.11, z = 51.43, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_veg_crop_orange", event = "farmer:Fruits", label = "Derrubar", time = 0, Distance = 1.25 },

	["34"] = { x = 2952.07, y = 2819.73, z = 42.58, heading = 3374176, height = 1.5, width = 1.5, show = 150.0, prop = "prop_rock_1_e", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["35"] = { x = 2923.9, y = 2809.09, z = 43.35, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_d", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["36"] = { x = 2921.64, y = 2793.9, z = 40.61, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_f", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["37"] = { x = 2934.44, y = 2779.35, z = 39.07, heading = 3374176, height = 1.5, width = 1.5, show = 150.0, prop = "prop_rock_1_e", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["38"] = { x = 2949.26, y = 2770.88, z = 39.02, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_d", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["39"] = { x = 2959.64, y = 2775.72, z = 39.92, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_f", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["40"] = { x = 2972.0, y = 2779.34, z = 38.64, heading = 3374176, height = 1.5, width = 1.5, show = 150.0, prop = "prop_rock_1_e", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["41"] = { x = 2976.44, y = 2787.3, z = 39.9, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_d", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["42"] = { x = 2968.12, y = 2796.86, z = 40.94, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_f", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["43"] = { x = 2952.52, y = 2847.42, z = 47.11, heading = 3374176, height = 1.5, width = 1.5, show = 150.0, prop = "prop_rock_1_e", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["44"] = { x = 2967.8, y = 2840.11, z = 45.41, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_d", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["45"] = { x = 2979.78, y = 2821.56, z = 44.74, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_f", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["46"] = { x = 2991.88, y = 2802.39, z = 43.93, heading = 3374176, height = 1.5, width = 1.5, show = 150.0, prop = "prop_rock_1_e", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["47"] = { x = 3003.04, y = 2780.11, z = 43.41, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_d", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["48"] = { x = 3001.14, y = 2763.14, z = 42.97, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_f", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["49"] = { x = 2992.83, y = 2756.31, z = 42.82, heading = 3374176, height = 1.5, width = 1.5, show = 150.0, prop = "prop_rock_1_e", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["50"] = { x = 2968.98, y = 2738.39, z = 43.74, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_d", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["51"] = { x = 2939.29, y = 2751.12, z = 43.39, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_f", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["52"] = { x = 2967.54, y = 2758.4, z = 43.08, heading = 3374176, height = 1.5, width = 1.5, show = 150.0, prop = "prop_rock_1_e", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["53"] = { x = 2989.76, y = 2770.21, z = 42.87, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_d", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["54"] = { x = 2937.02, y = 2799.51, z = 41.01, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_f", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["55"] = { x = 2954.26, y = 2802.48, z = 41.74, heading = 3374176, height = 1.5, width = 1.5, show = 150.0, prop = "prop_rock_1_e", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["56"] = { x = 2964.23, y = 2786.72, z = 39.75, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_d", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },
	["57"] = { x = 2947.96, y = 2783.56, z = 39.93, heading = 3374176, height = 1.25, width = 1.5, show = 150.0, prop = "prop_rock_1_f", event = "farmer:Miner", label = "Mineirar", time = 0, Distance = 2.0 },

	["58"] = { x = 2386.34, y = 5099.58, z = 47.55, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_tree_pine_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["59"] = { x = 2397.96, y = 5087.04, z = 47.31, heading = 3374176, height = 2.0, width = 1.0, show = 150.0, prop = "prop_tree_cedar_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["60"] = { x = 2401.23, y = 5099.75, z = 46.4, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_tree_cedar_s_01", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["61"] = { x = 2391.37, y = 5110.17, z = 46.39, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_w_r_cedar_dead", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["62"] = { x = 2410.42, y = 5089.48, z = 46.51, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_tree_pine_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["63"] = { x = 2420.39, y = 5070.15, z = 46.62, heading = 3374176, height = 2.0, width = 1.0, show = 150.0, prop = "prop_tree_cedar_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["64"] = { x = 2424.72, y = 5082.12, z = 46.71, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_tree_cedar_s_01", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["65"] = { x = 2434.98, y = 5062.41, z = 46.34, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_w_r_cedar_dead", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["66"] = { x = 2411.24, y = 5079.37, z = 46.88, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_w_r_cedar_dead", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["67"] = { x = 2433.39, y = 5074.77, z = 46.32, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_w_r_cedar_dead", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["68"] = { x = 2410.41, y = 5127.09, z = 47.25, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_tree_pine_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["69"] = { x = 2416.61, y = 5116.57, z = 46.88, heading = 3374176, height = 2.0, width = 1.0, show = 150.0, prop = "prop_tree_cedar_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["70"] = { x = 2426.6, y = 5122.74, z = 46.98, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_tree_cedar_s_01", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["71"] = { x = 2434.38, y = 5111.16, z = 47.08, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_w_r_cedar_dead", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["72"] = { x = 2436.03, y = 5098.54, z = 46.45, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_tree_pine_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["73"] = { x = 2444.76, y = 5087.11, z = 46.34, heading = 3374176, height = 2.0, width = 1.0, show = 150.0, prop = "prop_tree_cedar_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["74"] = { x = 2452.11, y = 5073.92, z = 46.32, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_tree_cedar_s_01", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["75"] = { x = 2459.98, y = 5082.81, z = 46.94, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_w_r_cedar_dead", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["76"] = { x = 2475.47, y = 5086.5, z = 46.13, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_tree_pine_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["77"] = { x = 2463.86, y = 5101.53, z = 46.45, heading = 3374176, height = 2.0, width = 1.0, show = 150.0, prop = "prop_tree_cedar_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["78"] = { x = 2450.84, y = 5107.65, z = 46.89, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_tree_cedar_s_01", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["79"] = { x = 2461.8, y = 5063.75, z = 46.78, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_w_r_cedar_dead", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["80"] = { x = 2473.81, y = 5048.59, z = 46.44, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_tree_pine_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["81"] = { x = 2487.0, y = 5035.03, z = 46.79, heading = 3374176, height = 2.0, width = 1.0, show = 150.0, prop = "prop_tree_cedar_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["82"] = { x = 2487.67, y = 5053.43, z = 49.29, heading = 3374176, height = 1.25, width = 1.0, show = 150.0, prop = "prop_tree_cedar_s_01", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["83"] = { x = 2504.84, y = 5049.0, z = 51.44, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_w_r_cedar_dead", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },
	["84"] = { x = 2502.22, y = 5069.15, z = 46.51, heading = 3374176, height = 1.5, width = 1.0, show = 150.0, prop = "prop_tree_pine_02", event = "farmer:Lumber", label = "Derrubar", time = 0, Distance = 1.25 },

	["85"] = { x = 228.48, y = 235.48, z = 97.12, heading = 32.44, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["86"] = { x = 228.71, y = 235.44, z = 97.12, heading = 7.44, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["87"] = { x = 228.44, y = 235.3, z = 97.12, heading = 22.44, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["88"] = { x = 228.72, y = 235.28, z = 97.12, heading = 357.44, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["89"] = { x = 229.02, y = 235.32, z = 97.12, heading = 346.67, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["90"] = { x = 229.31, y = 235.26, z = 97.12, heading = 358.04, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["91"] = { x = 229.58, y = 235.15, z = 97.12, heading = 331.58, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["92"] = { x = 229.89, y = 235.06, z = 97.12, heading = 346.58, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["93"] = { x = 229.03, y = 235.15, z = 97.12, heading = 199.87, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["94"] = { x = 229.3, y = 235.08, z = 97.12, heading = 207.43, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["95"] = { x = 229.61, y = 235.0, z = 97.12, heading = 199.93, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["96"] = { x = 227.32, y = 234.62, z = 97.12, heading = 41.08, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["97"] = { x = 227.17, y = 234.37, z = 97.12, heading = 48.62, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["98"] = { x = 227.4, y = 234.43, z = 97.12, heading = 48.62, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["99"] = { x = 227.08, y = 234.14, z = 97.12, heading = 33.62, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["100"] = { x = 227.29, y = 234.19, z = 97.12, heading = 39.18, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["101"] = { x = 227.59, y = 234.42, z = 97.12, heading = 39.85, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["102"] = { x = 232.0, y = 234.28, z = 97.12, heading = 315.85, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["103"] = { x = 231.74, y = 234.38, z = 97.12, heading = 319.51, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["104"] = { x = 231.47, y = 234.42, z = 97.12, heading = 319.51, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["105"] = { x = 232.05, y = 233.99, z = 97.12, heading = 304.51, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["106"] = { x = 231.8, y = 234.15, z = 97.12, heading = 319.51, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["107"] = { x = 231.52, y = 234.24, z = 97.12, heading = 332.01, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["108"] = { x = 231.24, y = 234.5, z = 97.12, heading = 315.84, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["109"] = { x = 230.98, y = 234.67, z = 97.12, heading = 341.86, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["110"] = { x = 230.7, y = 234.76, z = 97.12, heading = 348.41, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["111"] = { x = 230.4, y = 234.87, z = 97.12, heading = 350.93, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["112"] = { x = 231.03, y = 234.48, z = 97.12, heading = 325.93, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["113"] = { x = 230.77, y = 234.61, z = 97.12, heading = 350.93, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["114"] = { x = 230.46, y = 234.7, z = 97.12, heading = 348.43, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["115"] = { x = 231.27, y = 234.32, z = 97.12, heading = 319.74, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["116"] = { x = 228.46, y = 235.11, z = 97.12, heading = 220.57, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["117"] = { x = 228.23, y = 234.91, z = 97.12, heading = 28.05, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["118"] = { x = 228.04, y = 234.71, z = 97.12, heading = 41.37, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["119"] = { x = 227.83, y = 234.5, z = 97.12, heading = 56.37, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["120"] = { x = 230.12, y = 234.93, z = 97.12, heading = 332.08, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["121"] = { x = 229.86, y = 234.9, z = 97.12, heading = 354.13, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 },
	["122"] = { x = 230.15, y = 234.78, z = 97.12, heading = 339.13, height = 1.0, width = 0.25, show = 20.0, prop = "prop_money_bag_01", event = "farmer:Money", label = "Pegar", time = 0, Distance = 0.75 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FARMER:FRUITS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Fruits")
AddEventHandler("farmer:Fruits",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport then
				local Ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_HATCHET") then
					local Amount = math.random(3,5)
					local Items = { "acerola","banana","guarana","tomato","passion","grape","tange","orange","apple","strawberry","coffee2" }
					local Select = math.random(#Items)

					if (vRP.InventoryWeight(Passport) + itemWeight(Items[Select]) * Amount) <= vRP.GetWeight(Passport) then
						vRPC.playAnim(source,false,{"lumberjackaxe@idle","idle"},true)
						Objects[Number]["time"] = GlobalState["Work"] + math.random(26,34)
						TriggerClientEvent("Progress",source,"Colhendo",11000)
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true

						local timeProgress = 10

						repeat
							if timeProgress ~= 10 then
								Wait(400)
							end

							Wait(700)
							TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(400)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["time"])
						vRP.GenerateItem(Passport,Items[Select],Amount,true)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Machado</b> não encontrado.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FARMER:MINER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Miner")
AddEventHandler("farmer:Miner",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport then
				if vRP.ConsultItem(Passport,"pickaxe",1) then
					local Amount = math.random(2)
					if (vRP.InventoryWeight(Passport) + itemWeight("geode") * Amount) <= vRP.GetWeight(Passport) then
						vRPC.createObjects(source,"melee@large_wpn@streamed_core","ground_attack_on_spot","prop_tool_pickaxe",1,18905,0.10,-0.1,0.0,-92.0,260.0,5.0)
						Objects[Number]["time"] = GlobalState["Work"] + math.random(16,20)
						TriggerClientEvent("Progress",source,"Mineirando",10000)
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true
						local timeProgress = 10

						repeat
							Wait(1000)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(1000)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["time"])
						vRP.GenerateItem(Passport,"geode",Amount,true)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Picareta</b> não encontrada.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FARMER:LUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Lumber")
AddEventHandler("farmer:Lumber",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport then
				local Ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_HATCHET") then
					local Amount = math.random(3,5)
					if (vRP.InventoryWeight(Passport) + itemWeight("woodlog") * Amount) <= vRP.GetWeight(Passport) then
						vRPC.playAnim(source,false,{"lumberjackaxe@idle","idle"},true)
						Objects[Number]["time"] = GlobalState["Work"] + math.random(16,20)
						TriggerClientEvent("Progress",source,"Cortando",11000)
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true
						local timeProgress = 10

						repeat
							if timeProgress ~= 10 then
								Wait(400)
							end

							Wait(700)
							TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(400)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["time"])
						vRP.GenerateItem(Passport,"woodlog",Amount,true)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Machado</b> não encontrado.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FARMER:MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Money")
AddEventHandler("farmer:Money",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport then
				if (vRP.InventoryWeight(Passport) + itemWeight("pouch")) <= vRP.GetWeight(Passport) then
					vRPC.playAnim(source,false,{"pickup_object","pickup_low"},true)
					Objects[Number]["time"] = GlobalState["Work"] + math.random(4,8)
					TriggerClientEvent("Progress",source,"Coletando",1000)
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true

					Wait(1000)

					TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["time"])
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRP.GenerateItem(Passport,"pouch",1,true)
					vRP.UpgradeStress(Passport,1)
					vRPC.removeObjects(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("farmer:Table",source,Objects)
end)