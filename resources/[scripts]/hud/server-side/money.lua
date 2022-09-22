-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKDEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.BankDeposit(Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Actived[Passport] and not exports["hud"]:Wanted(Passport,source) then
		Actived[Passport] = true

		if vRP.TakeItem(Passport,"dollars",Amount,true) then
			vRP.GiveBank(Passport,Amount)
		else
			TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
		end

		Actived[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANWITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.BankWithdraw(Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Actived[Passport] then
		Actived[Passport] = true

		if vRP.GetFine(source) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
		else
			if (vRP.InventoryWeight(Passport) + itemWeight("dollars") * Amount) <= vRP.GetWeight(Passport) then
				if not vRP.WithdrawCash(Passport,source,Amount) then
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		end

		Actived[Passport] = nil
	end
end