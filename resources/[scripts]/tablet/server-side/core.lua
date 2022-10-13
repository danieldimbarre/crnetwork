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
Tunnel.bindInterface("tablet",Creative)
vCLIENT = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
GlobalState["Cars"] = {}
GlobalState["Bikes"] = {}
GlobalState["Rental"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Cars = {}
	local Bikes = {}
	local Rental = {}
	local Vehicles = VehicleGlobal()

	for k,v in pairs(Vehicles) do
		if v["Type"] == "cars" then
			table.insert(Cars,{ k = k, name = v["Name"], price = v["Price"], chest = v["Weight"], tax = v["Price"] * 0.10 })
		elseif v["Type"] == "bikes" then
			table.insert(Bikes,{ k = k, name = v["Name"], price = v["Price"], chest = v["Weight"], tax = v["Price"] * 0.10 })
		elseif v["Type"] == "rental" then
			table.insert(Rental,{ k = k, name = v["Name"], price = v["Gems"], chest = v["Weight"], tax = v["Price"] * 0.10 })
		end
	end

	GlobalState:set("Cars",Cars,true)
	GlobalState:set("Bikes",Bikes,true)
	GlobalState:set("Rental",Rental,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENTAL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Rental(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true

			if vRP.GetFine(source) > 0 then
				TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
				Active[Passport] = nil
				return
			end

			local VehiclePrice = VehicleGems(vehName)
			local Text = "Alugar o veículo <b>"..VehicleName(vehName).."</b> por <b>"..VehiclePrice.."</b> gemas?"

			if vRP.ConsultItem(Passport,"rentalveh",1) then
				Text = "Alugar o veículo <b>"..VehicleName(vehName).."</b> usando o vale?"
			end

			if vRP.Request(source,Text,"Sim, concluír pagamento","Não, mudei de ideia") then
				if vRP.TakeItem(Passport,"rentalveh",1,true) or vRP.PaymentGems(Passport,VehiclePrice) then
					local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
					if vehicle[1] then
						if vehicle[1]["rental"] <= os.time() then
							vRP.Query("vehicles/rentalVehiclesUpdate",{ Passport = Passport, vehicle = vehName })
							TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..VehicleName(vehName).."</b> atualizado.",5000)
						else
							vRP.Query("vehicles/rentalVehiclesDays",{ Passport = Passport, vehicle = vehName })
							TriggerClientEvent("Notify",source,"verde","Adicionado <b>30 Dias</b> de aluguel no veículo <b>"..VehicleName(vehName).."</b>.",5000)
						end
					else
						vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "false" })
						TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..VehicleName(vehName).."</b> concluído.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
				end
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Buy(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true

			if vRP.GetFine(source) > 0 then
				TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
				Active[Passport] = nil
				return
			end

			if VehicleType(vehName) == "rental" or not VehicleType(vehName) then
				Active[Passport] = nil
				return
			end

			local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
			if vehicle[1] then
				TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..VehicleName(vehName).."</b>.",3000)
				Active[Passport] = nil
				return
			else
				if VehicleType(vehName) == "work" then
					if vRP.PaymentFull(Passport,VehiclePrice(vehName)) then
						vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "true" })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				else
					local VehiclePrice = VehiclePrice(vehName)
					if vRP.Request(source,"Comprar <b>"..VehicleName(vehName).."</b> por <b>$"..parseFormat(VehiclePrice).."</b> dólares?","Sim, concluír pagamento","Não, mudei de ideia") then
						if vRP.PaymentFull(Passport,VehiclePrice) then
							vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "false" })
							TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)
						else
							TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
						end
					end
				end
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.startDrive()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true

			if not exports["hud"]:Wanted(Passport) then
				if vRP.Request(source,"Iniciar o teste por <b>$100</b> dólares?","Sim, iniciar o teste","Não, volto depois") then
					if vRP.PaymentFull(Passport,100) then
						Player(source)["state"]["Route"] = Passport
						SetPlayerRoutingBucket(source,Passport)
						Active[Passport] = nil

						return true
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				end
			end

			Active[Passport] = nil
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.removeDrive()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		Player(source)["state"]["Route"] = 0
		SetPlayerRoutingBucket(source,0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)