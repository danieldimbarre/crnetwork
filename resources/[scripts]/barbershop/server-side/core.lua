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
cRP = {}
Tunnel.bindInterface("barbershop",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkShares()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.GetFine(source) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
			return false
		end

		if exports["hud"]:Reposed(Passport) or exports["hud"]:Wanted(Passport,source) then
			return false
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateSkin(Clothes)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Execute("playerdata/SetData",{ Passport = Passport, dkey = "Barbershop", dvalue = json.encode(Clothes) })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Debug")
AddEventHandler("barbershop:Debug",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerClientEvent("barbershop:Apply",source,vRP.userData(Passport,"Barbershop"))
		TriggerClientEvent("skinshop:Apply",source,vRP.userData(Passport,"Clothings"))
		TriggerClientEvent("tattoos:Apply",source,vRP.userData(Passport,"Tatuagens"))
		TriggerClientEvent("target:Debug",source)

		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		TriggerClientEvent("syncarea",source,Coords["x"],Coords["y"],Coords["z"],1)
	end
end)