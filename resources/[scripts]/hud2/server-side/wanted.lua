-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Call = {}
local Wanted = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Wanted",function(source,Passport,Seconds)
	if Wanted[Passport] then
		if os.time() > Wanted[Passport] then
			Wanted[Passport] = os.time() + Seconds
		else
			Wanted[Passport] = Wanted[Passport] + Seconds
		end
	else
		Wanted[Passport] = os.time() + Seconds
	end

	--TriggerClientEvent("hud:Wanted",source,Wanted[Passport] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Wanted",function(Passport,source)
	local source = parseInt(source)
	local Passport = parseInt(Passport)

	if Wanted[Passport] then
		if Wanted[Passport] > os.time() then
			if Call[Passport] == nil then
				Call[Passport] = os.time()
			end

			if Call[Passport] <= os.time() and source > 0 then
				Call[Passport] = os.time() + 60

				TriggerClientEvent("Notify",source,"amarelo","Você foi denunciado, parece que suas digitais<br>estão no banco de dados do governo como procurado.",5000)

				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)
				local Polices = vRP.NumPermission("Police")

				for k,v in pairs(Polices) do
					async(function()
						TriggerClientEvent("NotifyPush",v["source"],{ code = 20, title = "Digitais Encontrada", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alerta de procurado", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
			end

			return true
		end
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	if Wanted[Passport] then
		if Wanted[Passport] > os.time() then
			--TriggerClientEvent("hud:Wanted",source,Wanted[Passport] - os.time())
		end
	end
end)