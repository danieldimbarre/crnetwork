-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function(Passport,Name)
	SetDiscordAppId(APPID)
	SetDiscordRichPresenceAsset("NAMEIMG")
	SetRichPresence("#"..Passport.." "..Name)
	SetDiscordRichPresenceAssetText("NAMESERVER")
	SetDiscordRichPresenceAssetSmall("NAMEIMG")
	SetDiscordRichPresenceAssetSmallText("NAMESERVER")
	SetDiscordRichPresenceAction(0,"Discord","LINKDISCORD")
end)