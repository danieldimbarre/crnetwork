-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["Name"] = ""
LocalPlayer["state"]["Route"] = 0
LocalPlayer["state"]["Passport"] = 0
LocalPlayer["state"]["Cancel"] = false
LocalPlayer["state"]["Active"] = false
LocalPlayer["state"]["Handcuff"] = false
LocalPlayer["state"]["Commands"] = false
LocalPlayer["state"]["usingPhone"] = false
LocalPlayer["state"]["Player"] = GetPlayerServerId(PlayerId())
LocalPlayer["state"]["Rope"] = false
LocalPlayer["state"]["Textform"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIENTSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["Admin"] = false
LocalPlayer["state"]["Police"] = false
LocalPlayer["state"]["Paramedic"] = false
LocalPlayer["state"]["Mechanic"] = false
LocalPlayer["state"]["Taxi"] = false
LocalPlayer["state"]["BurgerShot"] = false
LocalPlayer["state"]["PizzaThis"] = false
LocalPlayer["state"]["UwuCoffee"] = false
LocalPlayer["state"]["BeanMachine"] = false
LocalPlayer["state"]["Ballas"] = false
LocalPlayer["state"]["Vagos"] = false
LocalPlayer["state"]["Families"] = false
LocalPlayer["state"]["Aztecas"] = false
LocalPlayer["state"]["Bloods"] = false
LocalPlayer["state"]["Triads"] = false
LocalPlayer["state"]["Razors"] = false
LocalPlayer["state"]["Tribo"] = false
LocalPlayer["state"]["Lost"] = false
LocalPlayer["state"]["Marabunta"] = false
LocalPlayer["state"]["Dracing"] = false
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

	Wait(30000)

	ReplaceHudColour(116,18)
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