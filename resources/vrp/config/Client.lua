-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function(Passport,Name)
	SetDiscordAppId(1016809425350176911)
	SetDiscordRichPresenceAsset("logo")
	SetRichPresence("#"..Passport.." "..Name)
	-- SetDiscordRichPresenceAssetSmall("creative")
	SetDiscordRichPresenceAssetText("Energy")
	-- SetDiscordRichPresenceAssetSmallText("Creative Network")
	SetDiscordRichPresenceAction(0,"Entrar na Cidade","https://discord.gg/8Z64czXtq6")
	-- SetDiscordRichPresenceAction(1,"Nosso Instagram","https://www.creative-rp.com/instagram/")
end)