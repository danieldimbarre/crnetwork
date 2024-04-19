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
Tunnel.bindInterface("pdm",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Buy(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Name and not exports["bank"]:CheckFines(Passport) then
		Active[Passport] = true

		local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, Vehicle = Name })
		if Vehicle[1] then
			TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..VehicleName(Name).."</b>.",3000)
		else
			if VehicleMode(Name) == "Rental" then
				local VehiclePrice = VehicleGemstone(Name)
				local Message = "Alugar o veículo <b>"..VehicleName(Name).."</b> por <b>"..Dotted(VehiclePrice).."</b> diamantes?"

				if vRP.Request(source,"Concessionária",Message) then
					if vRP.PaymentGems(Passport,VehiclePrice) then
						local Plate = vRP.GeneratePlate()

						TriggerEvent("garages:Pdm",Passport,source,Name,Plate)
						vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, Vehicle = Name, Plate = Plate, Work = 0 })
						TriggerClientEvent("Notify",source,"Sucesso","Aluguel do veículo <b>"..VehicleName(Name).."</b> concluído.","verde",5000)
					else
						TriggerClientEvent("Notify",source,"Aviso","<b>Diamantes</b> insuficientes.","amarelo",5000)
					end
				end
			else
				if VehicleClass(Name) == "Exclusivos" then
					if vRP.Scalar("vehicles/Count",{ Vehicle = Name }) >= VehicleStock(Name) then
						TriggerClientEvent("Notify",source,"Aviso","Estoque insuficiente.","amarelo",5000)
						Active[Passport] = nil

						return false
					end

					local VehiclePrice = VehicleGemstone(Name)
					if vRP.Request(source,"Concessionária","Alugar o veículo <b>"..VehicleName(Name).."</b> por <b>$"..Dotted(VehiclePrice).."</b> Platinas?") then
						if vRP.TakeItem(Passport,"platinum",VehiclePrice) then
							local Plate = vRP.GeneratePlate()

							TriggerEvent("garages:Pdm",Passport,source,Name,Plate)
							vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, Vehicle = Name, Plate = Plate, Work = 0 })
							TriggerClientEvent("Notify",source,"Sucesso","Aluguel do veículo <b>"..VehicleName(Name).."</b> concluído.","verde",5000)
						else
							TriggerClientEvent("Notify",source,"Aviso","<b>Platinas</b> insuficientes.","amarelo",5000)
						end
					end
				else
					local VehiclePrice = VehiclePrice(Name)
					if vRP.Request(source,"Concessionária","Comprar o veículo <b>"..VehicleName(Name).."</b> por <b>$"..Dotted(VehiclePrice).."</b> dólares?") then
						if vRP.PaymentFull(Passport,VehiclePrice) then
							local Plate = vRP.GeneratePlate()

							TriggerEvent("garages:Pdm",Passport,source,Name,Plate)
							TriggerClientEvent("Notify",source,"Sucesso","Compra concluída.","verde",5000)
							vRP.Query("vehicles/addVehicles",{ Passport = Passport, Vehicle = Name, Plate = Plate, Work = 0 })
							exports["bank"]:AddTaxs(Passport,source,"Concessionária",VehiclePrice,"Compra do veículo "..VehicleName(Name)..".")
						else
							TriggerClientEvent("Notify",source,"Aviso","<b>Dólares</b> insuficientes.","amarelo",5000)
						end
					end
				end
			end
		end

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
local Premium = {
	[0] = 250,
	[1] = 25,
	[2] = 50,
	[3] = 100
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Check()
	local Return = true
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Price = 250
		if vRP.UserPremium(Passport) then
			Price = Premium[vRP.LevelPremium(source)]
		end

		if vRP.PaymentFull(Passport,Price) then
			exports["vrp"]:Bucket(source,"Enter",Passport)
		else
			TriggerClientEvent("Notify",source,"Aviso","<b>Dólares</b> insuficientes.","amarelo",5000)
			Return = false
		end

		Active[Passport] = nil
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Remove()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		exports["vrp"]:Bucket(source,"Exit")
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