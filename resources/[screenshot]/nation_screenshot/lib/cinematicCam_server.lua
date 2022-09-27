--------------------------------------------------
---------------------- EVENTS --------------------
--------------------------------------------------

RegisterServerEvent('CinematicCam:requestPermissions')
AddEventHandler('CinematicCam:requestPermissions', function()
    local user_id = vRP.Passaport(source)
    local isWhitelisted = vRP.HasPermission(user_id,"Admin")
	TriggerClientEvent('CinematicCam:receivePermissions', source, isWhitelisted)
end)
