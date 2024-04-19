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
Tunnel.bindInterface("trucker",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {
	{ ["Item"] = "plastic", ["Chance"] = 80, ["Amount"] = 235, ["Addition"] = 8 },
	{ ["Item"] = "glass", ["Chance"] = 80, ["Amount"] = 235, ["Addition"] = 8 },
	{ ["Item"] = "rubber", ["Chance"] = 80, ["Amount"] = 235, ["Addition"] = 8 },
	{ ["Item"] = "aluminum", ["Chance"] = 20, ["Amount"] = 185, ["Addition"] = 5 },
	{ ["Item"] = "copper", ["Chance"] = 20, ["Amount"] = 185, ["Addition"] = 5 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Payment()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Coords = vRP.GetEntityCoords(source)
		if not vRPC.LastVehicle(source,"packer") or #(Coords - vec3(1256.59,-3239.63,5.17)) > 25 then
			exports["megazord"]:Discord("**Passaporte:** "..Passport.."\n**Função:** Payment do Trucker",source)
		end

		local Result = RandPercentage(Drops)
		local Experience = vRP.GetExperience(Passport,"Trucker")
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

		if not vRP.MaxItens(Passport,Result["Item"],Valuation) and vRP.CheckWeight(Passport,Result["Item"],Valuation) then
			vRP.GenerateItem(Passport,Result["Item"],Valuation,true)
		else
			TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
			exports["inventory"]:Drops(Passport,source,Result["Item"],Valuation)
		end

		vRP.PutExperience(Passport,"Trucker",25)

		Active[Passport] = nil
	end
end