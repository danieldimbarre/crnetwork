-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
local LastAimX,LastAimY = nil,nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Pid = PlayerId()
		local Ped = PlayerPedId()

		if GetPedArmour(Ped) >= 100 then
			TriggerServerEvent("admin:Print","Está com hacker de colete.")
		end

		local Health = GetEntityHealth(Ped)
		if Health > 102 then
			SetEntityHealth(Ped,Health - 2)

			Wait(250)

			if GetEntityHealth(Ped) >= Health and GetEntityHealth(Ped) ~= 0 then
				TriggerServerEvent("admin:Print","Está de GodMode.")
			elseif GetEntityHealth(Ped) == (Health - 2) then
				SetEntityHealth(Ped,Health)
			end
		end

		if not LocalPlayer["state"]["Invincible"] and GetPlayerInvincible_2(Pid) then
			TriggerServerEvent("admin:Print","Está imortal.")
		end

		if GetEntitySpeed(Ped) > 7 and not IsPedInAnyVehicle(Ped) and not IsPedFalling(Ped) and not IsPedInParachuteFreeFall(Ped) and not IsPedJumpingOutOfVehicle(Ped) and not IsPedRagdoll(Ped) and GetPlayerSprintStaminaRemaining(Pid) == 0.0 then
			TriggerServerEvent("admin:Print","Está com estamina infinita.")
		end

		if (not LocalPlayer["state"]["Invisible"] and not IsEntityVisible(Ped)) and GetEntityAlpha(Ped) <= 150 then
			TriggerServerEvent("admin:Print","Ativou a invisibilidade.")
		end

		if IsPlayerCamControlDisabled() then
			TriggerServerEvent("admin:Print","Ativou o Menyoo.")
		end

		if GetLocalPlayerAimState() ~= 3 then
			TriggerServerEvent("admin:Print","Modificou a assistência de mira.")
		end

		if GetPedConfigFlag(Ped,223,true) then
			TriggerServerEvent("admin:Print","Modificou o personagem.")
		end

		if NetworkIsInSpectatorMode() and not LocalPlayer["state"]["Spectate"] then
			TriggerServerEvent("admin:Print","Ativou o modo espectador.")
		end

		if GetUsingseethrough() then
			TriggerServerEvent("admin:Print","Ativou a visão térmica.")
		end

		if GetUsingnightvision() then
			TriggerServerEvent("admin:Print","Ativou a visão noturna.")
		end

		local DetectableTextures = {
			{ txd = "HydroMenu", txt = "HydroMenuHeader", name = "HydroMenu" },
			{ txd = "John", txt = "John2", name = "SugarMenu" },
			{ txd = "darkside", txt = "logo", name = "Darkside" },
			{ txd = "ISMMENU", txt = "ISMMENUHeader", name = "ISMMENU" },
			{ txd = "dopatest", txt = "duiTex", name = "Copypaste Menu" },
			{ txd = "fm", txt = "menu_bg", name = "Fallout" },
			{ txd = "wave", txt = "logo", name = "Wave" },
			{ txd = "wave1", txt = "logo1", name = "Wave (alt.)" },
			{ txd = "meow2", txt = "woof2", name = "Alokas66", x = 1000, y = 1000 },
			{ txd = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86", txt = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6", name = "Guest Menu" },
			{ txd = "hugev_gif_DSGUHSDGISDG", txt = "duiTex_DSIOGJSDG", name = "HugeV Menu" },
			{ txd = "MM", txt = "menu_bg", name = "MetrixFallout" },
			{ txd = "wm", txt = "wm2", name = "WM Menu" }
		}

		for _,Data in pairs(DetectableTextures) do
			if Data["x"] and Data["y"] then
				if GetTextureResolution(Data["txd"],Data["txt"])["x"] == Data["x"] and GetTextureResolution(Data["txd"],Data["txt"])["y"] == Data["y"] then
					TriggerServerEvent("admin:Print","Carregou textura do Monster Menu.")
				end
			else 
				if GetTextureResolution(Data["txd"],Data["txt"])["x"] ~= 4.0 then
					TriggerServerEvent("admin:Print","Carregou textura do Monster Menu.")
				end
			end
		end

		if IsPedInAnyVehicle(Ped) then
			if not LocalPlayer["state"]["Nitro"] then
				local Vehicle = GetVehiclePedIsIn(Ped)
				local Max = GetVehicleEstimatedMaxSpeed(Vehicle)
				local Speed = GetEntitySpeed(Vehicle)

				if Speed > (Max + 10) then
					TriggerServerEvent("admin:Print","Mudou a velocidade dos veículos. Velocidade: "..Speed * 3.6)
				end
			end
		else
			local Speed = GetEntitySpeed(Ped)
			if IsPedRunning(Ped) and Speed > 9 and not IsPedJumping(Ped) then
				TriggerServerEvent("admin:Print","Está correndo igual o flash. Velocidade: "..Speed)
			end
		end

		if IsAimCamActive() then
			local Aiming,Entity = GetEntityPlayerIsFreeAimingAt(Pid)
			if Aiming and Entity then
				if IsEntityAPed(Entity) and not IsEntityDead(Entity) and not IsPedStill(Entity) and not IsPedStopped(Entity) and not IsPedInAnyVehicle(Entity) then
					local Coords = GetEntityCoords(Entity)
					local _,ScreenX,ScreenY = GetScreenCoordFromWorldCoord(Coords["x"],Coords["y"],Coords["z"])
					if ScreenX == LastAimX or ScreenY == LastAimY then
						TriggerServerEvent("admin:Print","Ativou o aimbot.")
					end

					LastAimX = ScreenX
					LastAimY = ScreenY
				end
			end
		end

		if not HasPedGotWeapon(Ped,GetHashKey("WEAPON_UNARMED")) and not LocalPlayer["state"]["Weapon"] then
			local _,Weapon = GetCurrentPedWeapon(Ped)
			RemoveAllPedWeapons(Ped,true)
			TriggerServerEvent("admin:Print","Spawnou uma arma. Arma: "..Weapon)
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKTEXTURES
-----------------------------------------------------------------------------------------------------------------------------------------
local blackTextures = {
	"mp_big_message_freemode","mpmissmarkers256","digitaloverlay","darts","mpleaderboard","commonmenu",
	"mpweaponscommon","visualflow","mpentry","mptattoos","srange_gen","mpweaponsgang1","deadline","timerbars",
	"commonmenutu","ps_menu","hunting","mpinventory","shared","mphud","mpweaponsunusedfornow","helicopterhud","visualflow","trafficcam"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for i = 1,#blackTextures do
			if HasStreamedTextureDictLoaded(blackTextures[i]) then
				TriggerServerEvent("admin:Print","Carregou textura do Monster Menu.")
			end
		end

		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEREVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
local HackerEvents = {
	"esx_vehicletrunk:giveDirty",
	"esx_moneywash:deposit",
	"Esx-MenuPessoal:Boss_recruterplayer",
	"esx_blackmoney:washMoney",
	"esx_ambulancejob:setDeathStatus",
	"esx_carthief:alertcops",
	"esx_dmvschool:addLicense",
	"esx:enterpolicecar",
	"esx_handcuffs:cuffing",
	"esx_jail:sendToJail",
	"esx_jail:unjailQuest",
	"esx_jailer:unjailTime",
	"esx_mecanojob:onNPCJobCompleted",
	"esx_mechanicjob:startHarvest",
	"esx_mechanicjob:startCraft",
	"esx-qalle-hunting:reward",
	"esx-qalle-hunting:sell",
	"esx_skin:responseSaveSkin",
	"esx_society:setJob",
	"esx_skin:responseSaDFWMveSkin",
	"esx_dmvschool:addLiceDFWMnse",
	"esx_mechanicjob:starDFWMtCraft",
	"esx_drugs:startHarvestWDFWMeed",
	"esx_drugs:startTransfoDFWMrmWeed",
	"esx_drugs:startSellWeDFWMed",
	"esx_drugs:startHarvestDFWMCoke",
	"esx_drugs:startTransDFWMformCoke",
	"esx_drugs:startSellCDFWMoke",
	"esx_drugs:startHarDFWMvestMeth",
	"esx_drugs:startTDFWMransformMeth",
	"esx_drugs:startSellMDFWMeth",
	"esx_drugs:startHDFWMarvestOpium",
	"esx_drugs:startSellDFWMOpium",
	"esx_drugs:starDFWMtTransformOpium",
	"esx_blanchisDFWMseur:startWhitening",
	"esx_drugs:stopHarvDFWMestCoke",
	"esx_drugs:stopTranDFWMsformCoke",
	"esx_drugs:stopSellDFWMCoke",
	"esx_drugs:stopHarvesDFWMtMeth",
	"esx_drugs:stopTranDFWMsformMeth",
	"esx_drugs:stopSellMDFWMeth",
	"esx_drugs:stopHarDFWMvestWeed",
	"esx_drugs:stopTDFWMransformWeed",
	"esx_drugs:stopSellWDFWMeed",
	"esx_drugs:stopHarvestDFWMOpium",
	"esx_drugs:stopTransDFWMformOpium",
	"esx_drugs:stopSellOpiuDFWMm",
	"esx_society:openBosDFWMsMenu",
	"esx_tankerjob:DFWMpay",
	"esx_vehicletrunk:givDFWMeDirty",
	"esx_vehicleshop:setVehicleOwnedPlayerId",
	"esx_drugs:pickedUpCDFWMannabis",
	"esx_drugs:processCDFWMannabis",
	"esx-qalle-hunting:DFWMreward",
	"esx-qalle-hunting:seDFWMll",
	"esx_mecanojob:onNPCJobCDFWMompleted",
	"esx_society:putVehicleDFWMInGarage",
	"esx:clientLog",
	"esx:triggerServerCallback",
	"esx:playerLoaded",
	"esx:createMissingPickups",
	"esx:updateLoadout",
	"esx:updateLastPosition",
	"esx:removeInventoryItem",
	"esx:useItem",
	"esx:onPickup",
	"esx_jobs:startWork",
	"esx_jobs:stopWork",
	"esx_fueldDFWMelivery:pay",
	"esx_carthDFWMief:pay",
	"esx_godiDFWMrtyjob:pay",
	"esx_pizza:pDFWMay",
	"esx_ranger:pDFWMay",
	"esx_garbageDFWMjob:pay",
	"esx_truckDFWMerjob:pay",
	"esx_jobs:caDFWMution",
	"esx_carthief:alertcoDFWMps",
	"esx:getShDFWMaredObjDFWMect",
	"esx_society:getOnlDFWMinePlayers",
	"esx_jailer:unjailTiDFWMme",
	"esx_ambulancejob:reDFWMvive",
	"esx_moneywash:depoDFWMsit",
	"esx_moneywash:witDFWMhdraw",
	"esx_handcuffs:cufDFWMfing",
	"esx_policejob:haDFWMndcuff",
	"esx-qalle-jail:jailPDFWMlayer",
	"esx_dmvschool:pDFWMay",
	"esx_biDFWMlling:sendBill",
	"esx_jDFWMailer:sendToJail",
	"esx_jaDFWMil:sendToJail",
	"esx_goDFWMpostaljob:pay",
	"esx_baDFWMnksecurity:pay",
	"esx_sloDFWMtmachine:sv:2",
	"esx:giDFWMveInventoryItem",
	"esx_vehicleshop:setVehicleOwnedDFWM",
	"esx_mafiajob:confiscateDFWMPlayerItem",
	"OG_cuffs:cuffCheckNearest",
	"CheckHandcuff",
	"arisonarp:wiezienie",
	"f0ba1292-b68d-4d95-8823-6230cdf282b6",
	"gambling:spend",
	"265df2d8-421b-4727-b01d-b92fd6503f5e",
	"mission:completed",
	"truckerJob:success",
	"c65a46c5-5485-4404-bacf-06a106900258",
	"paycheck:salary",
	"MF_MobileMeth:RewardPlayers",
	"lscustoms:UpdateVeh",
	"xk3ly-farmer:paycheck",
	"AdminMenu:giveDirtyMoney",
	"Tem2LPs5Para5dCyjuHm87y2catFkMpV",
	"dqd36JWLRC72k8FDttZ5adUKwvwq9n9m",
	"antilynxr4:detect",
	"antilynxr6:detection",
	"ynx8:anticheat",
	"antilynx8r4a:anticheat",
	"lynx8:anticheat",
	"AntiLynxR4:kick",
	"AntiLynxR4:log",
	"Banca:withdraw",
	"BsCuff:Cuff696999",
	"cuffServer",
	"cuffGranted",
	"DFWM:adminmenuenable",
	"DFWM:askAwake",
	"DFWM:checkup",
	"DFWM:cleanareaentity",
	"DFWM:cleanareapeds",
	"DFWM:cleanareaveh",
	"DFWM:enable",
	"DFWM:invalid",
	"DFWM:log",
	"DFWM:openmenu",
	"DFWM:spectate",
	"DFWM:ViolationDetected",
	"eden_garage:payhealth",
	"ems:revive",
	"hentailover:xdlol",
	"JailUpdate",
	"js:removejailtime",
	"LegacyFuel:PayFuel",
	"ljail:jailplayer",
	"mellotrainer:adminTempBan",
	"mellotrainer:adminKick",
	"mellotrainer:s_adminKill",
	"NB:destituerplayer",
	"NB:recruterplayer",
	"paramedic:revive",
	"police:cuffGranted",
	"unCuffServer",
	"uncuffGranted",
	"whoapd:revive",
	"lscustoms:pDFWMayGarage",
	"vrp_slotmachDFWMine:server:2",
	"Banca:dDFWMeposit",
	"bank:depDFWMosit",
	"give_back",
	"AdminMeDFWMnu:giveBank",
	"AdminMDFWMenu:giveCash",
	"NB:recDFWMruterplayer",
	"LegacyFuel:PayFuDFWMel",
	"OG_cuffs:cuffCheckNeDFWMarest",
	"CheckHandcDFWMuff",
	"cuffSeDFWMrver",
	"cuffGDFWMranted",
	"police:cuffGDFWMranted",
	"bank:withdDFWMraw",
	"dmv:succeDFWMss",
	"gambling:speDFWMnd",
	"AdminMenu:giveDirtyMDFWMoney",
	"mission:completDFWMed",
	"truckerJob:succeDFWMss",
	"99kr-burglary:addMDFWMoney",
	"DiscordBot:plaDFWMyerDied",
	"js:jaDFWMiluser",
	"h:xd",
	"adminmenu:setsalary",
	"adminmenu:cashoutall",
	"bank:tranDFWMsfer",
	"paycheck:bonDFWMus",
	"paycheck:salDFWMary",
	"HCheat:TempDisableDetDFWMection",
	"BsCuff:Cuff696DFWM999",
	"veh_SR:CheckMonDFWMeyForVeh",
	"mellotrainer:adminTeDFWMmpBan",
	"mellotrainer:adminKickDFWM",
	"tigoanticheat:getSharedObject",
	"tigoanticheat:triggerServerCallback",
	"tigoanticheat:triggerServerEvent",
	"tigoanticheat:serverCallback",
	"tigoanticheat:triggerClientCallback",
	"tigoanticheat:clientCallback",
	"tigoanticheat:getServerConfig",
	"tigoanticheat:banPlayer",
	"tigoanticheat:playerResourceStarted",
	"tigoanticheat:logToConsole",
	"tigoanticheat:stillAlive",
	"tigoanticheat:storeSecurityToken",
	"modmenu",
	"esx:getSharedObject",
	"esx_ambulancejob:revive",
	"esx_society:openBossMenu",
	"esx_status:set",
	"esx_policejob:handcuff",
	"esx_jailer:wysylandoo",
	"esx_godirtyjob:pay",
	"esx_pizza:pay",
	"esx_slotmachine:sv:2",
	"esx_banksecurity:pay",
	"esx_gopostaljob:pay",
	"esx_truckerjob:pay",
	"esx_carthief:pay",
	"esx_garbagejob:pay",
	"esx_ranger:pay",
	"esx_truckersjob:payy",
	"esx_blanchisseur:washMoney",
	"esx_moneywash:withdraw",
	"esx_blanchisseur:startWhitening",
	"esx_billing:sendBill",
	"esx_dmvschool:pay",
	"esx_jailer:sendToJail",
	"esx_jailler:sendToJail",
	"esx-qalle-jail:jailPlayer",
	"esx-qalle-jail:jailPlayerNew",
	"esx_jailer:sendToJailCatfrajerze",
	"esx_policejob:billPlayer",
	"esx_skin:openRestrictedMenu",
	"esx_inventoryhud:openPlayerInventory",
	"bank:transfer",
	"advancedFuel:setEssence",
	"tost:zgarnijsiano",
	"Sasaki_kurier:pay",
	"wojtek_ubereats:napiwek",
	"wojtek_ubereats:hajs",
	"xk3ly-barbasz:getfukingmony",
	"xk3ly-farmer:paycheck",
	"tostzdrapka:wygranko",
	"laundry:washcash",
	"projektsantos:mandathajs",
	"program-keycard:hacking",
	"6a7af019-2b92-4ec2-9435-8fb9bd031c26",
	"211ef2f8-f09c-4582-91d8-087ca2130157",
	"neweden_garage:pay",
	"8321hiue89js",
	"js:jailuser",
	"wyspa_jail:jailPlayer",
	"wyspa_jail:jail",
	"ambulancier:selfRespawn",
	"UnJP",
	"esx-qalle-jail:openJailMenu",
	"esx:spawnVehicle",
	"HCheat:TempDisableDetection",
	"bank:deposit",
	"bank:withdraw",
	"cacador-vender",
	"esx:giveInventoryItem",
	"esx_jobs:caution",
	"esx_fueldelivery:pay",
	"esx_society:getOnlinePlayers",
	"esx_vehicleshop:setVehicleOwned",
	"AdminMenu:giveBank",
	"AdminMenu:giveCash",
	"vrp_slotmachine:server:2",
	"Banca:deposit",
	"lscustoms:payGarage",
	"LegacyFuel:PayFuel",
	"blarglebus:finishRoute",
	"dmv:success",
	"departamento-vender",
	"reanimar:pagamento",
	"adminmenu:allowall",
	"antilynx8:anticheat",
	"DiscordBot:playerDie",
	"esx_fueldeliver",
	"PayForRepairNow",
	"esx_pizza:pay",
	"esx_jobs:caution",
	"bank:transfer",
	"lscustoms:payGarag",
	"esx_vangelico_robbery:gioielli1",
	"99kr-burglary:addMoney",
	"burglary:money",
	"lenzh_chopshop:sell",
	"esx_deliveries:AddCashMoney",
	"loffe_prisonwork",
	"esx_tankerjob:pay",
	"napadtransport:graczZrobilnapad",
	"tost:zgarnijsiano",
	"esx_loffe_fangelse:Pay",
	"esx_mugging:giveMoney",
	"esx_robnpc:giveMoney",
	"esx_vehicletrunk:giveDirty",
	"esx_gopostaljob:pay",
	"f0ba1292-b68d-4d95-8823-6230cdf282b6",
	"gambling:spend",
	"265df2d8-421b-4727-b01d-b92fd6503f5e",
	"AdminMenu:giveDirtyMoney",
	"AdminMenu:giveBank",
	"AdminMenu:giveCash",
	"esx_slotmachine:sv:2",
	"esx_moneywash:deposit",
	"esx_moneywash:withdraw",
	"esx_moneywash:deposit",
	"mission:completed",
	"truckerJob:success",
	"esx_fishing:receiveFish",
	"c65a46c5-5485-4404-bacf-06a106900258",
	"dropOff",
	"truckerfuel:success",
	"delivery:success",
	"lscustoms:payGarage",
	"esx_brinksjob:pay",
	"esx_garbagejob:pay",
	"esx_postejob:pay",
	"esx_garbage:pay",
	"esx_carteirojob:pay",
	"esx_pilot:success",
	"esx_taxijob:success",
	"adminmenu:setsalary",
	"esx_mugging:giveMoney",
	"paycheck:salary",
	"vrp_slotmachine:server:2",
	"DiscordBot:playerDied",
	"esx_drugs:startHarvestWeed",
	"esx_drugs:startTransformWeed",
	"esx_drugs:startSellWeed",
	"esx_drugs:startHarvestCoke",
	"esx_drugs:startTransformCoke",
	"esx_drugs:startSellCoke",
	"esx_drugs:startHarvestMeth",
	"esx_drugs:startTransformMeth",
	"esx_drugs:startSellMeth",
	"esx_drugs:startHarvestOpium",
	"esx_drugs:startTransformOpium",
	"esx_drugs:startSellOpium",
	"esx_drugs:stopTransformCoke",
	"esx_handcuffs:unlocking",
	"esx_policejob:requestarrest",
	"esx_policejob:handcuffPasta",
	"17A34C820A685513C5B4ADDD85968B9E905CC300A261EB55D299ABCB6C90AAA872712B3B6C13DC41913FCC2BE84A07EF9300DC4E89669A4B0E6FBB344A69D239",
	"llotrainer:adminKick",
	"esx_mafiajob:confiscatePlayerItem",
	"InteractSound_SV:PlayOnAll",
	"SEM_InteractionMenu:Jail",
	"SEM_InteractionMenu:DragNear"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEREVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
for i = 1,#HackerEvents do
	RegisterNetEvent(HackerEvents[i])
	AddEventHandler(HackerEvents[i],function()
		TriggerServerEvent("admin:Print","Carregou textura do Monster Menu.")
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStop",function(Resource)
	TriggerServerEvent("AnyResource",Resource,"Pausou")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	TriggerServerEvent("AnyResource",Resource,"Iniciou")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Name,Message)
	local Player = PlayerId()
	local Source = GetPlayerServerId(NetworkGetEntityOwner(Message[2]))

	if Source == GetPlayerServerId(PlayerId()) or Message[2] == -1 then
		if IsEntityAPed(Message[1]) then
			if not IsEntityOnScreen(Message[1]) then
				local Coords = GetEntityCoords(Message[1])
                local Distance = #(Coords - GetEntityCoords(PlayerPedId()))
				TriggerServerEvent("admin:Print","Atirou em um jogador sem estar na tela dele. Distância: "..Distance)
			end
		end
	end

	if Name == "CEventNetworkPlayerCollectedPickup" then
		TriggerServerEvent("admin:Print","Coletou um pickup de hacker.")
	end
end)