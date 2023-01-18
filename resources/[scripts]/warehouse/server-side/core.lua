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
Tunnel.bindInterface("warehouse",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local Informations = {
	["1"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["2"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["3"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["4"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["5"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["6"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["7"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["8"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["9"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["10"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["11"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["12"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["13"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["14"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["15"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["16"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["17"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["18"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["19"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["20"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["21"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["22"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["23"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["24"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["25"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["26"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["27"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["28"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["29"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["30"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["31"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["32"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["33"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["34"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["35"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["36"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["37"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["38"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["39"] = { ["Price"] = 100000, ["Weight"] = 100 },
	["40"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["41"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["42"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["43"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["44"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["45"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["46"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["47"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["48"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["49"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["50"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["51"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["52"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["53"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["54"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["55"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["56"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["57"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["58"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["59"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["60"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["61"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["62"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["63"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["64"] = { ["Price"] = 200000, ["Weight"] = 200 },
	["65"] = { ["Price"] = 200000, ["Weight"] = 200 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE:PASSWORD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("warehouse:Password")
AddEventHandler("warehouse:Password",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Warehouse = vRP.Query("warehouse/Informations",{ name = Name })
		if Warehouse[1] and Warehouse[1]["Passport"] == Passport then
			local Keyboard = vKEYBOARD.keyWord(source,"Nova Senha:")
			if Keyboard then
				local Password = sanitizeString(Keyboard[1],"0123456789",true)
				if string.len(Password) >= 4 and string.len(Password) <= 20 then
					vRP.Query("warehouse/Password",{ name = Name, password = Password })
					TriggerClientEvent("Notify",source,"verde","Senha atualizada.",5000)
				else
					TriggerClientEvent("Notify",source,"amarelo","Necessário possuir entre <b>4</b> e <b>20</b> números.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Warehouse(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not exports["hud"]:Wanted(Passport) then
			local Warehouse = vRP.Query("warehouse/Informations",{ name = Name })
			if Warehouse[1] then
				local Keyboard = vKEYBOARD.keyWord(source,"Senha:")
				if Keyboard then
					local Warehouse = vRP.Query("warehouse/Acess",{ name = Name, password = Keyboard[1] })
					if Warehouse[1] then
						if Warehouse[1]["tax"] > os.time() then
							return true
						else
							if vRP.Request(source,"Pagar o aluguel do armazém por <b>$20.000</b>?","Sim, por favor","Não, decido depois") then
								if vRP.PaymentFull(Passport,20000) then
									vRP.Query("warehouse/Tax",{ name = Name })
									return true
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
								end
							end
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Senha incorreta.",5000)
					end
				end
			else
				if Informations[Name]["Price"] then
					if vRP.Request(source,"Gostaria de comprar o armazém por <b>$"..parseFormat(Informations[Name]["Price"]).."</b>?","Sim, por favor","Não, decido depois") then
						local Keyboard = vKEYBOARD.keyWord(source,"Senha:")
						if Keyboard then
							local Password = sanitizeString(Keyboard[1],"0123456789",true)
							if string.len(Password) >= 4 and string.len(Password) <= 20 then
								if vRP.Request(source,"Finalizar a compra usando a senha <b>"..Password.."</b>?","Sim, por favor","Não, decido depois") then
									if vRP.PaymentFull(Passport,Informations[Name]["Price"]) then
										vRP.Query("warehouse/Buy",{ name = Name, weight = Informations[Name]["Weight"], Passport = Passport, password = Password })
										return true
									else
										TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
									end
								end
							else
								TriggerClientEvent("Notify",source,"amarelo","Necessário possuir entre <b>4</b> e <b>20</b> números.",5000)
							end
						end
					end
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE:UPGRADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("warehouse:Upgrade")
AddEventHandler("warehouse:Upgrade",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Warehouse = vRP.Query("warehouse/Informations",{ name = Name })
		if Warehouse[1] then
			if vRP.Request(source,"Aumentar <b>10kg</b> por <b>$10.000</b> dólares?","Sim, efetuar pagamento","Não, decido depois") then
				if vRP.PaymentFull(Passport,10000) then
					vRP.Query("warehouse/Upgrade",{ name = Name })
					TriggerClientEvent("Notify",source,"verde","Aumento concluído.",3000)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE:SELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("warehouse:Sell")
AddEventHandler("warehouse:Sell",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Warehouse = vRP.Query("warehouse/Informations",{ name = Name })
		if Warehouse[1] then
			if vRP.Request(source,"Deseja vender o armazém?","Sim, concluir a venda","Não, mudeia de ideia") then
				vRP.RemSrvData("Warehouse:"..Name)

				vRP.Query("warehouse/Sell",{ name = Name })
				TriggerClientEvent("Notify",source,"verde","Venda concluída.",5000)
				local Price = Informations[Name]["Price"] * 0.25
				vRP.GiveBank(Passport,Price)

				TriggerEvent("Discord","Warehouse","**Passaporte:** "..Passport.."\n**Vendeu:** "..Name.."\n**Valor:** $"..Price,3042892)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENWAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.openWarehouse(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local myInventory = {}
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

			myInventory[Index] = v
		end

		local myWarehouse = {}
		local Consult = vRP.GetSrvData("Warehouse:"..Name)
		for Index,v in pairs(Consult) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
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

			myWarehouse[Index] = v
		end

		local Warehouse = vRP.Query("warehouse/Informations",{ name = Name })
		if Warehouse[1] then
			return myInventory,myWarehouse,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Consult),Warehouse[1]["weight"]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.storeItem(Item,Slot,Amount,Target,Name)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if itemBlock(Item) then
			TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
			goto scapeInventory
		end

		local Consult = vRP.Query("warehouse/Informations",{ name = Name })
		if Consult[1] then
			if vRP.StoreChest(Passport,"Warehouse:"..Name,Amount,Consult[1]["weight"],Slot,Target) then
				TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
			else
				local result = vRP.GetSrvData("Warehouse:"..Name)
				TriggerClientEvent("warehouse:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(result),Consult[1]["weight"])
			end
		end
	end

	::scapeInventory::
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.takeItem(Item,Slot,Amount,Target,Name)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		local Consult = vRP.Query("warehouse/Informations",{ name = Name })
		if Consult[1] then
			if vRP.TakeChest(Passport,"Warehouse:"..Name,Amount,Slot,Target) then
				TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
			else
				local result = vRP.GetSrvData("Warehouse:"..Name)
				TriggerClientEvent("warehouse:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(result),Consult[1]["weight"])
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEWAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.updateWarehouse(Slot,Target,Amount,Name)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.UpdateChest(Passport,"Warehouse:"..Name,Slot,Target,Amount) then
			TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
		end
	end
end