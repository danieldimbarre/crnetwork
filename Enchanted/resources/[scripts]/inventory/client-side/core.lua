-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("inventory",Creative)
vGARAGE = Tunnel.getInterface("garages")
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {}
local Types = ""
local Weapon = ""
local Usables = 1
local Actived = false
local Inventory = false
local TakeWeapon = false
local StoreWeapon = false
local Reloaded = GetGameTimer()
local ShotDelay = GetGameTimer()
local UseCooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:CleanWeapons",function(Create)
	if Weapon ~= "" then
		if Create and Usables <= 5 then
			TriggerEvent("inventory:CreateWeapon",Weapon)
		end

		RemoveAllPedWeapons(PlayerPedId(),true)
	end

	TriggerEvent("hud:Weapon",false)
	TriggerEvent("Weapon","")
	Actived = false
	Weapon = ""
	Types = ""
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Buttons"] then
			TimeDistance = 1
			DisableControlAction(0,75,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,257,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	if Inventory then
		Inventory = false
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "Close" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	TriggerEvent("inventory:Close")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:USE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:Use",function(Slot,Amount)
	Usables = parseInt(Slot)
	vSERVER.Use(Slot,Amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Use",function(Data,Callback)
	if GetGameTimer() >= UseCooldown then
		TriggerEvent("inventory:Use",Data["slot"],Data["amount"])
		UseCooldown = GetGameTimer() + 1000
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Send",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Send(Data["slot"],Data["amount"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	vRPS.invUpdate(Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Update")
AddEventHandler("inventory:Update",function(Action)
	SendNUIMessage({ action = Action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:verifyWeapon")
AddEventHandler("inventory:verifyWeapon",function(Item)
	local Name = SplitOne(Item)

	if Weapon == Name then
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped,Weapon)
		if not vSERVER.VerifyWeapon(Weapon,Ammo) then
			TriggerEvent("inventory:CleanWeapons",false)
		end
	else
		vSERVER.VerifyWeapon(Name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:preventWeapon",function()
	if Weapon ~= "" then
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped,Weapon)

		TriggerEvent("inventory:CreateWeapon",Weapon)
		vSERVER.PreventWeapons(Weapon,Ammo)
		TriggerEvent("hud:Weapon",false)
		RemoveAllPedWeapons(Ped,true)
		TriggerEvent("Weapon","")

		Actived = false
		Weapon = ""
		Types = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Inventory",function()
	if not IsPauseMenuActive() and GetEntityHealth(PlayerPedId()) > 100 and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPlayerFreeAiming(PlayerId()) then
		Inventory = true
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "Open" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Inventory","Abrir/Fechar a mochila.","keyboard","OEM_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRBOOSTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RepairBoosts")
AddEventHandler("inventory:RepairBoosts",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) and GetVehicleNumberPlateText(Vehicle) == Plate then
			local Tyres = {}

			for i = 0,7 do
				local Status = false

				if GetTyreHealth(Vehicle,i) ~= 1000.0 then
					Status = true
				end

				Tyres[i] = Status
			end

			local Fuel = GetVehicleFuelLevel(Vehicle)

			SetVehicleFixed(Vehicle)
			SetVehicleDeformationFixed(Vehicle)

			SetVehicleFuelLevel(Vehicle,Fuel)

			for Tyre,Burst in pairs(Tyres) do
				if Burst then
					SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRTYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RepairTyres")
AddEventHandler("inventory:RepairTyres",function(Vehicle,Tyres,Plate)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) and GetVehicleNumberPlateText(Vehicle) == Plate then
			if Tyres == "All" then
				for i = 0,10 do
					SetVehicleTyreFixed(Vehicle,i)
				end
			else
				for i = 0,10 do
					if GetTyreHealth(Vehicle,i) ~= 1000.0 then
						SetVehicleTyreBurst(Vehicle,i,true,1000.0)
					end
				end

				SetVehicleTyreFixed(Vehicle,Tyres)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRDEFAULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RepairDefault")
AddEventHandler("inventory:RepairDefault",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) and GetVehicleNumberPlateText(Vehicle) == Plate then
			SetVehicleEngineHealth(Vehicle,1000.0)
			SetVehicleBodyHealth(Vehicle,1000.0)
			SetEntityHealth(Vehicle,1000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RepairAdmin")
AddEventHandler("inventory:RepairAdmin",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) and GetVehicleNumberPlateText(Vehicle) == Plate then
			local Fuel = GetVehicleFuelLevel(Vehicle)

			SetVehicleFixed(Vehicle)
			SetVehicleDeformationFixed(Vehicle)

			SetVehicleFuelLevel(Vehicle,Fuel)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Parachute()
	GiveWeaponToPed(PlayerPedId(),"GADGET_PARACHUTE",1,false,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Fishing()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local Fishings = vec3(-1227.49,4389.84,5.12)

	if #(Coords - Fishings) <= 150 and IsEntityInWater(Ped) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ReturnWeapon()
	return Weapon ~= "" and Weapon or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckWeapon(Hash)
	return Weapon == Hash and true or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVECOMPONENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.GiveComponent(Component)
	GiveWeaponComponentToPed(PlayerPedId(),Weapon,Component)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.TakeWeapon(Name,Ammo,Components,Type,Skin)
	if not TakeWeapon then
		if not Ammo then
			Ammo = 0
		end

		if Ammo > 0 then
			Actived = true
		end

		TakeWeapon = true
		LocalPlayer["state"]:set("Cancel",true,true)

		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			if LoadAnim("reaction@intimidation@1h") then
				TaskPlayAnim(Ped,"reaction@intimidation@1h","intro",8.0,8.0,-1,48,1,0,0,0)
			end

			Wait(1250)

			Weapon = Name
			TriggerEvent("Weapon",Weapon)
			TriggerEvent("inventory:RemoveWeapon",Weapon)
			GiveWeaponToPed(Ped,Weapon,Ammo,false,true)

			Wait(1000)

			ClearPedTasks(Ped)
		else
			Weapon = Name
			TriggerEvent("Weapon",Weapon)
			TriggerEvent("inventory:RemoveWeapon",Weapon)
			GiveWeaponToPed(Ped,Weapon,Ammo,false,true)
		end

		if Components then
			for Item,_ in pairs(Components) do
				Creative.GiveComponent(WeaponAttach(Item,Weapon))
			end
		end

		if Type then
			Types = Type
		end

		if Skin then
			GiveWeaponComponentToPed(Ped,Weapon,Skin)
		end

		TakeWeapon = false
		LocalPlayer["state"]:set("Cancel",false,true)

		if WeaponAmmo(Weapon) then
			TriggerEvent("hud:Weapon",true,Weapon)
		end

		if vSERVER.CheckExistWeapons(Weapon) then
			TriggerEvent("inventory:CleanWeapons",true)
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StoreWeapon()
	if not StoreWeapon and Weapon ~= "" then
		StoreWeapon = true

		local Lasted = Weapon
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped,Weapon)
		LocalPlayer["state"]:set("Cancel",true,true)

		if not IsPedInAnyVehicle(Ped) then
			if LoadAnim("reaction@intimidation@1h") then
				TaskPlayAnim(Ped,"reaction@intimidation@1h","outro",8.0,8.0,-1,48,1,0,0,0)
			end

			Wait(1600)

			ClearPedTasks(Ped)
		end

		StoreWeapon = false
		TriggerEvent("inventory:CleanWeapons",true)
		LocalPlayer["state"]:set("Cancel",false,true)

		return true,Ammo,Lasted
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFOWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.InfoWeapon(Type)
	local Ammo = 0

	if Weapon ~= "" then
		Ammo = GetAmmoInPedWeapon(PlayerPedId(),Weapon)
	end

	return Weapon,Ammo
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Reloading(Hash,Ammo)
	AddAmmoToPed(PlayerPedId(),Hash,Ammo)
	Actived = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Actived and Weapon ~= "" then
			TimeDistance = 10

			local Ped = PlayerPedId()
			local Ammo = GetAmmoInPedWeapon(Ped,Weapon)

			if GetGameTimer() >= Reloaded and IsPedReloading(Ped) then
				vSERVER.PreventWeapons(Weapon,Ammo)
				Reloaded = GetGameTimer() + 100
			end

			if Ammo <= 0 or (Weapon == "WEAPON_PETROLCAN" and Ammo <= 135 and IsPedShooting(Ped)) or IsPedSwimming(Ped) then
				if Types ~= "" then
					vSERVER.RemoveThrowing(Types)
				else
					vSERVER.PreventWeapons(Weapon,Ammo)
				end

				TriggerEvent("inventory:CleanWeapons",true)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WATER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Water()
	return IsEntityInWater(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Drops")
AddEventHandler("inventory:Drops",function(Table)
	Drops = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPSREMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DropsRemover")
AddEventHandler("inventory:DropsRemover",function(Route,Number)
	if Drops[Route] and Drops[Route][Number] then
		Drops[Route][Number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPSATUALIZAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DropsAtualizar")
AddEventHandler("inventory:DropsAtualizar",function(Route,Number,Amount)
	if Drops[Route] and Drops[Route][Number] then
		Drops[Route][Number]["Amount"] = Amount
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPSADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DropsAdicionar")
AddEventHandler("inventory:DropsAdicionar",function(Route,Number,Table)
	if not Drops[Route] then
		Drops[Route] = {}
	end

	Drops[Route][Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Drops",function(Data,Callback)
	if not TakeWeapon and not StoreWeapon and MumbleIsConnected() then
		vSERVER.Drops(Data["item"],Data["slot"],Data["amount"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Pickup",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Pickup(Data["id"],Data["route"],Data["target"],Data["amount"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Inventory",function(Data,Callback)
	local Inventory,Weight,MaxWeight = vSERVER.Inventory()
	if Inventory then
		local DropList = {}
		local Ped = PlayerPedId()
		local Route = LocalPlayer["state"]["Route"]

		if not IsPedInAnyVehicle(Ped) and Drops[Route] then
			local Coords = GetEntityCoords(Ped)
			local _,GroundZ = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])

			for Index,v in pairs(Drops[Route]) do
				local OtherCoords = vec3(Coords["x"],Coords["y"],GroundZ)
				if #(OtherCoords - v["Coords"]) <= 1.0 then
					DropList[#DropList + 1] = v
				end
			end
		end

		Callback({ Inventory = Inventory, Drops = DropList, Weight = Weight, MaxWeight = MaxWeight })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDROPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		local Route = LocalPlayer["state"]["Route"]
		if not IsPedInAnyVehicle(Ped) and Drops[Route] then
			local Coords = GetEntityCoords(Ped)

			for _,v in pairs(Drops[Route]) do
				if #(Coords - v["Coords"]) <= 50 then
					TimeDistance = 1
					DrawMarker(20,v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"] + 0.5,0.0,0.0,0.0,0.0,180.0,0.0,0.35,0.35,0.35,65,130,226,100,0,0,0,1)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:EXPLODETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:explodeTyres")
AddEventHandler("inventory:explodeTyres",function(Network,Plate,Tyre)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) and GetVehicleNumberPlateText(Vehicle) == Plate then
			SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local TyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Tyres()
	local Ped = PlayerPedId()
	if not IsPedInAnyVehicle(Ped) then
		local Vehicle,Model = vRP.ClosestVehicle(7)
		if IsEntityAVehicle(Vehicle) then
			local Coords = GetEntityCoords(Ped)

			for Index,Tyre in pairs(TyreList) do
				local Selected = GetEntityBoneIndexByName(Vehicle,Index)
				if Selected ~= -1 then
					local CoordsWheel = GetWorldPositionOfEntityBone(Vehicle,Selected)
					if #(Coords - CoordsWheel) <= 1.0 and GetTyreHealth(Vehicle,Tyre) ~= 1000.0 then
						return Vehicle,Tyre,VehToNet(Vehicle),GetVehicleNumberPlateText(Vehicle),Model
					end
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.tyreHealth(Network,Tyre)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			return GetTyreHealth(Vehicle,Tyre)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTEXISTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ObjectExists(Coords,Hash)
	return DoesObjectOfTypeExistAtCoords(Coords["x"],Coords["y"],Coords["z"],0.35,Hash,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTERIOR
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckInterior()
	return GetInteriorFromEntity(PlayerPedId()) ~= 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATM
-----------------------------------------------------------------------------------------------------------------------------------------
local Atm = {
	vec4(228.2,338.38,105.56,158.75),
	vec4(158.66,234.2,106.63,345.83),
	vec4(-57.66,-92.62,57.78,294.81),
	vec4(356.97,173.56,103.07,343.0),
	vec4(-1415.93,-212.01,46.51,235.28),
	vec4(-1430.18,-211.1,46.51,116.23),
	vec4(-1282.53,-210.9,42.44,308.98),
	vec4(-1286.28,-213.45,42.44,124.73),
	vec4(-1289.31,-226.82,42.44,124.73),
	vec4(-1285.56,-224.3,42.44,311.82),
	vec4(-1109.78,-1690.81,4.36,127.56),
	vec4(1686.85,4815.82,42.01,280.63),
	vec4(1701.21,6426.57,32.76,65.2),
	vec4(1171.56,2702.59,38.16,0.0),
	vec4(1172.48,2702.58,38.16,2.84),
	vec4(-1091.49,2708.67,18.96,42.52),
	vec4(-3144.36,1127.58,20.86,65.2),
	vec4(527.35,-160.69,57.09,272.13),
	vec4(285.5,143.36,104.17,158.75),
	vec4(-846.27,-341.31,38.67,119.06),
	vec4(-846.84,-340.23,38.67,116.23),
	vec4(-721.05,-415.5,34.98,269.3),
	vec4(-1410.31,-98.78,52.42,107.72),
	vec4(-1409.77,-100.49,52.39,104.89),
	vec4(-712.94,-818.91,23.72,0.0),
	vec4(-710.05,-818.9,23.72,0.0),
	vec4(-660.72,-854.07,24.48,178.59),
	vec4(-594.56,-1161.28,22.33,2.84),
	vec4(-596.07,-1161.3,22.33,0.0),
	vec4(-821.63,-1081.93,11.12,31.19),
	vec4(155.91,6642.85,31.59,320.32),
	vec4(174.15,6637.93,31.58,45.36),
	vec4(-283.0,6226.12,31.49,320.32),
	vec4(-95.55,6457.18,31.46,45.36),
	vec4(-97.3,6455.46,31.46,45.36),
	vec4(-132.96,6366.57,31.48,317.49),
	vec4(-386.75,6046.07,31.49,317.49),
	vec4(24.47,-945.95,29.35,343.0),
	vec4(5.25,-919.84,29.55,252.29),
	vec4(295.79,-896.09,29.22,252.29),
	vec4(296.46,-894.19,29.23,252.29),
	vec4(1138.24,-468.93,66.73,73.71),
	vec4(1166.96,-456.06,66.79,345.83),
	vec4(1077.72,-776.53,58.23,181.42),
	vec4(289.09,-1256.82,29.44,272.13),
	vec4(288.84,-1282.35,29.64,272.13),
	vec4(-1571.07,-547.39,34.95,221.11),
	vec4(-1570.11,-546.68,34.95,221.11),
	vec4(-1305.38,-706.39,25.33,127.56),
	vec4(-2072.38,-317.31,13.31,269.3),
	vec4(-2295.46,358.13,174.6,113.39),
	vec4(-2294.69,356.43,174.6,113.39),
	vec4(-2293.93,354.82,174.6,116.23),
	vec4(2558.77,350.99,108.61,85.04),
	vec4(89.65,2.47,68.31,343.0),
	vec4(-866.66,-187.78,37.84,119.06),
	vec4(-867.62,-186.14,37.84,119.06),
	vec4(-618.22,-708.89,30.04,274.97),
	vec4(-618.25,-706.9,30.04,272.13),
	vec4(-614.57,-704.84,31.24,181.42),
	vec4(-611.89,-704.84,31.24,181.42),
	vec4(-537.82,-854.47,29.28,184.26),
	vec4(-526.65,-1222.98,18.45,155.91),
	vec4(-165.16,232.71,94.91,90.71),
	vec4(-165.17,234.8,94.91,90.71),
	vec4(-303.25,-829.74,32.42,354.34),
	vec4(-301.75,-830.04,32.42,351.5),
	vec4(-203.81,-861.37,30.26,25.52),
	vec4(119.06,-883.74,31.12,68.04),
	vec4(112.59,-819.37,31.34,158.75),
	vec4(111.26,-775.23,31.44,343.0),
	vec4(114.44,-776.4,31.41,343.0),
	vec4(-256.23,-716.01,33.53,68.04),
	vec4(-258.84,-723.4,33.48,70.87),
	vec4(-254.39,-692.46,33.6,158.75),
	vec4(-28.0,-724.53,44.23,343.0),
	vec4(-30.21,-723.7,44.23,343.0),
	vec4(-1315.74,-834.71,16.95,311.82),
	vec4(-1314.79,-835.97,16.95,308.98),
	vec4(-2956.86,487.63,15.47,175.75),
	vec4(-2959.0,487.73,15.47,178.59),
	vec4(-3040.74,593.1,7.9,289.14),
	vec4(-3241.17,997.59,12.55,36.86),
	vec4(-1205.76,-324.81,37.86,116.23),
	vec4(-1204.99,-326.33,37.83,116.23),
	vec4(147.59,-1035.79,29.34,158.75),
	vec4(145.98,-1035.2,29.34,155.91),
	vec4(33.17,-1348.27,29.49,181.42),
	vec4(2558.48,389.49,108.61,266.46),
	vec4(1153.64,-326.76,69.2,102.05),
	vec4(-717.69,-915.69,19.21,90.71),
	vec4(-56.95,-1752.07,29.42,51.03),
	vec4(380.79,323.37,103.56,164.41),
	vec4(-3240.59,1008.6,12.82,266.46),
	vec4(1735.26,6410.52,35.03,150.24),
	vec4(540.32,2671.11,42.16,8.51),
	vec4(1968.1,3743.54,32.33,212.6),
	vec4(2683.1,3286.54,55.23,240.95),
	vec4(1703.0,4933.59,42.06,325.99),
	vec4(-1827.28,784.87,138.3,136.07),
	vec4(-3040.73,593.11,7.9,289.14),
	vec4(238.3,215.95,106.29,297.64),
	vec4(237.91,216.9,106.29,297.64),
	vec4(237.46,217.81,106.29,297.64),
	vec4(237.05,218.73,106.29,297.64),
	vec4(236.59,219.66,106.29,297.64),
	vec4(264.45,210.04,106.27,252.29),
	vec4(264.81,211.05,106.27,252.29),
	vec4(265.15,211.98,106.27,252.29),
	vec4(265.5,212.93,106.27,252.29),
	vec4(265.85,213.88,106.27,252.29),
	vec4(130.11,-1292.67,29.27,300.48),
	vec4(129.66,-1291.91,29.27,300.48),
	vec4(129.24,-1291.16,29.27,303.31),
	vec4(-248.07,6327.51,32.42,314.65),
	vec4(-677.39,5834.59,17.32,136.07),
	vec4(2564.5,2584.78,38.08,110.56),
	vec4(-609.78,-1091.96,22.33,133.23),
	vec4(-1206.87,-889.54,13.02,218.27)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end

	for Number,v in pairs(Atm) do
		exports["target"]:AddCircleZone("Atm:"..Number,v["xyz"],0.5,{
			name = "Atm:"..Number,
			heading = v["w"],
			useZ = true
		},{
			shop = "eletronics",
			Distance = 1.0,
			options = {
				{
					event = "Bank",
					label = "Abrir",
					tunnel = "client"
				},{
					event = "inventory:Robberys",
					tunnel = "server",
					label = "Roubar"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTIITYCOORDSZ
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.EntityCoordsZ()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local _,GroundZ = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])

	return vec3(Coords["x"],Coords["y"],GroundZ)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOSSANTOS
-----------------------------------------------------------------------------------------------------------------------------------------
local LosSantos = PolyZone:Create({
	vec2(-2153.08,-3131.33),
	vec2(-1581.58,-2092.38),
	vec2(-3271.05,275.85),
	vec2(-3460.83,967.42),
	vec2(-3202.39,1555.39),
	vec2(-1642.50,993.32),
	vec2(312.95,1054.66),
	vec2(1313.70,341.94),
	vec2(1739.01,-1280.58),
	vec2(1427.42,-3440.38),
	vec2(-737.90,-3773.97)
},{ name = "Santos" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANDYSHORES
-----------------------------------------------------------------------------------------------------------------------------------------
local SandyShores = PolyZone:Create({
	vec2(-375.38,2910.14),
	vec2(307.66,3664.47),
	vec2(2329.64,4128.52),
	vec2(2349.93,4578.50),
	vec2(1680.57,4462.48),
	vec2(1570.01,4961.27),
	vec2(1967.55,5203.67),
	vec2(2387.14,5273.98),
	vec2(2735.26,4392.21),
	vec2(2512.33,3711.16),
	vec2(1681.79,3387.82),
	vec2(258.85,2920.16)
},{ name = "Sandy" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- PALETOBAY
-----------------------------------------------------------------------------------------------------------------------------------------
local PaletoBay = PolyZone:Create({
	vec2(-529.40,5755.14),
	vec2(-234.39,5978.46),
	vec2(278.16,6381.84),
	vec2(672.67,6434.39),
	vec2(699.56,6877.77),
	vec2(256.59,7058.49),
	vec2(17.64,7054.53),
	vec2(-489.45,6449.50),
	vec2(-717.59,6030.94)
},{ name = "Paleto" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- CEVENTGUNSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("CEventGunShot",function(_,OtherPeds)
	local Ped = PlayerPedId()
	if Ped == OtherPeds and not LocalPlayer["state"]["Policia"] and GetGameTimer() >= ShotDelay and Weapon ~= "WEAPON_MUSKET" and Weapon ~= "WEAPON_SAUER" then
		ShotDelay = GetGameTimer() + 60000
		TriggerEvent("player:Residuals","Resíduo de Pólvora.")

		local Coords = GetEntityCoords(Ped)
		if not IsPedCurrentWeaponSilenced(Ped) then
			if (LosSantos:isPointInside(Coords) or SandyShores:isPointInside(Coords) or PaletoBay:isPointInside(Coords)) then
				vSERVER.ShotsFired(IsPedInAnyVehicle(Ped))
			end
		else
			if math.random(100) >= 75 and (LosSantos:isPointInside(Coords) or SandyShores:isPointInside(Coords) or PaletoBay:isPointInside(Coords)) then
				vSERVER.ShotsFired(IsPedInAnyVehicle(Ped))
			end
		end
	end
end)