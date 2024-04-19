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
Tunnel.bindInterface("grime",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIME:PACKAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("grime:Package")
AddEventHandler("grime:Package",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if vRP.CheckWeight(Passport,Item) then
			vRP.GenerateItem(Passport,Item,1)
		else
			TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
			exports["inventory"]:Drops(Passport,source,Item)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Payment(Selected)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and vRP.TakeItem(Passport,Item) then
		Active[Passport] = true

		local Coords = vRP.GetEntityCoords(source)
		if not Selected or #(Coords - Locations[Selected]) > 2.5 then
			exports["megazord"]:Discord("**Passaporte:** "..Passport.."\n**Função:** Payment do Grime",source)
		end

		local Experience = vRP.GetExperience(Passport,"Grime")
		local Level = ClassCategory(Experience)
		local Valuation = 250 + (Level * 10)

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

		vRP.GenerateItem(Passport,"dollar",Valuation,true)
		vRP.PutExperience(Passport,"Grime",3)

		Active[Passport] = nil

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)