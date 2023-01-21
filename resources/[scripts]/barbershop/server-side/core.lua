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
Tunnel.bindInterface("barbershop",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckWanted()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Wanted(Passport,source) and #exports["bank"]:Fines(Passport) <= 0 then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.updateSkin(Barbers,Creator)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Tables = json.encode(Barbers)
		if Tables ~= "[]" then
			vRP.Query("playerdata/SetData",{ Passport = Passport, dkey = "Barbershop", dvalue = Tables })
		end

		if Creator then
			vRP.Query("playerdata/SetData",{ Passport = Passport, dkey = "Creator", dvalue = 1 })

			TriggerEvent("vRP:BucketServer",source,"Exit")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
local Debug = {}
RegisterServerEvent("barbershop:Debug")
AddEventHandler("barbershop:Debug",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Debug[Passport] then
			Debug[Passport] = os.time()
		end

		if os.time() >= Debug[Passport] then
			TriggerClientEvent("barbershop:Apply",source,vRP.UserData(Passport,"Barbershop"))
			TriggerClientEvent("skinshop:Apply",source,vRP.UserData(Passport,"Clothings"))
			TriggerClientEvent("tattoos:Apply",source,vRP.UserData(Passport,"Tatuagens"))
			TriggerClientEvent("target:Debug",source)
			TriggerEvent("DebugObjects",Passport)

			Debug[Passport] = os.time() + 10
		else
			local Cooldown = parseInt(Debug[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..MinimalTimers(Cooldown).."</b>.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Debug[Passport] then
		Debug[Passport] = nil
	end
end)