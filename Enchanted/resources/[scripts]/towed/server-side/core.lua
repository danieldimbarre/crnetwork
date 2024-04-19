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
Tunnel.bindInterface("towed",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Service = {}
local Vehicles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {
	{ ["Item"] = "plastic", ["Chance"] = 80, ["Amount"] = 40, ["Addition"] = 2 },
	{ ["Item"] = "glass", ["Chance"] = 80, ["Amount"] = 40, ["Addition"] = 2 },
	{ ["Item"] = "rubber", ["Chance"] = 80, ["Amount"] = 40, ["Addition"] = 2 },
	{ ["Item"] = "aluminum", ["Chance"] = 20, ["Amount"] = 25, ["Addition"] = 1 },
	{ ["Item"] = "copper", ["Chance"] = 20, ["Amount"] = 25, ["Addition"] = 1 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Service()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Service[Passport] then
			Service[Passport] = nil
		else
			Service[Passport] = source
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CreateVehicle(Model,Destiny)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicle = CreateVehicle(Model,Locations[Destiny],true,true)

		while not DoesEntityExist(Vehicle) do
			Wait(1)
		end

		if DoesEntityExist(Vehicle) then
			local Plate = vRP.GeneratePlate()
			local Network = NetworkGetNetworkIdFromEntity(Vehicle)

			SetVehicleBodyHealth(Vehicle,10.0)
			SetVehicleNumberPlateText(Vehicle,Plate)

			Entity(Vehicle)["state"]:set("Fuel",0,true)
			Entity(Vehicle)["state"]:set("Nitro",0,true)

			Vehicles[Plate] = {
				["Source"] = source,
				["Network"] = Network,
				["Impound"] = false
			}

			return Network,Plate
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Delete")
AddEventHandler("garages:Delete",function(Network,Plate)
	if Network and Plate and Vehicles[Plate] then
		if not Vehicles[Plate]["Impound"] and vRP.Passport(Vehicles[Plate]["Source"]) then
			TriggerClientEvent("towed:Inative",Vehicles[Plate]["Source"],Plate)
		end

		Vehicles[Plate] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWED:PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("towed:Payment")
AddEventHandler("towed:Payment",function(Plate)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Vehicles[Plate] then
		Active[Passport] = true

		local Result = RandPercentage(Drops)
		local Experience = vRP.GetExperience(Passport,"Towed")
		local Valuation = Result["Amount"] + (ClassCategory(Experience) / Result["Addition"])

		if exports["inventory"]:Buffs("Dexterity",Passport) then
			Valuation = Valuation + (Valuation * 0.1)
		end

		if vRP.UserPremium(Passport) then
			local Bonification = 0.05
			local Hierarchy = vRP.LevelPremium(source)

			if Hierarchy == 1 then
				Bonification = 0.1
			elseif Hierarchy == 2 then
				Bonification = 0.2
			end

			Valuation = Valuation + (Valuation * Bonification)
		end

		TriggerEvent("garages:Delete",Vehicles[Plate]["Network"],Plate)
		vRP.GenerateItem(Passport,Result["Item"],Valuation,true)
		vRP.GenerateItem(Passport,"dollar",500,true)
		vRP.PutExperience(Passport,"Towed",5)

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOWED:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("towed:Impound")
AddEventHandler("towed:Impound",function(Table)
	local source = source
	local Passport = vRP.Passport(source)
	local Plate,Model,Network = Table[1],Table[2],Table[4]
	if Passport and not Active[Passport] and not Vehicles[Plate] and vRP.HasService(Passport,"Policia") then
		Active[Passport] = true

		Vehicles[Plate] = {
			["Source"] = source,
			["Network"] = Network,
			["Impound"] = true
		}

		TriggerClientEvent("Notify",source,"Impound","Veículo registrado.","verde",5000)

		local Coords = vRP.GetEntityCoords(source)
		for Passports,Sources in pairs(Service) do
			async(function()
				vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Impound Solicitado", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(Model).." - "..Plate, color = 44 })
			end)
		end

		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end

	if Service[Passport] then
		Service[Passport] = nil
	end
end)