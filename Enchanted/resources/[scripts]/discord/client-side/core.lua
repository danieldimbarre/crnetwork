-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function(Passport,Name)
	SetDiscordAppId(909884329084223488)
	SetDiscordRichPresenceAsset("creative")
	SetRichPresence("#"..Passport.." "..Name)
	SetDiscordRichPresenceAssetText("Creative")
	SetDiscordRichPresenceAssetSmall("creative")
	SetDiscordRichPresenceAssetSmallText("Creative")
	SetDiscordRichPresenceAction(0,"Discord","http://creative-rp.com/")
end)