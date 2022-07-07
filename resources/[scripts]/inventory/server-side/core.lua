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
cRP = {}
Tunnel.bindInterface("inventory",cRP)
vPLAYER = Tunnel.getInterface("player")
vGARAGE = Tunnel.getInterface("garages")
vTASKBAR = Tunnel.getInterface("taskbar")
vDELIVER = Tunnel.getInterface("deliver")
vCLIENT = Tunnel.getInterface("inventory")
vKEYBOARD = Tunnel.getInterface("keyboard")
vPARAMEDIC = Tunnel.getInterface("paramedic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {}
local Drugs = {}
local Carry = {}
local Ammos = {}
local Loots = {}
local Boxes = {}
local Active = {}
local Trashs = {}
local Armors = {}
local Plates = {}
local Trunks = {}
local Healths = {}
local Animals = {}
local Attachs = {}
local invTemp = {}
local Scanners = {}
local atmTimers = {}
local verifyObjects = {}
local verifyAnimals = {}
local DismantleExperience = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
local Buffs = {
	["Dexterity"] = {},
	["Luck"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEOGES
-----------------------------------------------------------------------------------------------------------------------------------------
local Geodes = {
	{ ["item"] = "emerald", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "diamond", ["min"] = 2, ["max"] = 2 },
	{ ["item"] = "ruby", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "sapphire", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "amethyst", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "amber", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "turquoise", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "aluminum", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "copper", ["min"] = 1, ["max"] = 2 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRUGSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local DrugsList = {
	["cocaine"] = { pMin = 75, pMax = 85, rMin = 2, rMax = 3 },
	["meth"] = { pMin = 75, pMax = 85, rMin = 2, rMax = 3 },
	["joint"] = { pMin = 175, pMax = 200, rMin = 1, rMax = 2 },
	["oxy"] = { pMin = 75, pMax = 85, rMin = 2, rMax = 3 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Objects = {
	["1"] = { x = 594.59, y = 146.52, z = 97.30, h = 70.04, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["2"] = { x = 660.44, y = 268.29, z = 102.04, h = 152.09, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["3"] = { x = 552.54, y = -198.45, z = 53.75, h = 89.32, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["4"] = { x = 339.75, y = -580.95, z = 73.42, h = 67.19, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["5"] = { x = 696.12, y = -965.69, z = 23.26, h = 271.33, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["6"] = { x = 1152.45, y = -1531.51, z = 34.65, h = 144.89, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["7"] = { x = 1382.1, y = -2081.97, z = 51.25, h = 220.16, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["8"] = { x = 589.32, y = -2802.73, z = 5.32, h = 328.01, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["9"] = { x = -453.19, y = -2810.47, z = 6.56, h = 225.82, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["10"] = { x = -1007.18, y = -2836.12, z = 13.20, h = 149.3, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["11"] = { x = -2018.21, y = -361.03, z = 47.36, h = 324.55, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["12"] = { x = -1727.77, y = 250.26, z = 61.65, h = 24.7, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["13"] = { x = -1089.6, y = 2717.05, z = 18.33, h = 40.52, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["14"] = { x = 321.27, y = 2874.98, z = 42.71, h = 27.62, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["15"] = { x = 1163.47, y = 2722.09, z = 37.26, h = 179.11, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["16"] = { x = 1745.86, y = 3326.69, z = 40.30, h = 115.55, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["17"] = { x = 2013.4, y = 3934.36, z = 31.65, h = 236.38, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["18"] = { x = 2526.3, y = 4191.6, z = 44.53, h = 236.44, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["19"] = { x = 2874.05, y = 4861.57, z = 61.35, h = 87.57, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["20"] = { x = 1985.16, y = 6200.39, z = 41.33, h = 330.21, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["21"] = { x = 1552.97, y = 6610.24, z = 2.12, h = 145.64, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["22"] = { x = -298.32, y = 6392.66, z = 29.87, h = 302.99, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["23"] = { x = -813.88, y = 5384.45, z = 33.77, h = 356.87, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["24"] = { x = -1606.5, y = 5259.26, z = 1.35, h = 114.45, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["25"] = { x = -199.22, y = 3638.8, z = 63.70, h = 39.84, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["26"] = { x = -1487.45, y = 2688.99, z = 2.94, h = 317.89, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },
	["27"] = { x = -3266.12, y = 1139.82, z = 1.91, h = 249.17, object = "sm_prop_smug_crate_s_medical", item = "", Distance = 50, mode = "Medic" },

	["28"] = { x = 574.01, y = 132.56, z = 98.48, h = 70.99, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["29"] = { x = 344.79, y = 929.2, z = 202.44, h = 268.09, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["30"] = { x = -123.8, y = 1896.67, z = 196.34, h = 358.95, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["31"] = { x = -1099.85, y = 2703.51, z = 21.99, h = 221.35, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["32"] = { x = -2198.91, y = 4243.21, z = 46.92, h = 128.84, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["33"] = { x = -1487.02, y = 4983.14, z = 62.67, h = 174.11, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["34"] = { x = 1346.49, y = 6396.73, z = 32.42, h = 90.94, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["35"] = { x = 2535.72, y = 4661.39, z = 33.08, h = 316.4, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["36"] = { x = 1155.62, y = -1334.48, z = 33.72, h = 174.97, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["37"] = { x = 1116.06, y = -2498.07, z = 32.37, h = 193.39, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["38"] = { x = 261.06, y = -3135.82, z = 4.8, h = 88.83, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["39"] = { x = -1619.81, y = -1035.0, z = 12.16, h = 50.84, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["40"] = { x = -3420.87, y = 977.0, z = 10.91, h = 226.29, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["41"] = { x = -1909.53, y = 4624.93, z = 56.07, h = 135.57, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["42"] = { x = 894.51, y = 3211.45, z = 38.09, h = 273.04, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["43"] = { x = 1791.71, y = 4602.84, z = 36.69, h = 185.86, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["44"] = { x = 464.8, y = 6462.03, z = 28.76, h = 334.71, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["45"] = { x = 63.22, y = 6323.67, z = 37.87, h = 301.22, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },
	["46"] = { x = -736.64, y = 5594.98, z = 40.66, h = 268.78, object = "prop_mb_crate_01a", item = "", Distance = 50, mode = "Weapons" },

	["47"] = { x = -2682.86, y = 2304.87, z = 20.85, h = 164.19, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["48"] = { x = -1282.33, y = 2559.98, z = 17.4, h = 148.06, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["49"] = { x = 159.65, y = 3118.8, z = 42.44, h = 16.37, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["50"] = { x = 1061.43, y = 3527.62, z = 33.15, h = 255.93, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["51"] = { x = 2370.22, y = 3156.55, z = 47.21, h = 221.77, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["52"] = { x = 2520.51, y = 2637.83, z = 36.95, h = 314.33, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["53"] = { x = 2572.37, y = 477.44, z = 107.68, h = 269.49, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["54"] = { x = 1223.15, y = -1079.56, z = 37.53, h = 123.38, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["55"] = { x = 1048.49, y = -247.53, z = 68.66, h = 149.33, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["56"] = { x = 499.41, y = -529.38, z = 23.76, h = 262.13, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["57"] = { x = 592.53, y = -2115.87, z = 4.76, h = 100.96, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["58"] = { x = 523.43, y = -2578.67, z = 13.82, h = 318.38, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["59"] = { x = -2.98, y = -1299.67, z = 28.28, h = 359.37, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["60"] = { x = 183.11, y = -1086.93, z = 28.28, h = 348.57, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" },
	["61"] = { x = 713.88, y = -850.95, z = 23.3, h = 271.63, object = "gr_prop_gr_rsply_crate03a", item = "", Distance = 50, mode = "Supplies" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Products = {
	["paper"] = {
		{ ["timer"] = 20, ["need"] = {
			{ ["item"] = "woodlog", ["amount"] = 3 }
		}, ["needAmount"] = 1, ["item"] = "paper", ["itemAmount"] = 1 }
	},
	["tablecoke"] = {
		{ ["timer"] = 20, ["need"] = {
			{ ["item"] = "sulfuric", ["amount"] = 1 },
			{ ["item"] = "cokeleaf", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "cocaine", ["itemAmount"] = 3 }
	},
	["tablemeth"] = {
		{ ["timer"] = 20, ["need"] = {
			{ ["item"] = "saline", ["amount"] = 1 },
			{ ["item"] = "acetone", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "meth", ["itemAmount"] = 3 }
	},
	["tableweed"] = {
		{ ["timer"] = 20, ["need"] = {
			{ ["item"] = "silk", ["amount"] = 1 },
			{ ["item"] = "weedleaf", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "joint", ["itemAmount"] = 1 }
	},
	["burgershot1"] = {
		{ ["timer"] = 10, ["item"] = "burgershot1", ["itemAmount"] = 1 }
	},
	["burgershot2"] = {
		{ ["timer"] = 10, ["item"] = "burgershot2", ["itemAmount"] = 1 }
	},
	["burgershot3"] = {
		{ ["timer"] = 10, ["need"] = {
			{ ["item"] = "burgershot2", ["amount"] = 1 },
			{ ["item"] = "burgershot1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "burgershot3", ["itemAmount"] = 1 }
	},
	["pizzathis1"] = {
		{ ["timer"] = 10, ["item"] = "pizzathis1", ["itemAmount"] = 1 }
	},
	["pizzathis2"] = {
		{ ["timer"] = 10, ["item"] = "pizzathis2", ["itemAmount"] = 1 }
	},
	["pizzathis3"] = {
		{ ["timer"] = 10, ["need"] = {
			{ ["item"] = "pizzathis2", ["amount"] = 1 },
			{ ["item"] = "pizzathis1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "pizzathis3", ["itemAmount"] = 1 }
	},
	["uwucoffee1"] = {
		{ ["timer"] = 10, ["item"] = "uwucoffee1", ["itemAmount"] = 1 }
	},
	["uwucoffee2"] = {
		{ ["timer"] = 10, ["item"] = "uwucoffee2", ["itemAmount"] = 1 }
	},
	["uwucoffee3"] = {
		{ ["timer"] = 10, ["need"] = {
			{ ["item"] = "uwucoffee2", ["amount"] = 1 },
			{ ["item"] = "uwucoffee1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "uwucoffee3", ["itemAmount"] = 1 }
	},
	["beanmachine1"] = {
		{ ["timer"] = 10, ["item"] = "beanmachine1", ["itemAmount"] = 1 }
	},
	["beanmachine2"] = {
		{ ["timer"] = 10, ["item"] = "beanmachine2", ["itemAmount"] = 1 }
	},
	["beanmachine3"] = {
		{ ["timer"] = 10, ["need"] = {
			{ ["item"] = "beanmachine2", ["amount"] = 1 },
			{ ["item"] = "beanmachine1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "beanmachine3", ["itemAmount"] = 1 }
	},
	["milkBottle"] = {
		{ ["timer"] = 10, ["need"] = "emptybottle", ["needAmount"] = 1, ["item"] = "milkbottle", ["itemAmount"] = 1 }
	},
	["scanner"] = {
		{ ["timer"] = 5, ["item"] = "sheetmetal", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "roadsigns", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "syringe", ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "fishingrod", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "plate", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "aluminum", ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "copper", ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "lighter", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "battery", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "metalcan", ["itemAmount"] = 1 }
	},
	["cemitery"] = {
		{ ["timer"] = 5, ["item"] = "silk", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "cotton", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "plaster", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "pouch", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "switchblade", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "joint", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "acetone", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "slipper", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "water", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "copper", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "cigarette", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "lighter", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "elastic", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "rose", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "teddy", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "binoculars", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "camera", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "silvercoin", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "goldcoin", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "watch", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "bracelet", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "WEAPON_BRICK", ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "WEAPON_SHOES", ["itemAmount"] = 2 },
		{ ["timer"] = 5, ["item"] = "dices", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "cup", ["itemAmount"] = 1 }
	},
	["fishfillet"] = {
		{ ["timer"] = 10, ["need"] = "fishfillet", ["needAmount"] = 1, ["item"] = "cookedfishfillet", ["itemAmount"] = 1 }
	},
	["marshmallow"] = {
		{ ["timer"] = 10, ["need"] = "sugar", ["needAmount"] = 4, ["item"] = "marshmallow", ["itemAmount"] = 1 }
	},
	["animalmeat"] = {
		{ ["timer"] = 10, ["need"] = "meat", ["needAmount"] = 1, ["item"] = "cookedmeat", ["itemAmount"] = 1 }
	},
	["emptybottle"] = {
		{ ["timer"] = 3, ["need"] = "emptybottle", ["needAmount"] = 1, ["item"] = "water", ["itemAmount"] = 1 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local StealPeds = {
	{ ["item"] = "pendrive", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "slipper", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "soap", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "pliers", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "deck", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "floppy", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "domino", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "brush", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "rimel", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "WEAPON_SHOES", ["min"] = 2, ["max"] = 2 },
	{ ["item"] = "dices", ["min"] = 2, ["max"] = 3 },
	{ ["item"] = "spray04", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "spray03", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "spray02", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "spray01", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "bracelet", ["min"] = 2, ["max"] = 3 },
	{ ["item"] = "watch", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "goldcoin", ["min"] = 3, ["max"] = 5 },
	{ ["item"] = "silvercoin", ["min"] = 4, ["max"] = 6 },
	{ ["item"] = "oxy", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "analgesic", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "pager", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "camera", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "binoculars", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "hennessy", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "dewars", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "teddy", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "chocolate", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "cellphone", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "notepad", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "emptybottle", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "card01", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "card02", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "card03", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "card04", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "card05", ["min"] = 1, ["max"] = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local StealItens = {
	{ ["item"] = "pendrive", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	{ ["item"] = "slipper", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	{ ["item"] = "soap", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	{ ["item"] = "pliers", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	{ ["item"] = "deck", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	{ ["item"] = "floppy", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "domino", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "brush", ["min"] = 1, ["max"] = 4, ["rand"] = 225 },
	{ ["item"] = "rimel", ["min"] = 2, ["max"] = 4, ["rand"] = 225 },
	{ ["item"] = "WEAPON_SHOES", ["min"] = 2, ["max"] = 2, ["rand"] = 225 },
	{ ["item"] = "dices", ["min"] = 2, ["max"] = 4, ["rand"] = 225 },
	{ ["item"] = "spray04", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "spray03", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "spray02", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "spray01", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "bracelet", ["min"] = 2, ["max"] = 4, ["rand"] = 200 },
	{ ["item"] = "xbox", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	{ ["item"] = "playstation", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	{ ["item"] = "watch", ["min"] = 2, ["max"] = 3, ["rand"] = 200 },
	{ ["item"] = "goldcoin", ["min"] = 4, ["max"] = 6, ["rand"] = 175 },
	{ ["item"] = "silvercoin", ["min"] = 4, ["max"] = 8, ["rand"] = 175 },
	{ ["item"] = "oxy", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	{ ["item"] = "analgesic", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "firecracker", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	{ ["item"] = "pager", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	{ ["item"] = "GADGET_PARACHUTE", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 1, ["rand"] = 50 },
	{ ["item"] = "WEAPON_WRENCH", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	{ ["item"] = "WEAPON_POOLCUE", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	{ ["item"] = "WEAPON_BAT", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	{ ["item"] = "card02", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "camera", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "binoculars", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "hennessy", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "dewars", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "teddy", ["min"] = 1, ["max"] = 1, ["rand"] = 225 },
	{ ["item"] = "chocolate", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "lighter", ["min"] = 1, ["max"] = 1, ["rand"] = 225 },
	{ ["item"] = "cellphone", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	{ ["item"] = "tyres", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "notepad", ["min"] = 1, ["max"] = 5, ["rand"] = 225 },
	{ ["item"] = "plate", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "emptybottle", ["min"] = 2, ["max"] = 5, ["rand"] = 225 },
	{ ["item"] = "bait", ["min"] = 1, ["max"] = 6, ["rand"] = 225 },
	{ ["item"] = "switchblade", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "card01", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "card02", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "card03", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "card04", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "card05", ["min"] = 1, ["max"] = 1, ["rand"] = 200 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local LootItens = {
	["Medic"] = {
		["cooldown"] = 3600,
		["list"] = {
			{ ["item"] = "alcohol", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "syringe", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "codeine", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "amphetamine", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "acetone", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "cotton", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "plaster", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "saline", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "sulfuric", ["min"] = 1, ["max"] = 3 }
		}
	},
	["Weapons"] = {
		["cooldown"] = 7200,
		["list"] = {
			{ ["item"] = "roadsigns", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "techtrash", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "pistolbody", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "smgbody", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "riflebody", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "sheetmetal", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "explosives", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "aluminum", ["min"] = 2, ["max"] = 3 },
			{ ["item"] = "copper", ["min"] = 2, ["max"] = 3 }
		}
	},
	["Supplies"] = {
		["cooldown"] = 3600,
		["list"] = {
			{ ["item"] = "tarp", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "sheetmetal", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "roadsigns", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "leather", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "animalfat", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "cotton", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "plaster", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "sulfuric", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "saline", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "alcohol", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "syringe", ["min"] = 2, ["max"] = 3 },
			{ ["item"] = "card01", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "card02", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "card03", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "card04", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "card05", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "silk", ["min"] = 1, ["max"] = 3 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestInventory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if GetPlayerRoutingBucket(source) < 900000 then
			if vRP.CheckRolepass(source) then
				TriggerEvent("vRP:Rewards",source)
			end
		end

		local myInventory = {}
		local Inventory = vRP.Inventory(Passport)
		for k,v in pairs(Inventory) do
			if (parseInt(v["amount"]) <= 0 or itemBody(v["item"]) == nil) then
				vRP.removeInventoryItem(Passport,v["item"],parseInt(v["amount"]),false)
			else
				v["amount"] = parseInt(v["amount"])
				v["name"] = itemName(v["item"])
				v["peso"] = itemWeight(v["item"])
				v["index"] = itemIndex(v["item"])
				v["max"] = itemMaxAmount(v["item"])
				v["desc"] = itemDescription(v["item"])
				v["economy"] = parseFormat(itemEconomy(v["item"]))
				v["key"] = v["item"]
				v["slot"] = k

				local splitName = splitString(v["item"],"-")
				if splitName[2] ~= nil then
					if splitName[1] == "identity" or splitName[1] == "fidentity" or string.sub(v["item"],1,5) == "badge" then
						local numberIdentity = parseInt(splitName[2])
						local Identity = vRP.Identity(numberIdentity)

						if splitName[1] == "fidentity" then
							Identity = vRP.falseIdentity(numberIdentity)
						end

						if Identity then
							v["idPremium"] = "Nenhum"
							v["idRolepass"] = "Inativo"
							v["idBlood"] = Sanguine(Identity["blood"])
							v["idName"] = Identity["name"].." "..Identity["name2"]

							if numberIdentity == Passport and splitName[1] == "identity" then
								if Identity["premium"] > os.time() then
									v["idPremium"] = MinimalTimers(Identity["premium"] - os.time())
								end

								if Identity["rolepass"] > 0 then
									v["idRolepass"] = "Ativo"
								end
							end
						end
					end

					if splitName[1] == "vehkey" then
						v["Vehkey"] = splitName[2]
					end

					if splitName[1] == "suitcase" then
						v["Suitcase"] = parseFormat(splitName[2])
					end

					if itemCharges(v["item"]) then
						v["charges"] = parseInt(splitName[2] * 33)
					end

					if itemDurability(v["item"]) then
						v["durability"] = parseInt(os.time() - splitName[2])
						v["days"] = itemDurability(v["item"])
					else
						v["durability"] = 0
						v["days"] = 1
					end
				else
					v["durability"] = 0
					v["days"] = 1
				end

				if splitName[1] == "weedclone" or splitName[1] == "weedleaf" or splitName[1] == "joint" then
					local Item = "da clonagem"
					if splitName[1] == "weedleaf" then
						Item = "da folha"
					elseif splitName[1] == "joint" then
						Item = "do baseado"
					end

					v["desc"] = "A pureza "..Item.." se encontra em <green>"..(splitName[2] or 0).."%</green>."
				end

				myInventory[k] = v
			end
		end

		return myInventory,vRP.inventoryWeight(Passport),vRP.getWeights(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DROPSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:DropServer",function(Coords,Item,Amount)
	local Number = 0

	repeat
		Number = Number + 1
	until Drops[tostring(Number)] == nil

	Drops[tostring(Number)] = {
		["key"] = Item,
		["amount"] = Amount,
		["Coords"] = { Coords["x"],Coords["y"],Coords["z"] },
		["name"] = itemName(Item),
		["peso"] = itemWeight(Item),
		["index"] = itemIndex(Item),
		["days"] = 1,
		["durability"] = 0,
		["charges"] = nil
	}

	TriggerClientEvent("drops:Adicionar",-1,tostring(Number),Drops[tostring(Number)])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Drops")
AddEventHandler("inventory:Drops",function(Item,Slot,Amount,x,y,z)
	local source = source
	local Slot = tostring(Slot)
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil and not Player(source)["state"]["Handcuff"] and not exports["hud"]:Wanted(Passport) and not vRPC.inVehicle(source) and GetPlayerRoutingBucket(source) < 900000 then
			if itemBlock(Item) then
				TriggerClientEvent("inventory:Update",source,"updateMochila")
				goto scapeInventory
			end

			if vRP.tryGetInventoryItem(Passport,Item,Amount,false,Slot) then
				local Days = 1
				local Number = 0
				local Charges = nil
				local Durability = 0
				local splitName = splitString(Item,"-")

				repeat
					Number = Number + 1
				until Drops[tostring(Number)] == nil

				if splitName[2] ~= nil then
					if itemCharges(Item) then
						Charges = parseInt(splitName[2] * 33)
					end

					if itemDurability(Item) then
						Durability = parseInt(os.time() - splitName[2])
						Days = itemDurability(Item)
					end
				end

				Drops[tostring(Number)] = {
					["key"] = Item,
					["amount"] = Amount,
					["Coords"] = { x,y,z },
					["name"] = itemName(Item),
					["peso"] = itemWeight(Item),
					["index"] = itemIndex(Item),
					["days"] = Days,
					["durability"] = Durability,
					["charges"] = Charges
				}

				Player(source)["state"]["Buttons"] = true
				Player(source)["state"]["Cancel"] = true

				if not vRPC.inVehicle(source) then
					vRPC.playAnim(source,false,{"pickup_object","pickup_low"},true)
					Active[Passport] = os.time() + 100

					SetTimeout(1000,function()
						vRPC.removeObjects(source)
						Active[Passport] = nil
					end)
				end

				TriggerClientEvent("drops:Adicionar",-1,tostring(Number),Drops[tostring(Number)])
				TriggerClientEvent("inventory:Update",source,"updateMochila")
				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
			end
		else
			TriggerClientEvent("inventory:Update",source,"updateMochila")
		end
	end

	::scapeInventory::
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Pickup")
AddEventHandler("inventory:Pickup",function(Number,Amount,Slot)
	local source = source
	local Slot = tostring(Slot)
	local Number = tostring(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil and GetPlayerRoutingBucket(source) < 900000 then
			if Drops[Number] == nil then
				TriggerClientEvent("inventory:Update",source,"updateMochila")

				goto scapeInventory
			else
				if (vRP.inventoryWeight(Passport) + itemWeight(Drops[Number]["key"]) * Amount) <= vRP.getWeights(Passport) then
					if Drops[Number] == nil or Drops[Number]["amount"] < Amount then
						TriggerClientEvent("inventory:Update",source,"updateMochila")

						goto scapeInventory
					end

					if vRP.checkMaxItens(Passport,Drops[Number]["key"],Amount) then
						TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
						TriggerClientEvent("inventory:Update",source,"updateMochila")

						goto scapeInventory
					end

					if Drops[Number] then
						local inventory = vRP.Inventory(Passport)
						if inventory[Slot] and Drops[Number]["key"] then
							if inventory[Slot]["item"] == Drops[Number]["key"] then
								vRP.giveInventoryItem(Passport,Drops[Number]["key"],Amount,false,Slot)
							else
								vRP.giveInventoryItem(Passport,Drops[Number]["key"],Amount,false)
							end
						else
							if Drops[Number] then
								vRP.giveInventoryItem(Passport,Drops[Number]["key"],Amount,false,Slot)
							end
						end

						Drops[Number]["amount"] = Drops[Number]["amount"] - Amount
						if Drops[Number]["amount"] <= 0 then
							TriggerClientEvent("drops:Remover",-1,Number)
							Drops[Number] = nil
						else
							TriggerClientEvent("drops:Atualizar",-1,Number,Drops[Number]["amount"])
						end

						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true

						if not vRPC.inVehicle(source) then
							vRPC.playAnim(source,false,{"pickup_object","pickup_low"},true)
							Active[Passport] = os.time() + 100

							SetTimeout(1000,function()
								vRPC.removeObjects(source)
								Active[Passport] = nil
							end)
						end

						TriggerClientEvent("inventory:Update",source,"updateMochila")
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
					else
						TriggerClientEvent("inventory:Update",source,"updateMochila")
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					TriggerClientEvent("inventory:Update",source,"updateMochila")

					goto scapeInventory
				end
			end
		else
			TriggerClientEvent("inventory:Update",source,"updateMochila")
		end
	end

	::scapeInventory::
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:sendItem")
AddEventHandler("inventory:sendItem",function(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil and GetPlayerRoutingBucket(source) < 900000 then
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			Active[Passport] = os.time() + 100

			local inventory = vRP.Inventory(Passport)
			if not inventory[Slot] or inventory[Slot]["item"] == nil then
				Active[Passport] = nil
				goto scapeInventory
			end

			if Amount <= 0 then Amount = 1 end
			local Item = inventory[Slot]["item"]

			if vRP.checkDamaged(Item) or itemBlock(Item) then
				Active[Passport] = nil
				goto scapeInventory
			end

			local OtherPassport = vRP.Passport(ClosestPed)
			if not vRP.checkMaxItens(OtherPassport,Item,Amount) then
				if (vRP.inventoryWeight(OtherPassport) + itemWeight(Item) * Amount) <= vRP.getWeights(OtherPassport) then
					if vRP.tryGetInventoryItem(Passport,Item,Amount,true,Slot) then
						vRPC.createObjects(source,"mp_safehouselost@","package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)
						Player(ClosestPed)["state"]["Buttons"] = true
						Player(ClosestPed)["state"]["Cancel"] = true
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true

						Wait(3000)

						vRP.giveInventoryItem(OtherPassport,Item,Amount,true)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						TriggerClientEvent("inventory:Update",ClosestPed,"updateMochila")
						Player(ClosestPed)["state"]["Buttons"] = false
						Player(ClosestPed)["state"]["Cancel"] = false
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRPC.removeObjects(source)
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			end

			Active[Passport] = nil
		end
	end

	::scapeInventory::
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Deliver")
AddEventHandler("inventory:Deliver",function(Slot)
	local source = source
	local Slot = tostring(Slot)
	local Passport = vRP.Passport(source)
	if Passport then
		local inventory = vRP.Inventory(Passport)
		if not inventory[Slot] or inventory[Slot]["item"] == nil then
			goto scapeInventory
		end

		local splitName = splitString(inventory[Slot]["item"],"-")
		local totalName = inventory[Slot]["item"]
		local nameItem = splitName[1]

		if nameItem == "woodlog" then
			if not vRPC.lastVehicle(source,"ratloader") then
				TriggerClientEvent("Notify",source,"amarelo","Precisa utilizar o veículo do <b>Lenhador</b>.",3000)
				goto scapeInventory
			end

			if vDELIVER.Deliver(source,"Lumberman") then
				if vRP.tryGetInventoryItem(Passport,totalName,3,false,Slot) then
					local Experience = vRP.GetExperience(Passport,"Lumberman")
					local Category = ClassCategory(Experience)
					local Valuation = 100

					if Category == "B+" then
						Valuation = Valuation + 20
					elseif Category == "A" then
						Valuation = Valuation + 40
					elseif Category == "A+" then
						Valuation = Valuation + 60
					elseif Category == "S" then
						Valuation = Valuation + 80
					elseif Category == "S+" then
						Valuation = Valuation + 100
					end

					if Buffs["Dexterity"][Passport] then
						if Buffs["Dexterity"][Passport] > os.time() then
							Valuation = Valuation + (Valuation * 0.1)
						end
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vRP.generateItem(Passport,"dollars",Valuation,true)
					vRP.PutExperience(Passport,"Lumberman",1)
					vDELIVER.Update(source)
				end
			end
		elseif nameItem == "pouch" then
			if not vRPC.lastVehicle(source,"stockade") then
				TriggerClientEvent("Notify",source,"amarelo","Precisa utilizar o veículo do <b>Transportador</b>.",3000)
				goto scapeInventory
			end

			if vDELIVER.Deliver(source,"Transporter") then
				if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
					local Experience = vRP.GetExperience(Passport,"Transporter")
					local Category = ClassCategory(Experience)
					local Valuation = 60

					if Category == "B+" then
						Valuation = Valuation + 10
					elseif Category == "A" then
						Valuation = Valuation + 20
					elseif Category == "A+" then
						Valuation = Valuation + 30
					elseif Category == "S" then
						Valuation = Valuation + 40
					elseif Category == "S+" then
						Valuation = Valuation + 50
					end

					if Buffs["Dexterity"][Passport] then
						if Buffs["Dexterity"][Passport] > os.time() then
							Valuation = Valuation + (Valuation * 0.1)
						end
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vRP.generateItem(Passport,"dollars",Valuation,true)
					vRP.PutExperience(Passport,"Transporter",1)
					vDELIVER.Update(source)
				end
			end
		elseif nameItem == "burgershot3" or nameItem == "burgershot4" then
			if vDELIVER.Deliver(source,"BurgerShot") then
				if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
					local Experience = vRP.GetExperience(Passport,"Delivery")
					local Category = ClassCategory(Experience)
					local Valuation = 200

					if nameItem == "burgershot4" then
						Valuation = 350
					end

					if Category == "B+" then
						Valuation = Valuation + 15
					elseif Category == "A" then
						Valuation = Valuation + 30
					elseif Category == "A+" then
						Valuation = Valuation + 45
					elseif Category == "S" then
						Valuation = Valuation + 60
					elseif Category == "S+" then
						Valuation = Valuation + 75
					end

					if Buffs["Dexterity"][Passport] then
						if Buffs["Dexterity"][Passport] > os.time() then
							Valuation = Valuation + (Valuation * 0.1)
						end
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vRP.generateItem(Passport,"dollars",Valuation,true)
					vRP.DirectChest("BurgerShot",Valuation * 0.05)
					vRP.PutExperience(Passport,"Delivery",1)
					vDELIVER.Update(source)
				end
			end
		elseif nameItem == "pizzathis3" or nameItem == "pizzathis4" then
			if vDELIVER.Deliver(source,"PizzaThis") then
				if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
					local Experience = vRP.GetExperience(Passport,"Delivery")
					local Category = ClassCategory(Experience)
					local Valuation = 200

					if nameItem == "pizzathis4" then
						Valuation = 350
					end

					if Category == "B+" then
						Valuation = Valuation + 15
					elseif Category == "A" then
						Valuation = Valuation + 30
					elseif Category == "A+" then
						Valuation = Valuation + 45
					elseif Category == "S" then
						Valuation = Valuation + 60
					elseif Category == "S+" then
						Valuation = Valuation + 75
					end

					if Buffs["Dexterity"][Passport] then
						if Buffs["Dexterity"][Passport] > os.time() then
							Valuation = Valuation + (Valuation * 0.1)
						end
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vRP.generateItem(Passport,"dollars",Valuation,true)
					vRP.DirectChest("PizzaThis",Valuation * 0.05)
					vRP.PutExperience(Passport,"Delivery",1)
					vDELIVER.Update(source)
				end
			end
		elseif nameItem == "uwucoffee3" or nameItem == "uwucoffee4" then
			if vDELIVER.Deliver(source,"UwuCoffee") then
				if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
					local Experience = vRP.GetExperience(Passport,"Delivery")
					local Category = ClassCategory(Experience)
					local Valuation = 200

					if nameItem == "uwucoffee4" then
						Valuation = 350
					end

					if Category == "B+" then
						Valuation = Valuation + 15
					elseif Category == "A" then
						Valuation = Valuation + 30
					elseif Category == "A+" then
						Valuation = Valuation + 45
					elseif Category == "S" then
						Valuation = Valuation + 60
					elseif Category == "S+" then
						Valuation = Valuation + 75
					end

					if Buffs["Dexterity"][Passport] then
						if Buffs["Dexterity"][Passport] > os.time() then
							Valuation = Valuation + (Valuation * 0.1)
						end
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vRP.generateItem(Passport,"dollars",Valuation,true)
					vRP.DirectChest("UwuCoffee",Valuation * 0.05)
					vRP.PutExperience(Passport,"Delivery",1)
					vDELIVER.Update(source)
				end
			end
		elseif nameItem == "beanmachine3" or nameItem == "beanmachine4" then
			if vDELIVER.Deliver(source,"BeanMachine") then
				if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
					local Experience = vRP.GetExperience(Passport,"Delivery")
					local Category = ClassCategory(Experience)
					local Valuation = 200

					if nameItem == "beanmachine4" then
						Valuation = 350
					end

					if Category == "B+" then
						Valuation = Valuation + 15
					elseif Category == "A" then
						Valuation = Valuation + 30
					elseif Category == "A+" then
						Valuation = Valuation + 45
					elseif Category == "S" then
						Valuation = Valuation + 60
					elseif Category == "S+" then
						Valuation = Valuation + 75
					end

					if Buffs["Dexterity"][Passport] then
						if Buffs["Dexterity"][Passport] > os.time() then
							Valuation = Valuation + (Valuation * 0.1)
						end
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vRP.generateItem(Passport,"dollars",Valuation,true)
					vRP.DirectChest("BeanMachine",Valuation * 0.05)
					vRP.PutExperience(Passport,"Delivery",1)
					vDELIVER.Update(source)
				end
			end
		end
	end

	::scapeInventory::
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:useItem")
AddEventHandler("inventory:useItem",function(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil then
		if Amount <= 0 then Amount = 1 end

		local inventory = vRP.Inventory(Passport)
		if not inventory[Slot] or inventory[Slot]["item"] == nil then
			goto scapeInventory
		end

		local splitName = splitString(inventory[Slot]["item"],"-")
		local totalName = inventory[Slot]["item"]
		local nameItem = splitName[1]

		if itemDurability(totalName) then
			if vRP.checkDamaged(totalName) then
				TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(nameItem).."</b> danificado.",5000)
				goto scapeInventory
			end
		end

		if (vCLIENT.checkWater(source) and nameItem ~= "soap") or (not vCLIENT.checkWater(source) and nameItem == "soap") then
			goto scapeInventory
		end

		if itemType(totalName) == "Armamento" and parseInt(Slot) <= 5 then
			if vCLIENT.CheckArms(source) then
				TriggerClientEvent("Notify",source,"amarelo","Mão machucada.",5000)
				goto scapeInventory
			end

			if vRPC.inVehicle(source) then
				if not itemVehicle(totalName) then
					goto scapeInventory
				end
			end

			local returnWeapon = vCLIENT.returnWeapon(source)
			if returnWeapon then
				local weaponStatus,weaponAmmo,hashItem = vCLIENT.storeWeaponHands(source)

				if weaponStatus then
					local wHash = itemAmmo(hashItem)
					if wHash ~= nil then
						if Ammos[Passport] == nil then
							Ammos[Passport] = {}
						end

						Ammos[Passport][wHash] = parseInt(weaponAmmo)
					end

					TriggerClientEvent("itensNotify",source,{ "guardou",itemIndex(hashItem),1,itemName(hashItem) })
				end
			else
				if Ammos[Passport] == nil then
					Ammos[Passport] = {}
				end

				if Attachs[Passport] == nil then
					Attachs[Passport] = {}
				end

				local wHash = itemAmmo(nameItem)
				if wHash ~= nil then
					if Ammos[Passport][wHash] == nil then
						Ammos[Passport][wHash] = 0
					end
				end

				if Attachs[Passport][nameItem] == nil then
					Attachs[Passport][nameItem] = {}
				end

				if vCLIENT.putWeaponHands(source,nameItem,Ammos[Passport][wHash],Attachs[Passport][nameItem]) then
					TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),1,itemName(totalName) })
				end
			end

			goto scapeInventory
		elseif itemType(totalName) == "Munição" then
			local returnWeapon,weaponHash,weaponAmmo = vCLIENT.rechargeCheck(source,nameItem)

			if returnWeapon then
				if nameItem ~= itemAmmo(weaponHash) then
					goto scapeInventory
				end

				if vRP.tryGetInventoryItem(Passport,totalName,Amount,false,Slot) then
					if Ammos[Passport] == nil then
						Ammos[Passport] = {}
					end

					Ammos[Passport][nameItem] = parseInt(weaponAmmo) + Amount

					TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),Amount,itemName(totalName) })
					vCLIENT.rechargeWeapon(source,weaponHash,Ammos[Passport][nameItem])
					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end

			goto scapeInventory
		elseif itemType(totalName) == "Throwing" then
			local returnWeapon = vCLIENT.returnWeapon(source)
			if returnWeapon then
				local weaponStatus,weaponAmmo,hashItem = vCLIENT.storeWeaponHands(source)

				if weaponStatus then
					local wHash = itemAmmo(hashItem)
					if wHash ~= nil then
						if Ammos[Passport] == nil then
							Ammos[Passport] = {}
						end

						Ammos[Passport][wHash] = parseInt(weaponAmmo)
					end

					TriggerClientEvent("itensNotify",source,{ "guardou",itemIndex(hashItem),1,itemName(hashItem) })
				end
			else
				if vCLIENT.putWeaponHands(source,nameItem,1,nil,totalName) then
					TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),1,itemName(totalName) })
				end
			end

			goto scapeInventory
		elseif nameItem == "attachsFlashlight" or nameItem == "attachsCrosshair" or nameItem == "attachsSilencer" or nameItem == "attachsMagazine" or nameItem == "attachsGrip" then
			local returnWeapon = vCLIENT.returnWeapon(source)
			if returnWeapon then
				if Attachs[Passport] == nil then
					Attachs[Passport] = {}
				end

				if Attachs[Passport][returnWeapon] == nil then
					Attachs[Passport][returnWeapon] = {}
				end

				if Attachs[Passport][returnWeapon][nameItem] == nil then
					local checkAttachs = vCLIENT.checkAttachs(source,nameItem,returnWeapon)
					if checkAttachs then
						if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
							TriggerClientEvent("itensNotify",source,{ "equipou",itemIndex(totalName),1,itemName(totalName) })
							TriggerClientEvent("inventory:Update",source,"updateMochila")
							vCLIENT.putAttachs(source,nameItem,returnWeapon)
							Attachs[Passport][returnWeapon][nameItem] = true
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","O armamento não possui suporte ao componente.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","O armamento já possui o componente equipado.",5000)
				end
			end

			goto scapeInventory
		elseif itemType(totalName) == "Usável" then
			if nameItem == "vehkey" then
				local Vehicle,vehNet,vehPlate = vRPC.vehList(source,5)
				if Vehicle then
					if vehPlate == splitName[2] then
						TriggerEvent("garages:keyVehicle",source,vehNet)
					end
				end

				goto scapeInventory
			elseif nameItem == "suitcase" then
				if splitName[2] then
					if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
						vRP.giveInventoryItem(Passport,"suitcase",1,false)
						vRP.giveInventoryItem(Passport,"dollars",splitName[2],false)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
					end
				end

				goto scapeInventory
			elseif nameItem == "newchars" then
				if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
					vRP.upgradeChars(source)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					TriggerClientEvent("Notify",source,"verde","Personagem liberado.",5000)
				end

				goto scapeInventory
			elseif nameItem == "wheelchair" then
				local plateVehicle = "WCH"..math.random(10000,99999)
				TriggerEvent("plateEveryone",plateVehicle)
				vCLIENT.wheelChair(source,plateVehicle)

				goto scapeInventory
			elseif nameItem == "backcamping" then
				local Name = "Acampamento"
				local Consult = vRP.getSrvdata("Exclusivas:"..Passport)
				if Consult[Name] == nil then
					if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						Consult[Name] = { ["id"] = 102, ["texture"] = 0, ["type"] = "backpack" }
						vRP.setSrvdata("Exclusivas:"..Passport,Consult)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Mochila já possuída.",5000)
				end

				goto scapeInventory
			elseif nameItem == "backschool" then
				local Name = "Escolar"
				local Consult = vRP.getSrvdata("Exclusivas:"..Passport)
				if Consult[Name] == nil then
					if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						Consult[Name] = { ["id"] = 101, ["texture"] = 0, ["type"] = "backpack" }
						vRP.setSrvdata("Exclusivas:"..Passport,Consult)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Mochila já possuída.",5000)
				end

				goto scapeInventory
			elseif nameItem == "backcyclist" then
				local Name = "Ciclista"
				local Consult = vRP.getSrvdata("Exclusivas:"..Passport)
				if Consult[Name] == nil then
					if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						Consult[Name] = { ["id"] = 103, ["texture"] = 0, ["type"] = "backpack" }
						vRP.setSrvdata("Exclusivas:"..Passport,Consult)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Mochila já possuída.",5000)
				end

				goto scapeInventory
			elseif nameItem == "backalohomorawhite" then
				local Name = "Alohomora Branca"
				local Consult = vRP.getSrvdata("Exclusivas:"..Passport)
				if Consult[Name] == nil then
					if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						Consult[Name] = { ["id"] = 104, ["texture"] = 0, ["type"] = "backpack" }
						vRP.setSrvdata("Exclusivas:"..Passport,Consult)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Mochila já possuída.",5000)
				end

				goto scapeInventory
			elseif nameItem == "backalohomorablack" then
				local Name = "Alohomora Preta"
				local Consult = vRP.getSrvdata("Exclusivas:"..Passport)
				if Consult[Name] == nil then
					if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						Consult[Name] = { ["id"] = 104, ["texture"] = 1, ["type"] = "backpack" }
						vRP.setSrvdata("Exclusivas:"..Passport,Consult)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Mochila já possuída.",5000)
				end

				goto scapeInventory
			elseif nameItem == "backalohomorared" then
				local Name = "Alohomora Vermelha"
				local Consult = vRP.getSrvdata("Exclusivas:"..Passport)
				if Consult[Name] == nil then
					if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						Consult[Name] = { ["id"] = 104, ["texture"] = 2, ["type"] = "backpack" }
						vRP.setSrvdata("Exclusivas:"..Passport,Consult)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Mochila já possuída.",5000)
				end

				goto scapeInventory
			elseif nameItem == "backrudolphpurple" then
				local Name = "Rudolph Roxo"
				local Consult = vRP.getSrvdata("Exclusivas:"..Passport)
				if Consult[Name] == nil then
					if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						Consult[Name] = { ["id"] = 105, ["texture"] = 0, ["type"] = "backpack" }
						vRP.setSrvdata("Exclusivas:"..Passport,Consult)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Mochila já possuída.",5000)
				end

				goto scapeInventory
			elseif nameItem == "backrudolphred" then
				local Name = "Rudolph Vermelho"
				local Consult = vRP.getSrvdata("Exclusivas:"..Passport)
				if Consult[Name] == nil then
					if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						Consult[Name] = { ["id"] = 105, ["texture"] = 1, ["type"] = "backpack" }
						vRP.setSrvdata("Exclusivas:"..Passport,Consult)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Mochila já possuída.",5000)
				end

				goto scapeInventory
			elseif nameItem == "defibrillator" then
				TriggerClientEvent("skinshop:Defibrillator",source)

				goto scapeInventory
			elseif nameItem == "gemstone" then
				if vRP.tryGetInventoryItem(Passport,totalName,Amount,false,Slot) then
					TriggerClientEvent("inventory:Update",source,"updateMochila")
					vRP.upgradeGemstone(source,Amount)
				end

				goto scapeInventory
			elseif nameItem == "badge01" then
				TriggerClientEvent("inventory:Close",source)
				vRPC.createObjects(source,"paper_1_rcm_alt1-8","player_one_dual-8","prop_police_badge",49,28422,0.065,0.029,-0.035,80.0,-1.90,75.0)

				goto scapeInventory
			elseif nameItem == "badge02" then
				TriggerClientEvent("inventory:Close",source)
				vRPC.createObjects(source,"paper_1_rcm_alt1-8","player_one_dual-8","prop_medic_badge",49,28422,0.065,0.029,-0.035,80.0,-1.90,75.0)

				goto scapeInventory
			elseif nameItem == "namechange" then
				TriggerClientEvent("inventory:Close",source)

				local Keyboard = vKEYBOARD.keyDouble(source,"Nome:","Sobrenome:")
				if Keyboard then
					if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
						TriggerClientEvent("Notify",source,"verde","Passaporte atualizado.",5000)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						vRP.upgradeNames(source,Passport,Keyboard[1],Keyboard[2])
					end
				end

				goto scapeInventory
			elseif nameItem == "dices" then
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Jogando",1750)
				vRPC.playAnim(source,true,{"anim@mp_player_intcelebrationmale@wank","wank"},true)

				Wait(1750)

				Active[Passport] = nil
				vRPC.stopAnim(source,false)
				Player(source)["state"]["Buttons"] = false

				local Dice = math.random(6)
				local Players = vRPC.Players(source)
				for _,v in ipairs(Players) do
					async(function()
						TriggerClientEvent("showme:pressMe",v,source,"<img src='images/"..Dice..".png'>",10,true)
					end)
				end

				goto scapeInventory
			elseif nameItem == "deck" then
				TriggerClientEvent("inventory:Close",source)

				local card = math.random(13)
				local cards = { "A","2","3","4","5","6","7","8","9","10","J","Q","K" }

				local naipe = math.random(4)
				local naipes = { "^8♣","^8♠","^7♦","^7♥" }

				local Identity = vRP.Identity(Passport)
				TriggerClientEvent("chatME",source,"^5CARTAS^9"..Identity["name"].." "..Identity["name2"].."^0 tirou "..cards[card]..naipes[naipe].."^0 do baralho.")

				local Players = vRPC.ClosestPeds(source,5)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("chatME",v[2],"^5CARTAS^9"..Identity["name"].." "..Identity["name2"].."^0 "..cards[card]..naipes[naipe].."^0 do baralho.")
					end)
				end

				goto scapeInventory
			elseif nameItem == "silvercoin" or nameItem == "goldcoin" then
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Jogando",1750)
				vRPC.playAnim(source,true,{"anim@mp_player_intcelebrationmale@wank","wank"},true)

				Wait(1750)

				Active[Passport] = nil
				vRPC.stopAnim(source,false)
				Player(source)["state"]["Buttons"] = false

				local Coins = math.random(2)
				local Sides = { "Cara","Coroa" }
				local Identity = vRP.Identity(Passport)
				TriggerClientEvent("chatME",source,"^5MOEDA^9"..Identity["name"].." "..Identity["name2"].."^0 "..Sides[Coins]..".")

				local Players = vRPC.ClosestPeds(source,5)
				for _,v in pairs(Players) do
					async(function()
						TriggerClientEvent("chatME",v[2],"^5MOEDA^9"..Identity["name"].." "..Identity["name2"].."^0 "..Sides[Coins]..".")
					end)
				end

				goto scapeInventory
			elseif nameItem == "bandage" then
				if (Healths[Passport] == nil or os.time() > Healths[Passport]) then
					if vRP.getHealth(source) > 100 and vRP.getHealth(source) < 200 then
						Active[Passport] = os.time() + 5
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("Progress",source,"Passando",5000)
						vRPC.playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

						repeat
							if os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								vRPC.stopAnim(source,false)
								Player(source)["state"]["Buttons"] = false

								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									TriggerClientEvent("sounds:Private",source,"bandage",0.5)
									Healths[Passport] = os.time() + 30
									vRP.upgradeStress(Passport,2)
									vRPC.updateHealth(source,15)
								end
							end

							Wait(100)
						until Active[Passport] == nil
					else
						TriggerClientEvent("Notify",source,"amarelo","Não pode utilizar de vida cheia ou nocauteado.",5000)
					end
				else
					local healTimers = parseInt(Healths[Passport] - os.time())
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..healTimers.."</b> segundos.",5000)
				end

				goto scapeInventory
			elseif nameItem == "sulfuric" then
				Active[Passport] = os.time() + 3
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",3000)
				vRPC.playAnim(source,true,{"mp_suicide","pill"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.stopAnim(source,false)
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRPC.downHealth(source,100)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "analgesic" or nameItem == "oxy" then
				if (Healths[Passport] == nil or os.time() > Healths[Passport]) then
					if vRP.getHealth(source) > 100 and vRP.getHealth(source) < 200 then
						Active[Passport] = os.time() + 3
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("Progress",source,"Tomando",3000)
						vRPC.playAnim(source,true,{"mp_suicide","pill"},true)

						repeat
							if os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								vRPC.stopAnim(source,false)
								Player(source)["state"]["Buttons"] = false

								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									Healths[Passport] = os.time() + 15
									vRP.upgradeStress(Passport,1)
									vRPC.updateHealth(source,8)
								end
							end

							Wait(100)
						until Active[Passport] == nil
					else
						TriggerClientEvent("Notify",source,"azul","Não pode utilizar de vida cheia ou nocauteado.",5000)
					end
				else
					local healTimers = parseInt(Healths[Passport] - os.time())
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..healTimers.."</b> segundos.",5000)
				end

				goto scapeInventory
			elseif nameItem == "soap" then
				if vPLAYER.checkSoap(source) ~= nil then
					Active[Passport] = os.time() + 10
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("Progress",source,"Usando",10000)
					vRPC.playAnim(source,false,{"amb@world_human_bum_wash@male@high@base","base"},true)

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.removeObjects(source)
							Player(source)["state"]["Buttons"] = false

							if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
								TriggerClientEvent("player:Residuals",source)
							end
						end

						Wait(100)
					until Active[Passport] == nil
				end

				goto scapeInventory
			elseif nameItem == "geode" then
				if vRP.consultItem(Passport,"WEAPON_HAMMER",1) then
					local Selected = math.random(#Geodes)
					local Rand = math.random(Geodes[Selected]["min"],Geodes[Selected]["max"])

					if (vRP.inventoryWeight(Passport) + (itemWeight(Geodes[Selected]["item"]) * Rand)) <= vRP.getWeights(Passport) then
						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.generateItem(Passport,Geodes[Selected]["item"],Rand,false)
							TriggerClientEvent("inventory:Update",source,"updateMochila")
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Martelo</b> não encontrado.",5000)
				end

				goto scapeInventory
			elseif nameItem == "joint" then
				if vRP.consultItem(Passport,"lighter",1) then
					Active[Passport] = os.time() + 10
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("Progress",source,"Fumando",10000)
					vRPC.createObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.removeObjects(source)
							Player(source)["state"]["Buttons"] = false

							if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
								local Points = 0
								if splitName[2] ~= nil then
									Points = parseInt(splitName[2])
								end

								vRP.WeedTimer(Passport,1)
								vRP.downgradeHunger(Passport,5 + (0.1 * Points))
								vRP.downgradeThirst(Passport,5 + (0.1 * Points))
								vRP.downgradeStress(Passport,5 + (0.1 * Points))
								vPLAYER.movementClip(source,"move_m@shadyped@a")
							end
						end

						Wait(100)
					until Active[Passport] == nil
				end

				goto scapeInventory
			elseif nameItem == "cocaine" then
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Cheirando",5000)
				vRPC.playAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.stopAnim(source)
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.ChemicalTimer(Passport,10)
							TriggerClientEvent("setCocaine",source)
							TriggerClientEvent("setEnergetic",source,15,1.20)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "meth" then
				if Armors[Passport] then
					if os.time() < Armors[Passport] then
						local armorTimers = parseInt(Armors[Passport] - os.time())
						TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..armorTimers.."</b> segundos.",5000)
						goto scapeInventory
					end
				end

				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Inalando",10000)
				vRPC.playAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.stopAnim(source)
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							TriggerClientEvent("setMeth",source)
							Armors[Passport] = os.time() + 60
							vRP.ChemicalTimer(Passport,10)
							vRP.setArmour(source,10)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "cigarette" then
				if vRP.consultItem(Passport,"lighter",1) then
					Active[Passport] = os.time() + 10
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("Progress",source,"Fumando",10000)
					vRPC.createObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.removeObjects(source)
							Player(source)["state"]["Buttons"] = false

							if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
								vRP.downgradeStress(Passport,5)
							end
						end

						Wait(100)
					until Active[Passport] == nil
				end

				goto scapeInventory
			elseif nameItem == "vape" then
				Active[Passport] = os.time() + 15
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Fumando",15000)
				vRPC.createObjects(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","ba_prop_battle_vape_01",49,18905,0.08,-0.00,0.03,-150.0,90.0,-10.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRP.downgradeStress(Passport,5)
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "medkit" then
				if (Healths[Passport] == nil or os.time() > Healths[Passport]) then
					if vRP.getHealth(source) > 100 and vRP.getHealth(source) < 200 then
						Active[Passport] = os.time() + 10
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("Progress",source,"Passando",10000)
						vRPC.playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

						repeat
							if os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								vRPC.stopAnim(source,false)
								Player(source)["state"]["Buttons"] = false

								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									Healths[Passport] = os.time() + 60
									vRPC.updateHealth(source,40)
								end
							end

							Wait(100)
						until Active[Passport] == nil
					else
						TriggerClientEvent("Notify",source,"amarelo","Não pode utilizar de vida cheia ou nocauteado.",5000)
					end
				else
					local healTimers = parseInt(Healths[Passport] - os.time())
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..healTimers.."</b> segundos.",5000)
				end

				goto scapeInventory
			elseif nameItem == "gauze" then
				if vPARAMEDIC.Bleeding(source) > 0 then
					Active[Passport] = os.time() + 3
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("Progress",source,"Passando",3000)
					vRPC.playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.stopAnim(source,false)
							Player(source)["state"]["Buttons"] = false

							if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
								vPARAMEDIC.Bandage(source)
							end
						end

						Wait(100)
					until Active[Passport] == nil
				else
					TriggerClientEvent("Notify",source,"amarelo","Nenhum ferimento encontrado.",5000)
				end

				goto scapeInventory
			elseif nameItem == "binoculars" then
				local Ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(Ped) ~= GetHashKey("WEAPON_UNARMED") then
					goto scapeInventory
				end

				Active[Passport] = os.time() + 3
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Usando",3000)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						TriggerClientEvent("useBinoculos",source)
						Player(source)["state"]["Buttons"] = false
						vRPC.createObjects(source,"amb@world_human_binoculars@male@enter","enter","prop_binoc_01",50,28422)
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif string.sub(nameItem,1,8) == "evidence" then
				local Microscope = {
					{ 482.95,-988.61,30.68 },
					{ 312.47,-562.1,43.29 },
					{ 368.33,-1592.01,25.44 },
					{ 1772.18,2577.82,45.73 }
				}

				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				for k,v in pairs(Microscope) do
					local Distance = #(Coords - vec3(v[1],v[2],v[3]))
					if Distance <= 1 then
						local Identity = vRP.Identity(splitName[2])
						if Identity then
							TriggerClientEvent("Notify",source,"amarelo","Evidência de <b>"..Identity["name2"].."</b>.",5000)
							break
						end
					end
				end

				goto scapeInventory
			elseif nameItem == "camera" then
				local Ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(Ped) ~= GetHashKey("WEAPON_UNARMED") then
					goto scapeInventory
				end

				Active[Passport] = os.time() + 3
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Usando",3000)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						TriggerClientEvent("useCamera",source)
						Player(source)["state"]["Buttons"] = false
						vRPC.createObjects(source,"amb@world_human_paparazzi@male@base","base","prop_pap_camera_01",49,28422)
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "teddy" then
				TriggerClientEvent("inventory:Close",source)
				vRPC.createObjects(source,"impexp_int-0","mp_m_waremech_01_dual-0","v_ilev_mr_rasberryclean",49,24817,-0.20,0.46,-0.016,-180.0,-90.0,0.0)

				goto scapeInventory
			elseif nameItem == "rose" then
				TriggerClientEvent("inventory:Close",source)
				vRPC.createObjects(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","prop_single_rose",49,18905,0.13,0.15,0.0,-100.0,0.0,-20.0)

				goto scapeInventory
			elseif nameItem == "firecracker" then
				if not vRPC.inVehicle(source) and not vCLIENT.checkCracker(source) then
					Active[Passport] = os.time() + 3
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("Progress",source,"Acendendo",3000)
					vRPC.playAnim(source,false,{"anim@mp_fireworks","place_firework_3_box"},true)

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.stopAnim(source,false)
							Player(source)["state"]["Buttons"] = false

							if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
								TriggerClientEvent("inventory:Firecracker",source)
							end
						end

						Wait(100)
					until Active[Passport] == nil
				end

				goto scapeInventory
			elseif nameItem == "gsrkit" then
				local ClosestPed = vRPC.ClosestPed(source,2)
				if ClosestPed then
					Active[Passport] = os.time() + 5
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("Progress",source,"Usando",5000)

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							Player(source)["state"]["Buttons"] = false

							if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
								local Informations = vPLAYER.checkSoap(ClosestPed)
								if Informations then
									local Number = 0
									local Message = ""

									for Value,v in pairs(Informations) do
										Number = Number + 1
										Message = Message.."<b>"..Number.."</b>: "..Value.."<br>"
									end

									TriggerClientEvent("Notify",source,"amarelo",Message,10000)
								else
									TriggerClientEvent("Notify",source,"amarelo","Nenhum resultado encontrado.",3000)
								end
							end
						end

						Wait(100)
					until Active[Passport] == nil
				end

				goto scapeInventory
			elseif nameItem == "gdtkit" then
				local ClosestPed = vRPC.ClosestPed(source,2)
				if ClosestPed then
					local OtherPassport = vRP.Passport(ClosestPed)
					local Identity = vRP.Identity(OtherPassport)
					if OtherPassport and Identity then
						Active[Passport] = os.time() + 5
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("Progress",source,"Usando",5000)

						repeat
							if os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								Player(source)["state"]["Buttons"] = false

								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									local weed = vRP.WeedReturn(OtherPassport)
									local chemical = vRP.ChemicalReturn(OtherPassport)
									local alcohol = vRP.AlcoholReturn(OtherPassport)

									local chemStr = ""
									local alcoholStr = ""
									local weedStr = ""

									if chemical == 0 then
										chemStr = "Nenhum"
									elseif chemical == 1 then
										chemStr = "Baixo"
									elseif chemical == 2 then
										chemStr = "Médio"
									elseif chemical >= 3 then
										chemStr = "Alto"
									end

									if alcohol == 0 then
										alcoholStr = "Nenhum"
									elseif alcohol == 1 then
										alcoholStr = "Baixo"
									elseif alcohol == 2 then
										alcoholStr = "Médio"
									elseif alcohol >= 3 then
										alcoholStr = "Alto"
									end

									if weed == 0 then
										weedStr = "Nenhum"
									elseif weed == 1 then
										weedStr = "Baixo"
									elseif weed == 2 then
										weedStr = "Médio"
									elseif weed >= 3 then
										weedStr = "Alto"
									end

									TriggerClientEvent("Notify",source,"azul","<b>Químicos:</b> "..chemStr.."<br><b>Álcool:</b> "..alcoholStr.."<br><b>Drogas:</b> "..weedStr,8000)
								end
							end

							Wait(100)
						until Active[Passport] == nil
					end
				end

				goto scapeInventory
			elseif nameItem == "nitro" then
				if not vRPC.inVehicle(source) then
					local Vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if Vehicle then
						vRPC.AnimActive(source)
						Active[Passport] = os.time() + 10
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("Progress",source,"Trocando",10000)
						TriggerClientEvent("player:syncHoodOptions",source,vehNet,"open")
						vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

						repeat
							if os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								vRPC.stopAnim(source,false)
								Player(source)["state"]["Buttons"] = false

								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									local Nitro = GlobalState["Nitro"]
									Nitro[vehPlate] = 2000
									GlobalState:set("Nitro",Nitro,true)
								end
							end

							Wait(100)
						until Active[Passport] == nil

						TriggerClientEvent("player:syncHoodOptions",source,vehNet,"close")
					end
				end

				goto scapeInventory
			elseif nameItem == "vest" then
				if Armors[Passport] then
					if os.time() < Armors[Passport] then
						local armorTimers = parseInt(Armors[Passport] - os.time())
						TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..armorTimers.."</b> segundos.",5000)
						goto scapeInventory
					end
				end

				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Vestindo",10000)
				vRPC.playAnim(source,true,{"clothingtie","try_tie_negative_a"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.stopAnim(source,false)
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							Armors[Passport] = os.time() + 1800
							vRP.setArmour(source,100)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "GADGET_PARACHUTE" then
				Active[Passport] = os.time() + 3
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Usando",3000)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vCLIENT.parachuteColors(source)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "advtoolbox" and splitName[2] then
				if not vRPC.inVehicle(source) then
					local Vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if Vehicle then
						vRPC.AnimActive(source)
						Active[Passport] = os.time() + 100
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("player:syncHoodOptions",source,vehNet,"open")
						vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

						if vTASKBAR.taskMechanic(source) then
							if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
								local Players = vRPC.Players(source)
								for _,v in ipairs(Players) do
									async(function()
										TriggerClientEvent("inventory:repairVehicle",v,vehNet,vehPlate)
									end)
								end

								local Number = parseInt(splitName[2]) - 1

								if Number >= 1 then
									vRP.giveInventoryItem(Passport,"advtoolbox-"..Number,1,false)
								end
							end
						end

						TriggerClientEvent("player:syncHoodOptions",source,vehNet,"close")
						Player(source)["state"]["Buttons"] = false
						vRPC.stopAnim(source,false)
						Active[Passport] = nil
					end
				end

				goto scapeInventory
			elseif string.sub(nameItem,1,6) == "engine" then
				if not vRPC.inVehicle(source) then
					local Vehicle,vehNet,vehPlate,vehName = vRPC.vehList(source,4)
					if Vehicle then
						local Passport = vRP.PassportPlate(vehPlate)
						if Passport then
							local Datatable = vRP.Query("entitydata/GetData",{ dkey = "vehMods:"..Passport["Passport"]..":"..vehName })
							if parseInt(#Datatable) > 0 then
								Datatable = json.decode(Datatable[1]["dvalue"])

								if Datatable["mods"]["11"] == nil then
									Datatable["mods"]["11"] = -1
								end

								local Modification = -1
								if nameItem == "engineb" then
									Modification = 0
								elseif nameItem == "enginec" then
									Modification = 1
								elseif nameItem == "engined" then
									Modification = 2
								elseif nameItem == "enginee" then
									Modification = 3
								end

								if Datatable["mods"]["11"] == Modification then
									if Datatable["mods"]["11"] >= vCLIENT.CheckMods(source,Vehicle,11) then
										TriggerClientEvent("Notify",source,"amarelo","Limite do <b>Motor</b> atingido.",5000)
									else
										vRPC.AnimActive(source)
										Active[Passport] = os.time() + 1000
										Player(source)["state"]["Buttons"] = true
										TriggerClientEvent("inventory:Close",source)
										TriggerClientEvent("player:syncHoodOptions",source,vehNet,"open")
										vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

										if vTASKBAR.UpgradeVehicle(source) then
											Active[Passport] = os.time() + 120
											TriggerClientEvent("Progress",source,"Aplicando",120000)

											repeat
												if os.time() >= parseInt(Active[Passport]) then
													Active[Passport] = nil
													vRPC.removeObjects(source)
													Player(source)["state"]["Buttons"] = false

													if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
														Datatable["mods"]["11"] = Datatable["mods"]["11"] + 1
														vCLIENT.ActiveMods(source,vehNet,vehPlate,11,Datatable["mods"]["11"])
														vRP.Execute("entitydata/SetData",{ key = "vehMods:"..Passport["Passport"]..":"..vehName, dvalue = json.encode(Datatable) })
													end
												end

												Wait(100)
											until Active[Passport] == nil
										end

										TriggerClientEvent("player:syncHoodOptions",source,vehNet,"close")
										Player(source)["state"]["Buttons"] = false
										vRPC.stopAnim(source,false)
										Active[Passport] = nil
									end
								else
									TriggerClientEvent("Notify",source,"amarelo","Modelo do <b>Motor</b> incorreto.",5000)
								end
							else
								TriggerClientEvent("Notify",source,"amarelo","Dirija-se até uma mecânica e efetue uma revisão.",5000)
							end
						end
					end
				end

				goto scapeInventory
			elseif string.sub(nameItem,1,5) == "brake" then
				if not vRPC.inVehicle(source) then
					local Vehicle,vehNet,vehPlate,vehName = vRPC.vehList(source,4)
					if Vehicle then
						local Passport = vRP.PassportPlate(vehPlate)
						if Passport then
							local Datatable = vRP.Query("entitydata/GetData",{ dkey = "vehMods:"..Passport["Passport"]..":"..vehName })
							if parseInt(#Datatable) > 0 then
								Datatable = json.decode(Datatable[1]["dvalue"])

								if Datatable["mods"]["12"] == nil then
									Datatable["mods"]["12"] = -1
								end

								local Modification = -1
								if nameItem == "brakeb" then
									Modification = 0
								elseif nameItem == "brakec" then
									Modification = 1
								elseif nameItem == "braked" then
									Modification = 2
								elseif nameItem == "brakee" then
									Modification = 3
								end

								if Datatable["mods"]["12"] == Modification then
									if Datatable["mods"]["12"] >= vCLIENT.CheckMods(source,Vehicle,12) then
										TriggerClientEvent("Notify",source,"amarelo","Limite do <b>Freio</b> atingido.",5000)
									else
										vRPC.AnimActive(source)
										Active[Passport] = os.time() + 1000
										Player(source)["state"]["Buttons"] = true
										TriggerClientEvent("inventory:Close",source)
										TriggerClientEvent("player:syncHoodOptions",source,vehNet,"open")
										vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

										if vTASKBAR.UpgradeVehicle(source) then
											Active[Passport] = os.time() + 120
											TriggerClientEvent("Progress",source,"Aplicando",120000)

											repeat
												if os.time() >= parseInt(Active[Passport]) then
													Active[Passport] = nil
													vRPC.removeObjects(source)
													Player(source)["state"]["Buttons"] = false

													if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
														Datatable["mods"]["12"] = Datatable["mods"]["12"] + 1
														vCLIENT.ActiveMods(source,vehNet,vehPlate,12,Datatable["mods"]["12"])
														vRP.Execute("entitydata/SetData",{ dkey = "vehMods:"..Passport["Passport"]..":"..vehName, dvalue = json.encode(Datatable) })
													end
												end

												Wait(100)
											until Active[Passport] == nil
										end

										TriggerClientEvent("player:syncHoodOptions",source,vehNet,"close")
										Player(source)["state"]["Buttons"] = false
										vRPC.stopAnim(source,false)
										Active[Passport] = nil
									end
								else
									TriggerClientEvent("Notify",source,"amarelo","Modelo do <b>Freio</b> incorreto.",5000)
								end
							else
								TriggerClientEvent("Notify",source,"amarelo","Dirija-se até uma mecânica e efetue uma revisão.",5000)
							end
						end
					end
				end

				goto scapeInventory
			elseif string.sub(nameItem,1,12) == "transmission" then
				if not vRPC.inVehicle(source) then
					local Vehicle,vehNet,vehPlate,vehName = vRPC.vehList(source,4)
					if Vehicle then
						local Passport = vRP.PassportPlate(vehPlate)
						if Passport then
							local Datatable = vRP.Query("entitydata/GetData",{ dkey = "vehMods:"..Passport["Passport"]..":"..vehName })
							if parseInt(#Datatable) > 0 then
								Datatable = json.decode(Datatable[1]["dvalue"])

								if Datatable["mods"]["13"] == nil then
									Datatable["mods"]["13"] = -1
								end

								local Modification = -1
								if nameItem == "transmissionb" then
									Modification = 0
								elseif nameItem == "transmissionc" then
									Modification = 1
								elseif nameItem == "transmissiond" then
									Modification = 2
								elseif nameItem == "transmissione" then
									Modification = 3
								end

								if Datatable["mods"]["13"] == Modification then
									if Datatable["mods"]["13"] >= vCLIENT.CheckMods(source,Vehicle,13) then
										TriggerClientEvent("Notify",source,"amarelo","Limite da <b>Transmissão</b> atingida.",5000)
									else
										vRPC.AnimActive(source)
										Active[Passport] = os.time() + 1000
										Player(source)["state"]["Buttons"] = true
										TriggerClientEvent("inventory:Close",source)
										TriggerClientEvent("player:syncHoodOptions",source,vehNet,"open")
										vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

										if vTASKBAR.UpgradeVehicle(source) then
											Active[Passport] = os.time() + 120
											TriggerClientEvent("Progress",source,"Aplicando",120000)

											repeat
												if os.time() >= parseInt(Active[Passport]) then
													Active[Passport] = nil
													vRPC.removeObjects(source)
													Player(source)["state"]["Buttons"] = false

													if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
														Datatable["mods"]["13"] = Datatable["mods"]["13"] + 1
														vCLIENT.ActiveMods(source,vehNet,vehPlate,13,Datatable["mods"]["13"])
														vRP.Execute("entitydata/SetData",{ dkey = "vehMods:"..Passport["Passport"]..":"..vehName, dvalue = json.encode(Datatable) })
													end
												end

												Wait(100)
											until Active[Passport] == nil
										end

										TriggerClientEvent("player:syncHoodOptions",source,vehNet,"close")
										Player(source)["state"]["Buttons"] = false
										vRPC.stopAnim(source,false)
										Active[Passport] = nil
									end
								else
									TriggerClientEvent("Notify",source,"amarelo","Modelo da <b>Transmissão</b> incorreta.",5000)
								end
							else
								TriggerClientEvent("Notify",source,"amarelo","Dirija-se até uma mecânica e efetue uma revisão.",5000)
							end
						end
					end
				end

				goto scapeInventory
			elseif string.sub(nameItem,1,10) == "suspension" then
				if not vRPC.inVehicle(source) then
					local Vehicle,vehNet,vehPlate,vehName = vRPC.vehList(source,4)
					if Vehicle then
						if vCLIENT.CheckCar(source,Vehicle) then
							local Passport = vRP.PassportPlate(vehPlate)
							if Passport then
								local Datatable = vRP.Query("entitydata/GetData",{ dkey = "vehMods:"..Passport["Passport"]..":"..vehName })
								if parseInt(#Datatable) > 0 then
									Datatable = json.decode(Datatable[1]["dvalue"])

									if Datatable["mods"]["15"] == nil then
										Datatable["mods"]["15"] = -1
									end

									local Modification = -1
									if nameItem == "suspensionb" then
										Modification = 0
									elseif nameItem == "suspensionc" then
										Modification = 1
									elseif nameItem == "suspensiond" then
										Modification = 2
									elseif nameItem == "suspensione" then
										Modification = 3
									end

									if Datatable["mods"]["15"] == Modification then
										if Datatable["mods"]["15"] >= vCLIENT.CheckMods(source,Vehicle,15) then
											TriggerClientEvent("Notify",source,"amarelo","Limite da <b>Suspensão</b> atingida.",5000)
										else
											vRPC.AnimActive(source)
											Active[Passport] = os.time() + 1000
											Player(source)["state"]["Buttons"] = true
											TriggerClientEvent("inventory:Close",source)
											TriggerClientEvent("player:syncHoodOptions",source,vehNet,"open")
											vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

											if vTASKBAR.UpgradeVehicle(source) then
												Active[Passport] = os.time() + 120
												TriggerClientEvent("Progress",source,"Aplicando",120000)

												repeat
													if os.time() >= parseInt(Active[Passport]) then
														Active[Passport] = nil
														vRPC.removeObjects(source)
														Player(source)["state"]["Buttons"] = false

														if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
															Datatable["mods"]["15"] = Datatable["mods"]["15"] + 1
															vCLIENT.ActiveMods(source,vehNet,vehPlate,15,Datatable["mods"]["15"])
															vRP.Execute("entitydata/SetData",{ dkey = "vehMods:"..Passport["Passport"]..":"..vehName, dvalue = json.encode(Datatable) })
														end
													end

													Wait(100)
												until Active[Passport] == nil
											end

											TriggerClientEvent("player:syncHoodOptions",source,vehNet,"close")
											Player(source)["state"]["Buttons"] = false
											vRPC.stopAnim(source,false)
											Active[Passport] = nil
										end
									else
										TriggerClientEvent("Notify",source,"amarelo","Modelo da <b>Suspensão</b> incorreta.",5000)
									end
								else
									TriggerClientEvent("Notify",source,"amarelo","Dirija-se até uma mecânica e efetue uma revisão.",5000)
								end
							end
						else
							TriggerClientEvent("Notify",source,"amarelo","O veículo <b>"..vehicleName(vehName).."</b> não possui suspensão.",5000)
						end
					end
				end

				goto scapeInventory
			elseif nameItem == "toolbox" then
				if not vRPC.inVehicle(source) then
					local Vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if Vehicle then
						vRPC.AnimActive(source)
						Active[Passport] = os.time() + 100
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close",source)
						TriggerClientEvent("player:syncHoodOptions",source,vehNet,"open")
						vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

						if vTASKBAR.taskMechanic(source) then
							if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
								local Players = vRPC.Players(source)
								for _,v in ipairs(Players) do
									async(function()
										TriggerClientEvent("inventory:repairVehicle",v,vehNet,vehPlate)
									end)
								end
							end
						end

						TriggerClientEvent("player:syncHoodOptions",source,vehNet,"close")
						Player(source)["state"]["Buttons"] = false
						vRPC.stopAnim(source,false)
						Active[Passport] = nil
					end
				end

				goto scapeInventory
			elseif nameItem == "lockpick" and not vRP.checkDamaged(nameItem) then
				if not Player(source)["state"]["Handcuff"] then
					local Vehicle,vehNet,vehPlate,vehName,vehClass = vRPC.vehList(source,4)
					if Vehicle then
						local Brokenpick = 950
						if vehClass == 15 or vehClass == 16 or vehClass == 19 then
							goto scapeInventory
						end

						if vRPC.inVehicle(source) then
							vRPC.AnimActive(source)
							vGARAGE.startAnimHotwired(source)
							Active[Passport] = os.time() + 100
							Player(source)["state"]["Buttons"] = true
							TriggerClientEvent("inventory:Close",source)

							if vTASKBAR.taskLockpick(source) then
								if math.random(100) >= 20 then
									Brokenpick = 900
									TriggerEvent("plateEveryone",vehPlate)
									TriggerEvent("platePlayers",vehPlate,Passport)
									TriggerClientEvent("inventory:vehicleAlarm",source,vehNet,vehPlate)

									local Network = NetworkGetEntityFromNetworkId(vehNet)
									if GetVehicleDoorLockStatus(Network) == 2 then
										SetVehicleDoorsLocked(Network,1)
									end
								end

								if math.random(100) >= 75 then
									local Coords = vRP.getEntityCoords(source)
									local Polices = vRP.numPermission("Police")
									for k,v in pairs(Polices) do
										async(function()
											TriggerClientEvent("NotifyPush",v["source"],{ code = 31, title = "Roubo de Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
										end)
									end
								end
							end

							if math.random(1000) >= Brokenpick then
								if vRP.tryGetInventoryItem(Passport,totalName,1,false) then
									vRP.giveInventoryItem(Passport,"lockpick-0",1,false)
									TriggerClientEvent("itensNotify",source,{ "quebrou","lockpick",1,"Lockpick de Alumínio" })
								end
							end

							Player(source)["state"]["Buttons"] = false
							vGARAGE.stopAnimHotwired(source,vehicle)
							Active[Passport] = nil
						else
							vRPC.AnimActive(source)
							Active[Passport] = os.time() + 100
							Player(source)["state"]["Buttons"] = true
							TriggerClientEvent("inventory:Close",source)
							vRPC.playAnim(source,false,{"missfbi_s4mop","clean_mop_back_player"},true)

							if string.sub(vehPlate,1,4) == "DISM" then
								if vTASKBAR.UpgradeVehicle(source) then
									Brokenpick = 900
									Active[Passport] = os.time() + 30
									TriggerClientEvent("inventory:DisPed",source)
									TriggerClientEvent("Progress",source,"Usando",30000)

									if math.random(100) >= 25 then
										local Coords = vRP.getEntityCoords(source)
										local Polices = vRP.numPermission("Police")
										for k,v in pairs(Polices) do
											async(function()
												TriggerClientEvent("NotifyPush",v["source"],{ code = 31, title = "Roubo de Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
											end)
										end
									end

									repeat
										if os.time() >= parseInt(Active[Passport]) then
											Active[Passport] = nil

											TriggerEvent("plateEveryone",vehPlate)
											TriggerClientEvent("target:Dismantles",source)
											TriggerClientEvent("inventory:vehicleAlarm",source,vehNet,vehPlate)

											local Network = NetworkGetEntityFromNetworkId(vehNet)
											if GetVehicleDoorLockStatus(Network) == 2 then
												SetVehicleDoorsLocked(Network,1)
											end
										end

										Wait(100)
									until Active[Passport] == nil
								end
							else
								if vTASKBAR.taskLockpick(source) then
									Brokenpick = 900

									if math.random(100) >= 75 then
										TriggerEvent("plateEveryone",vehPlate)
										TriggerClientEvent("inventory:vehicleAlarm",source,vehNet,vehPlate)

										local Network = NetworkGetEntityFromNetworkId(vehNet)
										if GetVehicleDoorLockStatus(Network) == 2 then
											SetVehicleDoorsLocked(Network,1)
										end
									end

									if math.random(100) >= 25 then
										local Coords = vRP.getEntityCoords(source)
										local Polices = vRP.numPermission("Police")
										for k,v in pairs(Polices) do
											async(function()
												TriggerClientEvent("NotifyPush",v["source"],{ code = 31, title = "Roubo de Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = vehicleName(vehName).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
											end)
										end
									end
								end
							end

							if math.random(1000) >= Brokenpick then
								if vRP.tryGetInventoryItem(Passport,totalName,1,false) then
									vRP.giveInventoryItem(Passport,"lockpick-0",1,false)
									TriggerClientEvent("itensNotify",source,{ "quebrou","lockpick",1,"Lockpick de Alumínio" })
								end
							end

							Player(source)["state"]["Buttons"] = false
							vRPC.removeObjects(source)
							Active[Passport] = nil
						end
					end
				end

				goto scapeInventory
			elseif nameItem == "blocksignal" then
				if not Player(source)["state"]["Handcuff"] then
					local Vehicle,vehNet,vehPlate = vRPC.vehList(source,4)
					if Vehicle and vRPC.inVehicle(source) then
						if exports["garages"]:vehSignal(vehPlate) == nil then
							vRPC.AnimActive(source)
							vGARAGE.startAnimHotwired(source)
							Active[Passport] = os.time() + 100
							Player(source)["state"]["Buttons"] = true
							TriggerClientEvent("inventory:Close",source)

							if vTASKBAR.taskLockpick(source) then
								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									TriggerClientEvent("Notify",source,"verde","<b>Bloqueador de Sinal</b> instalado.",5000)
									TriggerEvent("signalRemove",vehPlate)
								end
							end

							Player(source)["state"]["Buttons"] = false
							vGARAGE.stopAnimHotwired(source)
							Active[Passport] = nil
						else
							TriggerClientEvent("Notify",source,"amarelo","<b>Bloqueador de Sinal</b> já instalado.",5000)
						end
					end
				end

				goto scapeInventory
			elseif nameItem == "postit" then
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("postit:initPostit",source)

				goto scapeInventory
			elseif nameItem == "dismantle" then
				if not vCLIENT.DismantleStatus(source) then
					if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
						TriggerClientEvent("inventory:Close",source)

						DismantleExperience[Passport] = vRP.GetExperience(Passport,"Dismantly")
						if math.random(100) <= 15 then
							DismantleExperience[Passport] = math.random(1000)
						end

						vCLIENT.Dismantle(source,DismantleExperience[Passport])
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Você possui um contrato ativo.",5000)
				end

				goto scapeInventory
			elseif nameItem == "absolut" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",10000)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.AlcoholTimer(Passport,1)
							vRP.upgradeThirst(Passport,20)
							TriggerClientEvent("setDrunkTime",source,90)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "hennessy" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",10000)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.AlcoholTimer(Passport,1)
							vRP.upgradeThirst(Passport,20)
							TriggerClientEvent("setDrunkTime",source,90)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "chandon" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",10000)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.AlcoholTimer(Passport,1)
							vRP.upgradeThirst(Passport,20)
							TriggerClientEvent("setDrunkTime",source,90)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "dewars" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",10000)
				vRPC.createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.AlcoholTimer(Passport,1)
							vRP.upgradeThirst(Passport,20)
							TriggerClientEvent("setDrunkTime",source,90)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "scanner" then
				vRPC.AnimActive(source)
				Scanners[Passport] = true
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:updateScanner",source,true)
				vRPC.createObjects(source,"mini@golfai","wood_idle_a","w_am_digiscanner",49,18905,0.15,0.1,0.0,-270.0,-180.0,-170.0)

				goto scapeInventory
			elseif nameItem == "orangejuice" or nameItem == "passionjuice" or nameItem == "tangejuice" or nameItem == "grapejuice" or nameItem == "strawberryjuice" or nameItem == "bananajuice" or nameItem == "acerolajuice" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",10000)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeThirst(Passport,50)
							vRP.generateItem(Passport,"emptybottle",1)

							if nameItem == "passionjuice" then
								vRP.downgradeStress(Passport,5)
							end

							if vCLIENT.Restaurant(source,"BurgerShot") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "orange" or nameItem == "apple" or nameItem == "strawberry" or nameItem == "coffee2" or nameItem == "grape" or nameItem == "tange" or nameItem == "banana" or nameItem == "acerola" or nameItem == "passion" or nameItem == "tomato" or nameItem == "mushroom" or nameItem == "guarana" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",10000)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeThirst(Passport,3)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "medicpass" then
				if vRP.hasGroup(Passport,"Paramedic") then
					if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
						vRP.generateItem(Passport,"gauze",3)
						vRP.generateItem(Passport,"medkit",1)
						vRP.generateItem(Passport,"analgesic",4)
						vRP.generateItem(Passport,"dollars",200)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
					end
				end

				goto scapeInventory
			elseif nameItem == "mechanicpass" then
				if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
					vRP.generateItem(Passport,"advtoolbox",1)
					vRP.generateItem(Passport,"toolbox",2)
					vRP.generateItem(Passport,"tyres",4)
					vRP.generateItem(Passport,"dollars",200)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end

				goto scapeInventory
			elseif nameItem == "dessertspass" then
				if vRP.hasGroup(Passport,"UwuCoffee") then
					if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
						vRP.generateItem(Passport,"nigirizushi",3)
						vRP.generateItem(Passport,"sushi",3)
						vRP.generateItem(Passport,"dollars",200)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
					end
				end

				goto scapeInventory
			elseif nameItem == "pizzathispass" then
				if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
					vRP.generateItem(Passport,"cookedmeat",1)
					vRP.generateItem(Passport,"pizzamushroom",1)
					vRP.generateItem(Passport,"pizzamozzarella",1)
					vRP.generateItem(Passport,"cookedfishfillet",1)
					vRP.generateItem(Passport,"dollars",200)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end

				goto scapeInventory
			elseif nameItem == "burgershotpass" then
				if vRP.hasGroup(Passport,"BurgerShot") then
					if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
						vRP.generateItem(Passport,"hamburger2",1)
						vRP.generateItem(Passport,"cookedmeat",2)
						vRP.generateItem(Passport,"cookedfishfillet",1)
						vRP.generateItem(Passport,"dollars",200)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
					end
				end

				goto scapeInventory
			elseif nameItem == "mushroomteaplus" then
				if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
					vRP.setWeights(Passport,10)
					vRP.upgradeThirst(Passport,20)
					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end

				goto scapeInventory
			elseif nameItem == "mushroomtea" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",10000)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Player(source)["state"]["Buttons"] = false
						vRPC.removeObjects(source,"one")
						Active[Passport] = nil

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							TriggerClientEvent("player:MushroomTea",source)
							vRP.upgradeThirst(Passport,20)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "water" or nameItem == "milkbottle" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",10000)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.generateItem(Passport,"emptybottle",1)
							vRP.upgradeThirst(Passport,20)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "guarananatural" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",10000)
				vRPC.createObjects(source,"amb@world_human_drinking@coffee@male@idle_a","idle_c","prop_food_bs_juice02",49,28422,0.0,-0.01,-0.15,0.0,0.0,0.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,10,1.10)
							vRP.upgradeThirst(Passport,25)

							if vCLIENT.Restaurant(source,"BurgerShot") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "sinkalmy" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Tomando",5000)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeThirst(Passport,5)
							vRP.ChemicalTimer(Passport,3)
							vRP.downgradeStress(Passport,20)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "ritmoneury" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Tomando",5000)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeThirst(Passport,5)
							vRP.ChemicalTimer(Passport,3)
							vRP.downgradeStress(Passport,30)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "cola" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",5000)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","prop_ecola_can",49,60309,0.01,0.01,0.05,0.0,0.0,90.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeThirst(Passport,15)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "soda" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",5000)
				vRPC.createObjects(source,"mp_player_intdrink","loop_bottle","ng_proc_sodacan_01b",49,60309,0.0,0.0,-0.04,0.0,0.0,130.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeThirst(Passport,15)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "fishingrod" then
				if vCLIENT.fishingCoords(source) then
					Active[Passport] = os.time() + 100
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)

					if not vCLIENT.fishingAnim(source) then
						vRPC.AnimActive(source)
						vRPC.createObjects(source,"amb@world_human_stand_fishing@idle_a","idle_c","prop_fishing_rod_01",49,60309)
					end

					if vTASKBAR.taskFishing(source) then
						local Members = exports["vrp"]:Party(Passport,source,10)
						local fishList = { "octopus","shrimp","carp","horsefish","tilapia","codfish","catfish" }

						if parseInt(#Members) >= 4 then
							fishList = { "octopus","shrimp","carp","horsefish","tilapia","codfish","catfish","goldenfish","pirarucu","pacu","tambaqui" }
						end

						local fishRandom = math.random(#fishList)
						local fishSelects = fishList[fishRandom]

						if (vRP.inventoryWeight(Passport) + itemWeight(fishSelects)) <= vRP.getWeights(Passport) then
							if vRP.tryGetInventoryItem(Passport,"bait",1,false) then
								vRP.generateItem(Passport,fishSelects,1,true)
							else
								TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("bait").."</b>.",5000)
							end
						else
							TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
						end
					end

					Player(source)["state"]["Buttons"] = false
					Active[Passport] = nil
				end

				goto scapeInventory
			elseif nameItem == "coffee" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",5000)
				vRPC.createObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeThirst(Passport,15)

							if vCLIENT.Restaurant(source,"BeanMachine") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "coffeemilk" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Bebendo",5000)
				vRPC.createObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,10,1.10)
							vRP.upgradeThirst(Passport,20)
							vRP.upgradeHunger(Passport,8)

							if vCLIENT.Restaurant(source,"BeanMachine") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "pizzamozzarella" or nameItem == "pizzamushroom" or nameItem == "pizzabanana" or nameItem == "pizzachocolate" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							if nameItem == "pizzamozzarella" then
								vRP.upgradeHunger(Passport,40)
							elseif nameItem == "pizzamushroom" then
								vRP.upgradeHunger(Passport,40)
							elseif nameItem == "pizzabanana" then
								vRP.upgradeHunger(Passport,40)
							elseif nameItem == "pizzachocolate" then
								vRP.upgradeHunger(Passport,30)
							end

							if vCLIENT.Restaurant(source,"PizzaThis") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "sushi" or nameItem == "nigirizushi" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							if nameItem == "sushi" then
								vRP.upgradeHunger(Passport,30)
							elseif nameItem == "nigirizushi" then
								vRP.upgradeHunger(Passport,25)
							end

							if vCLIENT.Restaurant(source,"UwuCoffee") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "calzone" or nameItem == "chickenfries" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeHunger(Passport,30)

							if vCLIENT.Restaurant(source,"PizzaThis") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "cookies" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.upgradeHunger(Passport,30)

							if vCLIENT.Restaurant(source,"UwuCoffee") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Luck",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "onionrings" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeHunger(Passport,30)

							if vCLIENT.Restaurant(source,"BurgerShot") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "hamburger" or nameItem == "hamburger2" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							if nameItem == "hamburger" then
								vRP.upgradeHunger(Passport,15)
							elseif nameItem == "hamburger2" then
								vRP.upgradeHunger(Passport,50)
							end

							if vCLIENT.Restaurant(source,"BurgerShot") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "cannedsoup" or nameItem == "canofbeans" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Tomando",5000)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.stopAnim(source,false)
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeHunger(Passport,20)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "tablecoke" then
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)

				local Hash = "bkr_prop_coke_table01a"
				local application,Coords,heading = vRPC.objectCoords(source,Hash)
				if application then
					if not vCLIENT.objectExist(source,Coords,Hash) then
						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = heading, object = Hash, item = totalName, Distance = 50, mode = "1" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						end
					end
				end

				Player(source)["state"]["Buttons"] = false

				goto scapeInventory
			elseif nameItem == "tablemeth" then
				-- local Hash = "prop_yoga_mat_01"
				-- local application,Coords,heading = vRPC.objectCoords(source,Hash)
				-- if application then
				-- 	print(Coords,heading)
				-- end

				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)

				local Hash = "bkr_prop_meth_table01a"
				local application,Coords,heading = vRPC.objectCoords(source,Hash)
				if application then
					if not vCLIENT.objectExist(source,Coords,Hash) then
						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = totalName, Distance = 50, mode = "1" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						end
					end
				end

				Player(source)["state"]["Buttons"] = false

				goto scapeInventory
			elseif nameItem == "tableweed" then
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)

				local Hash = "bkr_prop_weed_table_01a"
				local application,Coords,heading = vRPC.objectCoords(source,Hash)
				if application then
					if not vCLIENT.objectExist(source,Coords,Hash) then
						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = totalName, Distance = 50, mode = "1" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						end
					end
				end

				Player(source)["state"]["Buttons"] = false

				goto scapeInventory
			elseif nameItem == "sprays01" then
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)

				local Hash = "spray_01"
				local Application,Coords,Heading = vRPC.objectCoords(source,Hash)
				if Application then
					vRPC.AnimActive(source)
					Active[Passport] = os.time() + 5
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("Progress",source,"Pichando",5000)
					vRPC.createObjects(source,"switch@franklin@lamar_tagging_wall","lamar_tagging_exit_loop_lamar","prop_cs_spray_can",1,28422,0.0,0.0,0.0,0.0,0.0,0.0)

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.removeObjects(source)

							if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
								local Number = 0

								repeat
									Number = Number + 1
								until Objects[tostring(Number)] == nil

								Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(Heading), object = Hash, item = totalName, Distance = 100, mode = "Spray" }
								TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
							end
						end

						Wait(100)
					until Active[Passport] == nil
				end

				Player(source)["state"]["Buttons"] = false

				goto scapeInventory
			elseif nameItem == "campfire" then
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)

				local Hash = "prop_beach_fire"
				local application,Coords,heading = vRPC.objectCoords(source,Hash)
				if application then
					if not vCLIENT.objectExist(source,Coords,Hash) then
						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]) + 0.10, h = mathLength(heading), object = Hash, item = totalName, Distance = 50, mode = "2" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						end
					end
				end

				Player(source)["state"]["Buttons"] = false

				goto scapeInventory
			elseif nameItem == "barrier" then
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)

				local Hash = "prop_mp_barrier_02b"
				local application,Coords,heading = vRPC.objectCoords(source,Hash)
				if application then
					if not vCLIENT.objectExist(source,Coords,Hash) then
						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = totalName, Distance = 100, mode = "3" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						end
					end
				end

				Player(source)["state"]["Buttons"] = false

				goto scapeInventory
			elseif nameItem == "medicbag" then
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)

				local Hash = "xm_prop_x17_bag_med_01a"
				local application,Coords,heading = vRPC.objectCoords(source,Hash)
				if application then
					if not vCLIENT.objectExist(source,Coords,Hash) then
						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = totalName, Distance = 50, mode = "4" }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
						end
					end
				end

				Player(source)["state"]["Buttons"] = false

				goto scapeInventory
			elseif nameItem == "weedclone" then
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)

				local Hash = "bkr_prop_weed_med_01a"
				local Application,Coords = vRPC.objectCoords(source,Hash)
				if Application then
					if not vCLIENT.objectExist(source,Coords,Hash) then
						if vRP.tryGetInventoryItem(Passport,totalName,1,false,Slot) then
							vRPC.playAnim(source,false,{"amb@prop_human_bum_bin@base","base"},true)

							if vTASKBAR.Weeds(source) then
								local Points = 0
								local Route = GetPlayerRoutingBucket(source)

								if splitName[2] ~= nil then
									Points = parseInt(splitName[2])
								end

								exports["plants"]:Plants(Coords,Route,Points)
							end

							vRPC.removeObjects(source)
						end
					end
				end

				Player(source)["state"]["Buttons"] = false

				goto scapeInventory
			elseif nameItem == "medicbed" then
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)

				local Hash = "prop_ld_binbag_01"
				local application,Coords,heading = vRPC.objectCoords(source,Hash)
				if application then
					if not vCLIENT.objectExist(source,Coords,Hash) then
						local spawnObjects = 0
						local mHash = GetHashKey(Hash)
						local Object = CreateObject(mHash,Coords["x"],Coords["y"],Coords["z"] - 0.86,true,true,false)

						while not DoesEntityExist(Object) and spawnObjects <= 1000 do
							spawnObjects = spawnObjects + 1
							Wait(1)
						end

						if DoesEntityExist(Object) then
							SetEntityHeading(Object,heading)
							FreezeEntityPosition(Object,true)
						end
					end
				end

				Player(source)["state"]["Buttons"] = false

				goto scapeInventory
			elseif nameItem == "c4" then
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)

				local Hash = "ch_prop_ch_ld_bomb_01a"
				local Application,Coords,Heading = vRPC.objectCoords(source,Hash)
				if Application then
					local CoordsAtm,NumberAtm = vCLIENT.checkAtm(source,Coords)

					if CoordsAtm then
						if atmTimers[NumberAtm] == nil then
							atmTimers[NumberAtm] = os.time()
						end

						if os.time() < atmTimers[NumberAtm] then
							local Cooldown = parseInt(atmTimers[NumberAtm] - os.time())
							TriggerClientEvent("Notify",source,"azul","Caixa vazio, aguarde <b>"..Cooldown.."</b> segundos até que um transportador venha até o local efetuar reabastecimento do mesmo.",5000)
							Player(source)["state"]["Buttons"] = false

							goto scapeInventory
						end

						local Polices = vRP.numPermission("Police")
						if parseInt(#Polices) <= 5 then
							TriggerClientEvent("Notify",source,"azul","Caixa vazio, aguarde até que um transportador venha até o local efetuar reabastecimento do mesmo.",5000)
							Player(source)["state"]["Buttons"] = false

							goto scapeInventory
						end

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							local Number = 0

							repeat
								Number = Number + 1
							until Objects[tostring(Number)] == nil

							Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(Heading), object = Hash, item = totalName, Distance = 100 }
							TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
							TriggerClientEvent("Progress",source,"Plantando",25000)
							Player(source)["state"]["Buttons"] = false
							atmTimers[NumberAtm] = os.time() + 10800
							local explosionProgress = 25

							for k,v in pairs(Polices) do
								async(function()
									vRPC.playSound(v["source"],"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
									TriggerClientEvent("NotifyPush",v["source"],{ code = 20, title = "Caixa Eletrônico", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
								end)
							end

							repeat
								Wait(1000)
								explosionProgress = explosionProgress - 1
							until explosionProgress <= 0

							TriggerEvent("inventory:DropServer",CoordsAtm,"dollars",math.random(2500,5000))
							TriggerClientEvent("player:Residuals",source,"Resíduo de Explosivo.")
							TriggerClientEvent("objects:Remover",-1,tostring(Number))
							TriggerClientEvent("vRP:Explosion",source,Coords)
							TriggerEvent("Wanted",source,Passport,600)
						end
					end
				else
					Player(source)["state"]["Buttons"] = true
				end

				goto scapeInventory
			elseif nameItem == "carp" or nameItem == "codfish" or nameItem == "catfish" or nameItem == "goldenfish" or nameItem == "horsefish" or nameItem == "tilapia" or nameItem == "pacu" or nameItem == "pirarucu" or nameItem == "tambaqui" then
				if (vRP.inventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.getWeights(Passport) then
					if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
						vRP.generateItem(Passport,"fishfillet",2)
						TriggerClientEvent("inventory:Update",source,"updateMochila")
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end

				goto scapeInventory
			elseif nameItem == "cookedfishfillet" or nameItem == "cookedmeat" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.playAnim(source,true,{"mp_player_inteat@burger","mp_player_int_eat_burger"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.stopAnim(source,false)
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							if nameItem == "cookedfishfillet" then
								vRP.upgradeHunger(Passport,20)
							else
								vRP.upgradeHunger(Passport,30)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "hotdog" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.createObjects(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_hotdog_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeHunger(Passport,10)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "sandwich" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_sandwich_01",49,18905,0.13,0.05,0.02,-50.0,16.0,60.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeHunger(Passport,10)

							if vCLIENT.Restaurant(source,"BeanMachine") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "tacos" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_taco_01",49,18905,0.16,0.06,0.02,-50.0,220.0,60.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeHunger(Passport,15)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "fries" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_food_bs_chips",49,18905,0.10,0.0,0.08,150.0,320.0,160.0)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeHunger(Passport,10)

							if vCLIENT.Restaurant(source,"BurgerShot") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "milkshake" or nameItem == "cappuccino" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Tomando",5000)
				vRPC.createObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeThirst(Passport,15)

							if vCLIENT.Restaurant(source,"UwuCoffee") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "applelove" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.upgradeHunger(Passport,10)

							if vCLIENT.Restaurant(source,"UwuCoffee") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "cupcake" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.upgradeHunger(Passport,10)

							if vCLIENT.Restaurant(source,"UwuCoffee") then
								TriggerEvent("inventory:BuffServer",source,Passport,"Dexterity",600)
							end
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "marshmallow" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 3
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",3000)
				vRPC.playAnim(source,true,{"mp_suicide","pill"},true)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source)
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeHunger(Passport,5)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "chocolate" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							vRP.upgradeHunger(Passport,8)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "donut" then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Comendo",5000)
				vRPC.createObjects(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_amb_donut",49,28422)

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.removeObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
							TriggerClientEvent("setEnergetic",source,20,1.10)
							vRP.upgradeHunger(Passport,8)
						end
					end

					Wait(100)
				until Active[Passport] == nil

				goto scapeInventory
			elseif nameItem == "notepad" then
				if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("notepad:createNotepad",source)
				end

				goto scapeInventory
			elseif nameItem == "megaphone" then
				TriggerClientEvent("player:Megaphone",source)
				TriggerClientEvent("pma-voice:Megaphone",source,true)
				TriggerEvent("pma-voice:Megaserver",source,true)
				TriggerClientEvent("emotes",source,"megaphone")

				goto scapeInventory
			elseif nameItem == "notebook" then
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("notebook:openSystem",source)

				goto scapeInventory
			elseif nameItem == "tyres" then
				if not vRPC.inVehicle(source) then
					if not vCLIENT.checkWeapon(source,"WEAPON_WRENCH") then
						TriggerClientEvent("Notify",source,"amarelo","<b>Chave Inglesa</b> não encontrada.",5000)
						goto scapeInventory
					end

					local tyreStatus,Tyre,vehNet,vehPlate = vCLIENT.tyreStatus(source)
					if tyreStatus then
						local Vehicle = NetworkGetEntityFromNetworkId(vehNet)
						if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
							if vCLIENT.tyreHealth(source,vehNet,Tyre) ~= 1000.0 then
								vRPC.AnimActive(source)
								Active[Passport] = os.time() + 100
								Player(source)["state"]["Buttons"] = true
								TriggerClientEvent("inventory:Close",source)
								vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

								if vTASKBAR.taskTyre(source) then
									if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
										local Players = vRPC.Players(source)
										for _,v in ipairs(Players) do
											async(function()
												TriggerClientEvent("inventory:repairTyre",v,vehNet,Tyre,vehPlate)
											end)
										end
									end
								end

								Player(source)["state"]["Buttons"] = false
								vRPC.stopAnim(source,false)
								Active[Passport] = nil
							end
						end
					end
				end

				goto scapeInventory
			elseif nameItem == "premiumplate" then
				if vRPC.inVehicle(source) then
					TriggerClientEvent("inventory:Close",source)

					local vehModel = vRPC.vehicleName(source)
					local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehModel })
					if vehicle[1] then
						local Keyboard = vKEYBOARD.keySingle(source,"Placa: (8 Caracteres)")
						if Keyboard then
							local namePlate = string.sub(Keyboard[1],1,8)
							local plateCheck = sanitizeString(namePlate,"abcdefghijklmnopqrstuvwxyz0123456789",true)

							if string.len(plateCheck) ~= 8 then
								TriggerClientEvent("Notify",source,"amarelo","O nome de definição para a placa inválida.",5000)
								goto scapeInventory
							else
								if vRP.PassportPlate(namePlate) then
									TriggerClientEvent("Notify",source,"vermelho","A placa escolhida já possui em outro veículo.",5000)
									goto scapeInventory
								else
									if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
										vRP.Execute("vehicles/plateVehiclesUpdate",{ Passport = Passport, vehicle = vehModel, plate = string.upper(namePlate) })
										TriggerClientEvent("Notify",source,"verde","Placa atualizada.",5000)
									end
								end
							end
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Modelo de veículo não encontrado.",5000)
					end
				end

				goto scapeInventory
			elseif nameItem == "radio" then
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("hud:RadioNui",source)
				vRPC.AnimActive(source)

				goto scapeInventory
			elseif nameItem == "scuba" then
				TriggerClientEvent("hud:Scuba",source)

				goto scapeInventory
			elseif nameItem == "handcuff" then
				if not vRPC.inVehicle(source) then
					local ClosestPed = vRPC.ClosestPed(source,1)
					if ClosestPed then
						Player(source)["state"]["Cancel"] = true
						Player(source)["state"]["Buttons"] = true

						if Player(ClosestPed)["state"]["Handcuff"] then
							Player(ClosestPed)["state"]["Handcuff"] = false
							Player(ClosestPed)["state"]["Commands"] = false
							TriggerClientEvent("sounds:Private",source,"uncuff",0.5)
							TriggerClientEvent("sounds:Private",ClosestPed,"uncuff",0.5)

							vRPC.removeObjects(ClosestPed)
						else
							TriggerClientEvent("hud:RadioClean",ClosestPed)
							TriggerClientEvent("player:playerCarry",ClosestPed,source,"handcuff")
							vRPC.playAnim(source,false,{"mp_arrest_paired","cop_p2_back_left"},false)
							vRPC.playAnim(ClosestPed,false,{"mp_arrest_paired","crook_p2_back_left"},false)

							Wait(3500)

							vRPC.removeObjects(source)
							Player(ClosestPed)["state"]["Handcuff"] = true
							Player(ClosestPed)["state"]["Commands"] = true
							TriggerClientEvent("inventory:Close",ClosestPed)
							TriggerClientEvent("sounds:Private",source,"cuff",0.5)
							TriggerClientEvent("sounds:Private",ClosestPed,"cuff",0.5)
							TriggerClientEvent("player:playerCarry",ClosestPed,source)
						end

						Player(source)["state"]["Cancel"] = false
						Player(source)["state"]["Buttons"] = false
					end
				end

				goto scapeInventory
			elseif nameItem == "hood" then
				local ClosestPed = vRPC.ClosestPed(source,2)
				if ClosestPed then
					if Player(ClosestPed)["state"]["Handcuff"] then
						TriggerClientEvent("hud:toggleHood",ClosestPed)
						TriggerClientEvent("inventory:Close",ClosestPed)
					end
				end

				goto scapeInventory
			elseif nameItem == "rope" then
				if not vRPC.inVehicle(source) then
					if Carry[Passport] then
						TriggerClientEvent("player:ropeCarry",Carry[Passport],source)
						TriggerClientEvent("player:Commands",Carry[Passport],false)
						vRPC.removeObjects(Carry[Passport])
						vRPC.removeObjects(source)
						Carry[Passport] = nil
					else
						local ClosestPed = vRPC.ClosestPed(source,2)
						if ClosestPed then
							if vRP.getHealth(ClosestPed) <= 100 or Player(ClosestPed)["state"]["Handcuff"] then
								Carry[Passport] = ClosestPed

								TriggerClientEvent("player:ropeCarry",Carry[Passport],source)
								TriggerClientEvent("player:Commands",Carry[Passport],true)
								TriggerClientEvent("inventory:Close",Carry[Passport])

								vRPC.playAnim(source,true,{"missfinale_c2mcs_1","fin_c2_mcs_1_camman"},true)
								vRPC.playAnim(ClosestPed,false,{"nm","firemans_carry"},true)
							end
						end
					end
				end

				goto scapeInventory
			elseif nameItem == "rolepass" then
				if not vRP.CheckRolepass(source) then
					if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
						TriggerEvent("vRP:ActivePass",source)
					end
				end

				goto scapeInventory
			elseif nameItem == "premium" then
				if not vRP.UserPremium(Passport) then
					if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						TriggerEvent("Salary:Add",Passport,"Premium")
						vRP.SetPremium(source)
					end
				else
					if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
						TriggerClientEvent("inventory:Update",source,"updateMochila")
						TriggerEvent("Salary:Add",Passport,"Premium")
						vRP.UpgradePremium(Passport)
					end
				end

				goto scapeInventory
			elseif nameItem == "pager" then
				local ClosestPed = vRPC.ClosestPed(source,2)
				if ClosestPed then
					if Player(ClosestPed)["state"]["Handcuff"] then
						local OtherPassport = vRP.Passport(ClosestPed)
						if OtherPassport then
							if vRP.hasGroup(OtherPassport,"Ranger") then
								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									vRP.removePermission(OtherPassport,"Police")
									TriggerEvent("blipsystem:Exit",ClosestPed)
									Player(ClosestPed)["state"]["Police"] = false
									TriggerClientEvent("hud:RadioClean",ClosestPed)

									vRP.remPermission(OtherPassport,"Ranger")
									vRP.setPermission(OtherPassport,"waitRanger")

									TriggerEvent("Salary:Remove",OtherPassport,"Emergency")
									TriggerClientEvent("service:Label",ClosestPed,"Ranger","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end

							if vRP.hasGroup(OtherPassport,"State") then
								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									vRP.removePermission(OtherPassport,"Police")
									TriggerEvent("blipsystem:Exit",ClosestPed)
									Player(ClosestPed)["state"]["Police"] = false
									TriggerClientEvent("hud:RadioClean",ClosestPed)

									vRP.remPermission(OtherPassport,"State")
									vRP.setPermission(OtherPassport,"waitState")

									TriggerEvent("Salary:Remove",OtherPassport,"Emergency")
									TriggerClientEvent("service:Label",ClosestPed,"State","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end

							if vRP.hasGroup(OtherPassport,"Lspd") then
								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									vRP.removePermission(OtherPassport,"Police")
									TriggerEvent("blipsystem:Exit",ClosestPed)
									Player(ClosestPed)["state"]["Police"] = false

									vRP.remPermission(OtherPassport,"Lspd")
									vRP.setPermission(OtherPassport,"waitLspd")

									TriggerClientEvent("hud:RadioClean",ClosestPed)
									TriggerEvent("Salary:Remove",OtherPassport,"Emergency")
									TriggerClientEvent("service:Label",ClosestPed,"Lspd","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end

							if vRP.hasGroup(OtherPassport,"Sheriff") then
								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									vRP.removePermission(OtherPassport,"Police")
									TriggerEvent("blipsystem:Exit",ClosestPed)
									Player(ClosestPed)["state"]["Police"] = false
									TriggerClientEvent("hud:RadioClean",ClosestPed)

									vRP.remPermission(OtherPassport,"Sheriff")
									vRP.setPermission(OtherPassport,"waitSheriff")

									TriggerEvent("Salary:Remove",OtherPassport,"Emergency")
									TriggerClientEvent("service:Label",ClosestPed,"Sheriff","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end

							if vRP.hasGroup(OtherPassport,"Corrections") then
								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									vRP.removePermission(OtherPassport,"Police")
									TriggerEvent("blipsystem:Exit",ClosestPed)
									Player(ClosestPed)["state"]["Police"] = false
									TriggerClientEvent("hud:RadioClean",ClosestPed)

									vRP.remPermission(OtherPassport,"Corrections")
									vRP.setPermission(OtherPassport,"waitCorrections")

									TriggerEvent("Salary:Remove",OtherPassport,"Emergency")
									TriggerClientEvent("service:Label",ClosestPed,"Corrections","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end

							if vRP.hasGroup(OtherPassport,"Paramedic") then
								if vRP.tryGetInventoryItem(Passport,totalName,1,true,Slot) then
									vRP.removePermission(Passport,"Paramedic")
									TriggerEvent("blipsystem:Exit",ClosestPed)
									TriggerClientEvent("hud:RadioClean",ClosestPed)

									vRP.remPermission(OtherPassport,"Paramedic")
									vRP.setPermission(OtherPassport,"waitParamedic")

									TriggerEvent("Salary:Remove",OtherPassport,"Emergency")
									TriggerClientEvent("service:Label",ClosestPed,"Paramedic","Entrar em Serviço",5000)
									TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
								end
							end
						end
					end
				end

				goto scapeInventory
			end
		end
	end

	::scapeInventory::
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SAVETEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:saveTemporary",function(Passport)
	if invTemp[Passport] == nil then
		invTemp[Passport] = {
			["Ammos"] = Ammos[Passport],
			["Attachs"] = Attachs[Passport]
		}

		Attachs[Passport] = {
			["WEAPON_COMBATPISTOL"] = {
				["attachsFlashlight"] = true
			},
			["WEAPON_PISTOL_MK2"] = {
				["attachsFlashlight"] = true,
				["attachsCrosshair"] = true
			}
		}

		Ammos[Passport] = {
			["WEAPON_PISTOL_AMMO"] = 250
		}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYTEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:applyTemporary",function(Passport)
	if invTemp[Passport] then
		Ammos[Passport] = invTemp[Passport]["Ammos"]
		Attachs[Passport] = invTemp[Passport]["Attachs"]
		invTemp[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] ~= nil then
			Active[Passport] = nil
			vGARAGE.updateHotwired(source,false)
			Player(source)["state"]["Buttons"] = false
			TriggerClientEvent("Progress",source,"Cancelando",1000)

			if verifyObjects[Passport] then
				local Model = verifyObjects[Passport][1]
				local hash = verifyObjects[Passport][2]

				if Trashs[Model] then
					if Trashs[Model][hash] then
						Trashs[Model][hash] = nil
					end
				end

				verifyObjects[Passport] = nil
			end

			if verifyAnimals[Passport] then
				local Model = verifyAnimals[Passport][1]

				if Animals[Model] then
					local netObjects = verifyAnimals[Passport][2]

					if Animals[Model][netObjects] then
						Animals[Model][netObjects] = Animals[Model][netObjects] - 1
						verifyAnimals[Passport] = nil
					end
				end
			end

			if Loots[Passport] then
				local myLoots = Loots[Passport]

				if Boxes[myLoots] then
					if Boxes[myLoots][Passport] then
						Boxes[myLoots][Passport] = nil
					end
				end

				Loots[Passport] = nil
			end
		end

		if Carry[Passport] then
			TriggerClientEvent("player:ropeCarry",Carry[Passport],source)
			TriggerClientEvent("player:Commands",Carry[Passport],false)
			vRPC.removeObjects(Carry[Passport])
			Carry[Passport] = nil
		end

		if Scanners[Passport] then
			TriggerClientEvent("inventory:updateScanner",source,false)
			Player(source)["state"]["Buttons"] = false
			Scanners[Passport] = nil
		end

		vRPC.removeObjects(source)

		if GetPlayerRoutingBucket(source) > 900000 then
			TriggerEvent("arena:Cancel",source,Passport)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkInventory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] ~= nil then
			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.verifyWeapon(Item,Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not vRP.consultItem(Passport,Item,1) then
			local wHash = itemAmmo(Item)

			if wHash ~= nil then
				if Ammos[Passport][wHash] then
					Ammos[Passport][wHash] = parseInt(Ammo)

					if Attachs[Passport][Item] ~= nil then
						for nameAttachs,_ in pairs(Attachs[Passport][Item]) do
							vRP.generateItem(Passport,nameAttachs,1)
						end

						Attachs[Passport][Item] = nil
					end

					if Ammos[Passport][wHash] > 0 then
						vRP.generateItem(Passport,wHash,Ammos[Passport][wHash])
						Ammos[Passport][wHash] = nil
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end

			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXISTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.existWeapon(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not vRP.consultItem(Passport,Item,1) then
			local wHash = itemAmmo(Item)

			if wHash ~= nil then
				if Ammos[Passport][wHash] then
					if Attachs[Passport][Item] ~= nil then
						for nameAttachs,_ in pairs(Attachs[Passport][Item]) do
							vRP.generateItem(Passport,nameAttachs,1)
						end

						Attachs[Passport][Item] = nil
					end

					if Ammos[Passport][wHash] > 0 then
						vRP.generateItem(Passport,wHash,Ammos[Passport][wHash])
						Ammos[Passport][wHash] = nil
					end

					TriggerClientEvent("inventory:Update",source,"updateMochila")
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.dropWeapons(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item ~= nil then
		if not vRP.consultItem(Passport,Item,1) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETHROWING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeThrowing(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item ~= nil then
		vRP.tryGetInventoryItem(Passport,Item,1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.preventWeapon(Item,Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local wHash = itemAmmo(Item)

		if wHash ~= nil then
			if Ammos[Passport][wHash] then
				if Ammo > 0 then
					Ammos[Passport][wHash] = Ammo
				else
					Ammos[Passport][wHash] = nil
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:CleanWeapons",function(Passport)
	if Ammos[Passport] then
		Ammos[Passport] = {}
		Attachs[Passport] = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:verifyObjects")
AddEventHandler("inventory:verifyObjects",function(Entity,Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil then
		if Service == "Lixeiro" then
			if not vRPC.lastVehicle(source,"trash") then
				TriggerClientEvent("Notify",source,"amarelo","Precisa utilizar o veículo do <b>Lixeiro</b>.",3000)
				return
			end
		end

		if Entity[1] ~= nil and Entity[2] ~= nil and Entity[4] ~= nil then
			local hash = Entity[1]
			local Model = Entity[2]
			local Coords = Entity[4]

			if verifyObjects[Passport] == nil then
				if Trashs[Model] == nil then
					Trashs[Model] = {}
				end

				for k,v in pairs(Trashs[Model]) do
					if #(v["Coords"] - Coords) <= 0.75 and os.time() <= v["timer"] then
						local Cooldown = parseInt(v["timer"] - os.time())
						TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Cooldown.."</b> segundos.",5000)
						return
					end
				end

				Active[Passport] = os.time() + 5
				TriggerClientEvent("Progress",source,"Vasculhando",5000)
				vRPC.playAnim(source,false,{"amb@prop_human_bum_bin@base","base"},true)

				verifyObjects[Passport] = { Model,hash }
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				Trashs[Model][hash] = { ["Coords"] = Coords, ["timer"] = os.time() + 3600 }

				repeat
					if os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.stopAnim(source,false)
						Player(source)["state"]["Buttons"] = false

						local itemSelect = { "",1 }

						if Service == "Lixeiro" then
							local randItem = math.random(90)
							if parseInt(randItem) >= 61 and parseInt(randItem) <= 70 then
								itemSelect = { "metalcan",math.random(2) }
							elseif parseInt(randItem) >= 51 and parseInt(randItem) <= 60 then
								itemSelect = { "battery",math.random(2) }
							elseif parseInt(randItem) >= 41 and parseInt(randItem) <= 50 then
								itemSelect = { "elastic",math.random(2) }
							elseif parseInt(randItem) >= 21 and parseInt(randItem) <= 40 then
								itemSelect = { "plasticbottle",math.random(2) }
							elseif parseInt(randItem) <= 20 then
								itemSelect = { "glassbottle",math.random(2) }
							end
						end

						if itemSelect[1] == "" then
							TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
						else
							if (vRP.inventoryWeight(Passport) + itemWeight(itemSelect[1]) * itemSelect[2]) <= vRP.getWeights(Passport) then
								vRP.generateItem(Passport,itemSelect[1],itemSelect[2],true)
								vRP.upgradeStress(Passport,1)
							else
								TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
								Trashs[Model][hash] = nil
							end
						end

						verifyObjects[Passport] = nil
					end

					Wait(100)
				until Active[Passport] == nil
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:LOOTSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:lootSystem")
AddEventHandler("inventory:lootSystem",function(Entity,Service)
	local source = source
	local Entity = tostring(Entity)
	local Passport = vRP.Passport(source)
	if Passport and LootItens[Service] then
		if Loots[Passport] == nil and Active[Passport] == nil then
			if Boxes[Entity] == nil then
				Boxes[Entity] = {}
			end

			if Boxes[Entity][Passport] then
				if os.time() <= Boxes[Entity][Passport] then
					local Cooldown = parseInt(Boxes[Entity][Passport] - os.time())
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Cooldown.."</b> segundos.",5000)
					return
				end
			end

			if Objects[Entity]["perm"] then
				if not vRP.hasGroup(Passport,Objects[Entity]["perm"]) then
					return
				end
			end

			Loots[Passport] = Entity
			Active[Passport] = os.time() + 5
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Vasculhando",5000)
			Boxes[Entity][Passport] = os.time() + LootItens[Service]["cooldown"]
			vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

			repeat
				if os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.stopAnim(source,false)
					Player(source)["state"]["Buttons"] = false

					local randItem = math.random(#LootItens[Service]["list"])
					local randAmount = math.random(LootItens[Service]["list"][randItem]["min"],LootItens[Service]["list"][randItem]["max"])
					local itemSelect = { LootItens[Service]["list"][randItem]["item"],randAmount }

					if (vRP.inventoryWeight(Passport) + itemWeight(itemSelect[1]) * itemSelect[2]) <= vRP.getWeights(Passport) then
						vRP.generateItem(Passport,itemSelect[1],itemSelect[2],true)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
						Boxes[Entity][Passport] = nil
					end

					Loots[Passport] = nil
				end

				Wait(100)
			until Active[Passport] == nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:applyPlate")
AddEventHandler("inventory:applyPlate",function(Entity)
	local source = source
	local consultItem = {}
	local vehPlate = Entity[1]
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil then
		if Plates[vehPlate] == nil then
			consultItem = vRP.getInventoryItemAmount(Passport,"plate")
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("plate").."</b>.",5000)
				return
			end
		end

		local consultPliers = vRP.getInventoryItemAmount(Passport,"pliers")
		if consultPliers[1] <= 0 then
			TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("pliers").."</b>.",5000)
			return
		end

		if Plates[vehPlate] ~= nil then
			if os.time() < Plates[vehPlate][1] then
				local plateTimers = parseInt(Plates[vehPlate][1] - os.time())
				if plateTimers ~= nil then
					TriggerClientEvent("Notify",source,"azul","Aguarde "..CompleteTimers(plateTimers)..".",5000)
				end

				return
			end
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress",source,"Trocando",10000)
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.stopAnim(source,false)
				Player(source)["state"]["Buttons"] = false

				if Plates[vehPlate] == nil then
					if vRP.tryGetInventoryItem(Passport,consultItem[2],1,true) then
						local newPlate = vRP.generatePlate()
						TriggerEvent("plateEveryone",newPlate)
						Plates[newPlate] = { os.time() + 3600,vehPlate }

						local Network = NetworkGetEntityFromNetworkId(Entity[4])
						if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
							SetVehicleNumberPlateText(Network,newPlate)
						end
					end
				else
					local Network = NetworkGetEntityFromNetworkId(Entity[4])
					if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
						SetVehicleNumberPlateText(Network,Plates[vehPlate][2])
					end

					if math.random(100) >= 50 then
						vRP.generateItem(Passport,"plate",1,true)
					else
						TriggerClientEvent("Notify",source,"azul","Após remove-la a mesma quebrou.",5000)
					end

					TriggerEvent("plateReveryone",vehPlate)
					Plates[vehPlate] = nil
				end
			end

			Wait(100)
		until Active[Passport] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:stealTrunk")
AddEventHandler("inventory:stealTrunk",function(Entity)
	local source = source
	local vehNet = Entity[4]
	local vehPlate = Entity[1]
	local vehModels = Entity[2]
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil then
		if not vCLIENT.checkWeapon(source,"WEAPON_CROWBAR") then
			TriggerClientEvent("Notify",source,"amarelo","<b>Pé de Cabra</b> não encontrado.",5000)
			goto scapeInventory
		end

		if not vRP.PassportPlate(vehPlate) then
			if Trunks[vehPlate] == nil then
				Trunks[vehPlate] = os.time()
			end

			if os.time() >= Trunks[vehPlate] then
				vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
				Active[Passport] = os.time() + 100

				if vTASKBAR.stealTrunk(source) then
					Active[Passport] = os.time() + 20
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("Progress",source,"Vasculhando",20000)
					TriggerClientEvent("player:Residuals",source,"Resíduo de Ferro.")
					TriggerClientEvent("player:syncDoorsOptions",source,vehNet,"open")

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.stopAnim(source,false)
							Player(source)["state"]["Buttons"] = false
							TriggerClientEvent("player:syncDoorsOptions",source,vehNet,"close")

							if os.time() >= Trunks[vehPlate] then
								local randItens = math.random(#StealItens)
								if math.random(250) <= StealItens[randItens]["rand"] then
									local randAmounts = math.random(StealItens[randItens]["min"],StealItens[randItens]["max"])

									if (vRP.inventoryWeight(Passport) + itemWeight(StealItens[randItens]["item"]) * randAmounts) <= vRP.getWeights(Passport) then
										vRP.generateItem(Passport,StealItens[randItens]["item"],randAmounts,true)
										Trunks[vehPlate] = os.time() + 3600
										vRP.upgradeStress(Passport,2)
									else
										TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
									end
								else
									TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
									Trunks[vehPlate] = os.time() + 3600
								end
							end
						end

						Wait(100)
					until Active[Passport] == nil
				else
					TriggerClientEvent("inventory:vehicleAlarm",source,vehNet,vehPlate)
					vRPC.stopAnim(source,false)
					Active[Passport] = nil

					local Coords = vRP.getEntityCoords(source)
					local Polices = vRP.numPermission("Police")
					for k,v in pairs(Polices) do
						async(function()
							TriggerClientEvent("NotifyPush",v["source"],{ code = 31, title = "Roubo de Veículo", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = vehicleName(vehModels).." - "..vehPlate, time = "Recebido às "..os.date("%H:%M"), blipColor = 44 })
						end)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Veículo protegido pela seguradora.",1000)
		end
	end

	::scapeInventory::
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Animals")
AddEventHandler("inventory:Animals",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Entity[2] ~= nil and Entity[3] ~= nil then
			local nameItem = "switchblade"
			local consultItem = vRP.getInventoryItemAmount(Passport,nameItem)
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify",source,"amarelo","Necessário possuir um <b>"..itemName(nameItem).."</b>.",5000)
				return
			end

			if vRP.checkDamaged(consultItem[2]) then
				TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(nameItem).."</b> danificado.",5000)
				return
			end

			local Model = Entity[2]
			local netObjects = Entity[3]

			if Animals[Model] == nil then
				Animals[Model] = {}
			end

			if Animals[Model][netObjects] == nil then
				Animals[Model][netObjects] = 0
			end

			if verifyAnimals[Passport] == nil and Active[Passport] == nil and Animals[Model][netObjects] < 5 then
				if (vRP.inventoryWeight(Passport) + itemWeight("meat")) <= vRP.getWeights(Passport) then
					if vTASKBAR.taskOne(source) then
						Active[Passport] = os.time() + 5
						TriggerClientEvent("Progress",source,"Esfolando",5000)

						if not vCLIENT.animalAnim(source) then
							vRPC.removeObjects(source)
							vRPC.playAnim(source,false,{"amb@medic@standing@kneel@base","base"},true)
							vRPC.playAnim(source,true,{"anim@gangops@facility@servers@bodysearch@","player_search"},true)
						end

						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close",source)
						verifyAnimals[Passport] = { Model,netObjects }
						Animals[Model][netObjects] = Animals[Model][netObjects] + 1

						repeat
							if os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								verifyAnimals[Passport] = nil
								Player(source)["state"]["Buttons"] = false

								if Animals[Model] then
									if parseInt(Animals[Model][netObjects]) <= 1 then
										vRP.generateItem(Passport,"meat",1,true)
									elseif parseInt(Animals[Model][netObjects]) == 2 then
										vRP.generateItem(Passport,"meat",1,true)
									elseif parseInt(Animals[Model][netObjects]) == 3 then
										local randItens = math.random(8)
										vRP.generateItem(Passport,"animalfat",randItens,true)
									elseif parseInt(Animals[Model][netObjects]) == 4 then
										local randItens = math.random(4)
										vRP.generateItem(Passport,"leather",randItens,true)
									elseif parseInt(Animals[Model][netObjects]) >= 5 then
										vRPC.removeObjects(source)
										local randItens = math.random(2)
										Animals[Model][netObjects] = nil
										TriggerEvent("tryDeletePed",netObjects)
										vRP.generateItem(Passport,"animalpelt",randItens,true)
									end
								end
							end

							Wait(100)
						until Active[Passport] == nil
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:GUARDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("objects:Guardar")
AddEventHandler("objects:Guardar",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Objects[Number] then
			if (vRP.inventoryWeight(Passport) + itemWeight(Objects[Number]["item"])) <= vRP.getWeights(Passport) then
				vRP.giveInventoryItem(Passport,Objects[Number]["item"],1,true)
				TriggerClientEvent("objects:Remover",-1,Number)
				Objects[Number] = nil
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:makeProducts")
AddEventHandler("inventory:makeProducts",function(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil then
		local splitName = splitString(Table,"-")
		local Selected = splitName[1]

		if Products[Selected] then
			if Selected == "cemitery" then
				if not vTASKBAR.taskOne(source) then
					local Coords = vRP.getEntityCoords(source)
					local Polices = vRP.numPermission("Police")

					for k,v in pairs(Polices) do
						async(function()
							vRPC.playSound(v["source"],"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
							TriggerClientEvent("NotifyPush",v["source"],{ code = 20, title = "Roubo de Pertences", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
						end)
					end
				end
			end

			local Need = {}
			local Consult = {}
			local Number = math.random(#Products[Selected])

			if Products[Selected][Number]["item"] then
				if vRP.checkMaxItens(Passport,Products[Selected][Number]["item"],Products[Selected][Number]["itemAmount"]) then
					TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
					goto scapeInventory
				end

				if (vRP.inventoryWeight(Passport) + itemWeight(Products[Selected][Number]["item"]) * Products[Selected][Number]["itemAmount"]) > vRP.getWeights(Passport) then
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					goto scapeInventory
				end
			end

			if Products[Selected][Number]["need"] then
				local needItem = Products[Selected][Number]["need"]

				if type(needItem) == "table" then
					for k,v in pairs(needItem) do
						Consult = vRP.getInventoryItemAmount(Passport,v["item"])
						if Consult[1] < v["amount"] then
							TriggerClientEvent("Notify",source,"amarelo","Necessário possuir <b>"..v["amount"].."x "..itemName(v["item"]).."</b>.",5000)
							goto scapeInventory
						end

						Need[k] = { Consult[2],v["amount"] }
					end
				else
					needAmount = Products[Selected][Number]["needAmount"]
					Consult = vRP.getInventoryItemAmount(Passport,needItem)
					if Consult[1] < needAmount then
						TriggerClientEvent("Notify",source,"amarelo","Necessário possuir <b>"..needAmount.."x "..itemName(needItem).."</b>.",5000)
						goto scapeInventory
					end
				end
			end

			Player(source)["state"]["Buttons"] = true
			Active[Passport] = os.time() + Products[Selected][Number]["timer"]
			TriggerClientEvent("Progress",source,"Produzindo",Products[Selected][Number]["timer"] * 1000)

			if Selected == "tablecoke" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "paper" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "tablemeth" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "tableweed" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "burgershot1" or Selected == "pizzathis1" or Selected == "uwucoffee1" or Selected == "beanmachine1" then
				vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
			elseif Selected == "burgershot2" or Selected == "pizzathis2" or Selected == "uwucoffee2" or Selected == "beanmachine2" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "burgershot3" or Selected == "pizzathis3" or Selected == "uwucoffee3" or Selected == "beanmachine3" then
				vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
			elseif Selected == "milkBottle" then
				vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
			elseif Selected == "cemitery" then
				vRPC.playAnim(source,false,{"amb@medic@standing@tendtodead@idle_a","idle_a"},true)
			elseif Selected == "fishfillet" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "marshmallow" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "animalmeat" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "emptybottle" then
				vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
			end

			repeat
				if os.time() >= parseInt(Active[Passport]) then
					Player(source)["state"]["Buttons"] = false
					Active[Passport] = nil
					local Points = 0

					if Selected ~= "scanner" then
						vRPC.stopAnim(source,false)
					end

					if Products[Selected][Number]["need"] then
						if type(Products[Selected][Number]["need"]) == "table" then
							for k,v in pairs(Need) do
								local splitName = splitString(v[1],"-")
								if splitName[1] == "weedleaf" and splitName[2] ~= nil then
									Points = splitName[2]
								end

								vRP.removeInventoryItem(Passport,v[1],v[2],false)
							end
						else
							vRP.removeInventoryItem(Passport,Consult[2],needAmount,false)
						end
					end

					if Products[Selected][Number]["item"] then
						if Selected == "tableweed" then
							vRP.generateItem(Passport,Products[Selected][Number]["item"].."-"..Points,Products[Selected][Number]["itemAmount"],true)
						else
							vRP.generateItem(Passport,Products[Selected][Number]["item"],Products[Selected][Number]["itemAmount"],true)
						end
					end
				end

				Wait(100)
			until Active[Passport] == nil
		end
	end

	::scapeInventory::
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Dismantle")
AddEventHandler("inventory:Dismantle",function(Entity)
	local source = source
	local vehName = Entity[2]
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil then
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Desmanchando",10000)
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.removeObjects(source)
				Player(source)["state"]["Buttons"] = false
				TriggerEvent("garages:deleteVehicle",Entity[4],Entity[1])
				TriggerClientEvent("player:Residuals",source,"Resíduo de Metal.")
				TriggerClientEvent("player:Residuals",source,"Resíduo de Alumínio.")

				local Class = "B"
				if DismantleExperience[Passport] then
					Class = ClassCategory(DismantleExperience[Passport])
				end

				local AmountItens = math.random(100,150)
				local VehSelected = "suspension"
				local VehParts = math.random(4)
				local VehRandom = 1000

				if Class == "B" or Class == "B+" then
					VehRandom = math.random(4500)
					AmountItens = math.random(150,200)
				elseif Class == "A" or Class == "A+" then
					VehRandom = math.random(3500)
					AmountItens = math.random(200,250)
				elseif Class == "S" or Class == "S+" then
					VehRandom = math.random(2500)
					AmountItens = math.random(250,300)
				end

				if VehParts <= 1 then
					VehSelected = "engine"
				elseif VehParts == 2 then
					VehSelected = "transmission"
				elseif VehParts == 3 then
					VehSelected = "brake"
				end

				if VehRandom <= 10 then
					vRP.generateItem(Passport,VehSelected.."e",1,true)
				elseif VehRandom >= 10 and VehRandom <= 30 then
					vRP.generateItem(Passport,VehSelected.."d",1,true)
				elseif VehRandom >= 31 and VehRandom <= 60 then
					vRP.generateItem(Passport,VehSelected.."c",1,true)
				elseif VehRandom >= 61 and VehRandom <= 100 then
					vRP.generateItem(Passport,VehSelected.."b",1,true)
				elseif VehRandom >= 101 and VehRandom <= 150 then
					vRP.generateItem(Passport,VehSelected.."a",1,true)
				end

				local Members = exports["vrp"]:Party(Passport,source,20)
				if #Members > 1 then
					for _,v in pairs(Members) do
						vRP.generateItem(v,"dollars",AmountItens * #Members,true)
						vRP.PutExperience(v,"Dismantly",2)
					end
				else
					vRP.generateItem(Passport,"dollars",AmountItens,true)
					vRP.PutExperience(Passport,"Dismantly",1)
				end

				vRP.generateItem(Passport,"dismantle",1,true)

				if math.random(1000) <= 100 then
					vRP.generateItem(Passport,"plate",1,true)
				end
			end

			Wait(100)
		until Active[Passport] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:removeTyres")
AddEventHandler("inventory:removeTyres",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil and Entity[2] ~= "veto" and Entity[2] ~= "veto2" then
		if not vCLIENT.checkWeapon(source,"WEAPON_WRENCH") then
			TriggerClientEvent("Notify",source,"amarelo","<b>Chave Inglesa</b> não encontrada.",5000)
			goto scapeInventory
		end

		local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
		if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
			if vCLIENT.tyreHealth(source,Entity[4],Entity[5]) == 1000.0 then
				if vRP.checkMaxItens(Passport,"tyres",1) then
					TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
					return
				end

				if vRP.PassportPlate(Entity[1]) then
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

					if vTASKBAR.taskTyre(source) then
						Active[Passport] = os.time() + 10
						TriggerClientEvent("Progress",source,"Removendo",10000)

						repeat
							if os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil

								local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
								if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
									if vCLIENT.tyreHealth(source,Entity[4],Entity[5]) == 1000.0 then
										TriggerClientEvent("inventory:explodeTyres",source,Entity[4],Entity[1],Entity[5])
										vRP.generateItem(Passport,"tyres",1,true)
									end
								end
							end

							Wait(100)
						until Active[Passport] == nil
					end

					Player(source)["state"]["Buttons"] = false
					vRPC.removeObjects(source)
				end
			end
		end
	end

	::scapeInventory::
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRINK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Drink")
AddEventHandler("inventory:Drink",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil then
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",5000)
		vRPC.createObjects(source,"amb@world_human_drinking@coffee@male@idle_a","idle_c","prop_plastic_cup_02",49,28422)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRP.upgradeThirst(Passport,15)
				vRPC.removeObjects(source,"one")
				Player(source)["state"]["Buttons"] = false
			end

			Wait(100)
		until Active[Passport] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:StealPeds")
AddEventHandler("inventory:StealPeds",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Rand = math.random(#StealPeds)
		local Amount = math.random(StealPeds[Rand]["min"],StealPeds[Rand]["max"])

		if vRP.checkMaxItens(Passport,StealPeds[Rand]["item"],Amount) then
			TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			return true
		end

		if (vRP.inventoryWeight(Passport) + itemWeight(StealPeds[Rand]["item"]) * Amount) <= vRP.getWeights(Passport) then
			vRP.generateItem(Passport,StealPeds[Rand]["item"],Amount,true)

			if math.random(100) >= 80 then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				local Polices = vRP.numPermission("Police")

				for k,v in pairs(Polices) do
					async(function()
						vRPC.playSound(v["source"],"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",v["source"],{ code = 32, title = "Assalto a mão armada", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.AmountDrugs()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		for k,v in pairs(DrugsList) do
			local Amount = math.random(v["rMin"],v["rMax"])
			local Price = math.random(v["pMin"],v["pMax"])

			local Consult = vRP.getInventoryItemAmount(Passport,k)
			if Consult[1] >= Amount then
				Drugs[Passport] = { Consult[2],Amount,Price * Amount }
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRUGSPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DrugsPeds")
AddEventHandler("inventory:DrugsPeds",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Drugs[Passport] then
		local Points = 0
		local Percentage = 95
		local splitName = splitString(Drugs[Passport][1],"-")
		if splitName[2] ~= nil then
			Points = parseInt(splitName[2])
		end

		if vRP.tryGetInventoryItem(Passport,Drugs[Passport][1],Drugs[Passport][2],true) then
			vRP.generateItem(Passport,"dollars",Drugs[Passport][3] + (Points * 2),true)
			TriggerClientEvent("player:Residuals",source,"Resíduo Orgânico.")
			Percentage = Percentage - Points

			if Percentage <= 25 then
				Percentage = 25
			end

			if math.random(100) >= Percentage then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				local Polices = vRP.numPermission("Police")

				for k,v in pairs(Polices) do
					async(function()
						vRPC.playSound(v["source"],"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",v["source"],{ code = 20, title = "Venda de Drogas", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Ligação Anônima", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
			end

			Drugs[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:RollVehicle")
AddEventHandler("player:RollVehicle",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] == nil then
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 60
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Desvirando",60000)
		vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

		repeat
			if os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.removeObjects(source)
				Player(source)["state"]["Buttons"] = false

				local Players = vRPC.Players(source)
				for _,v in ipairs(Players) do
					async(function()
						TriggerClientEvent("target:RollVehicle",v,Entity[4])
					end)
				end
			end

			Wait(100)
		until Active[Passport] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAINERS
-----------------------------------------------------------------------------------------------------------------------------------------
local ContainersLast = os.time()
local ContainersSpawn = false
local ContainersTimer = {
	["00:00"] = true,
	["04:00"] = true,
	["08:00"] = true,
	["12:00"] = true,
	["16:00"] = true,
	["20:00"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAINERSINFOS
-----------------------------------------------------------------------------------------------------------------------------------------
local ContainersInfos = {
	{ -2201.32,4579.64,0.39,127.56 },
	{ -3163.97,3273.68,0.81,195.6 },
	{ -1547.47,2836.74,29.90,223.94 },
	{ 250.79,3600.06,33.07,328.82 },
	{ 2818.82,3898.95,46.72,246.62 },
	{ 3732.37,3813.16,3.52,22.68 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCONTAINERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if ContainersTimer[os.date("%H:%M")] and os.time() >= ContainersLast then
			if Objects["9999"] then
				TriggerClientEvent("objects:Remover",-1,"9999")
				Objects["9999"] = nil
			end

			ContainersSpawn = math.random(#ContainersInfos)
			Objects["9999"] = { x = ContainersInfos[ContainersSpawn][1], y = ContainersInfos[ContainersSpawn][2], z = ContainersInfos[ContainersSpawn][3], h = ContainersInfos[ContainersSpawn][4], object = "prop_container_03b", Distance = 200, mode = "Containers" }
			TriggerClientEvent("Notify",-1,"amarelo","Container disponível.",10000)
			TriggerClientEvent("objects:Adicionar",-1,"9999",Objects["9999"])
			TriggerEvent("crafting:Containers")
			ContainersLast = os.time() + 3600
		end

		Wait(30000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BUFFSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:BuffServer",function(source,Passport,Name,Amount)
	if Buffs[Name][Passport] == nil then
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
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Ammos[Passport] then
		if invTemp[Passport] then
			Ammos[Passport] = invTemp[Passport]["Ammos"]
			Attachs[Passport] = invTemp[Passport]["Attachs"]
			invTemp[Passport] = nil
		end

		vRP.Execute("playerdata/SetData",{ Passport = Passport, dkey = "Attachs", dvalue = json.encode(Attachs[Passport]) })
		vRP.Execute("playerdata/SetData",{ Passport = Passport, dkey = "Ammos", dvalue = json.encode(Ammos[Passport]) })
		Attachs[Passport] = nil
		Ammos[Passport] = nil
	end

	if Active[Passport] then
		Active[Passport] = nil
	end

	if verifyObjects[Passport] then
		verifyObjects[Passport] = nil
	end

	if verifyAnimals[Passport] then
		verifyAnimals[Passport] = nil
	end

	if Loots[Passport] then
		Loots[Passport] = nil
	end

	if Healths[Passport] then
		Healths[Passport] = nil
	end

	if Armors[Passport] then
		Armors[Passport] = nil
	end

	if Scanners[Passport] then
		Scanners[Passport] = nil
	end

	if Carry[Passport] then
		TriggerClientEvent("player:Commands",Carry[Passport],false)
		vRPC.removeObjects(Carry[Passport])
		Carry[Passport] = nil
	end

	if Drugs[Passport] then
		Drugs[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	Ammos[Passport] = vRP.userData(Passport,"Ammos")
	Attachs[Passport] = vRP.userData(Passport,"Attachs")

	TriggerClientEvent("objects:Table",source,Objects)
	TriggerClientEvent("drops:Table",source,Drops)

	for Name,v in pairs(Buffs) do
		if Buffs[Name][Passport] then
			if os.time() < Buffs[Name][Passport] then
				TriggerClientEvent("hud:"..Name,source,Buffs[Name][Passport] - os.time())
			end
		end
	end
end)