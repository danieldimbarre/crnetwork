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
Tunnel.bindInterface("bus",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Payment(Selected)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Locations[Selected] then
		Active[Passport] = true

		local Coords = vRP.GetEntityCoords(source)
		if not Selected or not vRPC.LastVehicle(source,"bus") or #(Coords - Locations[Selected]) > 25 then
			exports["megazord"]:Discord("**Passaporte:** "..Passport.."\n**Função:** Payment do Motorista",source)
		end

		local Experience = vRP.GetExperience(Passport,"Driver")
		local Level = ClassCategory(Experience)
		local Valuation = 40 + (Level * 2)

		if exports["inventory"]:Buffs("Dexterity",Passport) then
			Valuation = Valuation + (Valuation * 0.1)
		end

		if exports["party"]:DoesExist(Passport) then
			local Members = exports["party"]:Room(Passport,source,10)
			if parseInt(#Members) >= 4 then
				Valuation = Valuation + (Valuation * 0.1)
			end
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

		vRP.GenerateItem(Passport,"dollar",Valuation,true)
		vRP.PutExperience(Passport,"Driver",1)

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)