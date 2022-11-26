-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Chat",function()
	if not IsPauseMenuActive() then
		SetNuiFocus(true,true)

		local Tags = {}
		-- for Index,v in pairs(ClientState) do
		-- 	if LocalPlayer["state"][Index] then
		-- 		Tags[#Tags + 1] = Index
		-- 	end
		-- end

		SendNUIMessage({ Action = "Chat", Data = Tags, Block = Block })
	end
end)