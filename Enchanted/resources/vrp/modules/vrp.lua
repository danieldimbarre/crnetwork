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
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNER/PROXY
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy.addInterface("vRP",vRP)
Tunnel.bindInterface("vRP",tvRP)
DEVICE = Tunnel.getInterface("device")
MEMORY = Tunnel.getInterface("memory")
REQUEST = Tunnel.getInterface("request")
TASKBAR = Tunnel.getInterface("taskbar")
SURVIVAL = Tunnel.getInterface("survival")
SAFECRACK = Tunnel.getInterface("safecrack")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetMapName(ServerName)
	SetGameType(ServerName)
	SetRoutingBucketEntityLockdownMode(0,"relaxed")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserPhone(Phone)
	local Consult = vRP.Query("characters/Phone",{ Phone = Phone })
	return Consult[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GeneratePhone()
	local Phone = ""
	local Passport = false

	repeat
		Phone = GenerateString("DDD-DDD")
		Passport = vRP.UserPhone(Phone)
	until not Passport

	return Phone
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Phone(Passport)
	local PhoneNumber = "Inativo"
	if GetResourceState("lb-phone") == "started" then
		local source = vRP.Source(Passport)
		if Characters[source] and Characters[source]["Phone"] then
			PhoneNumber = exports["lb-phone"]:FormatNumber(Characters[source]["Phone"])
		else
			local Consult = vRP.Query("smartphone/Phone",{ Passport = Passport })
			if Consult[1] and Consult[1]["phone_number"] then
				PhoneNumber = exports["lb-phone"]:FormatNumber(Consult[1]["phone_number"])

				if Characters[source] then
					Characters[source]["Phone"] = PhoneNumber
				end
			end
		end

		return PhoneNumber
	elseif GetResourceState("smartphone") == "started" then
		local Consult = vRP.Query("characters/Person",{ id = Passport })
		if Consult[1] and Consult[1]["Phone"] then
			PhoneNumber = Consult[1]["Phone"]
		else
			PhoneNumber = vRP.GeneratePhone()
			vRP.Query("characters/NewPhone",{ Passport = Passport, Phone = PhoneNumber })
		end

		return PhoneNumber
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Request(source,Title,Message)
	return REQUEST.Function(source,Title,Message)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Revive(source,Health)
	return SURVIVAL.Revive(source,Health)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.TASK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Task(source,Amount,Speed)
	return TASKBAR.Task(source,Amount,Speed)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.MEMORY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Memory(source)
	return MEMORY.Memory(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.SAFECRACK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Safecrack(source,Number)
	return SAFECRACK.Safecrack(source,Number)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.DEVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Device(source,Seconds)
    return DEVICE.Device(source,Seconds)
end