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
local Cooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local ChestItens = {
	["backpackp"] = {
		["Slots"] = 20,
		["Weight"] = 50,
		["Block"] = true
	},
	["backpackm"] = {
		["Slots"] = 25,
		["Weight"] = 75,
		["Block"] = true
	},
	["backpackg"] = {
		["Slots"] = 30,
		["Weight"] = 100,
		["Block"] = true
	},
	["suitcase"] = {
		["Slots"] = 20,
		["Weight"] = 0,
		["Block"] = false,
		["Itens"] = {
			["dollar"] = true,
			["dirtydollar"] = true,
			["wetdollar"] = true,
			["promissory"] = true
		}
	},
	["treasurebox"] = {
		["Slots"] = 20,
		["Weight"] = 50,
		["Block"] = false
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permissions(Name,Mode,Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Mode == "Personal" then
			Open[Passport] = {
				["Name"] = "Personal:"..Passport,
				["Weight"] = 50,
				["Logs"] = false,
				["Save"] = true,
				["Slots"] = 50
			}

			return true
		elseif Mode == "Tray" then
			Open[Passport] = {
				["Name"] = Name,
				["Weight"] = 25,
				["Logs"] = false,
				["Save"] = false,
				["Slots"] = 20
			}

			return true
		elseif Mode == "Custom" or Mode == "Trash" then
			if SplitOne(Name,":") == "Helicrash" and Cooldown[Name] and Cooldown[Name] > os.time() then
				TriggerClientEvent("Notify",source,"Aviso","Aguarde até que esfrie o compartimento.","amarelo",10000)
				vRPC.DowngradeHealth(source,50)

				return false
			end

			if Mode == "Trash" then
				Name = "Trash:"..Name
			end

			Open[Passport] = {
				["Name"] = Name,
				["Weight"] = 50,
				["Logs"] = false,
				["Save"] = false,
				["Slots"] = 20,
				["Mode"] = "Custom"
			}

			return true
		elseif Mode == "Item" then
			local Previous = SplitOne(Name,":")
			if ChestItens[Previous] then
				Open[Passport] = {
					["Name"] = Name,
					["Save"] = true,
					["Logs"] = false,
					["Unique"] = Previous,
					["Slots"] = ChestItens[Previous]["Slots"],
					["Weight"] = ChestItens[Previous]["Weight"]
				}

				if Item then
					Open[Passport]["Item"] = Item
				end

				return true
			end
		else
			local Consult = vRP.Query("chests/GetChests",{ Name = Name })
			if not Consult[1] then
				vRP.Query("chests/AddChests",{ Name = Name })
				Consult = vRP.Query("chests/GetChests",{ Name = Name })
			end

			if Consult[1] and vRP.HasService(Passport,Consult[1]["Permission"]) then
				Open[Passport] = {
					["Slots"] = Consult[1]["Slots"],
					["Weight"] = Consult[1]["Weight"],
					["NameLogs"] = Name,
					["Name"] = "Chest:"..Name,
					["Logs"] = Consult[1]["Logs"],
					["Permission"] = Consult[1]["Permission"],
					["Save"] = true
				}

				return true
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
		local Chest = {}
		local Inventory = {}
		local Inv = vRP.Inventory(Passport)

		for Index,v in pairs(Inv) do
			if (parseInt(v["amount"]) <= 0 or not ItemExist(v["item"])) then
				vRP.RemoveItem(Passport,v["item"],parseInt(v["amount"]),false)
			else
				v["amount"] = parseInt(v["amount"])
				v["peso"] = ItemWeight(v["item"])
				v["index"] = ItemIndex(v["item"])
				v["name"] = ItemName(v["item"])
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

		local Result = vRP.GetSrvData(Open[Passport]["Name"],Open[Passport]["Save"])
		for Index,v in pairs(Result) do
			if (parseInt(v["amount"]) <= 0 or not ItemExist(v["item"])) then
				vRP.RemoveChest(Open[Passport]["Name"],Index,Open[Passport]["Save"])
			else
				v["amount"] = parseInt(v["amount"])
				v["peso"] = ItemWeight(v["item"])
				v["index"] = ItemIndex(v["item"])
				v["name"] = ItemName(v["item"])
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

				Chest[Index] = v
			end
		end

		return Inventory,Chest,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"],Open[Passport]["Slots"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Store(Item,Slot,Amount,Target,Block)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		if BlockDelete(Item) or Block then
			TriggerClientEvent("chest:Update",source,"Refresh")

			return false
		end

		if Item == "diagram" and Open[Passport]["NameLogs"] then
			if vRP.TakeItem(Passport,Item,Amount) then
				Open[Passport]["Weight"] = Open[Passport]["Weight"] + (10 * Amount)

				local Result = vRP.GetSrvData(Open[Passport]["Name"],Open[Passport]["Save"])
				vRP.Query("chests/UpdateWeight",{ Name = Open[Passport]["NameLogs"], Multiplier = Amount })
				TriggerClientEvent("chest:Update",source,"Update",vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"])
				TriggerClientEvent("chest:Update",source,"Refresh")
			end
		else
			local Item = SplitOne(Item)
			local Unique = Open[Passport]["Unique"]

			if Unique and ChestItens[Unique] and ((ChestItens[Item] and ChestItens[Item]["Block"]) or (ChestItens[Unique]["Itens"] and not ChestItens[Unique]["Itens"][Item])) then
				TriggerClientEvent("chest:Update",source,"Refresh")

				return false
			end

			if vRP.StoreChest(Passport,Open[Passport]["Name"],Amount,Open[Passport]["Weight"],Slot,Target,Open[Passport]["Save"],ChestItens[Unique]) then
				TriggerClientEvent("chest:Update",source,"Refresh")
			else
				local Result = vRP.GetSrvData(Open[Passport]["Name"],Open[Passport]["Save"])
				TriggerClientEvent("chest:Update",source,"Update",vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"])

				if Open[Passport]["Logs"] then
					exports["discord"]:Embed(Open[Passport]["NameLogs"],"**Passaporte:** "..Passport.."\n**Guardou:** "..Amount.."x "..ItemName(Item),0xa3c846)
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
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		if vRP.TakeChest(Passport,Open[Passport]["Name"],Amount,Slot,Target,Open[Passport]["Save"]) then
			TriggerClientEvent("chest:Update",source,"Refresh")
		else
			local Result = vRP.GetSrvData(Open[Passport]["Name"],Open[Passport]["Save"])
			if (Open[Passport]["Mode"] or Open[Passport]["Item"]) and json.encode(Result) == "[]" then
				TriggerClientEvent("chest:Close",source)

				if Open[Passport]["Item"] then
					vRP.RemoveItem(Passport,Open[Passport]["Item"],1,false)
				end

				if SplitOne(Open[Passport]["Name"],":") == "Helicrash" then
					exports["helicrash"]:Box()
				end
			else
				TriggerClientEvent("chest:Update",source,"Update",vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"])

				if Open[Passport]["Logs"] then
					exports["discord"]:Embed(Open[Passport]["NameLogs"],"**Passaporte:** "..Passport.."\n**Retirou:** "..Amount.."x "..ItemName(Item),0xe84855)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Update(Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount,true)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] and vRP.UpdateChest(Passport,Open[Passport]["Name"],Slot,Target,Amount,Open[Passport]["Save"]) then
		TriggerClientEvent("chest:Update",source,"Refresh")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:COOLDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chest:Cooldown")
AddEventHandler("chest:Cooldown",function(Name)
	Cooldown[Name] = os.time() + math.random(600,900)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Open[Passport] then
		Open[Passport] = nil
	end
end)