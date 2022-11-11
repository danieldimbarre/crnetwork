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
Tunnel.bindInterface("taxi",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXI
-----------------------------------------------------------------------------------------------------------------------------------------
local Taxi = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.toggleService()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Taxi[Passport] then
			Taxi[Passport] = nil

			vRP.RemovePermission(Passport,"Taxi")
		else
			Taxi[Passport] = true

			vRP.SetPermission(Passport,"Taxi",2)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.paymentService()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Valuation = math.random(175,275)

		if Buffs["Dexterity"][Passport] then
			if Buffs["Dexterity"][Passport] > os.time() then
				Valuation = Valuation + (Valuation * 0.1)
			end
		end

		if vRP.UserPremium(Passport) then
			Valuation = Valuation + (Valuation * 0.1)
		end

		vRP.GenerateItem(Passport,"dollars",Valuation,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Taxi[Passport] then
		Taxi[Passport] = nil

		vRP.RemovePermission(Passport,"Taxi")
	end
end)