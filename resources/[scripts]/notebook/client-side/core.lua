-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleData(Vehicle)
	local vehBoost = {
		boost = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fInitialDriveForce"),
		curve = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionCurveLateral"),
		lowspeed = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fLowSpeedTractionLossMult"),
		trafront = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fTractionBiasFront"),
		clutchup = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleUpShift"),
		clutchdown = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fClutchChangeRateScaleDownShift"),
		trackf = exports["vstancer"]:GetFrontTrackWidth(vehicle),
		trackr = exports["vstancer"]:GetRearTrackWidth(vehicle),
		camberf = exports["vstancer"]:GetFrontCamber(vehicle),
		camberr = exports["vstancer"]:GetRearCamber(vehicle)
	}

	return vehBoost
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

	exports["vstancer"]:SetFrontTrackWidth(vehicle,data["trackf"])
	exports["vstancer"]:SetRearTrackWidth(vehicle,data["trackr"])
	exports["vstancer"]:SetFrontCamber(vehicle,data["camberf"])
	exports["vstancer"]:SetRearCamber(vehicle,data["camberr"])
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
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(vehicle,-1) == Ped then
			TriggerEvent("Notify","verde","Modificações aplicadas.",5000)
			saveData(vehicle,Data)
		end
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