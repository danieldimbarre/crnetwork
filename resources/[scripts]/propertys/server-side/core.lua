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
Tunnel.bindInterface("propertys",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
vSKINSHOP = Tunnel.getInterface("skinshop")
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Lock = {}
local Inside = {}
local Markers = {}
local Active = {}
local Theft = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEFTINTERIORS
-----------------------------------------------------------------------------------------------------------------------------------------
local TheftInteriors = {
	"Emerald",
	"Diamond",
	"Ruby",
	"Sapphire",
	"Amethyst",
	"Amber"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
local Robberys = {
	{ ["item"] = "notepad", ["min"] = 1, ["max"] = 5 },
	{ ["item"] = "keyboard", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "mouse", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "silverring", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "goldring", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "watch", ["min"] = 2, ["max"] = 4 },
	{ ["item"] = "playstation", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "xbox", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "legos", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "ominitrix", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "bracelet", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "dildo", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "sapphire", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "amethyst", ["min"] = 1, ["max"] = 4 },
	{ ["item"] = "amber", ["min"] = 1, ["max"] = 4 },
	{ ["item"] = "turquoise", ["min"] = 1, ["max"] = 5 },
	{ ["item"] = "spray01", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "spray02", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "spray03", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "spray04", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "brick", ["min"] = 1, ["max"] = 5 },
	{ ["item"] = "dices", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "dish", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "pan", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "sneakers", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "fan", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "rimel", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "blender", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "switch", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "brush", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "domino", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "floppy", ["min"] = 1, ["max"] = 4 },
	{ ["item"] = "horseshoe", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "cup", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "deck", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "eraser", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "pliers", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "lampshade", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "slipper", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "soap", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "card01", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "card02", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "card03", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "card04", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "card05", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "pendrive", ["min"] = 1, ["max"] = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestHomes(source)
	local Ped = GetPlayerPed(source)
	local Coords = GetEntityCoords(Ped)

	for Name,v in pairs(Propertys) do
		local Distance = #(Coords - v)
		if Distance <= 1 then
			local Consult = vRP.Query("propertys/Exist",{ name = Name })
			if Consult[1] then
				return Name,Consult[1]["Interior"]
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Propertys(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if Consult[1] then
			if parseInt(Consult[1]["Passport"]) == Passport or vRP.InventoryFull(Passport,"propertys-"..Consult[1]["Serial"]) or Lock[Name] then
				if os.time() > Consult[1]["Tax"] then
					if vRP.Request(source,"Hipoteca atrasada, deseja efetuar o pagamento?","Sim, concluir pagamento","Não, pago depois") then
						if vRP.PaymentFull(Passport,Informations[Consult[1]["Interior"]]["Price"] * 0.1) then
							vRP.Query("propertys/Tax",{ name = Name })
							TriggerClientEvent("Notify",source,"amarelo","Pagamento concluído.",5000)
						end
					end
				else
					Consult[1]["Tax"] = MinimalTimers(Consult[1]["Tax"] - os.time())
					return "Player",Consult[1]
				end
			end
		else
			return "Corretor",Informations
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Toggle")
AddEventHandler("propertys:Toggle",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Inside[Passport] then
			Inside[Passport] = nil
			TriggerEvent("vRP:BucketServer",source,"Exit")
		else
			Inside[Passport] = Name
			TriggerEvent("vRP:BucketServer",source,"Enter",Route(Name))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:INVADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Invade")
AddEventHandler("propertys:Invade",function()
	local source = source
	local Name,Interior = nearestHomes(source)
	if Name and Interior then
		local Passport = vRP.Passport(source)
		if Passport then
			if vRP.HasService(Passport,"Police") then
				TriggerClientEvent("propertys:Enter",source,Name,Interior)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Buy")
AddEventHandler("propertys:Buy",function(Name)
	local source = source
	local Split = splitString(Name,"-")
	local Passport = vRP.Passport(source)
	if Passport then
		local Name = Split[1]
		local Interior = Split[2]
		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if not Consult[1] then
			TriggerClientEvent("dynamic:closeSystem",source)

			if vRP.Request(source,"Deseja comprar a propriedade?","Sim, assinar papelada","Não, mudeia de ideia") then
				if vRP.TakeItem(Passport,"homecont"..Interior,1,true) or vRP.PaymentFull(Passport,Informations[Interior]["Price"]) then
					Markers[Name] = true
					local Serial = PropertysSerials()
					vRP.GiveItem(Passport,"propertys-"..Serial,3,true)
					TriggerClientEvent("propertys:Markers",-1,Markers)
					vRP.Query("propertys/Buy",{ name = Name, interior = Interior, passport = Passport, serial = Serial, vault = Informations[Interior]["Vault"], fridge = Informations[Interior]["Fridge"], tax = os.time() + 2592000 })
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Lock")
AddEventHandler("propertys:Lock",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if Consult[1] then
			if parseInt(Consult[1]["Passport"]) == Passport or vRP.InventoryFull(Passport,"propertys-"..Consult[1]["Serial"]) then
				if Lock[Name] then
					Lock[Name] = nil
					TriggerClientEvent("Notify",source,"amarelo","Propriedade trancada.",5000)
				else
					Lock[Name] = true
					TriggerClientEvent("Notify",source,"amarelo","Propriedade destrancada.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:SELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Sell")
AddEventHandler("propertys:Sell",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if Consult[1] then
			if parseInt(Consult[1]["Passport"]) == Passport then
				TriggerClientEvent("dynamic:closeSystem",source)

				if vRP.Request(source,"Deseja vender a propriedade?","Sim, concluir a venda","Não, mudeia de ideia") then
					if Markers[Name] then
						Markers[Name] = nil
						TriggerClientEvent("propertys:Markers",-1,Markers)
					end

					vRP.RemSrvData("Vault:"..Name)
					vRP.RemSrvData("Fridge:"..Name)

					vRP.Query("propertys/Sell",{ name = Name })
					TriggerClientEvent("Notify",source,"verde","Venda concluída.",5000)
					local Price = Informations[Consult[1]["Interior"]]["Price"] * 0.25
					vRP.GiveBank(Passport,Price)

					TriggerEvent("Discord","Propertys","**Passaporte:** "..Passport.."\n**Vendeu:** "..Name.."\n**Valor:** $"..parseFormat(Price),13541152)
				end
			end
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CREDENTIALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Credentials")
AddEventHandler("propertys:Credentials",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if Consult[1] then
			if parseInt(Consult[1]["Passport"]) == Passport then
				TriggerClientEvent("dynamic:closeSystem",source)

				if vRP.Request(source,"Você escolheu reconfigurar todos os cartões de segurança, lembrando que ao prosseguir todos os cartões vão deixar de funcionar, deseja prosseguir?","Sim, prosseguir","Não, outra hora") then
					local Serial = PropertysSerials()
					vRP.Query("propertys/Credentials",{ name = Name, serial = Serial })
					vRP.GiveItem(Passport,"propertys-"..Serial,Consult[1]["Keys"],true)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:VAULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Vault")
AddEventHandler("propertys:Vault",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if Consult[1] then
			if parseInt(Consult[1]["Passport"]) == Passport or vRP.InventoryFull(Passport,"propertys-"..Consult[1]["Serial"]) then
				if vRP.Request(source,"Aumentar <b>10kg</b> por <b>$10.000</b> dólares?","Sim, efetuar pagamento","Não, decido depois") then
					if vRP.PaymentFull(Passport,10000) then
						vRP.Query("propertys/Vault",{ name = Name, weight = 10 })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Clothes()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Clothes = {}
		local Consult = vRP.GetSrvData("Wardrobe:"..Passport)

		for Table,_ in pairs(Consult) do
			Clothes[#Clothes + 1] = { ["name"] = Table }
		end

		return Clothes
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Clothes")
AddEventHandler("propertys:Clothes",function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Split = splitString(Mode,"-")
		local Consult = vRP.GetSrvData("Wardrobe:"..Passport)
		local Name = Split[2]

		if Split[1] == "save" then
			local Keyboard = vKEYBOARD.keySingle(source,"Salvar como:")
			if Keyboard then
				local Name = Keyboard[1]

				if not Consult[Name] then
					Consult[Name] = vSKINSHOP.getCustomization(source)
					vRP.SetSrvData("Wardrobe:"..Passport,Consult)
					TriggerClientEvent("propertys:ClothesReset",source)
					TriggerClientEvent("Notify",source,"verde","<b>"..Name.."</b> adicionado.",5000)
				else
					TriggerClientEvent("Notify",source,"amarelo","Nome escolhido já existe em seu armário.",5000)
				end
			end
		elseif Split[1] == "delete" then
			if Consult[Name] ~= nil then
				Consult[Name] = nil
				vRP.SetSrvData("Wardrobe:"..Passport,Consult)
				TriggerClientEvent("propertys:ClothesReset",source)
				TriggerClientEvent("Notify",source,"verde","<b>"..Name.."</b> removido.",5000)
			else
				TriggerClientEvent("Notify",source,"amarelo","A vestimenta salva não se encontra mais em seu armário.",5000)
			end
		elseif Split[1] == "apply" then
			if Consult[Name] ~= nil then
				TriggerClientEvent("updateRoupas",source,Consult[Name])
				TriggerClientEvent("Notify",source,"verde","<b>"..Name.."</b> aplicado.",5000)
			else
				TriggerClientEvent("Notify",source,"amarelo","A vestimenta salva não se encontra mais em seu armário.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYSSERIALS
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertysSerials()
	local Serial = vRP.GenerateString("LDLDLDLDLD")
	local Consult = vRP.Query("propertys/Serial",{ serial = Serial })
	if Consult[1] then
		PropertysSerials()
	end

	return Serial
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.OpenChest(Name,Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Chest = {}
		local Inventory = {}
		local Inv = vRP.Inventory(Passport)
		local Consult = vRP.GetSrvData(Mode..":"..Name)

		for k,v in pairs(Inv) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

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

			Inventory[k] = v
		end

		for k,v in pairs(Consult) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

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

			Chest[k] = v
		end

		local Exist = vRP.Query("propertys/Exist",{ name = Name })
		if Exist[1] then
			return Inventory,Chest,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Consult),Exist[1][Mode]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Store(Item,Slot,Amount,Target,Name,Mode)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if itemBlock(Item) or (Mode == "Vault" and BlockChest(Item)) or (Mode == "Fridge" and not BlockChest(Item)) then
			TriggerClientEvent("propertys:Update",source)
			return
		end

		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if Consult[1] then
			if Item == "diagram" then
				if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
					vRP.Query("propertys/"..Mode,{ name = Name, weight = 10 * Amount })
					TriggerClientEvent("propertys:Update",source)
				end
			else
				if vRP.StoreChest(Passport,Mode..":"..Name,Amount,Consult[1][Mode],Slot,Target) then
					TriggerClientEvent("propertys:Update",source)
				else
					local Result = vRP.GetSrvData(Mode..":"..Name)
					TriggerClientEvent("propertys:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Consult[1][Mode])

					TriggerEvent("Discord","Propertys","**Passaporte:** "..Passport.."\n**Propriedade:** "..Mode..":"..Name.."\n**Guardou:** "..Amount.."x "..itemName(Item),3042892)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Item,Slot,Amount,Target,Name,Mode)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.TakeChest(Passport,Mode..":"..Name,Amount,Slot,Target) then
			TriggerClientEvent("propertys:Update",source)
		else
			local Consult = vRP.Query("propertys/Exist",{ name = Name })
			if Consult[1] then
				local Result = vRP.GetSrvData(Mode..":"..Name)
				TriggerClientEvent("propertys:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Consult[1][Mode])

				TriggerEvent("Discord","Propertys","**Passaporte:** "..Passport.."\n**Propriedade:** "..Mode..":"..Name.."\n**Retirou:** "..Amount.."x "..itemName(Item),9317187)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Update(Slot,Target,Amount,Name,Mode)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.UpdateChest(Passport,Mode..":"..Name,Slot,Target,Amount) then
			TriggerClientEvent("propertys:Update",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUTE
-----------------------------------------------------------------------------------------------------------------------------------------
function Route(Name)
	local Split = splitString(Name,"Propertys")

	return 100000 + parseInt(Split[1])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("propertys:Table",source,Propertys,Interiors,Markers)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Inside[Passport] then
		vRP.InsidePropertys(Passport,Propertys[Inside[Passport]])
		Inside[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Wait(1000)
	local Consult = vRP.Query("propertys/All")

	for Index,v in pairs(Consult) do
		Markers[v["Name"]] = true
	end

	TriggerClientEvent("propertys:Table",-1,Propertys,Interiors,Markers)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("CharacterChosen",function(Passport,source)
	local Consult = vRP.Query("propertys/AllUser",{ Passport = Passport })
	if Consult[1] then
		local Tables = {}

		for _,v in pairs(Consult) do
			local Name = v["Name"]
			if Propertys[Name] then
				Tables[#Tables + 1] = { ["Coords"] = Propertys[Name] }
			end
		end

		TriggerClientEvent("spawn:Increment",source,Tables)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Robberys")
AddEventHandler("propertys:Robberys",function(Property)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Property then
		if not Theft[Property] then
			Theft[Property] = os.time()
		end

		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
		Active[Passport] = os.time() + 100
		local Service,Total = vRP.NumPermission("Police")

		if vTASKBAR.stealTrunk(source) then
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("Progress",source,"Roubando",10000)

			repeat
				if os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.stopAnim(source,false)
					Player(source)["state"]["Buttons"] = false

					if os.time() >= Theft[Property] then
						if GlobalState["Buffs"]["Luck"][Passport] then
							if GlobalState["Buffs"]["Luck"][Passport] > os.time() then
								randItem = math.random(175)
							end
						end

						local Selected = math.random(#Robberys)
						local Value = parseInt(math.random(Robberys[Selected]["min"],Robberys[Selected]["max"]))

						if (vRP.InventoryWeight(Passport) + (itemWeight(Robberys[Selected]["item"]) * Value)) <= vRP.GetWeight(Passport) then
							local Random = 80
							if Total >= 10 then
								Random = 40
							end

							if math.random(100) <= Random then
								vRP.GenerateItem(Passport,Robberys[Selected]["item"],Value,true)
								Theft[Property] = os.time() + 3600
							else
								TriggerClientEvent("Notify",source,"amarelo","Compartimento vazio.",5000)
								Theft[Property] = os.time() + 3600
							end
						else
							TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
						end

						vRP.UpgradeStress(Passport,1)

						if math.random(1000) >= 950 then
							TriggerEvent("Wanted",source,Passport,120)
				
							for Passports,Sources in pairs(Service) do
								async(function()
									vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
									TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "Roubo de Propriedade", x = Propertys[Name]["x"], y = Propertys[Name]["y"], z = Propertys[Name]["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
								end)
							end
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","Compartimento vazio.",5000)
					end
				end

				Wait(100)
			until not Active[Passport]
		else
			TriggerEvent("Wanted",source,Passport,120)
			vRPC.stopAnim(source,false)
			Active[Passport] = nil

			for Passports,Sources in pairs(Service) do
				async(function()
					vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
					TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "Roubo de Propriedade", x = Propertys[Name]["x"], y = Propertys[Name]["y"], z = Propertys[Name]["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:CallPolice")
AddEventHandler("propertys:CallPolice",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Name and Theft[Name] then
		TriggerEvent("Wanted",source,Passport,120)

		local Service = vRP.NumPermission("Police")
		for Passports,Sources in pairs(Service) do
			async(function()
				vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "Roubo de Propriedade", x = Propertys[Name]["x"], y = Propertys[Name]["y"], z = Propertys[Name]["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMESTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
function HomesTheft(source)
	local Ped = GetPlayerPed(source)
	local Coords = GetEntityCoords(Ped)

	for Name,v in pairs(Propertys) do
		local Distance = #(Coords - v)
		if Distance <= 1.0 then
			if Theft[Name] then
				if os.time() >= Theft[Name] then
					Theft[Name] = os.time() + 1800
					return Name
				else
					local Cooldown = parseInt(Theft[Name] - os.time())
					TriggerClientEvent("Notify",source,"azul","Vizinhança em alerta, aguarde <b>"..parseFormat(Cooldown).."</b> segundos até que fique tranquilo.",5000)
					return false
				end
			else
				Theft[Name] = os.time() + 1800
				return Name
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function EnterHomes(source,Passport,Name)
	local Interior = TheftInteriors[math.random(#TheftInteriors)]
	local Consult = vRP.Query("propertys/Exist",{ name = Name })
	if Consult[1] then
		Interior = Consult[1]["Interior"]
	end

	TriggerClientEvent("propertys:Enter",source,Name,Interior,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETTHEFT
-----------------------------------------------------------------------------------------------------------------------------------------
function ResetTheft(Name)
	Theft[Name] = nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("ResetTheft",ResetTheft)
exports("HomesTheft",HomesTheft)
exports("EnterHomes",EnterHomes)