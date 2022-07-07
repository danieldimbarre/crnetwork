-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("chat",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local chatOpen = false
local chatActive = true
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUGGESTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local suggestions = {
	{
		name = "/ancorar",
		help = "Ancorar/Desancorar uma embarcação."
	},{
		name = "/sugestao",
		help = "Envia uma sugestão para a equipe de administração."
	},{
		name = "/limbo",
		help = "Reaparecer o personagem na rua mais próxima."
	},{
		name = "/hud",
		help = "Mostra/Esconde a interface na tela."
	},{
		name = "/movie",
		help = "Mostra/Esconde a interface de video na tela."
	},{
		name = "/me",
		help = "Ativar uma animação não existente."
	},{
		name = "/volume",
		help = "Muda o volume do rádio.",
		params = {
			{ name = "número", help = "De 0 a 100 - Padrão: 60" }
		}
	},{
		name = "/chat",
		help = "Ativa/Desativa o chat."
	},{
		name = "/andar",
		help = "Muda o estilo de andar.",
		params = {
			{ name = "número", help = "De 1 a 59" }
		}
	},{
		name = "/e",
		help = "Inicia uma animação a sua escolha.",
		params = {
			{ name = "animação", help = "Nome da animação" }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chatMessage")
AddEventHandler("chatMessage",function(author,color,text)
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		if chatActive then
			local args = { text }
			if author ~= "" then
				table.insert(args,1,author)
			end

			SendNUIMessage({ type = "ON_MESSAGE", message = { color = color, multiline = true, args = args } })
			SendNUIMessage({ type = "ON_SCREEN_STATE_CHANGE", shouldHide = false })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chatME")
AddEventHandler("chatME",function(text)
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		if chatActive then
			SendNUIMessage({ type = "ON_MESSAGE", message = { color = {}, multiline = true, args = { text } } })
			SendNUIMessage({ type = "ON_SCREEN_STATE_CHANGE", shouldHide = false })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERPRINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("__cfx_internal:serverPrint")
AddEventHandler("__cfx_internal:serverPrint",function(msg)
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		SendNUIMessage({ type = "ON_MESSAGE", message = { templateId = "print", multiline = true, args = { msg } } })
		chatOpen = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:addMessage")
AddEventHandler("chat:addMessage",function(message)
	SendNUIMessage({ type = "ON_MESSAGE", message = message })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:clear")
AddEventHandler("chat:clear",function(name)
	SendNUIMessage({ type = "ON_CLEAR" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATRESULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chatResult",function(Data,Callback)
	SetNuiFocus(false,false)

	if Data["message"] then
		if Data["message"]:sub(1,1) == "/" then
			ExecuteCommand(Data["message"]:sub(2))
		else
			TriggerServerEvent("chat:messageEntered",Data["message"])
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("loaded",function(Data,Callback)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chat",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and MumbleIsConnected() then
		if chatOpen then
			if chatActive then
				chatActive = false
				SendNUIMessage({ type = "ON_CLEAR" })
			else
				chatActive = true
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if GetCurrentResourceName() == Resource then
		SetTextChatEnabled(false)
		SetNuiFocus(false,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _,v in ipairs(suggestions) do
		SendNUIMessage({ type = "ON_SUGGESTION_ADD", suggestion = v })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERCHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("enterChat",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and MumbleIsConnected() then
		chatOpen = true
		SetNuiFocus(true,true)
		SendNUIMessage({ type = "ON_OPEN" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("enterChat","Interação ao bate-papo.","keyboard","T")
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSCHAT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.statusChat()
	return chatOpen
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSCHAT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("statusChat",function()
	return chatOpen
end)