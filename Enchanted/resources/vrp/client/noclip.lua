-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Speed = 1.0
local Camera = nil
local NoClip = false
local PlayerPed = nil
local NoClipEntity = nil
local PlayerVehicle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISCONTROLALWAYSPRESSED
-----------------------------------------------------------------------------------------------------------------------------------------
local function IsControlAlwaysPressed(Input,Control)
	return IsControlPressed(Input,Control) or IsDisabledControlPressed(Input,Control)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISPEDDRIVINGVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
local function IsPedDrivingVehicle(Ped,Vehicle)
	return Ped == GetPedInVehicleSeat(Vehicle,-1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCAM
-----------------------------------------------------------------------------------------------------------------------------------------
local function SetupCam()
	local Heading = GetEntityHeading(NoClipEntity)
	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	RenderScriptCams(true,false,0,false,false)
	SetCamRot(Camera,0.0,0.0,Heading)
	SetCamActive(Camera,true)

	AttachCamToEntity(Camera,NoClipEntity,0.0,0.0,1.0,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESTROYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
local function DestroyCamera()
	SetGameplayCamRelativeHeading(0)

	RenderScriptCams(false,false,0,false,false)
	SetCamActive(Camera,false)
	DestroyCam(Camera,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGROUNDCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local function GetGroundCoords(Coords)
	local Ray = StartShapeTestRay(Coords.x,Coords.y,Coords.z,Coords.x,Coords.y,-10000.0,1,0)
	local _,Hit,HitCoords = GetShapeTestResult(Ray)

	return Hit == 1 and HitCoords or Coords
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINPUTROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
local function CheckInputRotation()
	local RightX,RightY = GetControlNormal(0,220),GetControlNormal(0,221)

	local yVal = RightY * -5
	local Rotate = GetCamRot(Camera,2)
	local NewX = (Rotate.x + yVal > -89.0 and Rotate.x + yVal < 89.0) and (Rotate.x + yVal) or Rotate.x
	local NewZ = Rotate.z + (RightX * -10)

	SetCamRot(Camera,vec3(NewX,Rotate.y,NewZ),2)
	SetEntityHeading(NoClipEntity,math.max(0,(Rotate.z % 360)))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RUNNOCLIPTHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
local function RunNoClipThread()
	CreateThread(function()
		while NoClip do
			Wait(0)

			CheckInputRotation()

			if IsControlAlwaysPressed(2,14) then
				Speed = math.max(0.5,Speed - 0.5)
			elseif IsControlAlwaysPressed(2,15) then
				Speed = math.min(16.0,Speed + 0.5)
			elseif IsDisabledControlJustReleased(0,348) then
				Speed = 1.0
			end

			local Multiplier = 1.0
			if IsControlAlwaysPressed(0,21) then
				Multiplier = 4.0
			end

			if IsControlAlwaysPressed(0,32) or IsControlAlwaysPressed(0,33) then
				local Pitch = GetCamRot(Camera,0)
				local Direction = IsControlAlwaysPressed(0,32) and 0.5 or -0.5
				local zAdjust = (Pitch.x >= 0 and Pitch.x or -math.abs(Pitch.x)) * ((Speed / 2) * Multiplier) / 89
				SetEntityCoordsNoOffset(NoClipEntity,GetOffsetFromEntityInWorldCoords(NoClipEntity,0.0,Direction * (Speed * Multiplier),zAdjust))
			end

			if IsControlAlwaysPressed(0,34) then
				SetEntityCoordsNoOffset(NoClipEntity,GetOffsetFromEntityInWorldCoords(NoClipEntity,-0.5 * (Speed * Multiplier),0.0,0.0))
			elseif IsControlAlwaysPressed(0,35) then
				SetEntityCoordsNoOffset(NoClipEntity,GetOffsetFromEntityInWorldCoords(NoClipEntity,0.5 * (Speed * Multiplier),0.0,0.0))
			end

			if IsControlAlwaysPressed(0,44) then
				SetEntityCoordsNoOffset(NoClipEntity,GetOffsetFromEntityInWorldCoords(NoClipEntity,0.0,0.0,0.5 * (Speed * Multiplier)))
			elseif IsControlAlwaysPressed(0,46) then
				SetEntityCoordsNoOffset(NoClipEntity,GetOffsetFromEntityInWorldCoords(NoClipEntity,0.0,0.0,-0.5 * (Speed * Multiplier)))
			end

			local Coords = GetEntityCoords(NoClipEntity)
			RequestCollisionAtCoord(Coords.x,Coords.y,Coords.z)

			SetEntityInvincible(NoClipEntity,true)
			FreezeEntityPosition(NoClipEntity,true)
			SetEntityVisible(NoClipEntity,false,false)
			SetEntityCollision(NoClipEntity,false,false)
			SetEveryoneIgnorePlayer(PlayerPed,true)
			SetPoliceIgnorePlayer(PlayerPed,true)

			if PlayerVehicle then
				SetVehicleEngineOn(NoClipEntity,false,true,true)
			end
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPNOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
local function StopNoClip()
	FreezeEntityPosition(NoClipEntity,false)
	SetEntityCollision(NoClipEntity,true,true)
	SetEntityVisible(NoClipEntity,true,false)
	SetEveryoneIgnorePlayer(PlayerPed,false)
	SetPoliceIgnorePlayer(PlayerPed,false)
	SetLocalPlayerVisibleLocally(true)

	if GetVehiclePedIsIn(PlayerPed) ~= 0 then
		while not NoClip and not IsVehicleOnAllWheels(NoClipEntity) do
			Wait(0)
		end
	else
		if IsPedFalling(NoClipEntity) and math.abs(1 - GetEntityHeightAboveGround(NoClipEntity)) > 1.0 then
			while not NoClip and (IsPedStopped(NoClipEntity) or not IsPedFalling(NoClipEntity)) do
				Wait(0)
			end
		end

		while not NoClip and (IsPedFalling(NoClipEntity) or IsPedRagdoll(NoClipEntity)) do
			Wait(0)
		end
	end

	SetEntityInvincible(NoClipEntity,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.noClip()
	NoClip = not NoClip
	PlayerPed = PlayerPedId()
	PlayerVehicle = GetVehiclePedIsUsing(PlayerPed)

	if PlayerVehicle and IsPedDrivingVehicle(PlayerPed,PlayerVehicle) then
		NoClipEntity = PlayerVehicle
	else
		NoClipEntity = PlayerPed
	end

	if NoClip then
		SetupCam()

		if not PlayerVehicle then
			ClearPedTasksImmediately(PlayerPed)
		end

		RunNoClipThread()
	else
		local Ground = GetGroundCoords(GetEntityCoords(NoClipEntity))
		SetEntityCoords(NoClipEntity,Ground.x,Ground.y,Ground.z)

		SetTimeout(100,function()
			DestroyCamera()
			StopNoClip()
		end)
	end
end