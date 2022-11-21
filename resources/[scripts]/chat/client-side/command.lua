-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Chat",function()
	if not IsPauseMenuActive() then
		SetNuiFocus(true,true)

		-- local Tags = {}

		-- if LocalPlayer["state"]["Police"] then
		-- 	Tags[#Tags + 1] = "Polícia"
		-- end

		-- if LocalPlayer["state"]["Mechanic"] then
		-- 	Tags[#Tags + 1] = "Mecânica"
		-- end

		-- if LocalPlayer["state"]["Paramedic"] then
		-- 	Tags[#Tags + 1] = "Hospital"
		-- end

		SendNUIMessage({ Action = "Chat", Data = Tags, Block = Block })
	end
end)