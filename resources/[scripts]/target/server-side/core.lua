-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("target",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.CheckIn()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.getHealth(source) <= 100 then
			if vRP.paymentFull(Passport,source,975) then
				vRP.upgradeHunger(Passport,20)
				vRP.upgradeThirst(Passport,20)
				TriggerEvent("Reposed",source,Passport,900)

				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		else
			if vRP.request(source,"Prosseguir o tratamento por <b>$750</b> dólares?","Sim, iniciar tratamento","Não, volto mais tarde") then
				if vRP.paymentFull(Passport,source,750) then
					vRP.upgradeHunger(Passport,20)
					vRP.upgradeThirst(Passport,20)
					TriggerEvent("Reposed",source,Passport,900)

					return true
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:CALLWORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local Calls = {}
RegisterNetEvent("target:CallWorks")
AddEventHandler("target:CallWorks",function(Perm)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Calls[Perm] == nil then
			Calls[Perm] = os.time()
		end

		if os.time() >= Calls[Perm] then
			if Perm == "Paramedic" then
				TriggerClientEvent("Notify",-1,"amarelo","Pillbox Medical Center","Estamos em busca de doadores de sangue, seja solidário e ajude o próximo, procure um de nossos profissionais.",15000)
			else
				TriggerClientEvent("Notify",-1,"amarelo",Perm,"Estamos em busca de trabalhadores, compareça ao estabelecimento, procure um de nossos funcionários e consulte nosso serviço de entregas.",15000)
			end

			Calls[Perm] = os.time() + 600
		else
			local Cooldown = parseInt(Calls[Perm] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Cooldown.."</b> segundos.",5000)
		end
	end
end)