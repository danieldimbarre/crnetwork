-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]:set("Route",0,false)
LocalPlayer["state"]:set("Name","",false)
LocalPlayer["state"]:set("Rope",false,false)
LocalPlayer["state"]:set("Passport",0,false)
LocalPlayer["state"]:set("Cancel",false,true)
LocalPlayer["state"]:set("Active",false,false)
LocalPlayer["state"]:set("Handcuff",false,true)
LocalPlayer["state"]:set("Commands",false,true)
LocalPlayer["state"]:set("Spectate",false,false)
LocalPlayer["state"]:set("Invisible",false,false)
LocalPlayer["state"]:set("Invincible",false,false)
LocalPlayer["state"]:set("usingPhone",false,false)
LocalPlayer["state"]:set("Player",GetPlayerServerId(PlayerId()),false)
LocalPlayer["state"]:set("Nitro",false,true)
LocalPlayer["state"]:set("Debug",false,false)
LocalPlayer["state"]:set("Textform",false,false)
LocalPlayer["state"]:set("Tea",3600,false)

LocalPlayer["state"]:set("Admin",false,false)
LocalPlayer["state"]:set("Police",false,false)
LocalPlayer["state"]:set("Paramedic",false,false)
LocalPlayer["state"]:set("Law",false,false)
LocalPlayer["state"]:set("Mechanic",false,false)
LocalPlayer["state"]:set("Taxi",false,false)
LocalPlayer["state"]:set("BurgerShot",false,false)
LocalPlayer["state"]:set("PizzaThis",false,false)
LocalPlayer["state"]:set("UwuCoffee",false,false)
LocalPlayer["state"]:set("BeanMachine",false,false)
LocalPlayer["state"]:set("Ballas",false,false)
LocalPlayer["state"]:set("Vagos",false,false)
LocalPlayer["state"]:set("Families",false,false)
LocalPlayer["state"]:set("Aztecas",false,false)
LocalPlayer["state"]:set("YoungBoys",false,false)
LocalPlayer["state"]:set("Triads",false,false)
LocalPlayer["state"]:set("Razors",false,false)
LocalPlayer["state"]:set("Tribo",false,false)
LocalPlayer["state"]:set("Lost",false,false)
LocalPlayer["state"]:set("Marabunta",false,false)
LocalPlayer["state"]:set("Dracing",false,false)
LocalPlayer["state"]:set("Favela01",false,false)
LocalPlayer["state"]:set("Favela02",false,false)
LocalPlayer["state"]:set("Favela03",false,false)
LocalPlayer["state"]:set("Favela04",false,false)

LocalPlayer["state"]:set("Buttons",false,true)
LocalPlayer["state"]:set("Cassino",false,false)
LocalPlayer["state"]:set("Race",false,false)
LocalPlayer["state"]:set("Target",false,false)
LocalPlayer["state"]:set("Bed",false,false)
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
	SetDiscordRichPresenceAction(0,"Entrar na Cidade","https://discord.gg/energy-rp/")
	SetDiscordRichPresenceAction(1,"Nosso Instagram","https://www.instagram.com/cidadeenergy/")

	RequestIpl("rc12b_default")
	AddTextEntry("FE_THDR_GTAO","Energy")

	Wait(5000)

	ReplaceHudColourWithRgba(116,0,224,118,255)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIND
-----------------------------------------------------------------------------------------------------------------------------------------
local cdBtns = GetGameTimer()
RegisterCommand("energyBind",function(source,args,rawCommand)
	if GetGameTimer() >= cdBtns then
		cdBtns = GetGameTimer() + 1000
		local Ped = PlayerPedId()
		if not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Cassino"] and not LocalPlayer["state"]["usingPhone"] and GetEntityHealth(Ped) > 101 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			if args[1] == "0" then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped,6) and not IsPedSwimming(Ped) then
					if IsEntityPlayingAnim(Ped,"amb@world_human_sunbathe@male@front@idle_a","idle_a",3) and IsEntityPlayingAnim(Ped,"jh_1_ig_3-2","cs_jewelass_dual-2",3) then
						StopAnimTask(Ped,"amb@world_human_sunbathe@male@front@idle_a","idle_a",2.0)
						StopAnimTask(Ped,"jh_1_ig_3-2","cs_jewelass_dual-2",2.0)
						tvRP.removeObjects("one")
					else
						tvRP.playAnim(false,{"amb@world_human_sunbathe@male@front@idle_a","idle_a"},true)
						tvRP.playAnim(true,{"jh_1_ig_3-2","cs_jewelass_dual-2"},true)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERKEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("energyBind 0","Interação do botão 0.","keyboard","0")