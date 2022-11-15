-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Chat",function()
	if not IsPauseMenuActive() then
		SetNuiFocus(true,true)

		local Tags = {}

		if LocalPlayer["state"]["Police"] then
			Tags[#Tags + 1] = "Police"
		end

		if LocalPlayer["state"]["Mechanic"] then
			Tags[#Tags + 1] = "Mechanic"
		end

		if LocalPlayer["state"]["Paramedic"] then
			Tags[#Tags + 1] = "Paramedic"
		end

		SendNUIMessage({ Action = "Chat", Data = Tags, Block = Block })
	end
end)