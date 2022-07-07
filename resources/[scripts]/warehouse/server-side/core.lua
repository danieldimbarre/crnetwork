-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("warehouse",cRP)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE:PASSWORD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("warehouse:Password")
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
					vRP.Execute("warehouse/Password",{ name = Name, password = Password })
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
function cRP.Warehouse(Name)
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
							if vRP.request(source,"Pagar o aluguel do armazém por <b>$20.000</b>?","Sim, por favor","Não, decido depois") then
								if vRP.paymentFull(Passport,source,20000) then
									vRP.Execute("warehouse/Tax",{ name = Name })
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
				if vRP.request(source,"Gostaria de comprar o armazém por <b>$100.000</b>?","Sim, por favor","Não, decido depois") then
					local Keyboard = vKEYBOARD.keyWord(source,"Senha:")
					if Keyboard then
						local Password = sanitizeString(Keyboard[1],"0123456789",true)
						if string.len(Password) >= 4 and string.len(Password) <= 20 then
							if vRP.request(source,"Finalizar a compra usando a senha <b>"..Password.."</b>?","Sim, por favor","Não, decido depois") then
								if vRP.paymentFull(Passport,source,100000) then
									vRP.Execute("warehouse/Buy",{ name = Name, Passport = Passport, password = Password })
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

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSEUPGRADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("warehouse:Upgrade")
AddEventHandler("warehouse:Upgrade",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Warehouse = vRP.Query("warehouse/Informations",{ name = Name })
		if Warehouse[1] then
			if vRP.request(source,"Aumentar <b>10Kg</b> por <b>$10.000</b> dólares?","Sim, efetuar pagamento","Não, decido depois") then
				if vRP.paymentFull(Passport,source,10000) then
					vRP.Execute("warehouse/Upgrade",{ name = Name })
					TriggerClientEvent("Notify",source,"verde","Aumento concluído.",3000)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENWAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.openWarehouse(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local myInventory = {}
		local inventory = vRP.Inventory(Passport)
		for k,v in pairs(inventory) do
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

			myInventory[k] = v
		end

		local myWarehouse = {}
		local result = vRP.getSrvdata("Warehouse:"..Name)
		for k,v in pairs(result) do
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

			myWarehouse[k] = v
		end

		local Warehouse = vRP.Query("warehouse/Informations",{ name = Name })
		if Warehouse[1] then
			return myInventory,myWarehouse,vRP.inventoryWeight(Passport),vRP.getWeights(Passport),vRP.chestWeight(result),Warehouse[1]["weight"]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(Item,Slot,Amount,Target,Name)
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
			if vRP.storeChest(Passport,"Warehouse:"..Name,Amount,Consult[1]["weight"],Slot,Target) then
				TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
			else
				local result = vRP.getSrvdata("Warehouse:"..Name)
				TriggerClientEvent("warehouse:Weight",source,vRP.inventoryWeight(Passport),vRP.getWeights(Passport),vRP.chestWeight(result),Consult[1]["weight"])
			end
		end
	end

	::scapeInventory::
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(Item,Slot,Amount,Target,Name)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		local Consult = vRP.Query("warehouse/Informations",{ name = Name })
		if Consult[1] then
			if vRP.tryChest(Passport,"Warehouse:"..Name,Amount,Slot,Target) then
				TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
			else
				local result = vRP.getSrvdata("Warehouse:"..Name)
				TriggerClientEvent("warehouse:Weight",source,vRP.inventoryWeight(Passport),vRP.getWeights(Passport),vRP.chestWeight(result),Consult[1]["weight"])
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEWAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateWarehouse(Slot,Target,Amount,Name)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.updateChest(Passport,"Warehouse:"..Name,Slot,Target,Amount) then
			TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
		end
	end
end