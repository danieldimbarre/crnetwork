-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Chat",function()
	if not IsPauseMenuActive() and LocalPlayer["state"]["Active"] then
		local Tags = {}
		-- for Index,_ in pairs(ClientState) do
		-- 	if LocalPlayer["state"][Index] then
		-- 		Tags[#Tags + 1] = Index
		-- 	end
		-- end

		SendNUIMessage({ Action = "Chat", Data = Tags, Block = Block })
		SetNuiFocus(true,true)
	end
end)