-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
local Discord = {
	["Connect"] = "https://discord.com/api/webhooks/1236098461938618419/EXvkiZFuDecG6jwhy8xv13ZDHOgiegExJWs9MGloE_TPHci3OE8mT5ZfDsNzsPi_WWVb",
	["Disconnect"] = "https://discord.com/api/webhooks/1236098632877478011/FULwF88Xpdyg9yM9t5ATjXdLA4epapR_omiCM2a-ezm7GpFyyNDxjCRwfN2PpXLbDDM7",
	["Airport"] = "https://discord.com/api/webhooks/1236098711558291547/hXaDw-kLuX2OlYl4fxM-1dMG9Sr5Vmc7MHsbp6PjQ5K4h9i9gBQRPx3DZzHixUxP74gs",
	["Deaths"] = "https://discord.com/api/webhooks/1236098776339583057/JcDJ1rreHcS_wXrJR9YT-2raRnqgyWhb8-g_nICltezBH2dLJZKoEuS9gdYrE9ohApSK",
	["Gemstone"] = "https://discord.com/api/webhooks/1236098888591609908/rWWu1IDLFCvMCtmfSS9f3XqquIGnp-NO9Ub00Co8h3vyKa_5d5lMslxSEu5_OsfcmPT1",
	["Rename"] = "https://discord.com/api/webhooks/1236098963321655377/zSyseJt4Oknj_ZPGFwl3KAM140H5qxS5eDjFaauUjwjysAKWufR6Exx4c4B6oYDtWlW0",
	["Roles"] = "https://discord.com/api/webhooks/1236099025523179560/fjMk1Ho64FVuNHsCv_RJ9qzpJxFi7SdQm9XQdPoMk26x1k-UADV6gNd3nLKesWTvL0Ai",
	["Skins"] = "https://discord.com/api/webhooks/1250285944201019402/1_ZHOnZB5ysulTKVvy6PCXgR0q_Bpyayq3H5pajtl1dBHs-RGKmk-06ebxhtuUGYhQP3",
	["Marketplace"] = "https://discord.com/api/webhooks/1250286539431477331/HTb-asV-ykQZOFbLqTTQa9Y0M70pE3wdJTyyHFH0OxpIr1mkqlBG92BSus5OL5bTHGhf",
	["Pause"] = "https://discord.com/api/webhooks/1250295180981043300/9abvECfBGRMsYAHLLWVEiq3eigDIk-OdvlKQrj6JuneCI9y6ofrycvzawINmjQh3Xtu2",
	["Boxes"] = "https://discord.com/api/webhooks/1250295382269886517/nNHZ0EFIchkHKC78pA9F8MRBQ7dZI15ZpScVfnvMB5EYm0XpQHxSZC6T9lcutP2ttLLe",
	["Hackers"] = "https://discord.com/api/webhooks/1236099146008625203/o4AcDnG5Tse1SKt_IlQIsGxya5uVwSpN2uHDET5Eynt5WsSxmN-8XB77doJZlFIiC0L5"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMBED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Embed",function(Hook,Message,Color,source)
	PerformHttpRequest(Discord[Hook],function() end,"POST",json.encode({
		username = ServerName,
		embeds = {
			{ color = (Color or 0xa3c846), description = Message }
		}
	}),{ ["Content-Type"] = "application/json" })

	if source then
		TriggerClientEvent("megazord:Screenshot",source,Discord[Hook])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTENT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Content",function(Hook,Message)
	PerformHttpRequest(Discord[Hook],function() end,"POST",json.encode({
		username = ServerName,
		content = Message
	}),{ ["Content-Type"] = "application/json" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Webhook",function(Hook)
	return Discord[Hook] or ""
end)