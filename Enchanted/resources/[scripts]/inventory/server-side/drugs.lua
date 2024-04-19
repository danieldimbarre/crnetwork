-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	["cocaine"] = {
		["Timer"] = 10,
		["Percentage"] = 90,
		["Price"] = { ["Min"] = 75, ["Max"] = 100 },
		["Amount"] = { ["Min"] = 2, ["Max"] = 4 }
	},
	["meth"] = {
		["Timer"] = 10,
		["Percentage"] = 90,
		["Price"] = { ["Min"] = 75, ["Max"] = 100 },
		["Amount"] = { ["Min"] = 2, ["Max"] = 4 }
	},
	["joint"] = {
		["Timer"] = 10,
		["Percentage"] = 90,
		["Price"] = { ["Min"] = 75, ["Max"] = 100 },
		["Amount"] = { ["Min"] = 2, ["Max"] = 4 }
	},
	["cokesack"] = {
		["Timer"] = 30,
		["Percentage"] = 75,
		["Price"] = { ["Min"] = 500, ["Max"] = 625 },
		["Amount"] = { ["Min"] = 1, ["Max"] = 1 }
	},
	["methsack"] = {
		["Timer"] = 30,
		["Percentage"] = 75,
		["Price"] = { ["Min"] = 500, ["Max"] = 625 },
		["Amount"] = { ["Min"] = 1, ["Max"] = 1 }
	},
	["weedsack"] = {
		["Timer"] = 30,
		["Percentage"] = 75,
		["Price"] = { ["Min"] = 975, ["Max"] = 1225 },
		["Amount"] = { ["Min"] = 1, ["Max"] = 1 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckDrugs()
	local Return = false
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		for Item,v in pairs(List) do
			local Price = math.random(v["Price"]["Min"],v["Price"]["Max"])
			local Amount = math.random(v["Amount"]["Min"],v["Amount"]["Max"])

			if vRP.ConsultItem(Passport,Item,Amount) then
				Drugs[Passport] = { Item,Amount,Price * Amount,v["Percentage"] }
				Return = v["Timer"]

				break
			end
		end
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.PaymentDrugs()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Drugs[Passport] and vRP.TakeItem(Passport,Drugs[Passport][1],Drugs[Passport][2]) then
		Active[Passport] = true

		local Experience = vRP.GetExperience(Passport,"Traffic")
		local Level = ClassCategory(Experience)
		local Valuation = Drugs[Passport][3] + (Percentage(Drugs[Passport][3],Level) * 3)

		if Buffs["Dexterity"][Passport] and Buffs["Dexterity"][Passport] > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		TriggerClientEvent("player:Residuals",source,"Resíduo de Orgânicos.")
		vRP.GenerateItem(Passport,"dirtydollar",Valuation,true)
		vRP.PutExperience(Passport,"Traffic",2)

		if math.random(100) >= Drugs[Passport][4] then
			TriggerEvent("Wanted",source,Passport,60)
			exports["markers"]:Enter(source,"Traficante",Passport,30)
			vRP.CallPolice(source,Passport,false,"Policia","Venda de Drogas",false,60,20,16)
		end

		Active[Passport] = nil
		Drugs[Passport] = nil
	end
end