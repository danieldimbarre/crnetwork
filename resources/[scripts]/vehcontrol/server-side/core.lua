---------------------------------------------------------------------
RegisterServerEvent("vehcontrol:Server")
AddEventHandler("vehcontrol:Server",function(Siren,Air,Network)
	local source = source
	TriggerClientEvent("vehcontrol:Client",-1,Siren,Air,Network,source)
end)