-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDS
-----------------------------------------------------------------------------------------------------------------------------------------
Discords = {
	["Connect"] = "https://discord.com/api/webhooks/1035718366821896232/JttUYqEC6gHTFG0eW-6hR4oMwqSa4Mwi3KBvqWNlVsuqxpwoIbwWgibaURKiG70Her6z",
	["Disconnect"] = "https://discord.com/api/webhooks/1035719123159765062/0v2-JJ5xztffhpr50eSp-uzy_vfFdAQ63Rdg-heG6IAcJn87s_0sMEscSjhTo_wXLcXa",
	["Airport"] = "https://discord.com/api/webhooks/1035719242970038374/4kVRLdCzfpOVT54Cllr9fmYt-zOdYw7zkUW6kB4_G7xiYptc2Mh7ls1iGo_9XHGwA1Gp",
	["Deaths"] = "https://discord.com/api/webhooks/1035719352642703400/fC6uKw06EvXmkNUW7PcwkVK5q-EfN7_T3JzhFCyvoHp-9Bwx1ulkkHDyltdj-Wf0sLEJ",
	["Police"] = "https://discord.com/api/webhooks/1022874777792282724/ImMiQ61Mc0u5dlHcLNRaaYx3TBKs0ODAvYo1CpEwM9Ht0aw3-7lU0dkQdrnR3BfcI5pw",
	["Paramedic"] = "https://discord.com/api/webhooks/1022874820674867344/NlfNCvOqnwlPiD1Bf_wZrAOHFV9FeiwCJ28mqByFYMdDMEa1Y7qpcdzv9SuPMW9mjEaY",
	["Gemstone"] = "https://discord.com/api/webhooks/1022874907358527599/EwrEt2FQDKc9i3EvHQFEx_oWgPTl4AXdZM_gNY5cCuWZ68-INHXeEAIbV-MimC8WHw8a",
	["Login"] = "https://discordapp.com/api/webhooks/1034966174531858543/uukZZBqyai-tX7av4Gisd_BvutPsRt-ZiDrpgtHKha0mlfhp6XcrHDDgYWFhiHMZMcvw"
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