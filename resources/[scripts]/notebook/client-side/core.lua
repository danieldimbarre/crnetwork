local Cooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleData(Vehicle)
	local Wheels = exports["vstancer"]:GetWheelPreset(Vehicle)

	local vehBoost = {
		boost = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fInitialDriveForce"),
		curve = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionCurveLateral"),
		lowspeed = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fLowSpeedTractionLossMult"),
		trafront = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionBiasFront"),
		clutchup = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleUpShift"),
		clutchdown = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleDownShift"),
		trackf = mathLength(Wheels[1] * -1),
		camberf = mathLength(Wheels[2] * -1),
		trackr = mathLength(Wheels[3] * -1),
		camberr = mathLength(Wheels[4] * -1)
	}

	if exports["vstancer"]:ResetWheelPreset(Vehicle) then
		local Preset = exports["vstancer"]:GetWheelPreset(Vehicle)

		local Reset = {
			trackfReset = mathLength(Preset[1] * -1),
			trackrReset = mathLength(Preset[3] * -1),
		}

		exports["vstancer"]:SetWheelPreset(Vehicle,Wheels[1],Wheels[2],Wheels[3],Wheels[4])

		return { vehBoost,Reset }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function saveData(Vehicle,data)
	SetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionCurveLateral",data["curve"] * 1.0)
	SetVehicleHandlingFloat(Vehicle,"CHandlingData","fInitialDriveForce",data["boost"] * 1.0)
	SetVehicleHandlingFloat(Vehicle,"CHandlingData","fLowSpeedTractionLossMult",data["lowspeed"] * 1.0)
	SetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionBiasFront",data["trafront"] * 1.0)
	SetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleUpShift",data["clutchup"] * 1.0)
	SetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleDownShift",data["clutchdown"] * 1.0)

	exports["vstancer"]:SetWheelPreset(Vehicle,data["trackf"] * -1,data["camberf"] * -1,data["trackr"] * -1,data["camberr"] * -1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEMENU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("togglemenu",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("save",function(Data,Callback)
	if Cooldown <= GetGameTimer() then
		Cooldown = GetGameTimer() + 2000

		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(vehicle,-1) == Ped then
				TriggerEvent("Notify","verde","Modificações aplicadas.",5000)
				saveData(vehicle,Data)
			end
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("reset",function(Data,Callback)
	if Cooldown <= GetGameTimer() then
		Cooldown = GetGameTimer() + 2000

		local Vehicle = GetVehiclePedIsUsing(PlayerPedId())
		exports["vstancer"]:ResetWheelPreset(Vehicle)

		local Reset = exports["vstancer"]:GetWheelPreset(Vehicle)
		Callback({ trackf = mathLength(Reset[1] * -1), trackr = mathLength(Reset[3] * -1) })
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTEBOOK:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("notebook:openSystem")
AddEventHandler("notebook:openSystem",function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(vehicle,-1) == Ped then
			SetNuiFocus(true,true)

			SendNUIMessage({ type = "togglemenu", state = true, data = vehicleData(vehicle) })
		end
	end
end)