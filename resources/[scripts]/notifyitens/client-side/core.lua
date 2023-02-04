-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENSNOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify",function(status)
	if status[1] == "recebeu" then
		status[1] = "+"
	elseif status[1] == "removeu" or status[1] == "pagou" then
		status[1] = "-"
	end

	SendNUIMessage({ mode = status[1], item = status[2], amount = parseFormat(status[3]), name = status[4] })
end)