-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
local Discord = {
	["Connect"] = "https://discord.com/api/webhooks/1218042721227509760/IogjTov41BUjOLiNzjHGYRNCeFHyIaCuzNocGjnGOYG55OqgSqNXMRUM10g5IyTx4UnA",
	["Disconnect"] = "https://discord.com/api/webhooks/1218042814701633636/ZfnEWKDRInA4vs1HOnH6yk8lQWQYQr2DNwFmGinXUVyimfK1KTMoh8VDxIZ_agzYNdYL",
	["Airport"] = "https://discord.com/api/webhooks/1218042878316777532/tYz91uv1vg1vc2PERFPoUQtcOSmJAkel8f-UuswaSsHMT_eceyEaIco8CAWgdhzxS4q0",
	["Deaths"] = "https://discord.com/api/webhooks/1218042929189228555/GrGEJRPBxron5iHc_Iu5N9RhKcZOzmZvqMzMuok7WW_8ldrEK9xNpvsHCfNm9oazdmQh",
	["Gemstone"] = "https://discord.com/api/webhooks/1218042990220541972/4-CknRXAtpXrzRxzbrJx_NCgoY8_QmTYAZXepsyXF1ybIJa170KeT_fYvElobRCt-QkJ",
	["Rename"] = "https://discord.com/api/webhooks/1218043064833146880/CGELohxg61Pr4RqLhcMY8Rmj_6iGwx5kiPUS8AuzD-5TMTbC1KUF0LSWwo37h9npf0k8",
	["Roles"] = "https://discord.com/api/webhooks/1218043128276320276/nrvvM71JRTocL34P3KLUyppIeF3fZoabZL8W4n2aarWV_Bf50etSAeu5ESu_38F7Qp7S",
	["Policia"] = "https://discord.com/api/webhooks/1226641098194030662/3JJKUy_SXJYvpuqBwrP-S2_Z_hf6GNTo4So-tBBQlVMssQzquLHzp1q50bytc-DKhRyw",
	["Paramedico"] = "https://discord.com/api/webhooks/1218043260115751023/Y6BbsAlwriYtyL_TswJy5eNE795cmvY4IIEPcsIHjNSFNskzg5eNNt6N64ERZXubpX25"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMBED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Embed",function(Hook,Message,Color)
	PerformHttpRequest(Discord[Hook],function() end,"POST",json.encode({
		username = ServerName,
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
		username = ServerName,
		content = Message
	}),{ ["Content-Type"] = "application/json" })
end)