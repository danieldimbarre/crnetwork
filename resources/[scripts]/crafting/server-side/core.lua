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
	["Marabunta"] = {
		["perm"] = "Marabunta",
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
	["CraftingTable"] = {
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
	},
	["Altruists"] = {
		["perm"] = "Altruists",
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
			["vest"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["roadsigns"] = 5,
					["aluminum"] = 10,
					["rubber"] = 5,
					["sheetmetal"] = 5
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
					["leather"] = 75,
					["tarp"] = 5,
					["rubber"] = 45
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
		for Item,v in pairs(List[Type]["List"]) do
			local keyList = {}

			for Item,v in pairs(v["require"]) do
				keyList[#keyList + 1] = { name = itemName(Item), amount = v }
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
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if List[Type]["List"][Item] then
			if vRP.MaxItens(Passport,Item,List[Type]["List"][Item]["amount"] * Amount) then
				TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
				TriggerClientEvent("crafting:Update",source,"requestCrafting")
				return
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

				for Index,v in pairs(List[Type]["List"][Item]["require"]) do
					local consultItem = vRP.InventoryItemAmount(Passport,Index)
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