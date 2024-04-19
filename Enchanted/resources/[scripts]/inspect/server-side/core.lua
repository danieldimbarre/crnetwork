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
Tunnel.bindInterface("inspect",Creative)
vCLIENT = Tunnel.getInterface("inspect")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Players = {}
local Sourcers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:INSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Inspect")
AddEventHandler("police:Inspect",function(OtherSource)
	local source = source
	local Passport = vRP.Passport(source)
	local OtherPassport = vRP.Passport(OtherSource)
	if Passport and vRP.DoesEntityExist(OtherSource) and not Players[OtherPassport] and (vRP.HasService(Passport,"Policia") or vRP.GetHealth(OtherSource) <= 100 or (vRP.GetHealth(OtherSource) > 100 and vRP.Request(OtherSource,"Revistar","Você aceita ser revistado?"))) then
		Sourcers[Passport] = OtherSource
		Players[Passport] = OtherPassport

		TriggerEvent("inventory:ServerCarry",source,Passport,OtherSource,true)
		TriggerClientEvent("inventory:Close",OtherSource)
		TriggerClientEvent("inspect:Open",source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Request()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
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

		local Chest = {}
		local Inv = vRP.Inventory(Players[Passport])
		for Index,v in pairs(Inv) do
			if (parseInt(v["amount"]) <= 0 or not ItemExist(v["item"])) then
				vRP.RemoveItem(Players[Passport],v["item"],parseInt(v["amount"]),false)
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

		return Inventory,Chest,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.InventoryWeight(Players[Passport]),vRP.GetWeight(Players[Passport])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Reset()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Sourcers[Passport] then
			if vRP.DoesEntityExist(Sourcers[Passport]) then
				TriggerEvent("inventory:ServerCarry",source,Passport,Sourcers[Passport])
			end

			Sourcers[Passport] = nil
		end

		if Players[Passport] then
			Players[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Store(Item,Slot,Amount,Target)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Sourcers[Passport] and vRP.DoesEntityExist(Sourcers[Passport]) then
		if vRP.MaxItens(Players[Passport],Item,Amount) then
			TriggerClientEvent("Notify",source,"Aviso","Limite atingido.","amarelo",5000)
			TriggerClientEvent("inspect:Update",source,"Request")

			return false
		end

		if (vRP.InventoryWeight(Players[Passport]) + ItemWeight(Item) * Amount) <= vRP.GetWeight(Players[Passport]) then
			if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
				vRP.GiveItem(Players[Passport],Item,Amount,true,Target)
			end
		else
			TriggerClientEvent("Notify",source,"Aviso","Mochila cheia.","amarelo",5000)
			TriggerClientEvent("inspect:Update",source,"Request")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Item,Slot,Target,Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Sourcers[Passport] and vRP.DoesEntityExist(Sourcers[Passport]) then
		if vRP.MaxItens(Passport,Item,Amount) then
			TriggerClientEvent("Notify",source,"Aviso","Limite atingido.","amarelo",5000)
			TriggerClientEvent("inspect:Update",source,"Request")

			return false
		end

		if vRP.CheckWeight(Passport,Item,Amount) then
			if vRP.TakeItem(Players[Passport],Item,Amount,true,Slot) then
				vRP.GiveItem(Passport,Item,Amount,true,Target)
				TriggerClientEvent("inspect:Update",source,"Request")
			end
		else
			TriggerClientEvent("Notify",source,"Aviso","Mochila cheia.","amarelo",5000)
			TriggerClientEvent("inspect:Update",source,"Request")
		end
	end
end