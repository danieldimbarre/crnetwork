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
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	["Departament"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["worm"] = 5,
			["postit"] = 20,
			["cigarette"] = 10,
			["lighter"] = 175,
			["rope"] = 925,
			["radio"] = 975,
			["vape"] = 4750,
			["scuba"] = 975,
			["fishingrod"] = 725,
			["cellphone"] = 725,
			["camera"] = 425,
			["binoculars"] = 425,
			["suitcase"] = 275,
			["WEAPON_BRICK"] = 25,
			["WEAPON_SHOES"] = 25,
			["alliancemale"] = 525,
			["alliancefemale"] = 525,
			["pickaxe"] = 725,
			["emptybottle"] = 3,
			["guarananatural"] = 50,
			["tangejuice"] = 65,
			["passionjuice"] = 75,
			["strawberryjuice"] = 65,
			["grapejuice"] = 65,
			["milkshakepeanut"] = 65,
			["coffeemilk"] = 50,
			["friesbacon"] = 35,
			["hamburger3"] = 75,
			["hamburger2"] = 75,
			["onionrings"] = 50,
			["cookies"] = 30,
			["calzone"] = 75,
			["chickenfries"] = 65,
			["bananajuice"] = 65,
			["acerolajuice"] = 65,
			["orangejuice"] = 65,
			["applelove"] = 35,
			["pizzamozzarella"] = 75,
			["pizzabanana"] = 75,
			["pizzachocolate"] = 75,
			["milkshake"] = 65,
			["cappuccino"] = 75,
			["nigirizushi"] = 35,
			["sushi"] = 35,
			["cupcake"] = 35
		}
	},
	["Fuel"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["WEAPON_PETROLCAN"] = 250
		}
	},
	["Pharmacy"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["medkit"] = 575,
			["bandage"] = 225,
			["gauze"] = 100,
			["analgesic"] = 125
		}
	},
	["Paramedico"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["Permission"] = "Paramedico",
		["List"] = {
			["syringe01"] = 50,
			["syringe02"] = 50,
			["syringe03"] = 50,
			["syringe04"] = 50,
			["bandage"] = 115,
			["gauze"] = 50,
			["gdtkit"] = 20,
			["medkit"] = 285,
			["sinkalmy"] = 185,
			["analgesic"] = 65,
			["ritmoneury"] = 235,
			["medicbag"] = 425
		}
	},
	["Ammunation"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["WEAPON_HATCHET"] = 975,
			["WEAPON_BAT"] = 975,
			["WEAPON_BATTLEAXE"] = 975,
			["WEAPON_GOLFCLUB"] = 975,
			["WEAPON_HAMMER"] = 975,
			["WEAPON_MACHETE"] = 975,
			["WEAPON_POOLCUE"] = 975,
			["WEAPON_STONE_HATCHET"] = 975,
			["WEAPON_KNUCKLE"] = 975,
			["WEAPON_FLASHLIGHT"] = 975,
			["GADGET_PARACHUTE"] = 225,
			["WEAPON_CROWBAR"] = 725,
			["WEAPON_WRENCH"] = 725
		}
	},
	["Lixeiro"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["plastic"] = 8,
			["glass"] = 8,
			["rubber"] = 8,
			["aluminum"] = 10,
			["copper"] = 10
		}
	},
	["Hunting"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["boar1star"] = 275,
			["boar2star"] = 300,
			["boar3star"] = 325,
			["deer1star"] = 275,
			["deer2star"] = 300,
			["deer3star"] = 325,
			["coyote1star"] = 275,
			["coyote2star"] = 300,
			["coyote3star"] = 325,
			["mtlion1star"] = 275,
			["mtlion2star"] = 300,
			["mtlion3star"] = 325
		}
	},
	["Hunting2"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["List"] = {
			["ration"] = 125,
			["WEAPON_SWITCHBLADE"] = 725,
			["WEAPON_MUSKET"] = 3250,
			["WEAPON_SAUER"] = 7225,
			["WEAPON_MUSKET_AMMO"] = 10
		}
	},
	["Fishing"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["sardine"] = 65,
			["smalltrout"] = 65,
			["orangeroughy"] = 65,
			["anchovy"] = 70,
			["catfish"] = 70,
			["herring"] = 75,
			["yellowperch"] = 75,
			["salmon"] = 100,
			["smallshark"] = 250
		}
	},
	["Recycle"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["techtrash"] = 75,
			["tarp"] = 50,
			["sheetmetal"] = 50,
			["roadsigns"] = 50,
			["explosives"] = 75,
			["sulfuric"] = 50,
			["saline"] = 25,
			["alcohol"] = 25,
			["camera"] = 175,
			["binoculars"] = 175
		}
	},
	["Miners"] = {
		["Mode"] = "Sell",
		["Type"] = "Cash",
		["List"] = {
			["rock"] = 50
		}
	},
	["Policia"] = {
		["Mode"] = "Buy",
		["Type"] = "Cash",
		["Permission"] = "Policia",
		["List"] = {
			["vest"] = 100,
			["gsrkit"] = 10,
			["gdtkit"] = 10,
			["barrier"] = 25,
			["handcuff"] = 125,
			["WEAPON_SMG"] = 2725,
			["WEAPON_STUNGUN"] = 725,
			["WEAPON_PUMPSHOTGUN"] = 2725,
			["WEAPON_CARBINERIFLE"] = 3225,
			["WEAPON_TACTICALRIFLE"] = 3725,
			["WEAPON_CARBINERIFLE_MK2"] = 4725,
			["WEAPON_FNSCAR"] = 4725,
			["WEAPON_PUMPSHOTGUN_MK2"] = 3225,
			["WEAPON_SPECIALCARBINE_MK2"] = 4725,
			["WEAPON_COMBATPISTOL"] = 1225,
			["WEAPON_HEAVYPISTOL"] = 1225,
			["WEAPON_NIGHTSTICK"] = 325,
			["WEAPON_PISTOL_AMMO"] = 2,
			["WEAPON_SMG_AMMO"] = 2,
			["WEAPON_RIFLE_AMMO"] = 2,
			["WEAPON_SHOTGUN_AMMO"] = 2
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permission(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if List[Type] and List[Type]["Permission"] and not vRP.HasService(Passport,List[Type]["Permission"]) then
			return false
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Request(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Name or not List[Name] or not List[Name]["List"] then
			exports["megazord"]:Discord("**Passaporte:** "..Passport.."\n**Função:** Request do shops",source)
		end

		if List[Name] then
			local Shop = {}
			local Slots = 30
			for Index,v in pairs(List[Name]["List"]) do
				Shop[#Shop + 1] = { key = Index, price = parseInt(v), name = ItemName(Index), index = ItemIndex(Index), peso = ItemWeight(Index) }
			end

			local Inventory = {}
			local Inv = vRP.Inventory(Passport)
			for Index,v in pairs(Inv) do
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

			if parseInt(#Shop) > 30 then
				Slots = parseInt(#Shop)
			end

			return Shop,Inventory,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),Slots
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ShopType(Type)
	if List[Type] and List[Type]["Mode"] then
		return List[Type]["Mode"]
	end

	return "Buy"
end
---------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.functionShops(Type,Item,Amount,Slot)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and List[Type] then
		if Amount > 1 and ItemUnique(Item) then
			Amount = 1
		end

		local Inv = vRP.Inventory(Passport)
		if (Inv[Slot] and Inv[Slot]["item"] == Item) or not Inv[Slot] then
			if List[Type]["Mode"] == "Buy" then
				if vRP.MaxItens(Passport,Item,Amount) then
					TriggerClientEvent("Notify",source,"Aviso","Limite atingido.","amarelo",5000)
					vCLIENT.Update(source,"Request")

					return false
				end

				if vRP.CheckWeight(Passport,Item,Amount) then
					if List[Type]["Type"] == "Cash" then
						if List[Type]["List"][Item] then
							if vRP.PaymentFull(Passport,List[Type]["List"][Item] * Amount) then
								vRP.GenerateItem(Passport,Item,Amount,false,Slot)

								if Item == "WEAPON_PETROLCAN" then
									vRP.GenerateItem(Passport,"WEAPON_PETROLCAN_AMMO",4500,false)
								end

								TriggerClientEvent("sounds:Private",source,"cash",0.1)
							else
								TriggerClientEvent("Notify",source,"Aviso","<b>Dólares</b> insuficientes.","amarelo",5000)
							end
						end
					elseif List[Type]["Type"] == "Consume" then
						if vRP.TakeItem(Passport,List[Type]["Item"],parseInt(List[Type]["List"][Item] * Amount)) then
							vRP.GenerateItem(Passport,Item,Amount,false,Slot)
						else
							TriggerClientEvent("Notify",source,"Atenção","<b>"..ItemName(List[Type]["Item"]).."</b> insuficiente.","amarelo",5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"Aviso","Mochila cheia.","amarelo",5000)
				end
			elseif List[Type]["Mode"] == "Sell" then
				local Split = splitString(Item)[1]

				if List[Type]["List"][Split] then
					local itemPrice = List[Type]["List"][Split]

					if itemPrice > 0 and vRP.CheckDamaged(Item) then
						TriggerClientEvent("Notify",source,"Atenção","Itens danificados não podem ser vendidos.","amarelo",5000)
						vCLIENT.Update(source,"Request")

						return false
					end

					if List[Type]["Type"] == "Cash" then
						if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
							if itemPrice > 0 then
								vRP.GenerateItem(Passport,"dollar",parseInt(itemPrice * Amount),false)
								TriggerClientEvent("sounds:Private",source,"cash",0.1)
							end
						end
					elseif List[Type]["Type"] == "Consume" then
						if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
							if itemPrice > 0 then
								vRP.GenerateItem(Passport,List[Type]["Item"],parseInt(itemPrice * Amount),false)
							end
						end
					end
				end
			end
		end

		vCLIENT.Update(source,"Request")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
			vRP.GiveItem(Passport,Item,Amount,false,Target)
			vCLIENT.Update(source,"Request")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport then
		local Inv = vRP.Inventory(Passport)
		if Inv[Slot] and Inv[Target] and Inv[Slot]["item"] == Inv[Target]["item"] then
			if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
				vRP.GiveItem(Passport,Item,Amount,false,Target)
			end
		else
			vRP.SwapSlot(Passport,Slot,Target)
		end

		vCLIENT.Update(source,"Request")
	end
end)