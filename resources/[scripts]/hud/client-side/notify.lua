-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(Css,Message,Timer)
	SendNUIMessage({ Action = "Notify", Css = Css, Message = Message, Timer = Timer })
end)