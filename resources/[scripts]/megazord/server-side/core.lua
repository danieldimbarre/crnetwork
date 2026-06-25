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
Tunnel.bindInterface("megazord",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState.Resource = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WARNING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Warning(Message,Banned)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Message and not vRP.HasService(Passport,PermBypass) then
		exports.discord:Embed("Hackers","**[SOURCE]:** "..source.."\n**[PASSAPORTE]:** "..Passport.."\n**[MOTIVO]:** "..Message,source)

		if Banned then
			vRP.SetBanned(Passport,-1,"Hacker")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRESOURCES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local List = {}
	for Number = 0,GetNumResources() - 1 do
		List[GetResourceByFindIndex(Number)] = true
	end

	GlobalState.Resource = List
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPLOSIONEVENT
-----------------------------------------------------------------------------------------------------------------------------------------
local SmokeRateLimit = {}
AddEventHandler("explosionEvent",function(source,Data)
	local source = source
	local ExplosionType = tonumber(Data.explosionType)
	
	if ExplosionType == 19 or ExplosionType == 20 or ExplosionType == 21 then
		local currentTime = os.time()
		if not SmokeRateLimit[source] then
			SmokeRateLimit[source] = { count = 1, time = currentTime }
		else
			if currentTime - SmokeRateLimit[source].time > 30 then
				SmokeRateLimit[source] = { count = 1, time = currentTime }
			else
				SmokeRateLimit[source].count = SmokeRateLimit[source].count + 1
			end
		end

		if SmokeRateLimit[source].count < 5 then
			return
		end
	end

	if Explodes[ExplosionType] then
		CancelEvent()

		local Passport = vRP.Passport(source)
		if Passport and not vRP.HasService(Passport,PermBypass) then
			exports.discord:Embed("Hackers","**[SOURCE]:** "..source.."\n**[PASSAPORTE]:** "..Passport.."\n**[MOTIVO]:** "..Explodes[ExplosionType],source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYCREATING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("entityCreating",function(Entity)
	if DoesEntityExist(Entity) then
		if BannedModels[GetEntityModel(Entity)] or NetworkGetEntityOwner(Entity) == nil then
			CancelEvent()

			return
		end
	else
		CancelEvent()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEREVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
for Number = 1,#HackerEvents do
	RegisterServerEvent(HackerEvents[Number])
	AddEventHandler(HackerEvents[Number],function()
		local source = source
		local Passport = vRP.Passport(source)
		if Passport and not vRP.HasService(Passport,PermBypass) then
			exports.discord:Embed("Hackers","**[SOURCE]:** "..source.."\n**[PASSAPORTE]:** "..Passport.."\n**[MOTIVO]:** Hacker Events",source)
			vRP.SetBanned(Passport,-1,"Hacker")
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PTFXEVENT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("ptFxEvent",function(source,Data)
	if Particles[Data.effectHash] or Assets[Data.assetHash] then
		CancelEvent()

		local source = source
		local Passport = vRP.Passport(source)
		if Passport and not vRP.HasService(Passport,PermBypass) then
			exports.discord:Embed("Hackers","**[SOURCE]:** "..source.."\n**[PASSAPORTE]:** "..Passport.."\n**[MOTIVO]:** Particles/Assets Block",source)
			vRP.SetBanned(Passport,-1,"Hacker")
		end
	end
end)