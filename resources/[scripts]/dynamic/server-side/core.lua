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
Tunnel.bindInterface("dynamic",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Experience()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Experiences = {
			["Desmanche"] = vRP.GetExperience(Passport,"Dismantly"),
			["Reboque"] = vRP.GetExperience(Passport,"Tows"),
			["Entregador"] = vRP.GetExperience(Passport,"Delivery"),
			["Transportador"] = vRP.GetExperience(Passport,"Transporter"),
			["Lenhador"] = vRP.GetExperience(Passport,"Lumberman")
		}

		return Experiences
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXCLUSIVAS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Exclusivas()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Roupas = {}
		local Consult = vRP.GetSrvData("Exclusivas:"..Passport)

		for k,v in pairs(Consult) do
			table.insert(Roupas,{ ["name"] = k, ["id"] = v["id"], ["texture"] = v["texture"] or 0, ["type"] = v["type"] })
		end

		return Roupas
	end
end