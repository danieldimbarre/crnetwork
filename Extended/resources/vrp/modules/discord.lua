-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
Discord = {
	["Connect"] = "",
	["Disconnect"] = "",
	["Airport"] = "",
	["Deaths"] = "",
	["Gemstone"] = "",
	["Login"] = "",
	["Payments"] = "",
	["Roles"] = "",
	["Admin"] = "",
	["Loja"] = "",
	["Peak"] = "",
	["Policia"] = "",
	["Paramedico"] = "",
	["Burgershot"] = "",
	["UwuCoffee"] = "",
	["Ballas"] = "",
	["Vagos"] = "",
	["Families"] = "",
	["Aztecas"] = "",
	["Bloods"] = "",
	["DaNangBoys"] = "",
	["Leone"] = "",
	["ONeilBrothers"] = "",
	["Rednecks"] = "",
	["Triads"] = ""
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMBED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Embed",function(Hook,Message,Color)
	PerformHttpRequest(Discord[Hook],function() end,"POST",json.encode({
		username = NameServer,
		embeds = {
			{ color = Color, description = Message }
		}
	}),{ ["Content-Type"] = "application/json" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTENT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Content",function(Hook,Message)
	PerformHttpRequest(Discord[Hook],function(err,text,headers) end,"POST",json.encode({
		username = NameServer,
		content = Message
	}),{ ["Content-Type"] = "application/json" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Payments",function(source,Passport,Work,Value)
	PerformHttpRequest(Discord["Payments"],function() end,"POST",json.encode({
		username = NameServer,
		embeds = {
			{ color = 0xa3c846, description = "**Source:** "..source.."\n**Passaport:** "..Passport.."\n**Valor:** $"..parseFormat(Value).."\n**Emprego:** "..Work.."\n**Cds:** "..vRP.GetEntityCoords(source).."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S") }
		}
	}),{ ["Content-Type"] = "application/json" })
end)