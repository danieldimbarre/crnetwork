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
Tunnel.bindInterface("races",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Finish(Number,Points)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Races[Number] then
		if Active[Passport] then
			Active[Passport] = nil

			local GainExperience = 8
			local Price = Races[Number]["Price"]
			local MinCalculate = parseInt(Price * 0.75)
			local MaxCalculate = parseInt(Price * 1.25)
			local Amount = math.random(MinCalculate,MaxCalculate)
			local Experience,Level = vRP.GetExperience(Passport,"Race")
			local Valuation = Amount + Amount * (0.025 * Level)

			if exports["inventory"]:Buffs("Dexterity",Passport) then
				Valuation = Valuation + (Valuation * 0.1)
			end

			if vRP.UserPremium(Passport) then
				local Bonification = 0.05
				local Hierarchy = vRP.LevelPremium(source)

				if Hierarchy == 1 then
					Bonification = 0.100
				elseif Hierarchy == 2 then
					Bonification = 0.075
				end

				GainExperience = GainExperience + 4
				Valuation = Valuation + (Valuation * Bonification)
			end

			vRP.UpgradeStress(Passport,5)
			exports["markers"]:Exit(source,Passport)
			vRP.PutExperience(Passport,"Race",GainExperience)
			vRP.GenerateItem(Passport,"dirtydollar",Valuation,true)
		end

		local Vehicle = vRPC.VehicleName(source)
		local Consult = vRP.Query("Races/User",{ Race = Number, Passport = Passport })
		if Consult[1] then
			if Points < Consult[1]["Points"] then
				vRP.Query("Races/Update",{ Race = Number, Passport = Passport, Vehicle = Vehicle, Points = Points })
			end
		else
			vRP.Query("Races/Insert",{ Race = Number, Passport = Passport, Vehicle = Vehicle, Points = Points })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Start(Number)
	local Return = false
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Races[Number] and vRP.RemoveCharges(Passport,"races") then
		Active[Passport] = true
		Return = Races[Number]["Explosive"]
		exports["markers"]:Enter(source,"Corredor")

		local Service = vRP.NumPermission("Policia")
		for Passports,Sources in pairs(Service) do
			async(function()
				vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("Notify",Sources,"Circuitos","Encontramos um veículo participando de uma corrida clandestina e todos os policiais foram avisados.","policia",10000)
			end)
		end
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Cancel()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] then
		Active[Passport] = nil
		exports["markers"]:Exit(source,Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANKING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Ranking(Number)
	local Ranking = {}
	if Races[Number] then
		local Consult = vRP.Query("Races/Consult",{ Race = Number })

		for _,v in pairs(Consult) do
			Ranking[#Ranking + 1] = {
				["Runner"] = vRP.FullName(v["Passport"]),
				["Points"] = NumberHours(v["Points"] / 1000),
				["Vehicle"] = VehicleName(v["Vehicle"])
			}
		end
	end

	return Ranking
end