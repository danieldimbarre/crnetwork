-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDS
-----------------------------------------------------------------------------------------------------------------------------------------
Discords = {
	["Connect"] = "https://discord.com/api/webhooks/1022874276065464380/NkKAoIcWvipHev6haEqzvAYRHWzf8GMtyEh0NT8jzZSk5g3Ku0G_2OEERS5vAQeoFfV4",
	["Disconnect"] = "https://discord.com/api/webhooks/1022874371833995264/t-0GcQHrBTuziykBbds2Zu1iFgjKG3ZZrGMxM6H2-ttnCdV04bn8Xm5oKF5hAZznsWF6",
	["Airport"] = "https://discord.com/api/webhooks/1022874655486394378/JOuDg3YeKXB-DFwoT5IiUozBO2K2cWPX6G0QTJV-dhs--vy7_troN93pRd5Z2GhD_9mI",
	["Deaths"] = "https://discord.com/api/webhooks/1022874690647244892/0oy4ge9hLAbWzYTViy3oa3vDONnktPpJoTW6mkB5E8zo8GXnvgDLPAbEYHYzGjnl6mZt",
	["Police"] = "https://discord.com/api/webhooks/1022874777792282724/ImMiQ61Mc0u5dlHcLNRaaYx3TBKs0ODAvYo1CpEwM9Ht0aw3-7lU0dkQdrnR3BfcI5pw",
	["Paramedic"] = "https://discord.com/api/webhooks/1022874820674867344/NlfNCvOqnwlPiD1Bf_wZrAOHFV9FeiwCJ28mqByFYMdDMEa1Y7qpcdzv9SuPMW9mjEaY",
	["Gemstone"] = "https://discord.com/api/webhooks/1022874907358527599/EwrEt2FQDKc9i3EvHQFEx_oWgPTl4AXdZM_gNY5cCuWZ68-INHXeEAIbV-MimC8WHw8a",
	["Login"] = "https://discord.com/api/webhooks/1024682305870114896/F2qoQtwiE358xLbF3rw1nUCfNtj-q5hvWcBk336cSEmM4OBZsz6RAZrxh3SmREssjwwa"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Discord")
AddEventHandler("Discord",function(Hook,Message,Color)
	PerformHttpRequest(Discords[Hook],function(err,text,headers) end,"POST",json.encode({
		username = ServerName,
		embeds = { { color = Color, description = Message } }
	}),{ ["Content-Type"] = "application/json" })
end)