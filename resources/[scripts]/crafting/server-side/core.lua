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
Tunnel.bindInterface("crafting",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
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
			},
			["chocolate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["cocoa"] = 1
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
			["passionjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["passion"] = 5
				}
			},
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
			["calzone"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["cheese"] = 1,
					["bread"] = 2,
					["milkbottle"] = 1
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
			["grapejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["grape"] = 5
				}
			},
			["mushroomtea"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["mushroom"] = 20,
					["water"] = 1
				}
			},
			["cheese"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["milkbottle"] = 1
				}
			},
			["chocolate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["cocoa"] = 1
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
			["fries"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["potato"] = 2
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
			["mushroomtea"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["mushroom"] = 20,
					["water"] = 1
				}
			},
			["cheese"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["milkbottle"] = 1
				}
			},
			["chocolate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["cocoa"] = 1
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
					["coffee2"] = 3,
					["milkbottle"] = 1
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
			["sandwich"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["cheese"] = 1
				}
			},
			["mushroomtea"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["mushroom"] = 20,
					["water"] = 1
				}
			},
			["cheese"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["milkbottle"] = 1
				}
			},
			["chocolate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["cocoa"] = 1
				}
			},
			["acerolajuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["acerola"] = 5
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
					["copper"] = 5,
					["aluminum"] = 5,
					["plastic"] = 5,
					["glass"] = 5,
					["rubber"] = 5
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
	["Aztecas"] = {
		["perm"] = "Aztecas",
		["List"] = {
		    ["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["copper"] = 1
				}
			},
			 ["WEAPON_SMG_AMMO"] = {
			 	["amount"] = 2,
			 	["destroy"] = false,
			 	["require"] = {
					["copper"] = 1
			 	}
			},
			-- ["WEAPON_SHOTGUN_AMMO"] = {
			-- 	["amount"] = 3,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["copper"] = 1
			-- 	}
			-- },
			-- ["WEAPON_RIFLE_AMMO"] = {
			-- 	["amount"] = 3,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 1
			-- 	}
			-- },
			["vest"] = {
                ["amount"] = 1,
                ["destroy"] = false,
                ["require"] = {
                    ["tarp"] = 1,
                    ["roadsigns"] = 4,
                    ["leather"] = 12,
                    ["sheetmetal"] = 5
                }
            }
		}
	},	
	["Marabunta"] = {
		["perm"] = "Marabunta",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 36,
					["copper"] = 36,
					["plastic"] = 24,
					["glass"] = 24,
					["rubber"] = 24
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 60,
					["copper"] = 60,
					["plastic"] = 28,
					["glass"] = 28,
					["rubber"] = 28
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
			 	["destroy"] = false,
			 	["require"] = {
			 		["aluminum"] = 100,
			 		["copper"] = 100,
			 		["plastic"] = 60,
			 		["glass"] = 60,
			 		["rubber"] = 60
			 	}
			},
			-- ["WEAPON_REVOLVER"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 60,
			-- 		["copper"] = 60,
			-- 		["plastic"] = 28,
			-- 		["glass"] = 28,
			-- 		["rubber"] = 20
			-- 	}
			-- },
			-- ["WEAPON_PUMPSHOTGUN_MK2"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 100,
			-- 		["copper"] = 100,
			-- 		["plastic"] = 80,
			-- 		["glass"] = 80,
			-- 		["rubber"] = 80
			-- 	}
			-- },
			-- ["WEAPON_SAWNOFFSHOTGUN"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 100,
			-- 		["copper"] = 100,
			-- 		["plastic"] = 60,
			-- 		["glass"] = 60,
			-- 		["rubber"] = 60
			-- 	}
			-- },
			["WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 100,
					["copper"] = 100,
					["plastic"] = 80,
					["glass"] = 80,
					["rubber"] = 80
				}
			},
			-- ["WEAPON_APPISTOL"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 36,
			-- 		["copper"] = 36,
			-- 		["plastic"] = 24,
			-- 		["glass"] = 24,
			-- 		["rubber"] = 24
			-- 	}
			-- },
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 28,
					["copper"] = 28,
					["plastic"] = 12,
					["glass"] = 12,
					["rubber"] = 8
				}
			},
			-- ["WEAPON_PISTOL50"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 60,
			-- 		["copper"] = 60,
			-- 		["plastic"] = 26,
			-- 		["glass"] = 26,
			-- 		["rubber"] = 20
			-- 	}
			-- },
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 100,
					["copper"] = 100,
					["plastic"] = 64,
					["glass"] = 64,
					["rubber"] = 60
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 36,
					["copper"] = 36,
					["plastic"] = 20,
					["glass"] = 20,
					["rubber"] = 20
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 36,
					["copper"] = 36,
					["plastic"] = 20,
					["glass"] = 20,
					["rubber"] = 20
				}
			},
			-- ["WEAPON_VINTAGEPISTOL"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 36,
			-- 		["copper"] = 20,
			-- 		["plastic"] = 12,
			-- 		["glass"] = 12,
			-- 		["rubber"] = 12
			-- 	}
			-- },
			-- ["WEAPON_COMPACTRIFLE"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 100,
			-- 		["copper"] = 100,
			-- 		["plastic"] = 60,
			-- 		["glass"] = 60,
			-- 		["rubber"] = 60
			-- 	}
			-- },
			-- ["WEAPON_ADVANCEDRIFLE"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 180,
			-- 		["copper"] = 180,
			-- 		["plastic"] = 140,
			-- 		["glass"] = 100,
			-- 		["rubber"] = 100
			-- 	}
			-- },
			-- ["WEAPON_BULLPUPRIFLE"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 180,
			-- 		["copper"] = 180,
			-- 		["plastic"] = 100,
			-- 		["glass"] = 100,
			-- 		["rubber"] = 100
			-- 	}
			-- },
			-- ["WEAPON_BULLPUPRIFLE_MK2"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 180,
			-- 		["copper"] = 180,
			-- 		["plastic"] = 100,
			-- 		["glass"] = 100,
			-- 		["rubber"] = 100
			-- 	}
			-- },
			-- ["WEAPON_SPECIALCARBINE"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 180,
			-- 		["copper"] = 180,
			-- 		["plastic"] = 100,
			-- 		["glass"] = 100,
			-- 		["rubber"] = 100
			-- 	}
			-- },
			-- ["WEAPON_SPECIALCARBINE_MK2"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 180,
			-- 		["copper"] = 180,
			-- 		["plastic"] = 100,
			-- 		["glass"] = 100,
			-- 		["rubber"] = 100
			-- 	}
			-- },
			["WEAPON_SMG_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 120,
					["copper"] = 120,
					["plastic"] = 80,
					["glass"] = 60,
					["rubber"] = 60
				}
			},
			-- ["WEAPON_ASSAULTRIFLE"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 180,
			-- 		["copper"] = 180,
			-- 		["plastic"] = 100,
			-- 		["glass"] = 100,
			-- 		["rubber"] = 100
			-- 	}
			-- },
			-- ["WEAPON_ASSAULTRIFLE_MK2"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 180,
			-- 		["copper"] = 180,
			-- 		["plastic"] = 100,
			-- 		["glass"] = 100,
			-- 		["rubber"] = 100
			-- 	}
			-- },
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 120,
					["copper"] = 120,
					["plastic"] = 80,
					["glass"] = 60,
					["rubber"] = 60
				}
			}
		}
	},
	["Triads"] = {
		["perm"] = "Triads",
		["List"] = {
			["dollars"] = {
				["amount"] = 1700,
				["destroy"] = false,
				["require"] = {
					["dollarsz"] = 2000
				}
			}
		}
	},
	["Lost"] = {
		["perm"] = "Lost",
		["List"] = {}
	},
	["Razors"] = {
		["perm"] = "Razors",
		["List"] = {
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
			["attachsSilencer"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 50,
					["roadsigns"] = 60,
					["sheetmetal"] = 60
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
			["attachsGrip"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					["roadsigns"] = 2,
					["aluminum"] = 3
				}
			},
			["attachsMazzleBrake"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					["roadsigns"] = 6,
					["sheetmetal"] = 6
				}
			},
			["attachsMazzleBoost"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					["roadsigns"] = 6,
					["sheetmetal"] = 6
				}
			}
		}
	},
	["YoungBoys"] = {
		["perm"] = "YoungBoys",
		["List"] = {
			["attachsFlashlight"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 5,
					["roadsigns"] = 2,
					["glass"] = 1,
					["plastic"] = 3
				}
			},
			["attachsCrosshair"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 5,
					["roadsigns"] = 2,
					["glass"] = 2,
					["aluminum"] = 1
				}
			},
			["attachsSilencer"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 5,
					["roadsigns"] = 6,
					["sheetmetal"] = 6
				}
			},
			["attachsMagazine"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 5,
					["roadsigns"] = 4,
					["sheetmetal"] = 3
				}
			},
			["attachsGrip"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 5,
					["roadsigns"] = 2,
					["aluminum"] = 3
				}
			},
			["attachsMazzleBrake"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 5,
					["roadsigns"] = 6,
					["sheetmetal"] = 6
				}
			},
			["attachsMazzleBoost"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 5,
					["roadsigns"] = 6,
					["sheetmetal"] = 6
				}
			}
		}
	},
	["CraftingTable"] = {
		["perm"] = "Facs",
		["List"] = {
			["tablecoke"] = {
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
			},
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
	},
	["Mechanic"] = {
		["perm"] = "Mechanic-3",
		["List"] = {
			["c4"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 5,
					["tarp"] = 2,
					["explosives"] = 5
				}
			},
			["blocksignal"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 5,
					["aluminum"] = 10,
					["rubber"] = 5
				}
			},
			["dismantle"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 100,
				}
			},
			["plate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["sheetmetal"] = 5,
					["roadsigns"] = 3
				}
			}
		}
	},
	["Backpack"] = {
		["List"] = {
		    ["backpack"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["leather"] = 20,
					["rubber"] = 45
				}
			}
		}
	},
	["Dollarsz"] = {
		["Type"] = "Wash",
		["List"] = {
			["dollars"] = {
				["amount"] = 1000,
				["destroy"] = false,
				["require"] = {
					["dollarsz"] = 2000
				}
			}
		}
	},
	["Paramedic"] = {
		["perm"] = "Paramedic-3",
		["List"] = {
			["adrenaline"] = {
				["amount"] = 4,
				["destroy"] = false,
				["require"] = {
					["syringe01"] = 1,
					["syringe02"] = 1,
					["syringe03"] = 1,
					["syringe04"] = 1
				}
			}
		}
	},
	["Dracing"] = {
		["perm"] = "Dracing-2",
		["List"] = {
			["notebook"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					["battery"] = 10,
					["aluminum"] = 20
				}
			},
			["nitro"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 10000,
				}
			},
			["credential"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 500,
				}
			}
		}
	},
	["tablemeth"] = {
		["perm"] = "Favelas",
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter",20 },
		["List"] = {
		    ["meth"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["drugtoy"] = 1
				}
			}
		}
	},
	["tablecoke"] = {
		["perm"] = "Facs",
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter",20 },
		["List"] = {
		    ["cocaine"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["drugtoy"] = 1
				}
			}
		}
	},
	["tableweed"] = {
		["perm"] = "Facs",
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter",20 },
		["List"] = {
		    ["joint"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["drugtoy"] = 1
				}
			}
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.requestPerm(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] then
		if List[Type]["perm"] then
			local Split = splitString(List[Type]["perm"],"-")

			if type(List[Type]["perm"]) == "table" then
				for _,Permission in pairs(List[Type]["perm"]) do
					if (Split[2] and vRP.HasGroup(Passport,Split[1],parseInt(Split[2]))) or vRP.HasService(Passport,Permission) then
						return true
					end
				end
			else
				if (Split[2] and vRP.HasGroup(Passport,Split[1],parseInt(Split[2]))) or vRP.HasService(Passport,List[Type]["perm"]) then
					return true
				end
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
		for Item,v in pairs(List[Type]["List"]) do
			local keyList = {}

			for Required,Amount in pairs(v["require"]) do
				keyList[#keyList + 1] = { name = itemName(Required), amount = Amount }
			end

			inventoryShop[#inventoryShop + 1] = { name = itemName(Item), index = itemIndex(Item), max = itemMaxAmount(Item), economy = parseFormat(itemEconomy(Item)), key = Item, peso = itemWeight(Item), list = keyList, amount = parseInt(v["amount"]), desc = itemDescription(Item) }
		end

		local inventoryUser = {}
		local inventory = vRP.Inventory(Passport)
		for Index,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["key"] = v["item"]
			v["slot"] = Index

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

			inventoryUser[Index] = v
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
	if Passport and not Active[Passport] then
		local consumePendrive = ""
		if Amount <= 0 then Amount = 1 end

		if List[Type]["List"][Item] then
			if vRP.MaxItens(Passport,Item,List[Type]["List"][Item]["amount"] * Amount) then
				TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
				TriggerClientEvent("crafting:Update",source,"requestCrafting")
				return
			end

			if List[Type]["Type"] == "Wash" then
				local consultItem = vRP.InventoryItemAmount(Passport,"pendrive")
				if consultItem[1] <= 0 then
					TriggerClientEvent("Notify",source,"vermelho","Pendrive não encontrado.",5000)
					return
				end

				if vRP.CheckDamaged(consultItem[2]) then
					TriggerClientEvent("Notify",source,"vermelho","Pendrive danificado.",5000)
					return
				end

				consumePendrive = consultItem[2]
			end

			if (vRP.InventoryWeight(Passport) + (itemWeight(Item) * List[Type]["List"][Item]["amount"]) * Amount) <= vRP.GetWeight(Passport) then
				for Index,v in pairs(List[Type]["List"][Item]["require"]) do
					local consultItem = vRP.InventoryItemAmount(Passport,Index)
					if consultItem[1] < parseInt(v * Amount) then
						return
					end

					if vRP.CheckDamaged(consultItem[2]) then
						TriggerClientEvent("Notify",source,"vermelho","Item danificado.",5000)
						return
					end
				end

				if List[Type]["anim"] then
					Player(source)["state"]["Buttons"] = true
					Active[Passport] = os.time() + List[Type]["anim"][3]
					TriggerClientEvent("Progress",source,"Produzindo",List[Type]["anim"][3] * 1000)
					vRPC.playAnim(source,false,{List[Type]["anim"][1],List[Type]["anim"][2]},true)
					TriggerClientEvent("crafting:Close",source)

					repeat
						if os.time() >= parseInt(Active[Passport]) then
							Player(source)["state"]["Buttons"] = false
							Active[Passport] = nil

							for Index,v in pairs(List[Type]["List"][Item]["require"]) do
								local consultItem = vRP.InventoryItemAmount(Passport,Index)
								vRP.RemoveItem(Passport,consultItem[2],parseInt(v * Amount))
							end

							vRP.GenerateItem(Passport,Item,List[Type]["List"][Item]["amount"] * Amount,false,Slot)
						end
		
						Wait(100)
					until not Active[Passport]
				else
					for Index,v in pairs(List[Type]["List"][Item]["require"]) do
						local consultItem = vRP.InventoryItemAmount(Passport,Index)
						vRP.RemoveItem(Passport,consultItem[2],parseInt(v * Amount))
					end
	
					vRP.GenerateItem(Passport,Item,List[Type]["List"][Item]["amount"] * Amount,false,Slot)
	
					if List[Type]["Type"] == "Wash" then
						vRP.RemoveItem(Passport,consumePendrive,1)
	
						TriggerEvent("Discord",List[Type]["Type"],"**Passaporte:** "..Passport.."\n**Gerou:** "..List[Type]["List"][Item]["amount"] * Amount.."x "..itemName(Item),3042892)
					end
				end
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
					for Index,v in pairs(List[Type]["List"][splitName[1]]["require"]) do
						if parseInt(v) <= 1 then
							vRP.GenerateItem(Passport,Index,1)
						else
							vRP.GenerateItem(Passport,Index,v / 2)
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("crafting:Cancel")
AddEventHandler("crafting:Cancel",function(source,Passport)
	if Active[Passport] then
		Active[Passport] = nil
		Player(source)["state"]["Buttons"] = false
		TriggerClientEvent("Progress",source,"Cancelando",1000)
	end
end)