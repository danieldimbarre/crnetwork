-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("creative")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFTENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
-- function driftEnable()
-- 	if not IsPauseMenuActive() then
-- 		local Ped = PlayerPedId()
-- 		if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyBoat(Ped) and not IsPedInAnyPlane(Ped) then
-- 			local Vehicle = GetVehiclePedIsIn(Ped)
-- 			if GetPedInVehicleSeat(Vehicle,-1) == Ped then
-- 				local speed = GetEntitySpeed(Vehicle) * 3.6
-- 				if speed <= 100.0 and speed >= 5.0 then
-- 					SetVehicleReduceGrip(Vehicle,true)

-- 					if not GetDriftTyresEnabled(Vehicle) then
-- 						SetDriftTyresEnabled(Vehicle,true)
-- 						SetReduceDriftVehicleSuspension(Vehicle,true)
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFTDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
-- function driftDisable()
-- 	local Ped = PlayerPedId()
-- 	if IsPedInAnyVehicle(Ped) then
-- 		local Vehicle = GetLastDrivenVehicle()

-- 		if GetDriftTyresEnabled(Vehicle) then
-- 			SetVehicleReduceGrip(Vehicle,false)
-- 			SetDriftTyresEnabled(Vehicle,false)
-- 			SetReduceDriftVehicleSuspension(Vehicle,false)
-- 		end
-- 	end
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEDRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("+activeDrift",driftEnable)
-- RegisterCommand("-activeDrift",driftDisable)
-- RegisterKeyMapping("+activeDrift","Ativação do drift.","keyboard","LSHIFT")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {
	{ 1239.87,-3257.2,7.09,67,62,"Caminhoneiro",0.5 },
	{ -676.58,312.84,83.09,80,38,"Hospital",0.5 },
	{ -247.42,6331.39,32.42,80,38,"Hospital",0.5 },
	-- { 1185.21,-1461.05,34.88,106,38,"Bombeiros",0.5 },
	{ 55.43,-876.19,30.66,357,38,"Garagem",0.6 },
	{ 598.04,2741.27,42.07,357,65,"Garagem",0.6 },
	{ -136.36,6357.03,31.49,357,38,"Garagem",0.6 },
	{ 275.23,-345.54,45.17,357,65,"Garagem",0.6 },
	{ 596.40,90.65,93.12,357,65,"Garagem",0.6 },
	{ -340.76,265.97,85.67,357,65,"Garagem",0.6 },
	{ -2030.01,-465.97,11.60,357,65,"Garagem",0.6 },
	{ -1184.92,-1510.00,4.64,357,65,"Garagem",0.6 },
	{ 214.02,-808.44,31.01,357,65,"Garagem",0.6 },
	{ -348.88,-874.02,31.31,357,65,"Garagem",0.6 },
	{ 67.74,12.27,69.21,357,65,"Garagem",0.6 },
	{ 361.90,297.81,103.88,357,65,"Garagem",0.6 },
	{ 1035.89,-763.89,57.99,357,65,"Garagem",0.6 },
	{ -796.63,-2022.77,9.16,357,65,"Garagem",0.6 },
	{ 453.27,-1146.76,29.52,357,65,"Garagem",0.6 },
	{ 528.66,-146.3,58.38,357,65,"Garagem",0.6 },
	{ -1159.48,-739.32,19.89,357,65,"Garagem",0.6 },
	{ 101.22,-1073.68,29.38,357,65,"Garagem",0.6 },
	{ 1725.21,4711.77,42.11,357,65,"Garagem",0.6 },
	{ 1624.05,3566.14,35.15,357,38,"Garagem",0.6 },
	{ -73.35,-2004.6,18.27,357,65,"Garagem",0.6 },
	{ 426.57,-981.71,30.7,60,18,"Departamento Policial",0.6 },
	{ 1839.67,3667.94,33.87,60,18,"Departamento Policial",0.6 },
	{ -448.18,6011.68,31.71,60,18,"Departamento Policial",0.6 },
	-- { 387.0,787.88,187.47,60,18,"Departamento Policial",0.6 },
	{ 382.92,-1590.65,29.27,60,18,"Departamento Policial",0.6 },
	{ 29.2,-1351.89,29.34,52,36,"Loja de Departamento",0.5 },
	{ 2561.74,385.22,108.61,52,36,"Loja de Departamento",0.5 },
	{ 1160.21,-329.4,69.03,52,36,"Loja de Departamento",0.5 },
	{ -711.99,-919.96,19.01,52,36,"Loja de Departamento",0.5 },
	{ -54.56,-1758.56,29.05,52,36,"Loja de Departamento",0.5 },
	{ 375.87,320.04,103.42,52,36,"Loja de Departamento",0.5 },
	{ -3237.48,1004.72,12.45,52,36,"Loja de Departamento",0.5 },
	{ 1730.64,6409.67,35.0,52,36,"Loja de Departamento",0.5 },
	{ 543.51,2676.85,42.14,52,36,"Loja de Departamento",0.5 },
	{ 1966.53,3737.95,32.18,52,36,"Loja de Departamento",0.5 },
	{ 2684.73,3281.2,55.23,52,36,"Loja de Departamento",0.5 },
	{ 1696.12,4931.56,42.07,52,36,"Loja de Departamento",0.5 },
	{ -1820.18,785.69,137.98,52,36,"Loja de Departamento",0.5 },
	{ 1395.35,3596.6,34.86,52,36,"Loja de Departamento",0.5 },
	{ -2977.14,391.22,15.03,52,36,"Loja de Departamento",0.5 },
	{ -3034.99,590.77,7.8,52,36,"Loja de Departamento",0.5 },
	{ 1144.46,-980.74,46.19,52,36,"Loja de Departamento",0.5 },
	{ 1166.06,2698.17,37.95,52,36,"Loja de Departamento",0.5 },
	{ -1493.12,-385.55,39.87,52,36,"Loja de Departamento",0.5 },
	{ -1228.6,-899.7,12.27,52,36,"Loja de Departamento",0.5 },
	{ 157.82,6631.8,31.68,52,36,"Loja de Departamento",0.5 },
	{ -154.06,6329.28,31.56,52,36,"Loja de Departamento",0.5 },
	{ 817.24,-785.81,26.18,52,36,"Loja de Departamento",0.5 },
	{ 1702.78,3748.82,34.05,76,6,"Loja de Armas",0.4 },
	{ 240.06,-43.74,69.71,76,6,"Loja de Armas",0.4 },
	{ 843.95,-1020.43,27.53,76,6,"Loja de Armas",0.4 },
	{ -322.19,6072.86,31.27,76,6,"Loja de Armas",0.4 },
	{ -664.03,-949.22,21.53,76,6,"Loja de Armas",0.4 },
	{ -1318.83,-389.19,36.43,76,6,"Loja de Armas",0.4 },
	{ -1110.11,2687.5,18.62,76,6,"Loja de Armas",0.4 },
	{ 2569.23,309.46,108.46,76,6,"Loja de Armas",0.4 },
	{ -3159.91,1080.64,20.69,76,6,"Loja de Armas",0.4 },
	{ 15.42,-1120.47,28.81,76,6,"Loja de Armas",0.4 },
	{ 811.81,-2145.58,29.34,76,6,"Loja de Armas",0.4 },
	{ -815.12,-184.15,37.57,71,62,"Barbearia",0.5 },
	{ 138.13,-1706.46,29.3,71,62,"Barbearia",0.5 },
	{ -1280.92,-1117.07,7.0,71,62,"Barbearia",0.5 },
	{ 1930.54,3732.06,32.85,71,62,"Barbearia",0.5 },
	{ 1214.2,-473.18,66.21,71,62,"Barbearia",0.5 },
	{ -33.61,-154.52,57.08,71,62,"Barbearia",0.5 },
	{ -276.65,6226.76,31.7,71,62,"Barbearia",0.5 },
	-- { -1117.26,-1438.74,5.11,366,62,"Loja de Roupas",0.5 },
	{ 86.06,-1391.64,29.23,366,62,"Loja de Roupas",0.5 },
	{ -719.94,-158.18,37.0,366,62,"Loja de Roupas",0.5 },
	{ -152.79,-306.79,38.67,366,62,"Loja de Roupas",0.5 },
	{ -816.39,-1081.22,11.12,366,62,"Loja de Roupas",0.5 },
	{ -1206.51,-781.5,17.12,366,62,"Loja de Roupas",0.5 },
	{ -1458.26,-229.79,49.2,366,62,"Loja de Roupas",0.5 },
	{ -2.41,6518.29,31.48,366,62,"Loja de Roupas",0.5 },
	{ 1682.59,4819.98,42.04,366,62,"Loja de Roupas",0.5 },
	{ 129.46,-205.18,54.51,366,62,"Loja de Roupas",0.5 },
	{ 618.49,2745.54,42.01,366,62,"Loja de Roupas",0.5 },
	{ 1197.93,2698.21,37.96,366,62,"Loja de Roupas",0.5 },
	{ -3165.74,1061.29,20.84,366,62,"Loja de Roupas",0.5 },
	{ -1093.76,2703.99,19.04,366,62,"Loja de Roupas",0.5 },
	{ 414.86,-807.57,29.34,366,62,"Loja de Roupas",0.5 },
	{ -1082.22,-247.54,37.77,439,73,"Life Invader",0.6 },
	{ -1728.06,-1050.69,1.71,266,62,"Embarcações",0.5 },
	{ 1966.36,3975.86,31.51,266,62,"Embarcações",0.5 },
	{ -776.72,-1495.02,2.29,266,62,"Embarcações",0.5 },
	{ -893.97,5687.78,3.29,266,62,"Embarcações",0.5 },
	{ 4952.76,-5163.6,-0.3,266,62,"Embarcações",0.5 },
	{ 356.42,274.61,103.14,67,62,"Transportador",0.5 },
	{ 2433.45,5013.46,46.99,285,62,"Lenhador",0.5 },
	-- { -172.21,6385.85,31.49,403,5,"Farmácia",0.7 },
	-- { 1690.07,3581.68,35.62,403,5,"Farmácia",0.7 },
	-- { 315.12,-1068.58,29.39,403,5,"Farmácia",0.7 },
	-- { 114.45,-4.89,67.82,403,5,"Farmácia",0.7 },
	-- { 46.66,-1749.79,29.64,78,11,"Mercado Central",0.5 },
	-- { 2747.28,3473.04,55.67,78,11,"Mercado Central",0.5 },
	{ 82.54,-1553.28,29.59,318,62,"Lixeiro",0.6 },
	{ 287.36,2843.6,44.7,318,62,"Lixeiro",0.6 },
	{ -413.97,6171.58,31.48,318,62,"Lixeiro",0.6 },
	{ -428.56,-1728.33,19.79,467,11,"Reciclagem",0.6 },
	{ 180.07,2793.29,45.65,467,11,"Reciclagem",0.6 },
	{ -195.42,6264.62,31.49,467,11,"Reciclagem",0.6 },
	{ 409.42,-1623.16,29.28,357,9,"Impound",0.6 },
	{ 820.61,-813.38,26.2,402,26,"Mecânica",0.7 },
	{ 2953.93,2787.49,41.5,617,62,"Minerador",0.6 },
	{ 1322.93,-1652.29,52.27,75,13,"Loja de Tatuagem",0.5 },
	{ -1154.42,-1425.9,4.95,75,13,"Loja de Tatuagem",0.5 },
	{ 322.84,180.16,103.58,75,13,"Loja de Tatuagem",0.5 },
	{ -3169.62,1075.8,20.83,75,13,"Loja de Tatuagem",0.5 },
	{ 1864.07,3747.9,33.03,75,13,"Loja de Tatuagem",0.5 },
	{ -293.57,6199.85,31.48,75,13,"Loja de Tatuagem",0.5 },
	{ 1525.07,3784.92,34.49,267,62,"Pescador",0.4 },
	{ 2057.89,5109.83,46.34,76,62,"Agricultor",0.4 },
	{ -1178.2,-880.6,13.92,408,62,"BurgerShot",0.6 },
	{ -580.93,-1074.92,22.33,408,62,"UwU Café",0.6 },
	{ 789.67,-758.2,26.72,408,62,"Pizza This",0.6 },
	{ 117.06,-1021.67,29.28,408,62,"Bean Machine",0.6 },
	{ -70.49,-1104.59,26.12,225,62,"Concessionária",0.4 },
	{ 1225.05,2724.07,38.0,225,62,"Concessionária",0.4 },
	{ 919.38,-182.83,74.02,198,62,"Taxista",0.5 },
	{ 1696.19,4785.25,42.02,198,62,"Taxista",0.5 },
	{ -680.9,5832.41,17.32,141,62,"Caçador",0.7 },
	{ -535.04,-221.34,37.64,267,5,"Prefeitura",0.6 },
	{ -1194.46,-1189.31,7.69,440,62,"Escritório",0.7 },
	{ -1007.12,-486.67,39.97,440,62,"Escritório",0.7 },
	{ -1913.48,-574.11,11.43,440,62,"Escritório",0.7 },
	{ 918.69,50.33,80.9,617,62,"Cassino",0.6 },
	{ -1248.52,-1472.67,5.19,269,62,"Alameda",0.4 },
	{ 2435.41,4771.21,34.36,77,62,"Leiteiro",0.4 },
	{ -631.84,-237.79,38.06,642,62,"Comércio",0.5 },
	{ -1816.64,-1193.73,14.31,642,62,"Comércio",0.5 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		InvalidateIdleCam()
		InvalidateVehicleIdleCam()

		SetCreateRandomCops(false)
		CancelCurrentPoliceReport()
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)

		SetVehicleModelIsSuppressed(GetHashKey("jet"),true)
		SetVehicleModelIsSuppressed(GetHashKey("besra"),true)
		SetVehicleModelIsSuppressed(GetHashKey("luxor"),true)
		SetVehicleModelIsSuppressed(GetHashKey("blimp"),true)
		SetVehicleModelIsSuppressed(GetHashKey("polmav"),true)
		SetVehicleModelIsSuppressed(GetHashKey("buzzard2"),true)
		SetVehicleModelIsSuppressed(GetHashKey("mammatus"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_prismuscl_01"),true)
		SetPedModelIsSuppressed(GetHashKey("u_m_y_prisoner_01"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_prisoner_01"),true)

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		SetWeaponDamageModifierThisFrame("WEAPON_BAT",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_KATANA",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_HAMMER",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_WRENCH",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_UNARMED",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_HATCHET",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_CROWBAR",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_MACHETE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_POOLCUE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_KNUCKLE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_KARAMBIT",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_GOLFCLUB",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_BATTLEAXE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_FLASHLIGHT",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_NIGHTSTICK",0.35)
		SetWeaponDamageModifierThisFrame("WEAPON_STONE_HATCHET",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_SMOKEGRENADE",0.0)

		RemoveAllPickupsOfType("PICKUP_WEAPON_KNIFE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PISTOL")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MINISMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MICROSMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PUMPSHOTGUN")
		RemoveAllPickupsOfType("PICKUP_WEAPON_CARBINERIFLE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_SAWNOFFSHOTGUN")

		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(2)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(10)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(19)
		HideHudComponentThisFrame(20)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)

		DisableControlAction(1,36,true)
		DisableControlAction(1,37,true)
		DisableControlAction(1,204,true)
		DisableControlAction(1,211,true)
		DisableControlAction(1,349,true)
		DisableControlAction(1,192,true)
		DisableControlAction(1,157,true)
		DisableControlAction(1,158,true)
		DisableControlAction(1,159,true)
		DisableControlAction(1,160,true)
		DisableControlAction(1,161,true)
		DisableControlAction(1,162,true)
		DisableControlAction(1,163,true)
		DisableControlAction(1,164,true)
		DisableControlAction(1,165,true)

		if LocalPlayer["state"]["Route"] > 0 then
			SetVehicleDensityMultiplierThisFrame(0.0)
			SetRandomVehicleDensityMultiplierThisFrame(0.0)
			SetParkedVehicleDensityMultiplierThisFrame(0.0)
			SetAmbientVehicleRangeMultiplierThisFrame(0.0)
			SetScenarioPedDensityMultiplierThisFrame(0.0,0.0)
			SetPedDensityMultiplierThisFrame(0.0)
		else
			SetVehicleDensityMultiplierThisFrame(0.50)
			SetRandomVehicleDensityMultiplierThisFrame(0.50)
			SetParkedVehicleDensityMultiplierThisFrame(1.0)
			SetAmbientVehicleRangeMultiplierThisFrame(1.0)
			SetScenarioPedDensityMultiplierThisFrame(1.0,1.0)
			SetPedDensityMultiplierThisFrame(1.0)
		end

		if IsPedArmed(PlayerPedId(),6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
		end

		if GetPlayerWantedLevel(PlayerId()) ~= 0 then
			ClearPlayerWantedLevel(PlayerId())
		end

		DisablePlayerVehicleRewards(PlayerId())

		SetWeatherTypeNow(GlobalState["Weather"])
		SetWeatherTypePersist(GlobalState["Weather"])
		SetWeatherTypeNowPersist(GlobalState["Weather"])
		NetworkOverrideClockTime(GlobalState["Hours"],GlobalState["Minutes"],00)

		Wait(0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local Teleport = {
	-- { 330.19,-601.21,43.29,343.65,-581.77,28.8 },
	-- { 343.65,-581.77,28.8,330.19,-601.21,43.29 },

	-- { 327.16,-603.53,43.29,338.97,-583.85,74.16 },
	-- { 338.97,-583.85,74.16,327.16,-603.53,43.29 },

	{ -741.07,5593.13,41.66,446.19,5568.79,781.19 },
	{ 446.19,5568.79,781.19,-741.07,5593.13,41.66 },

	{ -740.78,5597.04,41.66,446.37,5575.02,781.19 },
	{ 446.37,5575.02,781.19,-740.78,5597.04,41.66 },

	{ -1194.46,-1189.31,7.69,1173.55,-3196.68,-39.00 },
	{ 1173.55,-3196.68,-39.00,-1194.46,-1189.31,7.69 },

	{ -1007.12,-486.67,39.97,-1003.05,-477.92,50.02 },
	{ -1003.05,-477.92,50.02,-1007.12,-486.67,39.97 },

	{ -1908.09,-570.9,22.97,-1902.05,-572.42,19.09 },
	{ -1902.05,-572.42,19.09,-1908.09,-570.9,22.97 },

	-- { 1089.67,206.05,-49.0,935.9,46.96,81.1 },
	-- { 935.9,46.96,81.1,1089.67,206.05,-49.0 },

	{ -71.05,-801.01,44.23,-75.0,-824.54,321.29 },
	{ -75.0,-824.54,321.29,-71.05,-801.01,44.23 },

	{ 236.23,229.27,97.11,234.24,229.94,97.11 },
	{ 234.24,229.94,97.11,236.23,229.27,97.11 },

	{ 848.79,3003.35,44.52,893.2,-3189.75,-97.04,"Aztecas" },
	{ 893.2,-3189.75,-97.04,848.79,3003.35,44.52,"Aztecas" },

	{ -391.17,4354.86,57.68,874.62,-3194.57,-96.67,"Marabunta" },
	{ 874.62,-3194.57,-96.67,-391.17,4354.86,57.68,"Marabunta" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number = 1,#Blips do
		local Blip = AddBlipForCoord(Blips[Number][1],Blips[Number][2],Blips[Number][3])
		SetBlipSprite(Blip,Blips[Number][4])
		SetBlipDisplay(Blip,4)
		SetBlipAsShortRange(Blip,true)
		SetBlipColour(Blip,Blips[Number][5])
		SetBlipScale(Blip,Blips[Number][7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Blips[Number][6])
		EndTextCommandSetBlipName(Blip)
	end

	local Tables = {}

	for Number = 1,#Teleport do
		Tables[#Tables + 1] = { Teleport[Number][1],Teleport[Number][2],Teleport[Number][3],2.5,"E","Porta de Acesso","Pressione para acessar" }
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for Number = 1,#Teleport do
					local v = Teleport[Number]
					local Distance = #(Coords - vec3(v[1],v[2],v[3]))
					if Distance <= 1 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) and vSERVER.requestPerm(v[7]) then
							SetEntityCoords(Ped,v[4],v[5],v[6],false,false,false,false)

							if k == 13 or k == 14 then
								local Finishing = false
								local Handle,Object = FindFirstObject()
		
								repeat
									local Coords2 = GetEntityCoords(Object)
									local Distance = #(Coords2 - Coords)
		
									if Distance < 3.0 and GetEntityModel(Object) == 961976194 then
										FreezeEntityPosition(Object,true)
									end
		
									Finishing,Object = FindNextObject(Handle)
								until not Finishing
		
								EndFindObject(Handle)
							end

							if v[7] then
								TriggerServerEvent("creative:SyncBucket",k)
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
local vehCamera = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_max = 90.0
local fov_min = 7.5
local zoomspeed = 12.0
local speed_lr = 16.0
local speed_ud = 8.0
local Button_HeliCam = 163 -- (9)
local Button_LockCam = 22 -- (spacebar)
local Button_ThermalVision = 157 -- (1)
local Button_NightVision = 158 -- (2)
local Button_Spotlight = 160 -- (3)
local minHeightAboveGround = 80.0 -- Minimum height above ground to activate Heli Cam (in metres).

local fov = (fov_max + fov_min) * 0.5

local Spritefov_max = 0.11
local Spritefov_min = 0.04
local Spritezoomspeed = 0.01
local Spritefov = (Spritefov_max + Spritefov_min) * 0.5

local polmav_hash = {
	[GetHashKey("supervolito")] = true,
	[GetHashKey("maverick2")] = true,
	[GetHashKey("B412")] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPASS
-----------------------------------------------------------------------------------------------------------------------------------------
local compass = { cardinal = {}, intercardinal = {} }

compass.show = true
compass.position = { x = 0.5, y = 0.07, centered = true }
compass.width = 0.1
compass.fov = 180
compass.followGameplayCam = false

compass.ticksBetweenCardinals = 9.0
compass.tickColour = { r = 255, g = 255, b = 255, a = 255 }
compass.tickSize = { w = 0.001, h = 0.003 }

compass.cardinal.textSize = 0.25
compass.cardinal.textOffset = 0.015
compass.cardinal.textColour = { r = 255, g = 255, b = 255, a = 255 }

compass.cardinal.tickShow = true
compass.cardinal.tickSize = { w = 0.001, h = 0.012}
compass.cardinal.tickColour = { r = 255, g = 255, b = 255, a = 255 }

compass.intercardinal.show = true
compass.intercardinal.textShow = true
compass.intercardinal.textSize = 0.2
compass.intercardinal.textOffset = 0.015
compass.intercardinal.textColour = { r = 255, g = 255, b = 255, a = 255 }

compass.intercardinal.tickShow = true
compass.intercardinal.tickSize = { w = 0.001, h = 0.006 }
compass.intercardinal.tickColour = { r = 255, g = 255, b = 255, a = 255 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWCOMPASSTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawCompassText(str,x,y,style )
	if style == nil then
		style = {}
	end
	
	SetTextFont( (style.font ~= nil) and style.font or 0 )
	SetTextScale( 0.0, (style.size ~= nil) and style.size or 1.0 )
	SetTextProportional( 1 )
	
	if style.colour ~= nil then
		SetTextColour( style.colour.r ~= nil and style.colour.r or 255, style.colour.g ~= nil and style.colour.g or 255, style.colour.b ~= nil and style.colour.b or 255, style.colour.a ~= nil and style.colour.a or 255 )
	else
		SetTextColour( 255, 255, 255, 255 )
	end
	
	if style.shadow ~= nil then
		SetTextDropShadow( style.shadow.distance ~= nil and style.shadow.distance or 0, style.shadow.r ~= nil and style.shadow.r or 0, style.shadow.g ~= nil and style.shadow.g or 0, style.shadow.b ~= nil and style.shadow.b or 0, style.shadow.a ~= nil and style.shadow.a or 255 )
	else
		SetTextDropShadow( 0, 0, 0, 0, 255 )
	end
	
	if style.border ~= nil then
		SetTextEdge( style.border.size ~= nil and style.border.size or 1, style.border.r ~= nil and style.border.r or 0, style.border.g ~= nil and style.border.g or 0, style.border.b ~= nil and style.border.b or 0, style.border.a ~= nil and style.shadow.a or 255 )
	end
	
	if style.centered ~= nil and style.centered == true then
		SetTextCentre( true )
	end
	
	if style.outline ~= nil and style.outline == true then
		SetTextOutline()
	end
	
	SetTextEntry( "STRING" )
	AddTextComponentString( str )
	
	DrawText( x, y )
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEGREESTOINTERCARDINALDIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function degreesToIntercardinalDirection( dgr )
	dgr = dgr % 360.0
	
	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
		return "N "
	elseif dgr >= 22.5 and dgr < 67.5 then
		return "NE"
	elseif dgr >= 67.5 and dgr < 112.5 then
		return "E"
	elseif dgr >= 112.5 and dgr < 157.5 then
		return "SE"
	elseif dgr >= 157.5 and dgr < 202.5 then
		return "S"
	elseif dgr >= 202.5 and dgr < 247.5 then
		return "SW"
	elseif dgr >= 247.5 and dgr < 292.5 then
		return "W"
	elseif dgr >= 292.5 and dgr < 337.5 then
		return "NW"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	if compass.position.centered then
		compass.position.x = compass.position.x - compass.width / 2
	end

	while true do 
		Wait(0)
		if vehCamera then
			local pxDegree = compass.width / compass.fov
			local playerHeadingDegrees = 0

			if compass.followGameplayCam then
				local camRot = GetGameplayCamRot(0)
				playerHeadingDegrees = 360.0 - ((camRot.z + 360.0) % 360.0)
			else
				playerHeadingDegrees = 360.0 - GetEntityHeading(PlayerPedId())
			end

			local tickDegree = playerHeadingDegrees - compass.fov / 2
			local tickDegreeRemainder = compass.ticksBetweenCardinals - (tickDegree % compass.ticksBetweenCardinals)
			local tickPosition = compass.position.x + tickDegreeRemainder * pxDegree

			tickDegree = tickDegree + tickDegreeRemainder

			while tickPosition < compass.position.x + compass.width do
				if (tickDegree % 90.0) == 0 then
					if compass.cardinal.tickShow then
						DrawRect(tickPosition, compass.position.y,compass.cardinal.tickSize.w,compass.cardinal.tickSize.h,compass.cardinal.tickColour.r,compass.cardinal.tickColour.g,compass.cardinal.tickColour.b,compass.cardinal.tickColour.a)
					end

					DrawCompassText(degreesToIntercardinalDirection(tickDegree),tickPosition,compass.position.y + compass.cardinal.textOffset,{
						size = compass.cardinal.textSize,
						colour = compass.cardinal.textColour,
						outline = true,
						centered = true
					})
				elseif (tickDegree % 45.0) == 0 and compass.intercardinal.show then
					if compass.intercardinal.tickShow then
						DrawRect(tickPosition,compass.position.y,compass.intercardinal.tickSize.w,compass.intercardinal.tickSize.h,compass.intercardinal.tickColour.r,compass.intercardinal.tickColour.g,compass.intercardinal.tickColour.b,compass.intercardinal.tickColour.a)
					end
					
					if compass.intercardinal.textShow then
						DrawCompassText(degreesToIntercardinalDirection(tickDegree),tickPosition,compass.position.y + compass.intercardinal.textOffset,{
							size = compass.intercardinal.textSize,
							colour = compass.intercardinal.textColour,
							outline = true,
							centered = true
						})
					end
				else
					DrawRect(tickPosition,compass.position.y,compass.tickSize.w,compass.tickSize.h,compass.tickColour.r,compass.tickColour.g,compass.tickColour.b,compass.tickColour.a)
				end

				tickDegree = tickDegree + compass.ticksBetweenCardinals
				tickPosition = tickPosition + pxDegree * compass.ticksBetweenCardinals
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWDISPLAYTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawDisplayText(x2,y2,text2)
    SetTextScale(0.25, 0.25)
    SetTextColour(255,255,255,255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text2)
    DrawText((x2 - 0.2), (y2 - 0.2) + 0.005)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread( function()
    while true do 
    	Wait(0)
    	if vehCamera then
			local Ped = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(Ped,true))
            local NorthCoord = tostring(y * 10000000)
            local WestCoord = tostring(x * 10000000)
            DrawDisplayText(0.21,0.22,"/.:!| DEPARTAMENTO DA POLÍCIA MILITAR ENERGY ")
            DrawDisplayText(0.69,0.22, math.ceil(GetEntityHeading(GetVehiclePedIsIn(Ped))).."°T")
            DrawDisplayText(0.697,0.24,"V")
            DrawDisplayText(0.21,0.24,string.sub(NorthCoord,1,3).."°"..string.sub(NorthCoord,4,5).."'"..string.sub(NorthCoord,6,7).."."..string.sub(NorthCoord,8,9))
            DrawDisplayText(0.255,0.24,"N")
            DrawDisplayText(0.27,0.24,string.sub(WestCoord,1,3).."°"..string.sub(WestCoord,4,5).."'"..string.sub(WestCoord,6,7).."."..string.sub(WestCoord,8,9))
            DrawDisplayText(0.315,0.24,"W")
            DrawDisplayText(0.21,0.26,"SPD    "..math.ceil(1.94384 * (GetEntitySpeed(Ped))))
            DrawDisplayText(0.25,0.26,"KTS")
            DrawDisplayText(0.27,0.26,"HDG")
            DrawDisplayText(0.30,0.26,math.ceil(GetGameplayCamRelativeHeading()))
            DrawDisplayText(0.315,0.26,"°T")
            DrawDisplayText(0.21,0.28,"ALT    "..math.ceil(GetEntityHeightAboveGround(Ped) * 3.28084))
            DrawDisplayText(0.25,0.28,"FT")
            --N W
            --SPD
            DrawDisplayText(1.0 - 0.135 + 0.25,0.26,"MPG")
            DrawDisplayText(1.0 - 0.135 + 0.27,0.26,"HDG")
            --Heading
            DrawDisplayText(1.0 - 0.135 + 0.315,0.26,"°T")
            DrawDisplayText(1.0 - 0.135 + 0.21,0.28,"ELV    "..math.ceil(GetGameplayCamRelativePitch()))
            DrawDisplayText(1.0 - 0.135 + 0.25,0.28,"FT")

            DrawDisplayText(0.22,1.0 - 0.135 + 0.18,"HDIR")
            DrawDisplayText(0.22,1.0 - 0.135 + 0.20,"M WH DDE")
            DrawDisplayText(0.22,1.0 - 0.135 + 0.22,"FOC MAN")
            DrawDisplayText(0.22,1.0 - 0.135 + 0.24,"EXP MAN")
            DrawDisplayText(0.22,1.0 - 0.135 + 0.26,"W")

            local TextureDict = "helicopterhud"
            local TextureName = "hud_line"
            if not HasStreamedTextureDictLoaded(TextureDict) then
				RequestStreamedTextureDict(TextureDict, true)
				while not HasStreamedTextureDictLoaded(TextureDict) do
					Wait(0)
				end
			end
			DrawSprite(TextureDict,TextureName,0.075,0.94,0.1,0.01,0.0,255,255,255,255)

			DrawDisplayText(0.32,1.0 - 0.135 + 0.26,"N")

            DrawDisplayText(0.37,1.0 - 0.135 + 0.26,"FT")

            DrawDisplayText(1.0 - 0.135 + 0.27,1.0 - 0.135 + 0.18,"GEOPOINT")
			DrawDisplayText(1.0 - 0.135 + 0.27,1.0 - 0.135 + 0.20,"INS NAV")
            DrawDisplayText(1.0 - 0.135 + 0.27,1.0 - 0.135 + 0.24,"TRK COR")
            DrawDisplayText(1.0 - 0.135 + 0.27,1.0 - 0.135 + 0.28,"SLAVE READY")

            hour = GetClockHours()
			minute = GetClockMinutes()
			second = GetClockSeconds()
			day = GetClockDayOfMonth()
			month = GetClockMonth()
			year = GetClockYear()
		
			if hour <= 9 then hour = "0"..hour end
			if minute <= 9 then	minute = "0"..minute end
			if second <= 9 then second = "0"..second end
			if day <= 9 then day = "0"..day end
			if month <= 9 then month = "0"..month end
            
            DrawDisplayText(0.21,0.34,month.."/"..day.."/"..(year - 2000))
            DrawDisplayText(0.21,0.36,hour..":"..minute..":"..second)
            DrawDisplayText(0.245,0.36, "Z")

            local TextureDict = "helicopterhud"
            local TextureName = "hud_target"
            if not HasStreamedTextureDictLoaded(TextureDict) then
				RequestStreamedTextureDict(TextureDict, true)
				while not HasStreamedTextureDictLoaded(TextureDict) do
					Wait(0)
				end
			end
            --DrawSprite(textureDict,textureName,X,Y,w,h,heading,r,g,b,a)
			DrawSprite(TextureDict,TextureName,0.5,0.5,0.05,0.1,0.0,255,255,255,100)

			local TextureDict = "cross"--helicopterhud cross srange_gen
            local TextureName = "circle_checkpoints_cross"--hud_target circle_checkpoints_cross hit_cross
            if not HasStreamedTextureDictLoaded(TextureDict) then
				RequestStreamedTextureDict(TextureDict, true)
				while not HasStreamedTextureDictLoaded(TextureDict) do
					Wait(0)
				end
			end
			DrawSprite(TextureDict,TextureName,0.5,0.5,0.015,0.025,0.0,255,255,255,255)
        end
    end
end)

function ThermalAdd()
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    repeat
		SetTimecycleModifier("NG_blackout")
		SetTimecycleModifierStrength(0.992)
        local distance = #(playerped - ped)
        if HasEntityClearLosToEntity(playerped,ped,17) then
        	if IsPedHuman(ped) and not IsPedInAnyVehicle(ped,false) then
        		for _, boneListItem in pairs(boneList) do
        			local x,y,z = table.unpack(vector3(GetPedBoneCoords(ped,boneListItem.boneId)))
					DrawThermal(x+boneListItem.X1,y + boneListItem.Y1,z + boneListItem.Z1,x + boneListItem.X2,y + boneListItem.Y2,z + boneListItem.Z2)
        		end
			else
				boneList2 = {
				--[[SKEL_Spine1 --]] { boneId =  24816, X1 = -0.3, Y1 = -0.3, Z1 = -0.3, X2 = 0.4, Y2 = 0.3, Z2 = 0.7 },
				}
        		for _, boneListItem2 in pairs(boneList2) do
        			local x,y,z = table.unpack(vector3(GetPedBoneCoords(ped,boneListItem2.boneId)))
					DrawThermal(x+boneListItem2.X1,y + boneListItem2.Y1,z + boneListItem2.Z1,x + boneListItem2.X2,y + boneListItem2.Y2,z + boneListItem2.Z2)
        		end
			end
        	
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
end

function ThermalAddVehicle()
	local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
	local handle, pedveh = FindFirstVehicle()
    local success
    local rped = nil
    repeat
    	local distance = #(playerped - pedveh)
    	if (HasEntityClearLosToEntity(playerped,pedveh,17)) and (not IsVehicleSeatFree(pedveh,-1)) and (not IsVehicleModel(pedveh,"polmav")) then
        	for _, vehBoneListItem in ipairs(vehBoneList) do
        		local getVehBoneIndex = GetEntityBoneIndexByName(pedveh, vehBoneListItem.vehBoneId)
        		local worldVehBone = GetWorldPositionOfEntityBone(pedveh, getVehBoneIndex)
        		local x,y,z = table.unpack(vector3(worldVehBone))	
				DrawThermal(x + vehBoneListItem.X1,y + vehBoneListItem.Y1,z + vehBoneListItem.Z1,x + vehBoneListItem.X2,y + vehBoneListItem.Y2,z + vehBoneListItem.Z2)
    		end
    	end
    	success, pedveh = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

function DrawThermal(x1,y1,z1,x2,y2,z2)
    DrawBox(x1,y1,z1,x2,y2,z2,255,255,255,90)
    --DrawBox(x1,y1,z1,x2,y2,z2,r,g,b,alpha)
end

function SpotlightAdd(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam,2))
	DrawSpotLight(coords,forward_vector,255,255,255,2000.0,90.0,0.0,5.0,1.0)
	--DrawSpotLight(posX,posY,posZ,dirX,dirY,dirZ,R,G,B,distance,brightness, hardness, radius, falloff)
end

local ThermalToggle = false
local NightVisionToggle = false
local SpotlightToggle = false

function DrawHeliText3Ds(x,y,z, text, scale)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(scale, scale)
    SetTextFont(10)
    SetTextProportional(1)
    SetTextColour(255,255,0,215)
    SetTextOutline()    
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text))
    DrawRect(_x,_y + 0.02,factor / 84,scale / 12,41,11,41,100)
end

CreateThread(function()
	RegisterCommand('helicamuifix',function() 
		locked_on = nil
       	ThermalToggle = false
		NightVisionToggle = false
		SpotlightToggle = false
		ClearTimecycleModifier()
		fov = (fov_max + fov_min) * 0.5
		Spritefov = (Spritefov_max + Spritefov_min) * 0.5
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
		vehCamera = false
    end)

	while true do
		Wait(0)
		if IsPlayerInPolmav() then
			local lPed = PlayerPedId()
			local heli = GetVehiclePedIsIn(lPed)
			if IsHeliHighEnough(heli) then
				if IsControlJustPressed(0,Button_HeliCam) then
					vehCamera = true
				end
			else
				ThermalToggle = false
				NightVisionToggle = false
				SetNightvision(false)
				SpotlightToggle = false
				vehCamera = false
				StopScreenEffect(ScreenEffectType)
				ClearTimecycleModifier()
				fov = (fov_max + fov_min) * 0.5
				Spritefov = (Spritefov_max + Spritefov_min) * 0.5
				RenderScriptCams(false,false,0,1,0)
				DestroyCam(cam, false)
			end
		end

		if vehCamera then
			Wait(0)
			local lPed = PlayerPedId()
			local heli = GetVehiclePedIsIn(lPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
			AttachCamToEntity(cam,heli,0.0,2.0,-1.5,true)
			SetCamRot(cam,0.0,0.0,GetEntityHeading(heli))
			SetCamFov(cam,fov)
			RenderScriptCams(true,false,0,1,0)
			local locked_on = nil
			while vehCamera and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == heli) and IsHeliHighEnough(heli) do
				if IsControlJustPressed(0,Button_HeliCam) then
					vehCamera = false
					NightVisionToggle = false
				end

				-- if IsControlJustPressed(1,Button_ThermalVision) then
				-- 	NightVisionToggle = false
				-- 	SpotlightToggle = false
				-- 	ThermalToggle = not ThermalToggle
				-- else
				-- 	StopScreenEffect(ScreenEffectType)
				-- 	ClearTimecycleModifier()
    			-- end

    			if IsControlJustPressed(1,Button_NightVision) then
					ThermalToggle = false
					SpotlightToggle = false
					NightVisionToggle = not NightVisionToggle
				else
					SetNightvision(false)
    			end

    			if IsControlJustPressed(1,Button_Spotlight) then
    				ThermalToggle = false
    				NightVisionToggle = false
    				SpotlightToggle = not SpotlightToggle
				end

				if locked_on then
					local coords = GetCamCoord(cam)
					local forward_vector = RotAnglesToVec(GetCamRot(cam,2))
					--DrawLine(coords, coords+(forward_vector*100.0), 255,0,0,255) -- debug line to show LOS of cam
					local x, y, z = table.unpack(coords + (forward_vector * 100.0))
					local NorthCoord = tostring(y * 10000000)
					local WestCoord = tostring(x * 10000000)
					DrawDisplayText(1.0 - 0.135 + 0.21,0.24,string.sub(NorthCoord,1,3).."°"..string.sub(NorthCoord,4,5).."'"..string.sub(NorthCoord,6,7).."."..string.sub(NorthCoord,8,9))
					DrawDisplayText(1.0 - 0.135 + 0.255,0.24,"N")
					DrawDisplayText(1.0 - 0.135 + 0.27,0.24,string.sub(WestCoord,1,3).."°"..string.sub(WestCoord,4,5).."'"..string.sub(WestCoord,6,7).."."..string.sub(WestCoord,8,9))
					DrawDisplayText(1.0 - 0.135 + 0.315,0.24,"W")
					DrawDisplayText(1.0 - 0.135 + 0.21,0.26,"SPD    "..math.ceil(GetEntitySpeed(locked_on) * 2.236936))
					DrawDisplayText(1.0 - 0.135 + 0.30,0.26,math.ceil(GetEntityHeading(locked_on)))

					local distancetoentity = #(GetPlayerPed(-1) - locked_on)
					DrawDisplayText(1.0 - 0.135 + 0.27,0.28,"SLT")
					DrawDisplayText(1.0 - 0.135 + 0.315,0.28,"M")
					DrawDisplayText(1.0 - 0.135 + 0.30,0.28,math.ceil(distancetoentity))
					if SpotlightToggle then
						SpotlightAdd(cam)
					end

					--stops underwater ped and submarine tracking but means boats cant be tracked
					if DoesEntityExist(locked_on) and not IsEntityInWater(locked_on) then
						PointCamAtEntity(cam,locked_on,0.0,0.0,0.0,true)
						if IsEntityAVehicle(locked_on) then
							RenderVehicleInfo(locked_on)
						end
						if IsControlJustPressed(0,Button_LockCam) or not HasEntityClearLosToEntity(heli,locked_on,17) then
							locked_on = nil
							local rot = GetCamRot(cam,2) -- All this because I can't seem to get the camera unlocked from the entity
							local fov = GetCamFov(cam)
							local old
							cam = cam
							DestroyCam(old_cam,false)
							cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
							AttachCamToEntity(cam,heli,0.0,0.0,-1.5,true)
							SetCamRot(cam,rot,2)
							SetCamFov(cam,fov)
							RenderScriptCams(true,false,0,1,0)
						end
					else
						locked_on = nil -- Cam will auto unlock when entity doesn't exist anyway
					end
				else
					local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)
					CheckInputRotation(cam, zoomvalue)
					local entity_detected = GetEntityInView(cam)
 					if SpotlightToggle then
						SpotlightAdd(cam)
					end
					if DoesEntityExist(entity_detected) then
						if IsEntityAVehicle(entity_detected) then
							RenderVehicleInfo(entity_detected)
						end
						if IsControlJustPressed(0, Button_LockCam) then
							locked_on = entity_detected
						end
					else
						DrawDisplayText(1.0 - 0.135 + 0.30,0.26,"---")
						DrawDisplayText(1.0 - 0.135 + 0.30,0.28,"---")
					end
				end
				HandleZoom(cam)
				HandleHUDZoom(cam)
				HideHUDThisFrame()
				Wait(0)
			end

			ThermalToggle = false
			NightVisionToggle = false
			SpotlightToggle = false
			vehCamera = false
			ClearTimecycleModifier()
			fov = (fov_max + fov_min) * 0.5
			RenderScriptCams(false,false,0,1,0)
			DestroyCam(cam,false)
		end
	end
end)

function IsPlayerInPolmav()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	if polmav_hash[vehicle] then
		return true
	end
	return false
end

function IsHeliHighEnough(heli)
	return GetEntityHeightAboveGround(heli) > minHeightAboveGround
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(19)
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
end

function CheckInputRotation(cam,zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX * -1.0 * (speed_ud) * (zoomvalue + 0.1)
		new_x = math.max(math.min(20.0,rotation.x + rightAxisY * -1.0 * (speed_lr) * (zoomvalue + 0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) then
		fov = math.max(fov - zoomspeed,fov_min)
	end

	if IsControlJustPressed(0,242) then
		fov = math.min(fov + zoomspeed,fov_max)
	end

	local current_fov = GetCamFov(cam)
	if math.abs(fov - current_fov) < 0.1 then
		fov = current_fov
	end

	SetCamFov(cam, current_fov + (fov - current_fov) * 0.05)
	DrawDisplayText(0.35,1.0 - 0.135 + 0.26,math.ceil(current_fov))
	if current_fov < 40.0 then
		boneList = {
			{ boneId = 11816, X1 = -0.2, Y1 = -0.2, Z1 = 0.2, X2 = 0.2, Y2 = 0.2, Z2 = 0.6 },

			{ boneId =  58271, X1 = -0.2, Y1 = -0.2, Z1 = -0.15, X2 = 0.2, Y2 = 0.2, Z2 = 0.15 },
			{ boneId =  51826, X1 = -0.2, Y1 = -0.2, Z1 = -0.15, X2 = 0.2, Y2 = 0.2, Z2 = 0.15 },

			{ boneId =  63931, X1 = -0.15, Y1 = -0.15, Z1 = -0.3, X2 = 0.15, Y2 = 0.15, Z2 = 0.3 },
			{ boneId =  36864, X1 = -0.15, Y1 = -0.15, Z1 = -0.3, X2 = 0.15, Y2 = 0.15, Z2 = 0.3 },

			{ boneId =  14201, X1 = -0.1, Y1 = -0.15, Z1 = -0.15, X2 = 0.1, Y2 = 0.2, Z2 = 0.15 },
			{ boneId =  52301, X1 = -0.1, Y1 = -0.15, Z1 = -0.15, X2 = 0.1, Y2 = 0.2, Z2 = 0.15 },

			{ boneId =  45509, X1 = -0.15, Y1 = -0.15, Z1 = -0.2, X2 = 0.15, Y2 = 0.15, Z2 = 0.1 },
			{ boneId =  40269, X1 = -0.15, Y1 = -0.15, Z1 = -0.2, X2 = 0.15, Y2 = 0.15, Z2 = 0.1 },

			{ boneId =  61163, X1 = -0.08, Y1 = -0.08, Z1 = -0.2, X2 = 0.08, Y2 = 0.08, Z2 = 0.1 },
			{ boneId =  28252, X1 = -0.08, Y1 = -0.08, Z1 = -0.2, X2 = 0.08, Y2 = 0.08, Z2 = 0.1 },

			{ boneId =  18905, X1 = -0.15, Y1 = -0.15, Z1 = -0.08, X2 = 0.15, Y2 = 0.15, Z2 = 0.1 },
			{ boneId =  57005, X1 = -0.15, Y1 = -0.15, Z1 = -0.08, X2 = 0.15, Y2 = 0.15, Z2 = 0.1 },

			{ boneId =  22711, X1 = -0.08, Y1 = -0.08, Z1 = -0.2, X2 = 0.08, Y2 = 0.08, Z2 = 0.1 },
			{ boneId =  2992, X1 = -0.08, Y1 = -0.08, Z1 = -0.2, X2 = 0.08, Y2 = 0.08, Z2 = 0.1 },

			{ boneId =  31086, X1 = -0.1, Y1 = -0.1, Z1 = -0.1, X2 = 0.1, Y2 = 0.2, Z2 = 0.2 },
		}

		vehBoneList = {
			{ vehBoneId = "wheel_lf", X1 = -0.3, Y1 = -0.3, Z1 = -0.3, X2 = 0.3, Y2 = 0.3, Z2 = 0.3 },
			{ vehBoneId = "wheel_rf", X1 = -0.3, Y1 = -0.3, Z1 = -0.3, X2 = 0.3, Y2 = 0.3, Z2 = 0.3 },
			{ vehBoneId = "wheel_lm", X1 = -0.3, Y1 = -0.3, Z1 = -0.3, X2 = 0.3, Y2 = 0.3, Z2 = 0.3 },
			{ vehBoneId = "wheel_rm", X1 = -0.3, Y1 = -0.3, Z1 = -0.3, X2 = 0.3, Y2 = 0.3, Z2 = 0.3 },
			{ vehBoneId = "wheel_lr", X1 = -0.3, Y1 = -0.3, Z1 = -0.3, X2 = 0.3, Y2 = 0.3, Z2 = 0.3 },
			{ vehBoneId = "wheel_rr", X1 = -0.3, Y1 = -0.3, Z1 = -0.3, X2 = 0.3, Y2 = 0.3, Z2 = 0.3 },

			{ vehBoneId = "engine", X1 = -0.7, Y1 = -0.7, Z1 = -0.3, X2 = 0.7, Y2 = 0.7, Z2 = 0.4 },

			{ vehBoneId = "exhaust", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_2", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_3", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_4", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_5", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_6", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_7", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_8", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_9", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_10", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_11", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_12", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_13", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_14", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_15", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
			{ vehBoneId = "exhaust_16", X1 = -0.3, Y1 = -0.3, Z1 = -0.05, X2 = 0.3, Y2 = 0.3, Z2 = 0.2 },
		}
	else
		boneList = {
		--[[SKEL_Spine1 --]] { boneId =  24816, X1 = -0.3, Y1 = -0.3, Z1 = -0.3, X2 = 0.4, Y2 = 0.3, Z2 = 0.7 },
		}

		vehBoneList = {
			{ vehBoneId = "engine", X1 = -0.7, Y1 = -0.7, Z1 = -0.3, X2 = 0.7, Y2 = 0.7, Z2 = 0.4 },
		}
	end
end

function HandleHUDZoom(cam)
	if IsControlJustPressed(0,241) then
		Spritefov = math.min(Spritefov + Spritezoomspeed,Spritefov_max)
	end
	if IsControlJustPressed(0,242) then
		
		Spritefov = math.max(Spritefov - Spritezoomspeed,Spritefov_min)
	end

	local Spritecurrent_fov = GetCamFov(cam)

	if math.abs(Spritefov - Spritecurrent_fov) < 0.01 then
		Spritefov = Spritecurrent_fov
	en
	TextureDictArrow = "mpinventory"
	TextureNameArrow = "mp_arrow"
	if not HasStreamedTextureDictLoaded(TextureDictArrow) then
		RequestStreamedTextureDict(TextureDictArrow,true)
		while not HasStreamedTextureDictLoaded(TextureDictArrow) do
			Wait(0)
		end
	end
	DrawSprite(TextureDictArrow,TextureNameArrow,Spritefov,0.934,0.013,0.02,0.0,255,255,255,255)
end

function GetEntityInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam,2))
	-- DrawLine(coords, coords+(forward_vector*100.0), 255,0,0,255) -- debug line to show LOS of cam
	local x,y,z = table.unpack(coords + (forward_vector * 100.0))
    local NorthCoord = tostring(y * 10000000)
    local WestCoord = tostring(x * 10000000)
    DrawDisplayText(1.0 - 0.135 + 0.21,0.24,string.sub(NorthCoord,1,3).."°"..string.sub(NorthCoord,4,5).."'"..string.sub(NorthCoord,6,7).."."..string.sub(NorthCoord,8,9))
    DrawDisplayText(1.0 - 0.135 + 0.255,0.24,"N")
    DrawDisplayText(1.0 - 0.135 + 0.27,0.24,string.sub(WestCoord,1,3).."°"..string.sub(WestCoord,4,5).."'"..string.sub(WestCoord,6,7).."."..string.sub(WestCoord,8,9))
    DrawDisplayText(1.0 - 0.135 + 0.315,0.24,"W")
	-- local rayhandle = CastRayPointToPoint(coords, coords + (forward_vector * 200.0), 10, GetVehiclePedIsIn(PlayerPedId()), 0)
	local rayhandle = StartShapeTestRay(coords,coords + (forward_vector * 10000.0),10,GetVehiclePedIsIn(PlayerPedId()),4,0,7)
	-- StartShapeTestRay(x1,y1,z1,x2,y2,z2,flags: 4 = ped,2 = vehicle -1 = everything,ent: ignores these entities,p8:7)
	-- local _,_,_,_, entityHit = GetRaycastResult(rayhandle)
	local retval,hit,endCoords,surfaceNormal,entityHit = GetShapeTestResult(rayhandle)
	local distancetoentity = #(coords - endCoords)
    DrawDisplayText(1.0-0.135+0.27, 0.28,  "SLT")
    DrawDisplayText(1.0-0.135+0.315, 0.28, "M")
	if entityHit > 0 then
		DrawDisplayText(1.0-0.135+0.30, 0.28,  math.ceil(distancetoentity))
		local entitySpeed = (GetEntitySpeed(entityHit)) * 2.236936
		DrawDisplayText(1.0-0.135+0.21, 0.26,"SPD    "..math.ceil(entitySpeed))
		return entityHit
	else
		DrawDisplayText(1.0-0.135+0.30, 0.28,"---")
		DrawDisplayText(1.0-0.135+0.21, 0.26,"SPD    0")
		return nil
	end
end

function RotAnglesToVec(rot)
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z) * num,math.cos(z) * num,math.sin(x))
end

function PlateText(vehicle)
	DrawDisplayText(1.0 - 0.135 + 0.21,0.30,"Plate: "..GetVehicleNumberPlateText(vehicle))
end

function RenderVehicleInfo(vehicle)
	DrawDisplayText(1.0 - 0.135 + 0.30,0.26,math.ceil(GetEntityHeading(vehicle)))
	--numberplate doesnt work so has to use the light bone and code out the exceptions
	local HasPlateLight = GetEntityBoneIndexByName(vehicle,"platelight") 
	
	--Debug for Plate on Vehicle Pointed at
	--DrawDisplayText(1.0-0.135+0.21, 0.32,  "~b~Plate: ~r~" .. GetVehicleNumberPlateText(vehicle).."\n~b~Plate Light ID Number: ~r~".. HasPlateLight)
	
	--HAVE A PLATE BUT RETURN PLATELIGHT AS -1 SO SHOULD DISPLAY PLATE
	if IsVehicleModel(vehicle,GetHashKey("Brioso")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("Asterope")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("Stafford")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("Imperator")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("Imperator2")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("Imperator3")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("casco")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("cheburek")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("fagaloa")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("feltzer3")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("stromberg")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("z190")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("bestiagts")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("comet2")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("comet3")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("furore")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("raptor")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("tampa2")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("autarch")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("cheetah")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("entityxf")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("pfister811")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("visione")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("zentorno")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("avarus")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("bagger")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("bati")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("carbon")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("chimera")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("diablous")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("esskey")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("faggion")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("faggio")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("faggio3")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("fcr")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("hakuchou")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("hexer")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("lectro")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("nemesis")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("nightblade")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("ruffian")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("sanctus")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("sovereign")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("thrust")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("vader")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("vindicator")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("bifta")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("blazer4")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("blazer5")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("caracara")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("marshall")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("rebel01")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("rebel02")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("technical")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("technical2")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("technical3")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("flatbed")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("rubble")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("trlarge")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("coach")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("rallytruck")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("police")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("policeb")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("chernobog")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("benson")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("phantom")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("phantom2")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("phantom3")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("pounder")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("pounder2")) then PlateText(vehicle)
 	elseif IsVehicleModel(vehicle,GetHashKey("stockade")) then PlateText(vehicle)
 	--Wouldn't work as Hash Strings
 	elseif IsVehicleModel(vehicle,-2033222435) then PlateText(vehicle) --Tornado Rusted Cabrio Guitars
 	elseif IsVehicleModel(vehicle,117401876) then PlateText(vehicle) --Roosevelt
 	elseif IsVehicleModel(vehicle,-602287871) then PlateText(vehicle) --Roosevelt Valor

	--HAVE NO PLATE BUT RETURN PLATELIGHT NUMBER SO SHOULD NOT DISPLAY PLATE
	elseif IsVehicleModel(vehicle,-688189648) then --Dominator4
	elseif IsVehicleModel(vehicle,-1375060657) then --Dominator5
	elseif IsVehicleModel(vehicle,-1293924613) then --Dominator6
	elseif IsVehicleModel(vehicle,-1232836011) then --LE7B
	elseif IsVehicleModel(vehicle,-638562243) then --Scramjet
	elseif IsVehicleModel(vehicle,537896628) then --Caddy Golf Rusted
	elseif IsVehicleModel(vehicle,-769147461) then --Caddy Flatbed
	elseif IsVehicleModel(vehicle,-32236122) then --halftrack Military
	
	--HAVE NO PLATE BUT RETURN PLATELIGHT NUMBER AS -1 SO SHOULD NOT DISPLAY PLATE Mostly boats,helis and planes 
	elseif HasPlateLight == -1 then
	
		--ALL VEHICLES WITH PLATES NOT RETURNING PLATELIGHT NUMBER AS -1 SO SHOULD DISPLAY PLATE
	else
		PlateText(vehicle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISLAND
-----------------------------------------------------------------------------------------------------------------------------------------
local Island = {
	"h4_islandairstrip",
	"h4_islandairstrip_props",
	"h4_islandx_mansion",
	"h4_islandx_mansion_props",
	"h4_islandx_props",
	"h4_islandxdock",
	"h4_islandxdock_props",
	"h4_islandxdock_props_2",
	"h4_islandxtower",
	"h4_islandx_maindock",
	"h4_islandx_maindock_props",
	"h4_islandx_maindock_props_2",
	"h4_IslandX_Mansion_Vault",
	"h4_islandairstrip_propsb",
	"h4_beach",
	"h4_beach_props",
	"h4_beach_bar_props",
	"h4_islandx_barrack_props",
	"h4_islandx_checkpoint",
	"h4_islandx_checkpoint_props",
	"h4_islandx_Mansion_Office",
	"h4_islandx_Mansion_LockUp_01",
	"h4_islandx_Mansion_LockUp_02",
	"h4_islandx_Mansion_LockUp_03",
	"h4_islandairstrip_hangar_props",
	"h4_IslandX_Mansion_B",
	"h4_islandairstrip_doorsclosed",
	"h4_Underwater_Gate_Closed",
	"h4_mansion_gate_closed",
	"h4_aa_guns",
	"h4_IslandX_Mansion_GuardFence",
	"h4_IslandX_Mansion_Entrance_Fence",
	"h4_IslandX_Mansion_B_Side_Fence",
	"h4_IslandX_Mansion_Lights",
	"h4_islandxcanal_props",
	"h4_beach_props_party",
	"h4_islandX_Terrain_props_06_a",
	"h4_islandX_Terrain_props_06_b",
	"h4_islandX_Terrain_props_06_c",
	"h4_islandX_Terrain_props_05_a",
	"h4_islandX_Terrain_props_05_b",
	"h4_islandX_Terrain_props_05_c",
	"h4_islandX_Terrain_props_05_d",
	"h4_islandX_Terrain_props_05_e",
	"h4_islandX_Terrain_props_05_f",
	"h4_islandx_terrain_01",
	"h4_islandx_terrain_02",
	"h4_islandx_terrain_03",
	"h4_islandx_terrain_04",
	"h4_islandx_terrain_05",
	"h4_islandx_terrain_06",
	"h4_ne_ipl_00",
	"h4_ne_ipl_01",
	"h4_ne_ipl_02",
	"h4_ne_ipl_03",
	"h4_ne_ipl_04",
	"h4_ne_ipl_05",
	"h4_ne_ipl_06",
	"h4_ne_ipl_07",
	"h4_ne_ipl_08",
	"h4_ne_ipl_09",
	"h4_nw_ipl_00",
	"h4_nw_ipl_01",
	"h4_nw_ipl_02",
	"h4_nw_ipl_03",
	"h4_nw_ipl_04",
	"h4_nw_ipl_05",
	"h4_nw_ipl_06",
	"h4_nw_ipl_07",
	"h4_nw_ipl_08",
	"h4_nw_ipl_09",
	"h4_se_ipl_00",
	"h4_se_ipl_01",
	"h4_se_ipl_02",
	"h4_se_ipl_03",
	"h4_se_ipl_04",
	"h4_se_ipl_05",
	"h4_se_ipl_06",
	"h4_se_ipl_07",
	"h4_se_ipl_08",
	"h4_se_ipl_09",
	"h4_sw_ipl_00",
	"h4_sw_ipl_01",
	"h4_sw_ipl_02",
	"h4_sw_ipl_03",
	"h4_sw_ipl_04",
	"h4_sw_ipl_05",
	"h4_sw_ipl_06",
	"h4_sw_ipl_07",
	"h4_sw_ipl_08",
	"h4_sw_ipl_09",
	"h4_islandx_mansion",
	"h4_islandxtower_veg",
	"h4_islandx_sea_mines",
	"h4_islandx",
	"h4_islandx_barrack_hatch",
	"h4_islandxdock_water_hatch",
	"h4_beach_party"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAYO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local CayoPerico = false

	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		if #(Coords - vec3(4840.57,-5174.42,2.0)) <= 2000 then
			if not CayoPerico then
				for _,v in pairs(Island) do
					RequestIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland",true)
				SetAiGlobalPathNodesType(1)
				SetDeepOceanScaler(0.0)
				LoadGlobalWaterType(1)
				CayoPerico = true
			end
		else
			if CayoPerico then
				for _,v in pairs(Island) do
					RemoveIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland",false)
				SetAiGlobalPathNodesType(0)
				SetDeepOceanScaler(1.0)
				LoadGlobalWaterType(0)
				CayoPerico = false
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
local IpList = {
	{
		Props = {
			"interior_upgrade",
			"equipment_upgrade",
			"security_high",
			"chair01",
			"chair02",
			"chair03",
			"chair04",
			"chair05",
			"chair06",
			"chair07"
		},
		Coords = { 1164.99,-3196.6,-39.01 }
	},{
		Props = {
			"Bunker_Style_A",
			"upgrade_bunker_set",
			"security_upgrade",
			"Office_blocker_set",
			"gun_locker_upgrade",
			"gun_range_blocker_set"
		},
		Coords = { 899.39,-3246.14,-98.07 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADIPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for _,Interior in pairs(IpList) do
		local InteriorCoords = GetInteriorAtCoords(Interior["Coords"][1],Interior["Coords"][2],Interior["Coords"][3])
		PinInteriorInMemory(InteriorCoords)

		if Interior["Props"] ~= nil then
			for _,Prop in pairs(Interior["Props"]) do
				ActivateInteriorEntitySet(InteriorCoords,Prop)
				Wait(1)
			end
		end

		RefreshInterior(InteriorCoords)
	end
end)