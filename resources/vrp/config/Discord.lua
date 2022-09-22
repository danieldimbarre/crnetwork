-----------------------------------------------------------------------------------------------------------------------------------------
-- LINKS
-----------------------------------------------------------------------------------------------------------------------------------------
local Links = {
	["Connect"] = "",
	["Disconnect"] = "",
	["Airport"] = "",
	["Deaths"] = "",
	["Police"] = "",
	["Paramedic"] = "",
	["Hackers"] = "",
	["Gemstone"] = ""
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Discord")
AddEventHandler("Discord",function(Hook,Message,Color)
	PerformHttpRequest(Links[Hook],function(err,text,headers) end,"POST",json.encode({
		username = "Creative Network",
		embeds = { { color = Color, description = Message } }
	}),{ ["Content-Type"] = "application/json" })
end)