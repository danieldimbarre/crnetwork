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
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Taxi = {}
local Active = {}
local Timers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.toggleService()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Timers[Passport] then
			Timers[Passport] = os.time()
		end

		if os.time() >= Timers[Passport] then
			Timers[Passport] = os.time() + 10

			if Taxi[Passport] then
				Taxi[Passport] = nil

				vRP.RemovePermission(Passport,"Taxi")
			else
				Taxi[Passport] = os.time()

				vRP.SetPermission(Passport,"Taxi",2)
			end

			return true
		end
	else
		local Cooldown = parseInt(Timers[Passport] - os.time())
		TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Cooldown.."</b> segundos para iniciar o trabalho novamente.",5000)
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Payment()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true
		
		if Taxi[Passport] <= os.time() then
			local Identity = vRP.Identity(Passport)
			if Identity then
				vRP.Query("banneds/InsertBanned",{ license = Identity["license"], time = 999999999 })
				vRP.Kick(source,"Banido.")

				local Cooldown = parseInt(Taxi[Passport] - os.time())
				TriggerEvent("Discord","Hackers","**Taxi**\n\n**Passaporte:** "..Passport.."\n**Tempo:** "..Cooldown,9317187)

				Active[Passport] = nil
				return
			end
		end

		Taxi[Passport] = os.time() + 60
		local Valuation = math.random(175,275)

		if GlobalState["Buffs"]["Dexterity"][Passport] then
			if GlobalState["Buffs"]["Dexterity"][Passport] > os.time() then
				Valuation = Valuation + (Valuation * 0.1)
			end
		end

		if vRP.UserPremium(Passport) then
			Valuation = Valuation + (Valuation * 0.1)
		end

		vRP.GenerateItem(Passport,"dollars",parseInt(Valuation),true)
		Active[Passport] = nil
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