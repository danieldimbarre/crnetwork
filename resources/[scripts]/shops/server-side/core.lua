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
Tunnel.bindInterface("shops",Creative)
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local shops = {
	["BurgerShot"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "BurgerShot",
		["List"] = {
			["hamburger2"] = 125,
			["onionrings"] = 100,
			["fries"] = 70,
			["guarananatural"] = 75,
			["orangejuice"] = 100,
			["tangejuice"] = 100,
			["strawberryjuice"] = 100,
			["acerolajuice"] = 100,
			["passionjuice"] = 100,
			["mushroomtea"] = 300
		}
	},
	["BurgerShot-2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["shop"] = true,
		["List"] = {
			["hamburger2"] = 200,
			["onionrings"] = 175,
			["fries"] = 145,
			["guarananatural"] = 150,
			["orangejuice"] = 175,
			["tangejuice"] = 175,
			["strawberryjuice"] = 175,
			["acerolajuice"] = 175,
			["passionjuice"] = 175
		}
	},
	["PizzaThis"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "PizzaThis",
		["List"] = {
			["pizzamozzarella"] = 125,
			["pizzamushroom"] = 125,
			["pizzabanana"] = 125,
			["pizzachocolate"] = 125,
			["calzone"] = 125,
			["chickenfries"] = 100,
			["grapejuice"] = 100,
			["bananajuice"] = 100,
			["mushroomtea"] = 300
		}
	},
	["PizzaThis-2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["shop"] = true,
		["List"] = {
			["pizzamozzarella"] = 200,
			["pizzamushroom"] = 200,
			["pizzabanana"] = 200,
			["pizzachocolate"] = 200,
			["calzone"] = 200,
			["chickenfries"] = 175,
			["grapejuice"] = 175,
			["bananajuice"] = 175
		}
	},
	["UwuCoffee"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "UwuCoffee",
		["List"] = {
			["nigirizushi"] = 50,
			["sushi"] = 50,
			["applelove"] = 50,
			["milkshake"] = 100,
			["cappuccino"] = 125,
			["cookies"] = 35,
			["mushroomtea"] = 300
		}
	},
	["UwuCoffee-2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["shop"] = true,
		["List"] = {
			["nigirizushi"] = 125,
			["sushi"] = 125,
			["applelove"] = 125,
			["milkshake"] = 175,
			["cappuccino"] = 200,
			["cookies"] = 110
		}
	},
	["BeanMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "BeanMachine",
		["List"] = {
			["coffeemilk"] = 70,
			["sandwich"] = 125,
			["tacos"] = 25,
			["cupcake"] = 50,
			["mushroomtea"] = 300
		}
	},
	["BeanMachine-2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["shop"] = true,
		["List"] = {
			["coffeemilk"] = 145,
			["sandwich"] = 200,
			["tacos"] = 75,
			["cupcake"] = 125
		}
	},
	["Identity"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["identity"] = 5000,
			["badge03"] = 2000,
			["badge04-Law"] = 5000
		}
	},
	["Identity2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["fidentity"] = 10000
		}
	},
	["Digital"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["cellphone"] = 725,
			["radio"] = 975,
			["camera"] = 275,
			["scanner"] = 6750
		}
	},
	["Brewery"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["chandon"] = 15,
			["dewars"] = 15,
			["hennessy"] = 15,
			["absolut"] = 15
		}
	},
	["Organic"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["tomato"] = 10,
			["banana"] = 10,
			["guarana"] = 10,
			["acerola"] = 10,
			["passion"] = 10,
			["grape"] = 10,
			["tange"] = 10,
			["orange"] = 10,
			["apple"] = 10,
			["strawberry"] = 10,
			["coffee2"] = 10
		}
	},
	["Beans"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["cupcake"] = 70
		}
	},
	["Weeds"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["silk"] = 5
		}
	},
	["Dismantle"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["dismantle"] = 2000
		}
	},
	["Departament"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["hamburger"] = 25,
			["bread"] = 5,
			["cheese"] = 10,
			["mushroom"] = 10,
			["sugar"] = 5,
			["postit"] = 20,
			["notepad"] = 10,
			["emptybottle"] = 30,
			["cigarette"] = 10,
			["lighter"] = 175,
			["rose"] = 25,
			["rope"] = 875,
			["firecracker"] = 100,
			["radio"] = 975,
			["binoculars"] = 275,
			["camera"] = 275,
			["vape"] = 4750,
			["scanner"] = 6750
		}
	},
	["Clothes"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["teddy"] = 75,
			["suitcase"] = 275,
			["WEAPON_BRICK"] = 25,
			["WEAPON_SHOES"] = 25
		}
	},
	["Mechanic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Mechanic",
		["List"] = {
			["tyres"] = 180,
			["toolbox"] = 500,
			["advtoolbox"] = 1220,
			["WEAPON_CROWBAR"] = 580,
			["WEAPON_WRENCH"] = 580
		}
	},
	["Mechanic-2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["shop"] = true,
		["List"] = {
			["tyres"] = 360,
			["toolbox"] = 1000,
			["advtoolbox"] = 2440,
			["WEAPON_CROWBAR"] = 1450,
			["WEAPON_WRENCH"] = 1450
		}
	},
	["Fuel"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["WEAPON_PETROLCAN"] = 250
		}
	},
	["Weapons"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["pistolbody"] = 425,
			["smgbody"] = 525,
			["riflebody"] = 625
		}
	},
	["Pharmacy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["medkit"] = 575,
			["bandage"] = 225,
			["gauze"] = 100,
			["analgesic"] = 125,
			["sinkalmy"] = 375,
			["ritmoneury"] = 475
		}
	},
	["Paramedic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["List"] = {
			["badge02"] = 10,
			["syringe"] = 2,
			["bandage"] = 180,
			["gauze"] = 80,
			["gdtkit"] = 20,
			["medkit"] = 460,
			["sinkalmy"] = 300,
			["analgesic"] = 100,
			["ritmoneury"] = 380,
			["wheelchair"] = 2750,
			["defibrillator"] = 325,
			["medicbag"] = 425,
			["medicbed"] = 725
		}
	},
	["Ammunation"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["GADGET_PARACHUTE"] = 475,
			["WEAPON_HATCHET"] = 975,
			["WEAPON_BAT"] = 975,
			["WEAPON_BATTLEAXE"] = 975,
			["WEAPON_GOLFCLUB"] = 975,
			["WEAPON_HAMMER"] = 975,
			["WEAPON_MACHETE"] = 975,
			["WEAPON_POOLCUE"] = 975,
			["WEAPON_STONE_HATCHET"] = 975,
			["WEAPON_KNUCKLE"] = 975,
			-- ["WEAPON_KARAMBIT"] = 975,
			-- ["WEAPON_KATANA"] = 975,
			["WEAPON_FLASHLIGHT"] = 975,
			["pickaxe"] = 525,
			["repairkit01"] = 525,
			["repairkit02"] = 3225,
			["WEAPON_NAILGUN"] = 10000,
			["WEAPON_NAIL_AMMO"] = 10
		}
	},
	["Premium"] = {
		["mode"] = "Buy",
		["type"] = "Premium",
		["List"] = {
			-- ["gemstone"] = 1,
			["premium"] = 100,
			["premium2"] = 150,
			-- ["premium3"] = 200,
			-- ["rolepass"] = 100,
			["premiumplate"] = 50,
			["newchars"] = 75,
			["namechange"] = 50,
			["chip"] = 60,
			["facechange"] = 25,
			["diagram"] = 10,
			-- ["backschool"] = 50,
			-- ["backcyclist"] = 50,
			-- ["backcamping"] = 50,
			-- ["backalohomorawhite"] = 75,
			-- ["backalohomorablack"] = 75,
			-- ["backalohomorared"] = 75,
			-- ["backrudolphpurple"] = 75,
			-- ["backrudolphred"] = 75,
			["homecontEmerald"] = 200,
			["homecontDiamond"] = 100,
			["homecontRuby"] = 200,
			["homecontSapphire"] = 350,
			["homecontAmethyst"] = 500,
			["homecontAmber"] = 650,
			-- ["homecontTurquoise"] = 100,
			-- ["homecontAquamarine"] = 100,
			-- ["homecontTopaz"] = 100
		}
	},
	["Hunting"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["meat"] = 16,
			["animalpelt"] = 25,
			["tomato"] = 10,
			["banana"] = 10,
			["guarana"] = 10,
			["acerola"] = 10,
			["passion"] = 10,
			["grape"] = 10,
			["tange"] = 10,
			["orange"] = 10,
			["apple"] = 10,
			["strawberry"] = 10,
			["coffee2"] = 10,
			["animalfat"] = 10,
			["leather"] = 20
		}
	},
	["Fishing"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["octopus"] = 17,
			["shrimp"] = 17,
			["carp"] = 14,
			["horsefish"] = 14,
			["tilapia"] = 17,
			["codfish"] = 19,
			["catfish"] = 19,
			["goldenfish"] = 36,
			["pirarucu"] = 31,
			["pacu"] = 29,
			["tambaqui"] = 34
		}
	},
	["Hunting2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["required"] = {
			["badge03"] = 1
		},
		["List"] = {
			["switchblade"] = 525,
			["WEAPON_MUSKET"] = 3250,
			["WEAPON_MUSKET_AMMO"] = 7
		}
	},
	["Fishing2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["bait"] = 5,
			["scuba"] = 975,
			["fishingrod"] = 725
		}
	},
	["Recycle"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["notepad"] = 5,
			["plastic"] = 10,
			["glass"] = 10,
			["rubber"] = 10,
			["aluminum"] = 10,
			["copper"] = 10,
			["radio"] = 485,
			["rope"] = 435,
			["cellphone"] = 325,
			["binoculars"] = 135,
			["emptybottle"] = 15,
			["switchblade"] = 215,
			["camera"] = 135,
			["vape"] = 2375,
			["rose"] = 15,
			["lighter"] = 75,
			["teddy"] = 35,
			["tyres"] = 100,
			["bait"] = 2,
			["firecracker"] = 50,
			["fishingrod"] = 365,
			["scuba"] = 485,
			["techtrash"] = 60,
			["tarp"] = 20,
			["sheetmetal"] = 20,
			["roadsigns"] = 20,
			["explosives"] = 30,
			["codeine"] = 5,
			["amphetamine"] = 5,
			["acetone"] = 5,
			["cotton"] = 20,
			["plaster"] = 15,
			["sulfuric"] = 5,
			["saline"] = 5,
			["alcohol"] = 5
		}
	},
	["Miners"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["emerald"] = 90,
			["diamond"] = 81,
			["ruby"] = 67,
			["sapphire"] = 58,
			["amethyst"] = 49,
			["amber"] = 40,
			["turquoise"] = 31
		}
	},
	["coffeeMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["coffee"] = 5
		}
	},
	["sodaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["cola"] = 15,
			["soda"] = 15
		}
	},
	["donutMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["donut"] = 15,
			["chocolate"] = 15
		}
	},
	["burgerMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["hamburger"] = 25
		}
	},
	["hotdogMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["hotdog"] = 15
		}
	},
	["Chihuahua"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["hotdog"] = 15,
			["hamburger"] = 25,
			["coffee"] = 5,
			["cola"] = 15,
			["soda"] = 15
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["water"] = 30
		}
	},
	["PharmacyIlegal"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["adrenaline"] = 1200,
			["sulfuric"] = 5,
			["acetone"] = 5,
			["amphetamine"] = 5,
			["codeine"] = 5,
			["saline"] = 5,
			["alcohol"] = 5
		}
	},
	["Polices"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Police",
		["List"] = {
			["vest"] = 175,
			["gsrkit"] = 20,
			["gdtkit"] = 20,
			["barrier"] = 250,
			["handcuff"] = 425,
			["WEAPON_SMG"] = 775,
			["WEAPON_SMG_MK2"] = 835,
			["WEAPON_PUMPSHOTGUN"] = 775,
			["WEAPON_CARBINERIFLE"] = 775,
			["WEAPON_CARBINERIFLE_MK2"] = 925,
			["WEAPON_HEAVYRIFLE"] = 985,
			["WEAPON_STUNGUN"] = 525,
			["WEAPON_COMBATPISTOL"] = 625,
			["WEAPON_HEAVYPISTOL"] = 725,
			["WEAPON_NIGHTSTICK"] = 125,
			["WEAPON_FLASHLIGHT"] = 125,
			["WEAPON_PISTOL_AMMO"] = 4,
			["WEAPON_SMG_AMMO"] = 5,
			["WEAPON_RIFLE_AMMO"] = 6,
			["WEAPON_SHOTGUN_AMMO"] = 5,
			["badge01"] = 10,
			-- ["WEAPON_MOLOTOV"] = 75,
			-- ["WEAPON_SMOKEGRENADE"] = 75,
			-- ["WEAPON_FLASHBANG"] = 75,
			["attachsFlashlight"] = 1750,
			["attachsCrosshair"] = 1750,
			["attachsSilencer"] = 1750,
			["attachsMagazine"] = 1750,
			["attachsGrip"] = 1750,
			["attachsMazzleBrake"] = 1750,
			["attachsMazzleBoost"] = 1750,
			["megaphone"] = 525,
			["radio"] = 975,
			["binoculars"] = 275
		}
	},
	["Criminal"] = {
		["mode"] = "Sell",
		["type"] = "Cashz",
		["List"] = {
			["keyboard"] = 75,
			["mouse"] = 75,
			["playstation"] = 75,
			["xbox"] = 75,
			["dish"] = 75,
			["pan"] = 100,
			["fan"] = 75,
			["blender"] = 75,
			["switch"] = 45,
			["cup"] = 100,
			["lampshade"] = 75,
			["watch"] = 75,
			["bracelet"] = 75,
			["dildo"] = 75,
			["spray01"] = 75,
			["spray02"] = 75,
			["spray03"] = 75,
			["spray04"] = 75,
			["slipper"] = 75,
			["rimel"] = 75,
			["brush"] = 75,
			["soap"] = 75,
			["eraser"] = 75,
			["legos"] = 75,
			["ominitrix"] = 75,
			["dices"] = 45,
			["domino"] = 45,
			["floppy"] = 45,
			["horseshoe"] = 75,
			["deck"] = 75,
			["goldbar"] = 525,
			["pliers"] = 55,
			["pager"] = 125,
			["card01"] = 325,
			["card02"] = 325,
			["card03"] = 375,
			["card04"] = 275,
			["card05"] = 425,
			["pendrive"] = 325,
			["silvercoin"] = 10,
			["goldcoin"] = 20
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NAMES
-----------------------------------------------------------------------------------------------------------------------------------------
local nameMale = { "James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Matthew","Gary","Timothy","Jose","Larry","Jeffrey","Frank","Scott","Eric","Stephen","Andrew","Raymond","Gregory","Joshua","Jerry","Dennis","Walter","Patrick","Peter","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Albert","Jonathan","Justin","Terry","Gerald","Keith","Samuel","Willie","Ralph","Lawrence","Nicholas","Roy","Benjamin","Bruce","Brandon","Adam","Harry","Fred","Wayne","Billy","Steve","Louis","Jeremy","Aaron","Randy","Howard","Eugene","Carlos","Russell","Bobby","Victor","Martin","Ernest","Phillip","Todd","Jesse","Craig","Alan","Shawn","Clarence","Sean","Philip","Chris","Johnny","Earl","Jimmy","Antonio" }
local nameFemale = { "Mary","Patricia","Linda","Barbara","Elizabeth","Jennifer","Maria","Susan","Margaret","Dorothy","Lisa","Nancy","Karen","Betty","Helen","Sandra","Donna","Carol","Ruth","Sharon","Michelle","Laura","Sarah","Kimberly","Deborah","Jessica","Shirley","Cynthia","Angela","Melissa","Brenda","Amy","Anna","Rebecca","Virginia","Kathleen","Pamela","Martha","Debra","Amanda","Stephanie","Carolyn","Christine","Marie","Janet","Catherine","Frances","Ann","Joyce","Diane","Alice","Julie","Heather","Teresa","Doris","Gloria","Evelyn","Jean","Cheryl","Mildred","Katherine","Joan","Ashley","Judith","Rose","Janice","Kelly","Nicole","Judy","Christina","Kathy","Theresa","Beverly","Denise","Tammy","Irene","Jane","Lori","Rachel","Marilyn","Andrea","Kathryn","Louise","Sara","Anne","Jacqueline","Wanda","Bonnie","Julia","Ruby","Lois","Tina","Phyllis","Norma","Paula","Diana","Annie","Lillian","Emily","Robin" }
local userName2 = { "Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodriguez","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Adams","Baker","Gonzalez","Nelson","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Sanders","Price","Bennett","Wood","Barnes","Ross","Henderson","Coleman","Jenkins","Perry","Powell","Long","Patterson","Hughes","Flores","Washington","Butler","Simmons","Foster","Gonzales","Bryant","Alexander","Russell","Griffin","Diaz","Hayes" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.requestPerm(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if exports["hud"]:Wanted(Passport,source) then
			return false
		end

		if shops[Type]["perm"] ~= nil then
			if not vRP.HasService(Passport,shops[Type]["perm"]) then
				return false
			end
		end

		if shops[Type]["required"] ~= nil then
			for Index,v in pairs(shops[Type]["required"]) do
				local consultItem = vRP.InventoryItemAmount(Passport,Index)
				if consultItem[1] < parseInt(v) then
					return false
				end
			end
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.requestShop(name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local shopSlots = 20
		local inventoryShop = {}
		for k,v in pairs(shops[name]["List"]) do
			inventoryShop[#inventoryShop + 1] = { key = k, price = parseInt(v), name = itemName(k), index = itemIndex(k), peso = itemWeight(k), economy = parseFormat(itemEconomy(k)), max = itemMaxAmount(k), desc = itemDescription(k) }
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
			v["desc"] = itemDescription(v["item"])
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

		if parseInt(#inventoryShop) > 20 then
			shopSlots = parseInt(#inventoryShop)
		end

		return inventoryShop,inventoryUser,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),shopSlots
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.getShopType(Type)
    return shops[Type]["mode"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.functionShops(Type,Item,Amount,Slot)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if shops[Type] then
			if Amount <= 0 then Amount = 1 end

			local inventory = vRP.Inventory(Passport)
			if (inventory[tostring(Slot)] and inventory[tostring(Slot)]["item"] == Item) or not inventory[tostring(Slot)] then
				if shops[Type]["mode"] == "Buy" then
					if vRP.MaxItens(Passport,Item,Amount) then
						TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
						vCLIENT.updateShops(source,"requestShop")
						return
					end

					if (vRP.InventoryWeight(Passport) + itemWeight(Item) * Amount) <= vRP.GetWeight(Passport) then
						if shops[Type]["type"] == "Cash" then
							if shops[Type]["List"][Item] then
								local Split = splitString(Item,"-")
								if Split[1] == "badge04" then
									if Split[2] and not vRP.HasService(Passport,Split[2]) then
										return
									end
								end

								if vRP.PaymentFull(Passport,shops[Type]["List"][Item] * Amount) then
									if Item == "identity" or string.sub(Item,1,5) == "badge" then
										local Split = splitString(Item,"-")
										if Split[1] == "badge04" then
											vRP.GiveItem(Passport,Split[1].."-"..Passport,Amount,false,Slot)
										else
											vRP.GiveItem(Passport,Item.."-"..Passport,Amount,false,Slot)
										end
									elseif Item == "fidentity" then
										local Identity = vRP.Identity(Passport)
										if Identity then
											if Identity["sex"] == "M" then
												vRP.Query("fidentity/NewIdentity",{ name = nameMale[math.random(#nameMale)], name2 = userName2[math.random(#userName2)], blood = math.random(4) })
											else
												vRP.Query("fidentity/NewIdentity",{ name = nameFemale[math.random(#nameFemale)], name2 = userName2[math.random(#userName2)], blood = math.random(4) })
											end

											local Identity = vRP.Identity(Passport)
											local consult = vRP.Query("fidentity/GetIdentity")
											if consult[1] then
												vRP.GiveItem(Passport,Item.."-"..consult[1]["id"],Amount,false,Slot)
											end
										end
									else
										vRP.GenerateItem(Passport,Item,Amount,false,Slot)

										if Item == "WEAPON_PETROLCAN" then
											vRP.GenerateItem(Passport,"WEAPON_PETROLCAN_AMMO",4500,false)
										end

										if shops[Type]["shop"] then
											local Split = splitString(Type,"-")
											
											vRP.DirectChest(Split[1],"500",(shops[Type]["List"][Item] * Amount) * 0.05)
										end
									end

									TriggerClientEvent("sounds:Private",source,"cash",0.1)

									TriggerEvent("Discord",Type,"**Passaporte:** "..Passport.."\n**Comprou:** "..Amount.."x "..itemName(Item),10181046)
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
								end
							end
						elseif shops[Type]["type"] == "Consume" then
							if vRP.TakeItem(Passport,shops[Type]["item"],parseInt(shops[Type]["List"][Item] * Amount)) then
								vRP.GenerateItem(Passport,Item,Amount,false,Slot)
								TriggerClientEvent("sounds:Private",source,"cash",0.1)

								TriggerEvent("Discord",Type,"**Passaporte:** "..Passport.."\n**Comprou:** "..Amount.."x "..itemName(Item),10181046)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(shops[Type]["item"]).."</b> insuficiente.",5000)
							end
						elseif shops[Type]["type"] == "Premium" then
							if vRP.PaymentGems(Passport,shops[Type]["List"][Item] * Amount) then
								TriggerClientEvent("sounds:Private",source,"cash",0.1)
								vRP.GenerateItem(Passport,Item,Amount,false,Slot)
								TriggerClientEvent("Notify",source,"verde","Comprou <b>"..Amount.."x "..itemName(Item).."</b> por <b>"..shops[Type]["List"][Item] * Amount.." Gemas</b>.",5000)

								TriggerEvent("Discord",Type,"**Passaporte:** "..Passport.."\n**Comprou:** "..Amount.."x "..itemName(Item),10181046)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
							end
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				elseif shops[Type]["mode"] == "Sell" then
					local splitName = splitString(Item,"-")

					if shops[Type]["List"][splitName[1]] then
						local itemPrice = shops[Type]["List"][splitName[1]]

						if itemPrice > 0 then
							if vRP.CheckDamaged(Item) then
								TriggerClientEvent("Notify",source,"vermelho","Itens danificados não podem ser vendidos.",5000)
								vCLIENT.updateShops(source,"requestShop")
								return
							end
						end

						if shops[Type]["type"] == "Consume" then
							if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
								if itemPrice > 0 then
									vRP.GenerateItem(Passport,shops[Type]["item"],parseInt(itemPrice * Amount),false)
									TriggerClientEvent("sounds:Private",source,"cash",0.1)
								end
							end
						else
							if shops[Type]["type"] == "Cash" then
								if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
									if itemPrice > 0 then
										if GlobalState["Buffs"]["Dexterity"][Passport] then
											if GlobalState["Buffs"]["Dexterity"][Passport] > os.time() then
												itemPrice = itemPrice + (itemPrice * 0.1)
											end
										end

										if vRP.UserPremium(Passport) then
											if vRP.HasGroup(Passport,"Premium",1) then
												itemPrice = itemPrice + (itemPrice * 0.1)
											elseif vRP.HasGroup(Passport,"Premium",2) then
												itemPrice = itemPrice + (itemPrice * 0.15)
											elseif vRP.HasGroup(Passport,"Premium",3) then
												itemPrice = itemPrice + (itemPrice * 0.2)
											end
										end

										vRP.GenerateItem(Passport,"dollars",parseInt(itemPrice * Amount),false)

										TriggerClientEvent("sounds:Private",source,"cash",0.1)
									end
								end
							elseif shops[Type]["type"] == "Cashz" then
								if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
									if itemPrice > 0 then
										vRP.GenerateItem(Passport,"dollarsz",parseInt(itemPrice * Amount),false)

										TriggerClientEvent("sounds:Private",source,"cash",0.1)
									end
								end
							end
						end
					end
				end
			end
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
			vRP.GiveItem(Passport,Item,Amount,false,Target)
			vCLIENT.updateShops(source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(Item,Slot,Target,Amount)
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

		vCLIENT.updateShops(source,"requestShop")
	end
end)