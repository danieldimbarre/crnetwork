-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("crafting",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	["Ballas"] = {
		["perm"] = "Ballas",
		["List"] = {
			["drugtoy"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["amphetamine"] = 1,
					["codeine"] = 1,
					["plastic"] = 1
				}
			},
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["copper"] = 1
				}
			},
			["WEAPON_SHOTGUN_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["copper"] = 1
				}
			},
			["handcuff"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["sheetmetal"] = 15
				}
			},
			["hood"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["leather"] = 150,
					["tarp"] = 10
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 60,
					["copper"] = 40,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 30
				}
			},
			["attachsFlashlight"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					["roadsigns"] = 2,
					["glass"] = 1,
					["plastic"] = 3
				}
			},
			["dismantle"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 100
				}
			}
		}
	},
	["Families"] = {
		["perm"] = "Families",
		["List"] = {
			["drugtoy"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["amphetamine"] = 1,
					["codeine"] = 1,
					["plastic"] = 1
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1
				}
			},
			["WEAPON_SHOTGUN_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["copper"] = 1
				}
			},
			["handcuff"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["sheetmetal"] = 15
				}
			},
			["hood"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["leather"] = 150,
					["tarp"] = 10
				}
			},
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 60,
					["copper"] = 60,
					["plastic"] = 45,
					["glass"] = 45,
					["rubber"] = 45
				}
			},
			["attachsCrosshair"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					["roadsigns"] = 2,
					["glass"] = 2,
					["aluminum"] = 1
				}
			},
			["dismantle"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 100
				}
			}
		}
	},
	["Vagos"] = {
		["perm"] = "Vagos",
		["List"] = {
			["drugtoy"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["amphetamine"] = 1,
					["codeine"] = 1,
					["plastic"] = 1
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1
				}
			},
			["WEAPON_SHOTGUN_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["copper"] = 1
				}
			},
			["c4"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 1,
					["explosives"] = 5,
					["sheetmetal"] = 1,
					["pliers"] = 1
				}
			},
			["WEAPON_MOLOTOV"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["alcohol"] = 1,
					["water"] = 1
				}
			},
			["WEAPON_SMOKEGRENADE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 3,
					["acetone"] = 1
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 50,
					["copper"] = 50,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 25
				}
			},
			["attachsSilencer"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					["roadsigns"] = 6,
					["sheetmetal"] = 6
				}
			},
			["dismantle"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 100
				}
			}
		}
	},
	["Aztecas"] = {
		["perm"] = "Aztecas",
		["List"] = {
			["drugtoy"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["amphetamine"] = 1,
					["codeine"] = 1,
					["plastic"] = 1
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1
				}
			},
			["WEAPON_SHOTGUN_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["copper"] = 1
				}
			},
			["c4"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 1,
					["explosives"] = 5,
					["sheetmetal"] = 1,
					["pliers"] = 1
				}
			},
			["WEAPON_MOLOTOV"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["alcohol"] = 1,
					["water"] = 1
				}
			},
			["WEAPON_SMOKEGRENADE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 3,
					["acetone"] = 1
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 60,
					["copper"] = 60,
					["plastic"] = 40,
					["glass"] = 40,
					["rubber"] = 40
				}
			},
			["attachsMagazine"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					["roadsigns"] = 4,
					["sheetmetal"] = 3
				}
			},
			["dismantle"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 100
				}
			}
		}
	},
	["Bloods"] = {
		["perm"] = "Bloods",
		["List"] = {
			["drugtoy"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["amphetamine"] = 1,
					["codeine"] = 1,
					["plastic"] = 1
				}
			},
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["copper"] = 1
				}
			},
			["WEAPON_SHOTGUN_AMMO"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["copper"] = 1
				}
			},
			["c4"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 1,
					["explosives"] = 5,
					["sheetmetal"] = 1,
					["pliers"] = 1
				}
			},
			["WEAPON_MOLOTOV"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["alcohol"] = 1,
					["water"] = 1
				}
			},
			["WEAPON_SMOKEGRENADE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 3,
					["acetone"] = 1
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 60,
					["copper"] = 60,
					["plastic"] = 40,
					["glass"] = 40,
					["rubber"] = 40
				}
			},
			["attachsGrip"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					["roadsigns"] = 2,
					["aluminum"] = 3
				}
			},
			["dismantle"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 100
				}
			}
		}
	},
	["UwuCoffee"] = {
		["perm"] = "UwuCoffee",
		["List"] = {
			["nigirizushi"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["fishfillet"] = 1,
					["bread"] = 1
				}
			},
			["sushi"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["fishfillet"] = 1,
					["bread"] = 1
				}
			},
			["cupcake"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["chocolate"] = 1,
					["bread"] = 1,
					["milkbottle"] = 1
				}
			},
			["applelove"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["apple"] = 1,
					["sugar"] = 5,
					["water"] = 1
				}
			},
			["milkshake"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["chocolate"] = 2,
					["milkbottle"] = 2
				}
			},
			["cappuccino"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["chocolate"] = 2,
					["milkbottle"] = 2,
					["coffee2"] = 5
				}
			},
			["mushroomtea"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["mushroom"] = 20,
					["water"] = 1
				}
			}
		}
	},
	["PizzaThis"] = {
		["perm"] = "PizzaThis",
		["List"] = {
			["pizzamozzarella"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["cheese"] = 1,
					["bread"] = 1,
					["ketchup"] = 1
				}
			},
			["pizzamushroom"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["cheese"] = 1,
					["bread"] = 1,
					["ketchup"] = 1,
					["mushroom"] = 3
				}
			},
			["pizzabanana"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["cheese"] = 1,
					["bread"] = 1,
					["banana"] = 6
				}
			},
			["pizzachocolate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["cheese"] = 1,
					["bread"] = 1,
					["chocolate"] = 2
				}
			},
			["mushroomtea"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["mushroom"] = 20,
					["water"] = 1
				}
			}
		}
	},
	["BurgerShot"] = {
		["perm"] = "BurgerShot",
		["List"] = {
			["hamburger2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["meat"] = 1,
					["bread"] = 1,
					["cheese"] = 1,
					["ketchup"] = 1,
					["animalfat"] = 2
				}
			},
			["guarananatural"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["guarana"] = 5
				}
			},
			["orangejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["orange"] = 5
				}
			},
			["tangejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["tange"] = 5
				}
			},
			["grapejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["grape"] = 5
				}
			},
			["strawberryjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["strawberry"] = 5
				}
			},
			["bananajuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["banana"] = 5
				}
			},
			["acerolajuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["acerola"] = 5
				}
			},
			["passionjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["passion"] = 5
				}
			},
			["mushroomtea"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["mushroom"] = 20,
					["water"] = 1
				}
			}
		}
	},
	["BeanMachine"] = {
		["perm"] = "BeanMachine",
		["List"] = {
			["coffeemilk"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["coffee"] = 1,
					["milkbottle"] = 1
				}
			},
			["mushroomtea"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["mushroom"] = 20,
					["water"] = 1
				}
			}
		}
	},
	["Lockpick"] = {
		["List"] = {
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["copper"] = 15,
					["aluminum"] = 20
				}
			}
		}
	},		
	["Inventory"] = {
		["List"] = {
			["ketchup"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["tomato"] = 3
				}
			},
			["campfire"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 10,
					["alcohol"] = 1,
					["lighter"] = 1
				}
			},
			["gauze"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["cotton"] = 2,
					["alcohol"] = 1,
					["plaster"] = 1,
					["silk"] = 1
				}
			}
		}
	},
	["Triads"] = {
		["perm"] = "Triads",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 30
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 35
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 25
				}
			},
			["WEAPON_PUMPSHOTGUN_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_APPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 30
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 35,
					["copper"] = 35,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 10
				}
			},
			["WEAPON_PISTOL50"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 25
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 80,
					["glass"] = 80,
					["rubber"] = 75
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 45,
					["copper"] = 25,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 15
				}
			},
			["WEAPON_COMPACTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_ADVANCEDRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 175,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_BULLPUPRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SMG_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 100,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 100,
					["glass"] = 75,
					["rubber"] = 75
				}
			}
		}
	},
	["Razors"] = {
		["perm"] = "Razors",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 30
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 35
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 25
				}
			},
			["WEAPON_PUMPSHOTGUN_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 100,
					["glass"] = 100,
					["rubber"] = 100
				}
			},
			["WEAPON_APPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 30
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 35,
					["copper"] = 35,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 10
				}
			},
			["WEAPON_PISTOL50"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 75,
					["copper"] = 75,
					["plastic"] = 30,
					["glass"] = 30,
					["rubber"] = 25
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 80,
					["glass"] = 80,
					["rubber"] = 75
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 45,
					["copper"] = 25,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 15
				}
			},
			["WEAPON_COMPACTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 125,
					["copper"] = 125,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_ADVANCEDRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 175,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_BULLPUPRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_SMG_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 100,
					["glass"] = 75,
					["rubber"] = 75
				}
			},
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["riflebody"] = 1,
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["smgbody"] = 1,
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 100,
					["glass"] = 75,
					["rubber"] = 75
				}
			}
		}
	},
	["Lixeiro"] = {
		["List"] = {
			["glass"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["glassbottle"] = 1
				}
			},
			["plastic"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["plasticbottle"] = 1
				}
			},
			["rubber"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["elastic"] = 1
				}
			},
			["aluminum"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["metalcan"] = 1
				}
			},
			["copper"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["battery"] = 1
				}
			}
		}
	},
	["Mafia2"] = {
		["List"] = {
		    ["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["copper"] = 3,
					["polvora"] = 3
				}
			},
			--["WEAPON_SMG_AMMO"] = {
			--	["amount"] = 3,
			--	["destroy"] = false,
			--	["require"] = {
			--		["copper"] = 5,
			--		["polvora"] = 3
			--	}
			--},
			--["WEAPON_RIFLE_AMMO"] = {
			--	["amount"] = 3,
			--	["destroy"] = false,
			--	["require"] = {
			--		["copper"] = 8,
			--		["polvora"] = 3
			--	}
			--}
		}
	},	
	["Mafia1"] = {
		["List"] = {
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 120,
					["copper"] = 175,
				}
		},		
			--["WEAPON_MACHINEPISTOL"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["pistolbody"] = 1,
			--		["aluminum"] = 150,
			--		["copper"] = 185,
			--	}
			--},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 120,
					["copper"] = 175,
				}
			},
			--["WEAPON_PISTOL50"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["pistolbody"] = 1,
			--		["aluminum"] = 120,
			--		["copper"] = 175,
			--	}
			--},
			--["WEAPON_PISTOL_MK2"] = {
			--	["amount"] = 1,				
			--	["destroy"] = false,
			--	["require"] = {
			--		["pistolbody"] = 1,
			--		["aluminum"] = 120,
			--		["copper"] = 175,
			--	}
			--},
			["WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pistolbody"] = 1,
					["aluminum"] = 120,
					["copper"] = 175,
				}
			},
			--["WEAPON_MINISMG"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["smgbody"] = 1,
			--		["aluminum"] = 180,
			--		["copper"] = 215,
			--	}
			--},
			--["WEAPON_MICROSMG"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["smgbody"] = 1,
			--		["aluminum"] = 180,
			--		["copper"] = 215,
			--	}	
			--},
			--["WEAPON_COMPACTRIFLE"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["smgbody"] = 1,
			--		["aluminum"] = 180,
			--		["copper"] = 215,
			--	}
			--},
			--["WEAPON_ADVANCEDRIFLE"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["riflebody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,
			--	}
			--},
			--["WEAPON_BULLPUPRIFLE"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["riflebody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,
			--	}
			--},
			--["WEAPON_BULLPUPRIFLE_MK2"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["riflebody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,
			--	}
			--},
			--["WEAPON_SPECIALCARBINE"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["riflebody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,
			--	}
			--},
			--["WEAPON_SPECIALCARBINE_MK2"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["riflebody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,
			--	}
			--},
			--["WEAPON_PUMPSHOTGUN_MK2"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["riflebody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,
			--	}
			--},
			--["WEAPON_SAWNOFFSHOTGUN"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["riflebody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,
			--	}
			--},
			--["WEAPON_SMG_MK2"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["riflebody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,
			--	}
			--},
			--["WEAPON_ASSAULTRIFLE"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["riflebody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,
			--	}
			--},
			--["WEAPON_ASSAULTRIFLE_MK2"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["riflebody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,
			--	}
			--},
			--["WEAPON_ASSAULTSMG"] = {--
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["smgbody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,
			--	}
			--},
			--["WEAPON_GUSENBERG"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["riflebody"] = 2,
			--		["aluminum"] = 220,
			--		["copper"] = 256,	--
			--	}
			--}
		}
	},				
	["craftingTable"] = {
		["List"] = {
			--["tablecoke"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["woodlog"] = 10,
			--		["glass"] = 25,
			--		["rubber"] = 15,
			--		["aluminum"] = 10,
			--		["sheetmetal"] = 2,
			--		["tarp"] = 1,
			--		["explosives"] = 3
			--	}
			--},
			--["tablemeth"] = {
			--	["amount"] = 1,
			--	["destroy"] = false,
			--	["require"] = {
			--		["woodlog"] = 10,
			--		["glass"] = 25,
			--		["rubber"] = 15,
			--		["aluminum"] = 10,
			--		["sheetmetal"] = 2,
			--		["tarp"] = 1,
			--		["explosives"] = 3
			--	}
			--},
			["tableweed"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 5000,
					["woodlog"] = 10,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 10,
					["sheetmetal"] = 2,
					["tarp"] = 1,
					["explosives"] = 3
		
				}
			}
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.requestPerm(Name,Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if List[Type]["perm"] ~= nil then
			if vRP.HasGroup(Passport,List[Type]["perm"]) then
				return true
			end
		else
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.requestCrafting(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local inventoryShop = {}
		for k,v in pairs(List[Type]["List"]) do
			local keyList = {}
			for k,v in pairs(v["require"]) do
				table.insert(keyList,{ name = itemName(k), amount = v })
			end

			table.insert(inventoryShop,{ name = itemName(k), index = itemIndex(k), max = itemMaxAmount(k), economy = parseFormat(itemEconomy(k)), key = k, peso = itemWeight(k), list = keyList, amount = parseInt(v["amount"]), desc = itemDescription(k) })
		end

		local inventoryUser = {}
		local inventory = vRP.Inventory(Passport)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
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

			inventoryUser[k] = v
		end

		return inventoryShop,inventoryUser,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.functionCrafting(Item,Type,Amount,Slot)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if List[Type]["List"][Item] then
			if vRP.MaxItens(Passport,Item,List[Type]["List"][Item]["amount"] * Amount) then
				TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
				TriggerClientEvent("crafting:Update",source,"requestCrafting")
				return
			end

			if (vRP.InventoryWeight(Passport) + (itemWeight(Item) * List[Type]["List"][Item]["amount"]) * Amount) <= vRP.GetWeight(Passport) then
				for k,v in pairs(List[Type]["List"][Item]["require"]) do
					local consultItem = vRP.InventoryItemAmount(Passport,k)
					if consultItem[1] < parseInt(v * Amount) then
						return
					end

					if vRP.CheckDamaged(consultItem[2]) then
						TriggerClientEvent("Notify",source,"vermelho","Item danificado.",5000)
						return
					end
				end

				for k,v in pairs(List[Type]["List"][Item]["require"]) do
					local consultItem = vRP.InventoryItemAmount(Passport,k)
					vRP.RemoveItem(Passport,consultItem[2],parseInt(v * Amount))
				end

				vRP.GenerateItem(Passport,Item,List[Type]["List"][Item]["amount"] * Amount,false,Slot)
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.functionDestroy(Item,Type,Amount,Slot)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		local splitName = splitString(Item,"-")
		if List[Type]["List"][splitName[1]] then
			if List[Type]["List"][splitName[1]]["destroy"] then
				if vRP.CheckDamaged(Item) then
					TriggerClientEvent("Notify",source,"vermelho","Item danificado.",5000)
					TriggerClientEvent("crafting:Update",source,"requestCrafting")
					return
				end

				if vRP.TakeItem(Passport,Item,List[Type]["List"][splitName[1]]["amount"],Slot) then
					for k,v in pairs(List[Type]["List"][splitName[1]]["require"]) do
						if parseInt(v) <= 1 then
							vRP.GenerateItem(Passport,k,1)
						else
							vRP.GenerateItem(Passport,k,v / 2)
						end
					end
				end
			end
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("crafting:populateSlot")
AddEventHandler("crafting:populateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
			vRP.GiveItem(Passport,Item,Amount,false,Target)
			TriggerClientEvent("crafting:Update",source,"requestCrafting")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("crafting:updateSlot")
AddEventHandler("crafting:updateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		local inventory = vRP.Inventory(Passport)
		if inventory[tostring(Slot)] and inventory[tostring(Target)] and inventory[tostring(Slot)]["item"] == inventory[tostring(Target)]["item"] then
			if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
				vRP.GiveItem(Passport,Item,Amount,false,Target)
			end
		else
			vRP.SwapSlot(Passport,Slot,Target)
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end)