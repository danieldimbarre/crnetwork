-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy = module("lib/Proxy")
Tunnel = module("lib/Tunnel")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = {}
tvRP = {}
Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNER/PROXY
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy.addInterface("vRP",vRP)
Tunnel.bindInterface("vRP",tvRP)
REQUEST = Tunnel.getInterface("request")
SURVIVAL = Tunnel.getInterface("survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SMARTPHONE:SERVICE_REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("smartphone:service_request",function(Data)
	local Answered = false
	local Service = vRP.NumPermission(Data["service"]["permission"])

	for Passport,Sources in pairs(Service) do
		async(function()
			TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "Chamado de "..Data["name"], text = Data["content"], x = Data["location"][1], y = Data["location"][2], z = Data["location"][3], time = "Recebido às "..os.date("%H:%M"), blipColor = 2 })

			if vRP.Request(Sources,"Aceitar o chamado de <b>"..Data["name"].."?","Sim","Não") then
				if not Answered then
					Answered = true
					TriggerClientEvent("smartphone:pusher",Data["source"],"SERVICE_RESPONSE",{})
					TriggerClientEvent("smartphone:pusher",Sources,"GPS",{ location = Data["location"] })
				else
					TriggerClientEvent("Notify",Sources,"negado","Chamado atendido.",5000)
				end
			end
		end)
	end

	SetTimeout(30000,function()
		if not Answered then
			TriggerClientEvent("smartphone:pusher",Data["source"],"SERVICE_REJECT",{})
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Request(source,Message,Accept,Reject)
    return REQUEST.Function(source,Message,Accept or "Sim",Reject or "Não")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Revive(source,Health,Arena)
    return SURVIVAL.Revive(source,Health,Arena)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.SETPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setPremium(source,Value)
	if Characters[source] then
		vRP.Query("accounts/AddPremium",{ license = Characters[source]["license"], premium = os.time() + 2592000, class = Value })
		Characters[source]["premium"] = parseInt(os.time() + 2592000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.UPGRADEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradePremium(source)
	if Characters[source] then
		vRP.Query("accounts/UpdatePremium",{ license = Characters[source]["license"], premium = 2592000 })
		Characters[source]["premium"] = Characters[source]["premium"] + 2592000
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.USERPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userPremium(Passport)
	local source = vRP.Source(Passport)

	if Characters[source] then
		if Characters[source]["premium"] >= os.time() then
			local License = vRP.Identities(source)
			local Account = vRP.Account(License)
			return true,Account["class"]
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.LICENSEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.licensePremium(License)
	local Account = vRP.Account(License)
	if Account and Account["premium"] >= os.time() then
		return true,Account["class"]
	end

	return false
end