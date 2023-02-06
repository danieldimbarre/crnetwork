local Cooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleData(Vehicle)
	local trackf = exports["vstancer"]:GetFrontTrackWidth(Vehicle)[1] * -1
	local trackr = exports["vstancer"]:GetRearTrackWidth(Vehicle)[1] * -1
	local camberf = exports["vstancer"]:GetFrontCamber(Vehicle)[1] * -1
	local camberr = exports["vstancer"]:GetRearCamber(Vehicle)[1] * -1

	local vehBoost = {
		boost = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fInitialDriveForce"),
		curve = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionCurveLateral"),
		lowspeed = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fLowSpeedTractionLossMult"),
		trafront = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionBiasFront"),
		clutchup = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleUpShift"),
		clutchdown = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleDownShift"),
		trackf = trackf,
		trackr = trackr,
		camberf = camberf,
		camberr = camberr
	}

	exports["vstancer"]:ResetWheelPreset(Vehicle)
	local Reset = {
		trackfReset = exports["vstancer"]:GetFrontTrackWidth(Vehicle)[1] * -1,
		trackrReset = exports["vstancer"]:GetRearTrackWidth(Vehicle)[1] * -1,
	}

	exports["vstancer"]:SetFrontTrackWidth(Vehicle,trackf * -1)
	exports["vstancer"]:SetRearTrackWidth(Vehicle,trackr * -1)
	exports["vstancer"]:SetFrontCamber(Vehicle,camberf * -1)
	exports["vstancer"]:SetRearCamber(Vehicle,camberr * -1)

	return vehBoost,Reset
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

	exports["vstancer"]:SetFrontTrackWidth(Vehicle,data["trackf"] * -1)
	exports["vstancer"]:SetRearTrackWidth(Vehicle,data["trackr"] * -1)
	exports["vstancer"]:SetFrontCamber(Vehicle,data["camberf"] * -1)
	exports["vstancer"]:SetRearCamber(Vehicle,data["camberr"] * -1)
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

		Callback("Ok")
	end
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
		Callback({ trackf = Reset[1] * -1, trackr = Reset[3] * -1, camberf = Reset[2], camberr = Reset[4] })
	end
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