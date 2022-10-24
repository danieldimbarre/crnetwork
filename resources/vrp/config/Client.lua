-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Phone = false
local cdBtns = GetGameTimer()
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
	SetDiscordRichPresenceAction(0,"Entrar na Cidade","https://discord.gg/8Z64czXtq6/")
	SetDiscordRichPresenceAction(1,"Nosso Instagram","https://www.instagram.com/cidadeenergy/")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	RequestIpl("RC12B_Default")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SMARTPHONE:STATUS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:Phone",function(Status)
	Phone = Status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("energyBind",function(source,args,rawCommand)
	if GetGameTimer() >= cdBtns and LocalPlayer["state"]["Network"] then
		cdBtns = GetGameTimer() + 1000

		local Ped = PlayerPedId()
		if not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Cassino"] and not Phone and GetEntityHealth(Ped) > 101 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(Ped) then
			if args[1] == "0" then
				if not IsPedInAnyVehicle(Ped) and not IsPedArmed(Ped,6) and not IsPedSwimming(Ped) then
					if IsEntityPlayingAnim(Ped,"amb@world_human_sunbathe@male@front@idle_a","idle_a",3) and IsEntityPlayingAnim(Ped,"jh_1_ig_3-2","cs_jewelass_dual-2",3) then
						StopAnimTask(Ped,"amb@world_human_sunbathe@male@front@idle_a","idle_a",2.0)
						StopAnimTask(Ped,"jh_1_ig_3-2","cs_jewelass_dual-2",2.0)
						vRP.stopActived()
					else
						vRP.playAnim(false,{"amb@world_human_sunbathe@male@front@idle_a","idle_a"},true)
						vRP.playAnim(false,{"jh_1_ig_3-2","cs_jewelass_dual-2"},true)
					end
				end
			end
		end
	end
end)

RegisterKeyMapping("energyBind 0","Interação do botão 0.","keyboard","0")