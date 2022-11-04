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
Tunnel.bindInterface("dynamic",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Experience()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Experiences = {
			["Desmanche"] = vRP.GetExperience(Passport,"Dismantle"),
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
function Creative.Exclusivas()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Clothes = {}
		local Consult = vRP.GetSrvData("Exclusivas:"..Passport)

		for Index,v in pairs(Consult) do
			Clothes[#Clothes + 1] = { ["name"] = Index, ["id"] = v["id"], ["texture"] = v["texture"] or 0, ["type"] = v["type"] }
		end

		return Clothes
	end
end