---------------------------------------------------------------------
RegisterServerEvent("vehcontrol:Server")
AddEventHandler("vehcontrol:Server",function(Siren,Air,vehNet)
	local source = source
	TriggerClientEvent("vehcontrol:Client",-1,Siren,Air,vehNet,source)
end)