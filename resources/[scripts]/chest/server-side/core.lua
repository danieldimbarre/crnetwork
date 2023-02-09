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
Tunnel.bindInterface("chest",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permissions(Name,Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Wanted(Passport) then
		if Mode == "Personal" then
			Open[Passport] = { ["Name"] = Passport, ["Weight"] = 50, ["Mode"] = Mode, ["Logs"] = false, ["Save"] = true }
			return true
		elseif Mode == "Evidences" and vRP.HasService(Passport,"Police") then
			local Keyboard = vKEYBOARD.keySingle(source,"Passaporte:")
			if Keyboard then
				Open[Passport] = { ["Name"] = "Evidences:"..Keyboard[1], ["Weight"] = 50, ["Logs"] = false, ["Save"] = true }
				return true
			end
		elseif Mode == "Custom" then
			local Split = splitString(Name)
			if Split[1] == "Helicrash" and GlobalState["HelicrashCooldown"] > os.time() then
				vRPC.DowngradeHealth(source,10)
				TriggerClientEvent("Notify",source,"aviso","A caixa ainda está quente! Aguarde <b>"..parseInt(GlobalState["HelicrashCooldown"] - os.time()).."</b> segundos.",3000)
				return
			end

			Open[Passport] = { ["Name"] = Name, ["Weight"] = 50, ["Mode"] = Mode, ["Logs"] = false, ["Save"] = false }
			return true
		elseif Mode == "Restaurants" then
			local Consult = vRP.Query("chests/GetChests",{ name = Name })
			if Consult[1] then
				local PermSplit = splitString(Consult[1]["perm"],"-")

				if (PermSplit[2] and vRP.HasGroup(Passport,PermSplit[1],parseInt(PermSplit[2]))) or vRP.HasService(Passport,Consult[1]["perm"]) then
					Open[Passport] = { ["Name"] = Name, ["Weight"] = Consult[1]["weight"], ["Mode"] = Mode, ["Logs"] = false, ["Save"] = true }
					return true
				end
			end
		else
			local NameSplit = splitString(Name,"-")
			if NameSplit[1] == "trayShot" or NameSplit[1] == "trayDesserts" or NameSplit[1] == "trayPizza" or NameSplit[1] == "trayBean" then
				Open[Passport] = { ["Name"] = Name, ["Weight"] = 15, ["Mode"] = Mode, ["Logs"] = false, ["Save"] = true }
				return true
			end

			local Consult = vRP.Query("chests/GetChests",{ name = Name })
			if Consult[1] then
				local PermSplit = splitString(Consult[1]["perm"],"-")

				if (PermSplit[2] and vRP.HasGroup(Passport,PermSplit[1],parseInt(PermSplit[2]))) or vRP.HasService(Passport,Consult[1]["perm"]) then
					Open[Passport] = { ["Name"] = Name, ["Weight"] = Consult[1]["weight"], ["Mode"] = Mode, ["Logs"] = Consult[1]["logs"], ["Save"] = true }
					return true
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Chest()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		local Inventory = {}
		local Inv = vRP.Inventory(Passport)
		for Index,v in pairs(Inv) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["key"] = v["item"]
			v["slot"] = Index

			local Split = splitString(v["item"],"-")
			if Split[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			Inventory[Index] = v
		end

		local Chest = {}
		local Result = vRP.GetSrvData("Chest:"..Open[Passport]["Name"],Open[Passport]["Save"])
		for Index,v in pairs(Result) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			local Split = splitString(v["item"],"-")
			if Split[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			Chest[Index] = v
		end

		return Inventory,Chest,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local OpenItens = {
	["mechanicpass"] = {
		["Open"] = "Mechanic",
		["Table"] = {
			{ ["Item"] = "advtoolbox", ["Amount"] = 1 },
			{ ["Item"] = "toolbox", ["Amount"] = 2 },
			{ ["Item"] = "tyres", ["Amount"] = 4 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["uwucoffeepass"] = {
		["Open"] = "UwuCoffee",
		["Table"] = {
			{ ["Item"] = "nigirizushi", ["Amount"] = 3 },
			{ ["Item"] = "sushi", ["Amount"] = 3 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["pizzathispass"] = {
		["Open"] = "PizzaThis",
		["Table"] = {
			{ ["Item"] = "nigirizushi", ["Amount"] = 3 },
			{ ["Item"] = "sushi", ["Amount"] = 3 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["burgershotpass"] = {
		["Open"] = "BurgerShot",
		["Table"] = {
			{ ["Item"] = "hamburger2", ["Amount"] = 1 },
			{ ["Item"] = "cookedmeat", ["Amount"] = 2 },
			{ ["Item"] = "cookedfishfillet", ["Amount"] = 1 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["paramedicpass"] = {
		["Open"] = "Paramedic",
		["Table"] = {
			{ ["Item"] = "gauze", ["Amount"] = 3 },
			{ ["Item"] = "medkit", ["Amount"] = 1 },
			{ ["Item"] = "analgesic", ["Amount"] = 4 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["lockpick"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["card01"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["card02"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["card03"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["card04"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["card05"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["c4"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["pliers"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["pliers"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["rope"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["pendrive"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["credential"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["explosives"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["pistolbody"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["smgbody"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["riflebody"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["silvercoin"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 10 }
		}
	},
	["goldcoin"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 10 }
		}
	},
	["WEAPON_NAILGUN"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_HATCHET"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_BAT"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_KATANA"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_KARAMBIT"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_BATTLEAXE"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_CROWBAR"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_GOLFCLUB"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_HAMMER"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_MACHETE"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_POOLCUE"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_STONE_HATCHET"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_WRENCH"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	},
	["WEAPON_KNUCKLE"] = {
		["Open"] = { "Police","Police-2","Police-3","Police-4","Police-5","Police-6" },
		["Table"] = {
			{ ["Item"] = "dollars", ["Amount"] = 20 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Store(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		if Amount <= 0 then Amount = 1 end

		local Restaurant = splitString(Open[Passport]["Name"],"-")
		local _,Shop = BlockRestaurant(Restaurant[1],Item)
		if itemBlock(Item) or (Open[Passport]["Mode"] == "Restaurants" and not Shop) then
			TriggerClientEvent("chest:Update",source,"Refresh")
			return
		end

		local Split = splitString(Item,"-")
		if OpenItens[Split[1]] then
			local Perm = false
			if type(OpenItens[Split[1]]["Open"]) == "string" and OpenItens[Split[1]]["Open"] == Open[Passport]["Name"] then
				Perm = true
			elseif type(OpenItens[Split[1]]["Open"]) == "table" then
				for _,Permission in pairs(OpenItens[Split[1]]["Open"]) do
					if (Split[2] and vRP.HasGroup(Passport,Split[1],parseInt(Split[2]))) or vRP.HasService(Passport,Permission) then
						Perm = true
						break
					end
				end
			end

			if Perm then
				if vRP.TakeItem(Passport,Item,Amount) then
					for _,v in pairs(OpenItens[Split[1]]["Table"]) do
						vRP.GenerateItem(Passport,v["Item"],v["Amount"] * Amount,true)
					end
				end

				TriggerClientEvent("chest:Update",source,"Refresh")
				return
			end
		end

		if Open[Passport]["Mode"] == "Restaurants" then
			Target = Shop

			local Result = vRP.GetSrvData("Chest:"..Open[Passport]["Name"],Open[Passport]["Save"])
			if vRP.ChestWeight(Result) + (itemWeight(Split[1]) * Amount) <= Open[Passport]["Weight"] then
				if Result[Target] then
					Result[Target]["amount"] = Result[Target]["amount"] + Amount
				else
					Result[Target] = { ["item"] = Split[1], ["amount"] = Amount }
				end

				vRP.RemoveItem(Passport,Item,Amount,true)
				vRP.SetSrvData("Chest:"..Open[Passport]["Name"],Result,Open[Passport]["Save"])
				TriggerClientEvent("chest:Update",source,"Update",vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"])

				if Open[Passport]["Logs"] then
					TriggerEvent("Discord",Open[Passport]["Name"],"**Passaporte:** "..Passport.."\n**Guardou:** "..Amount.."x "..itemName(Item),3042892)
				end
			end

			TriggerClientEvent("chest:Update",source,"Refresh")
		else
			if vRP.StoreChest(Passport,"Chest:"..Open[Passport]["Name"],Amount,Open[Passport]["Weight"],Slot,Target) then
				TriggerClientEvent("chest:Update",source,"Refresh")
			else
				local Result = vRP.GetSrvData("Chest:"..Open[Passport]["Name"],Open[Passport]["Save"])
				TriggerClientEvent("chest:Update",source,"Update",vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"])
				TriggerClientEvent("chest:Update",source,"Refresh")
	
				if Open[Passport]["Logs"] then
					TriggerEvent("Discord",Open[Passport]["Name"],"**Passaporte:** "..Passport.."\n**Guardou:** "..Amount.."x "..itemName(Item),3042892)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		if Amount <= 0 then Amount = 1 end

		if Open[Passport]["Mode"] ~= "Restaurants" then
			local Result = vRP.GetSrvData("Chest:"..Open[Passport]["Name"],Open[Passport]["Save"])
			if vRP.ChestWeight(Result) > 50 and Item == "diagram" then
				if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
					vRP.Query("chests/UpdateChests",{ name = Open[Passport]["Name"] })
					TriggerClientEvent("chest:Update",source,"Refresh")
				end
			else
				if vRP.TakeChest(Passport,"Chest:"..Open[Passport]["Name"],Amount,Slot,Target) then
					TriggerClientEvent("chest:Update",source,"Refresh")
				else
					Result = vRP.GetSrvData("Chest:"..Open[Passport]["Name"],Open[Passport]["Save"])
					TriggerClientEvent("chest:Update",source,"Update",vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"])
					TriggerClientEvent("chest:Update",source,"Refresh")

					if string.sub(Open[Passport]["Name"],1,9) == "Helicrash" and vRP.ChestWeight(Result) <= 0 then
						TriggerClientEvent("chest:Close",source)
						exports["helicrash"]:Box()
					end

					if Open[Passport]["Logs"] then
						TriggerEvent("Discord",Open[Passport]["Name"],"**Passaporte:** "..Passport.."\n**Retirou:** "..Amount.."x "..itemName(Item),9317187)
					end
				end
			end
		else
			TriggerClientEvent("chest:Update",source,"Refresh")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Update(Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		if Amount <= 0 then Amount = 1 end

		if vRP.UpdateChest(Passport,"Chest:"..Open[Passport]["Name"],Slot,Target,Amount) then
			TriggerClientEvent("chest:Update",source,"Refresh")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPGRADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chest:Upgrade")
AddEventHandler("chest:Upgrade",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Split = splitString(Name,"-")

		if (Split[2] and vRP.HasGroup(Passport,Split[1],parseInt(Split[2]))) or vRP.HasService(Passport,Name) then
			if vRP.Request(source,"Aumentar <b>10kg</b> por <b>$10.000</b> dólares?","Sim, efetuar pagamento","Não, decido depois") then
				if vRP.PaymentFull(Passport,10000) then
					vRP.Query("chests/UpdateChests",{ name = Name })
					TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Open[Passport] then
		Open[Passport] = nil
	end
end)