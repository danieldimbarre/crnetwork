-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("tencode")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
local policeRadar = false
local policeFreeze = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(Data,Callback)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ tencode = false })

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendCode",function(Data,Callback)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	vSERVER.sendCode(Data["code"])
	SendNUIMessage({ tencode = false })

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRADAR
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyPoliceVehicle(Ped) and not IsPedInAnyHeli(Ped) and LocalPlayer["state"]["Police"] then
			if policeRadar then
				if not policeFreeze then
					TimeDistance = 100

					local vehicle = GetVehiclePedIsUsing(Ped)
					local vehicleDimension = GetOffsetFromEntityInWorldCoords(vehicle,0.0,1.0,1.0)

					local vehicleFront = GetOffsetFromEntityInWorldCoords(vehicle,0.0,105.0,0.0)
					local vehicleFrontShape = StartShapeTestCapsule(vehicleDimension,vehicleFront,3.0,10,vehicle,7)
					local _,_,_,_,vehFront = GetShapeTestResult(vehicleFrontShape)

					if IsEntityAVehicle(vehFront) then
						local vehHash = vRP.VehicleModel(vehFront)
						local vehSpeed = GetEntitySpeed(vehFront) * 3.6
						local Plate = GetVehicleNumberPlateText(vehFront)

						SendNUIMessage({ radar = "top", plate = Plate, Model = VehicleName(vehHash), speed = vehSpeed })
					end

					local vehicleBack = GetOffsetFromEntityInWorldCoords(vehicle,0.0,-105.0,0.0)
					local vehicleBackShape = StartShapeTestCapsule(vehicleDimension,vehicleBack,3.0,10,vehicle,7)
					local _,_,_,_,vehBack = GetShapeTestResult(vehicleBackShape)

					if IsEntityAVehicle(vehBack) then
						local vehHash = vRP.VehicleModel(vehBack)
						local vehSpeed = GetEntitySpeed(vehBack) * 3.6
						local Plate = GetVehicleNumberPlateText(vehBack)

						SendNUIMessage({ radar = "bot", plate = Plate, Model = VehicleName(vehHash), speed = vehSpeed })
					end
				end
			end
		end

		if not IsPedInAnyVehicle(Ped) and policeRadar then
			policeRadar = false
			SendNUIMessage({ radar = false })
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLERADAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleRadar",function()
	local Ped = PlayerPedId()
	if IsPedInAnyPoliceVehicle(Ped) and not IsPedInAnyHeli(Ped) and LocalPlayer["state"]["Police"] and not IsPauseMenuActive() then
		if policeRadar then
			policeRadar = false
			SendNUIMessage({ radar = false })
		else
			policeRadar = true
			SendNUIMessage({ radar = true })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEFREEZE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleFreeze",function()
	local Ped = PlayerPedId()
	if IsPedInAnyPoliceVehicle(Ped) and LocalPlayer["state"]["Police"] and not IsPauseMenuActive() then
		policeFreeze = not policeFreeze
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TENCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("enterTencodes",function()
	if LocalPlayer["state"]["Police"] and LocalPlayer["state"]["Route"] < 900000 and not IsPauseMenuActive() then
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.1)
		SendNUIMessage({ tencode = true })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("enterTencodes","Manusear o código policial.","keyboard","F3")
RegisterKeyMapping("toggleRadar","Ativar/Desativar radar das viaturas.","keyboard","N")
RegisterKeyMapping("toggleFreeze","Travar/Destravar radar das viaturas.","keyboard","M")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
local vehCamera = false
local fov_max = 90.0
local fov_min = 7.5
local zoomspeed = 12.0
local speed_lr = 16.0
local speed_ud = 8.0
local minHeightAboveGround = 5.0 -- Minimum height above ground to activate Heli Cam (in metres).

local fov = (fov_max + fov_min) * 0.5

local Spritefov_max = 0.11
local Spritefov_min = 0.04
local Spritezoomspeed = 0.01
local Spritefov = (Spritefov_max + Spritefov_min) * 0.5

local cam = nil
local entity_detected = nil
local locked_on = nil

local ThermalToggle = false
local NightVisionToggle = false
local SpotlightToggle = false

local polmav_hash = {
	[`maverick2`] = true,
	[`B412`] = true
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
	
	SetTextFont((style.font ~= nil) and style.font or 0)
	SetTextScale(0.0,(style.size ~= nil) and style.size or 1.0)
	SetTextProportional(1)
	
	if style.colour ~= nil then
		SetTextColour( style.colour.r ~= nil and style.colour.r or 255,style.colour.g ~= nil and style.colour.g or 255,style.colour.b ~= nil and style.colour.b or 255,style.colour.a ~= nil and style.colour.a or 255)
	else
		SetTextColour(255,255,255,255)
	end
	
	if style.shadow ~= nil then
		SetTextDropShadow(style.shadow.distance ~= nil and style.shadow.distance or 0,style.shadow.r ~= nil and style.shadow.r or 0,style.shadow.g ~= nil and style.shadow.g or 0,style.shadow.b ~= nil and style.shadow.b or 0,style.shadow.a ~= nil and style.shadow.a or 255)
	else
		SetTextDropShadow(0,0,0,0,255)
	end
	
	if style.border ~= nil then
		SetTextEdge(style.border.size ~= nil and style.border.size or 1,style.border.r ~= nil and style.border.r or 0,style.border.g ~= nil and style.border.g or 0,style.border.b ~= nil and style.border.b or 0,style.border.a ~= nil and style.shadow.a or 255)
	end
	
	if style.centered ~= nil and style.centered == true then
		SetTextCentre(true)
	end
	
	if style.outline ~= nil and style.outline == true then
		SetTextOutline()
	end
	
	SetTextEntry("STRING")
	AddTextComponentString(str)
	
	DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEGREESTOINTERCARDINALDIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function degreesToIntercardinalDirection(dgr)
	dgr = dgr % 360.0
	
	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
		return "N "
	elseif dgr >= 22.5 and dgr < 67.5 then
		return "NE"
	elseif dgr >= 67.5 and dgr < 112.5 then
		return "L"
	elseif dgr >= 112.5 and dgr < 157.5 then
		return "SE"
	elseif dgr >= 157.5 and dgr < 202.5 then
		return "S"
	elseif dgr >= 202.5 and dgr < 247.5 then
		return "SO"
	elseif dgr >= 247.5 and dgr < 292.5 then
		return "O"
	elseif dgr >= 292.5 and dgr < 337.5 then
		return "NO"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function Compass()
	CreateThread(function()
		if compass.position.centered then
			compass.position.x = compass.position.x - compass.width / 2
		end

		while vehCamera do 
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

			Wait(4)
		end
	end)
end
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
-- THREADHELICAMINFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function HelicamInformations()
	CreateThread(function()
		while vehCamera do 
			-- local Ped = PlayerPedId()
			-- local x,y,z = table.unpack(GetEntityCoords(Ped,true))
			-- local NorthCoord = tostring(y * 10000000)
			-- local WestCoord = tostring(x * 10000000)
			-- DrawDisplayText(0.21,0.22,"/.:!| DEPARTAMENTO DA POLÍCIA MILITAR ENERGY ")
			-- DrawDisplayText(0.69,0.22, math.ceil(GetEntityHeading(GetVehiclePedIsIn(Ped))).."°T")
			-- DrawDisplayText(0.697,0.24,"V")
			-- DrawDisplayText(0.21,0.24,string.sub(NorthCoord,1,3).."°"..string.sub(NorthCoord,4,5).."'"..string.sub(NorthCoord,6,7).."."..string.sub(NorthCoord,8,9))
			-- DrawDisplayText(0.255,0.24,"N")
			-- DrawDisplayText(0.27,0.24,string.sub(WestCoord,1,3).."°"..string.sub(WestCoord,4,5).."'"..string.sub(WestCoord,6,7).."."..string.sub(WestCoord,8,9))
			-- DrawDisplayText(0.315,0.24,"L")
			-- DrawDisplayText(0.21,0.26,"SPD    "..math.ceil(3.6 * (GetEntitySpeed(Ped))))
			-- DrawDisplayText(0.25,0.26,"KTS")
			-- DrawDisplayText(0.27,0.26,"HDG")
			-- DrawDisplayText(0.30,0.26,math.ceil(GetGameplayCamRelativeHeading()))
			-- DrawDisplayText(0.315,0.26,"°T")
			-- DrawDisplayText(0.21,0.28,"ALT    "..math.ceil(GetEntityHeightAboveGround(Ped) * 3.28084))
			-- DrawDisplayText(0.25,0.28,"FT")
			--N W
			--SPD
			-- DrawDisplayText(1.0 - 0.135 + 0.25,0.26,"MPG")
			-- DrawDisplayText(1.0 - 0.135 + 0.27,0.26,"HDG")
			--Heading
			-- DrawDisplayText(1.0 - 0.135 + 0.315,0.26,"°T")
			-- DrawDisplayText(1.0 - 0.135 + 0.21,0.28,"ELV    "..math.ceil(GetGameplayCamRelativePitch()))
			-- DrawDisplayText(1.0 - 0.135 + 0.25,0.28,"FT")

			-- DrawDisplayText(0.22,1.0 - 0.135 + 0.18,"HDIR")
			-- DrawDisplayText(0.22,1.0 - 0.135 + 0.20,"M WH DDE")
			-- DrawDisplayText(0.22,1.0 - 0.135 + 0.22,"FOC MAN")
			-- DrawDisplayText(0.22,1.0 - 0.135 + 0.24,"EXP MAN")
			-- DrawDisplayText(0.22,1.0 - 0.135 + 0.26,"W")

			local TextureDict = "helicopterhud"
			local TextureName = "hud_line"
			if not HasStreamedTextureDictLoaded(TextureDict) then
				RequestStreamedTextureDict(TextureDict, true)
				while not HasStreamedTextureDictLoaded(TextureDict) do
					Wait(0)
				end
			end
			DrawSprite(TextureDict,TextureName,0.075,0.94,0.1,0.01,0.0,255,255,255,255)

			-- DrawDisplayText(0.32,1.0 - 0.135 + 0.26,"N")

			-- DrawDisplayText(0.37,1.0 - 0.135 + 0.26,"FT")

			-- DrawDisplayText(1.0 - 0.135 + 0.27,1.0 - 0.135 + 0.18,"GEOPOINT")
			-- DrawDisplayText(1.0 - 0.135 + 0.27,1.0 - 0.135 + 0.20,"INS NAV")
			-- DrawDisplayText(1.0 - 0.135 + 0.27,1.0 - 0.135 + 0.24,"TRK COR")
			-- DrawDisplayText(1.0 - 0.135 + 0.27,1.0 - 0.135 + 0.28,"SLAVE READY")

			-- day = GetClockDayOfMonth()
			-- month = GetClockMonth()
			-- year = GetClockYear()
		
			-- if day <= 9 then day = "0"..day end
			-- if month <= 9 then month = "0"..month end
			
			-- DrawDisplayText(0.21,0.34,month.."/"..day.."/"..(year - 2000))
			-- DrawDisplayText(0.21,0.36,GlobalState["Hours"]..":"..GlobalState["Minutes"])
			-- DrawDisplayText(0.245,0.36,"Z")

			local TextureDict = "helicopterhud"
			local TextureName = "hud_target"
			if not HasStreamedTextureDictLoaded(TextureDict) then
				RequestStreamedTextureDict(TextureDict,true)
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

			Wait(1)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THERMALADD
-----------------------------------------------------------------------------------------------------------------------------------------
function ThermalAdd()
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle,ped = FindFirstPed()
    local success
    repeat
        if HasEntityClearLosToEntity(playerped,ped,17) then
        	if IsPedHuman(ped) and not IsPedInAnyVehicle(ped,false) then
        		for _,boneListItem in pairs(boneList) do
        			local x,y,z = table.unpack(vector3(GetPedBoneCoords(ped,boneListItem.boneId)))
					DrawThermal(x + boneListItem.X1,y + boneListItem.Y1,z + boneListItem.Z1,x + boneListItem.X2,y + boneListItem.Y2,z + boneListItem.Z2)
        		end
			else
				boneList2 = {
				--[[SKEL_Spine1 --]] { boneId =  24816, X1 = -0.3, Y1 = -0.3, Z1 = -0.3, X2 = 0.4, Y2 = 0.3, Z2 = 0.7 },
				}

        		for _,boneListItem2 in pairs(boneList2) do
        			local x,y,z = table.unpack(vector3(GetPedBoneCoords(ped,boneListItem2.boneId)))
					DrawThermal(x + boneListItem2.X1,y + boneListItem2.Y1,z + boneListItem2.Z1,x + boneListItem2.X2,y + boneListItem2.Y2,z + boneListItem2.Z2)
        		end
			end
        	
        end
        success,ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
	return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THERMALADDVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function ThermalAddVehicle()
	local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
	local handle,pedveh = FindFirstVehicle()
    local success
    local rped = nil
    repeat
    	if HasEntityClearLosToEntity(playerped,pedveh,17) then
        	for _,vehBoneListItem in ipairs(vehBoneList) do
        		local getVehBoneIndex = GetEntityBoneIndexByName(pedveh,vehBoneListItem.vehBoneId)
        		local worldVehBone = GetWorldPositionOfEntityBone(pedveh,getVehBoneIndex)
        		local x,y,z = table.unpack(vector3(worldVehBone))	
				DrawThermal(x + vehBoneListItem.X1,y + vehBoneListItem.Y1,z + vehBoneListItem.Z1,x + vehBoneListItem.X2,y + vehBoneListItem.Y2,z + vehBoneListItem.Z2)
    		end
    	end
    	success,pedveh = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWHELITEXT3DS
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawHeliText3Ds(x,y,z, text, scale)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(scale,scale)
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHELICAM
-----------------------------------------------------------------------------------------------------------------------------------------
function Helicam()
	CreateThread(function()
		while vehCamera do
			local Ped = PlayerPedId()
			local heli = GetVehiclePedIsIn(Ped)

			if not IsEntityDead(Ped) and (GetVehiclePedIsIn(Ped) == heli) and IsHeliHighEnough(heli) then
				if locked_on then
					-- local coords = GetCamCoord(cam)
					-- local forward_vector = RotAnglesToVec(GetCamRot(cam,2))
					-- --DrawLine(coords,coords + (forward_vector * 100.0),255,0,0,255) -- debug line to show LOS of cam
					-- local x, y, z = table.unpack(coords + (forward_vector * 100.0))
					-- local NorthCoord = tostring(y * 10000000)
					-- local WestCoord = tostring(x * 10000000)
					-- DrawDisplayText(1.0 - 0.135 + 0.21,0.24,string.sub(NorthCoord,1,3).."°"..string.sub(NorthCoord,4,5).."'"..string.sub(NorthCoord,6,7).."."..string.sub(NorthCoord,8,9))
					-- DrawDisplayText(1.0 - 0.135 + 0.255,0.24,"N")
					-- DrawDisplayText(1.0 - 0.135 + 0.27,0.24,string.sub(WestCoord,1,3).."°"..string.sub(WestCoord,4,5).."'"..string.sub(WestCoord,6,7).."."..string.sub(WestCoord,8,9))
					-- DrawDisplayText(1.0 - 0.135 + 0.315,0.24,"L")
					-- DrawDisplayText(1.0 - 0.135 + 0.21,0.26,"SPD    "..math.ceil(GetEntitySpeed(locked_on) * 3.6))
					-- DrawDisplayText(1.0 - 0.135 + 0.30,0.26,math.ceil(GetEntityHeading(locked_on)))

					-- local distancetoentity = #(GetEntityCoords(PlayerPedId()) - locked_on)
					-- DrawDisplayText(1.0 - 0.135 + 0.27,0.28,"SLT")
					-- DrawDisplayText(1.0 - 0.135 + 0.315,0.28,"M")
					-- DrawDisplayText(1.0 - 0.135 + 0.30,0.28,math.ceil(distancetoentity))
					if SpotlightToggle then
						SpotlightAdd(cam)
					end

					--stops underwater ped and submarine tracking but means boats cant be tracked
					if DoesEntityExist(locked_on) and not IsEntityInWater(locked_on) then
						PointCamAtEntity(cam,locked_on,0.0,0.0,0.0,true)
						if IsEntityAVehicle(locked_on) and policeRadar and not policeFreeze then
							local vehHash = vRP.VehicleModel(locked_on)
							local vehSpeed = GetEntitySpeed(locked_on) * 3.6
							local Plate = GetVehicleNumberPlateText(locked_on)

							SendNUIMessage({ radar = "top", plate = Plate, Model = VehicleName(vehHash), speed = vehSpeed })
						end

						if not HasEntityClearLosToEntity(heli,locked_on,17) then
							locked_on = nil
							local rot = GetCamRot(cam,2)
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
						locked_on = nil
					end
				else
					local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)
					CheckInputRotation(cam,zoomvalue)
					entity_detected = GetEntityInView(cam)

					if SpotlightToggle then
						SpotlightAdd(cam)
					end

					if DoesEntityExist(entity_detected) then
						if IsEntityAVehicle(entity_detected) and policeRadar and not policeFreeze then
							local vehHash = vRP.VehicleModel(entity_detected)
							local vehSpeed = GetEntitySpeed(entity_detected) * 3.6
							local Plate = GetVehicleNumberPlateText(entity_detected)

							SendNUIMessage({ radar = "top", plate = Plate, Model = VehicleName(vehHash), speed = vehSpeed })
						end
					end
				end

				if ThermalToggle then
					ThermalAdd()
					ThermalAddVehicle()
				end

				HandleZoom(cam)
				-- HandleHUDZoom(cam)
			else
				TriggerEvent("hud:Active",true)
				vehCamera = false
				ThermalToggle = false
				NightVisionToggle = false
				SpotlightToggle = false
				SetNightvision(false)

				if LocalPlayer["state"]["Fps"] then
					SetTimecycleModifier("cinema")
				else
					ClearTimecycleModifier()
				end

				fov = (fov_max + fov_min) * 0.5
				Spritefov = (Spritefov_max + Spritefov_min) * 0.5
				RenderScriptCams(false,false,0,1,0)
				DestroyCam(cam,false)

				policeRadar = false
				SendNUIMessage({ radar = false })
			end

			Wait(1)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKHELI
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckHeli()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local model = GetEntityModel(vehicle)
	if polmav_hash[model] then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISHELIHIGHENOUGH
-----------------------------------------------------------------------------------------------------------------------------------------
function IsHeliHighEnough(heli)
	return GetEntityHeightAboveGround(heli) > minHeightAboveGround
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINPUTROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLEZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
function HandleZoom(cam)
	if IsControlJustPressed(1,241) then
		fov = math.max(fov - zoomspeed,fov_min)
	end

	if IsControlJustPressed(1,242) then
		fov = math.min(fov + zoomspeed,fov_max)
	end

	local current_fov = GetCamFov(cam)
	if math.abs(fov - current_fov) < 0.1 then
		fov = current_fov
	end

	SetCamFov(cam,current_fov + (fov - current_fov) * 0.05)
	-- DrawDisplayText(0.35,1.0 - 0.135 + 0.26,math.ceil(current_fov))
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLEHUDZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
function HandleHUDZoom(cam)
	if IsControlJustPressed(1,241) then
		Spritefov = math.min(Spritefov + Spritezoomspeed,Spritefov_max)
	end

	if IsControlJustPressed(1,242) then
		Spritefov = math.max(Spritefov - Spritezoomspeed,Spritefov_min)
	end

	local Spritecurrent_fov = GetCamFov(cam)
	if math.abs(Spritefov - Spritecurrent_fov) < 0.01 then
		Spritefov = Spritecurrent_fov
	end

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
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETENTITYINVIEW
-----------------------------------------------------------------------------------------------------------------------------------------
function GetEntityInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam,2))
	-- DrawLine(coords, coords+(forward_vector*100.0), 255,0,0,255) -- debug line to show LOS of cam
	-- local x,y,z = table.unpack(coords + (forward_vector * 100.0))
    -- local NorthCoord = tostring(y * 10000000)
    -- local WestCoord = tostring(x * 10000000)
    -- DrawDisplayText(1.0 - 0.135 + 0.21,0.24,string.sub(NorthCoord,1,3).."°"..string.sub(NorthCoord,4,5).."'"..string.sub(NorthCoord,6,7).."."..string.sub(NorthCoord,8,9))
    -- DrawDisplayText(1.0 - 0.135 + 0.255,0.24,"N")
    -- DrawDisplayText(1.0 - 0.135 + 0.27,0.24,string.sub(WestCoord,1,3).."°"..string.sub(WestCoord,4,5).."'"..string.sub(WestCoord,6,7).."."..string.sub(WestCoord,8,9))
    -- DrawDisplayText(1.0 - 0.135 + 0.315,0.24,"L")
	-- local rayhandle = CastRayPointToPoint(coords, coords + (forward_vector * 200.0), 10, GetVehiclePedIsIn(PlayerPedId()), 0)
	local rayhandle = StartShapeTestRay(coords,coords + (forward_vector * 10000.0),10,GetVehiclePedIsIn(PlayerPedId()),4,0,7)
	-- StartShapeTestRay(x1,y1,z1,x2,y2,z2,flags: 4 = ped,2 = vehicle -1 = everything,ent: ignores these entities,p8:7)
	-- local _,_,_,_, entityHit = GetRaycastResult(rayhandle)
	local retval,hit,endCoords,surfaceNormal,entityHit = GetShapeTestResult(rayhandle)
	-- local distancetoentity = #(coords - endCoords)
    -- DrawDisplayText(1.0 - 0.135 + 0.27,0.28,"SLT")
    -- DrawDisplayText(1.0 - 0.135 + 0.315,0.28,"M")
	if entityHit > 0 then
		-- DrawDisplayText(1.0 - 0.135 + 0.30,0.28,math.ceil(distancetoentity))
		-- local entitySpeed = (GetEntitySpeed(entityHit)) * 3.6
		-- DrawDisplayText(1.0 - 0.135 + 0.21,0.26,"SPD    "..math.ceil(entitySpeed))
		return entityHit
	else
		-- DrawDisplayText(1.0 - 0.135 + 0.30,0.28,"---")
		-- DrawDisplayText(1.0 - 0.135 + 0.21,0.26,"SPD    0")
		return nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTANGLESTOVEC
-----------------------------------------------------------------------------------------------------------------------------------------
function RotAnglesToVec(rot)
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z) * num,math.cos(z) * num,math.sin(x))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATETEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function PlateText(vehicle)
	DrawDisplayText(1.0 - 0.135 + 0.21,0.30,"PLACA: "..GetVehicleNumberPlateText(vehicle))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENDERVEHICLEINFO
-----------------------------------------------------------------------------------------------------------------------------------------
function RenderVehicleInfo(vehicle)
	-- DrawDisplayText(1.0 - 0.135 + 0.30,0.26,math.ceil(GetEntityHeading(vehicle)))
	--numberplate doesnt work so has to use the light bone and code out the exceptions
	local HasPlateLight = GetEntityBoneIndexByName(vehicle,"platelight") 
	
	--Debug for Plate on Vehicle Pointed at
	--DrawDisplayText(1.0 - 0.135 + 0.21,0.32,"~b~Plate: ~r~" .. GetVehicleNumberPlateText(vehicle).."\n~b~Plate Light ID Number: ~r~"..HasPlateLight)
	
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
-- TOGGLEHELICAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleHelicam",function()
	if not IsPauseMenuActive() and (LocalPlayer["state"]["Police"] or LocalPlayer["state"]["Paramedic"]) then
		local Ped = PlayerPedId()
		local Veh = GetVehiclePedIsIn(Ped)
		if CheckHeli() and IsHeliHighEnough(Veh) then
			if vehCamera then
				TriggerEvent("hud:Active",true)
				vehCamera = false

				ThermalToggle = false
				NightVisionToggle = false
				SetNightvision(false)
				SpotlightToggle = false
				
				if LocalPlayer["state"]["Fps"] then
					SetTimecycleModifier("cinema")
				else
					ClearTimecycleModifier()
				end

				fov = (fov_max + fov_min) * 0.5
				Spritefov = (Spritefov_max + Spritefov_min) * 0.5
				RenderScriptCams(false,false,0,1,0)
				DestroyCam(cam,false)

				policeRadar = false
				SendNUIMessage({ radar = false })
			else
				TriggerEvent("hud:Active",false)
				vehCamera = true

				cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
				AttachCamToEntity(cam,Veh,0.0,2.0,-1.5,true)
				SetCamRot(cam,0.0,0.0,GetEntityHeading(Veh))
				SetCamFov(cam,fov)
				RenderScriptCams(true,false,0,1,0)
				locked_on = nil

				Helicam()
				HelicamInformations()
				-- Compass()

				policeRadar = true
				SendNUIMessage({ radar = true })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLETHERMAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleThermal",function()
	if not IsPauseMenuActive() and LocalPlayer["state"]["Police"] then
		local Ped = PlayerPedId()
		local Veh = GetVehiclePedIsIn(Ped)
		if vehCamera and CheckHeli() and IsHeliHighEnough(Veh) then
			if ThermalToggle then
				if LocalPlayer["state"]["Fps"] then
					SetTimecycleModifier("cinema")
				else
					ClearTimecycleModifier()
				end
			else
				NightVisionToggle = false
				SetNightvision(false)

				SpotlightToggle = false

				SetTimecycleModifier("NG_blackout")
				SetTimecycleModifierStrength(0.992)
			end

			ThermalToggle = not ThermalToggle
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLENIGHTVISION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleNightvision",function()
	if not IsPauseMenuActive() and LocalPlayer["state"]["Police"] then
		local Veh = GetVehiclePedIsIn(PlayerPedId())
		if vehCamera and CheckHeli() and IsHeliHighEnough(Veh) then
			if NightVisionToggle then
				SetNightvision(false)
			else
				ThermalToggle = false

				if LocalPlayer["state"]["Fps"] then
					SetTimecycleModifier("cinema")
				else
					ClearTimecycleModifier()
				end

				SpotlightToggle = false

				SetNightvision(true)
			end

			NightVisionToggle = not NightVisionToggle
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLESPOTLIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleSpotlight",function()
	if not IsPauseMenuActive() and (LocalPlayer["state"]["Police"] or LocalPlayer["state"]["Paramedic"]) then
		local Veh = GetVehiclePedIsIn(PlayerPedId())
		if vehCamera and CheckHeli() and IsHeliHighEnough(Veh) then
			if SpotlightToggle then

			else
				ThermalToggle = false

				if LocalPlayer["state"]["Fps"] then
					SetTimecycleModifier("cinema")
				else
					ClearTimecycleModifier()
				end

    			NightVisionToggle = false
				SetNightvision(false)
			end

			SpotlightToggle = not SpotlightToggle
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEHELICAMLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleHelicamLock",function()
	if not IsPauseMenuActive() and LocalPlayer["state"]["Police"] then
		local Veh = GetVehiclePedIsIn(PlayerPedId())
		if vehCamera and entity_detected and CheckHeli() and IsHeliHighEnough(Veh) then
			if DoesEntityExist(entity_detected) then
				if locked_on then
					locked_on = nil
					local rot = GetCamRot(cam,2)
					local fov = GetCamFov(cam)
					local old
					cam = cam
					DestroyCam(old_cam,false)
					cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
					AttachCamToEntity(cam,Veh,0.0,0.0,-1.5,true)
					SetCamRot(cam,rot,2)
					SetCamFov(cam,fov)
					RenderScriptCams(true,false,0,1,0)
				else
					locked_on = entity_detected
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLERAPPEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleRappel",function()
	if not IsPauseMenuActive() and LocalPlayer["state"]["Police"] then
		local Ped = PlayerPedId()
		local Veh = GetVehiclePedIsIn(Ped)
		if not vehCamera and CheckHeli() and IsHeliHighEnough(Veh) and (GetPedInVehicleSeat(Veh,1) == Ped or GetPedInVehicleSeat(Veh,2) == Ped) then
			TaskRappelFromHeli(Ped,1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("toggleHelicam","Ativar/Desativar câmera do helicóptero.","keyboard","6")
RegisterKeyMapping("toggleThermal","Ativar/Desativar câmera termal.","keyboard","7")
RegisterKeyMapping("toggleNightvision","Ativar/Desativar câmera de visão noturna.","keyboard","8")
RegisterKeyMapping("toggleSpotlight","Ativar/Desativar lanterna.","keyboard","9")
RegisterKeyMapping("toggleHelicamLock","Travar/Destravar câmera em veículos.","keyboard","SPACE")
RegisterKeyMapping("toggleRappel","Acionar rapel no helicóptero.","keyboard","X")