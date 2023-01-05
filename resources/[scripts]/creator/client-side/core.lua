-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vBARBERSHOP = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local Change = nil
local myClothes = { 0,100,0,100,0,0,0,0,0,0,0,-1,5,-1,-1,5,0,0,0,0,-1,5,0,-1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(Data,Callback)
	myClothes = { tonumber(Data["fathers"]),tonumber(Data["kinship"]),tonumber(Data["eyecolor"]),tonumber(Data["skincolor"]),tonumber(Data["acne"]),tonumber(Data["stains"]),tonumber(Data["freckles"]),tonumber(Data["aging"]),tonumber(Data["hair"]),tonumber(Data["haircolor"]),tonumber(Data["haircolor2"]),tonumber(Data["makeup"]),tonumber(Data["makeupintensity"]),tonumber(Data["makeupcolor"]),tonumber(Data["lipstick"]),tonumber(Data["lipstickintensity"]),tonumber(Data["lipstickcolor"]),tonumber(Data["eyebrow"]),tonumber(Data["eyebrowintensity"]),tonumber(Data["eyebrowcolor"]),tonumber(Data["beard"]),tonumber(Data["beardintensity"]),tonumber(Data["beardcolor"]),tonumber(Data["blush"]),tonumber(Data["blushintensity"]),tonumber(Data["blushcolor"]),tonumber(Data["face00"]),tonumber(Data["face01"]),tonumber(Data["face04"]),tonumber(Data["face06"]),tonumber(Data["face08"]),tonumber(Data["face09"]),tonumber(Data["face10"]),tonumber(Data["face12"]),tonumber(Data["face13"]),tonumber(Data["face14"]),tonumber(Data["face15"]),tonumber(Data["face16"]),tonumber(Data["face17"]),tonumber(Data["face19"]),tonumber(Data["mothers"]) }

	if Data["value"] then
		OpenCreator(false)
		SetNuiFocus(false,false)
		vBARBERSHOP.updateSkin(myClothes,true)
		SendNUIMessage({ Open = false })
		TriggerEvent("skinshop:updateTattoo")
		TriggerServerEvent("vRP:BucketClient","Exit")
	end

	TriggerEvent("barbershop:Apply",myClothes)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotate",function(Data,Callback)
	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	if Data == "left" then
		SetEntityHeading(Ped,Heading + 10)
	else
		SetEntityHeading(Ped,Heading - 10)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCREATOR
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenCreator(enable,Options)
	local Ped = PlayerPedId()

	if enable then
		if Options then
			Change = GetEntityCoords(Ped)
		end

		vRP.playAnim(true,{"mp_sleep","bind_pose_180"},true)
		TriggerServerEvent("vRP:BucketClient","Enter")

		SetEntityCoords(Ped,239.41,-1381.01,33.73 - 1,0,0,1)
		SetEntityHeading(Ped,136.07)

		SetFollowPedCamViewMode(0)
		SetNuiFocus(true,true)
		SendNUIMessage({ Open = true, maxHair = GetNumberOfPedDrawableVariations(Ped,2)-1, maxHaircolors = GetNumHairColors()-1, maxMakeupcolor = GetNumMakeupColors()-1, maxBeard = GetPedHeadOverlayNum(1)-1, maxEyebrow = GetPedHeadOverlayNum(2)-1, maxMakeup = GetPedHeadOverlayNum(4)-1, maxBlush = GetPedHeadOverlayNum(5)-1, maxLipstick = GetPedHeadOverlayNum(8)-1, fathers = myClothes[1], mothers = myClothes[41], kinship = myClothes[2], eyecolor = myClothes[3], skincolor = myClothes[4], acne = myClothes[5], stains = myClothes[6], freckles = myClothes[7], aging = myClothes[8], hair = myClothes[9], haircolor = myClothes[10], haircolor2 = myClothes[11], makeup = myClothes[12], makeupintensity = myClothes[13], makeupcolor = myClothes[14], lipstick = myClothes[15], lipstickintensity = myClothes[16], lipstickcolor = myClothes[17], eyebrow = myClothes[18], eyebrowintensity = myClothes[19], eyebrowcolor = myClothes[20], beard = myClothes[21], beardintensity = myClothes[22], beardcolor = myClothes[23], blush = myClothes[24], blushintensity = myClothes[25], blushcolor = myClothes[26], face00 = myClothes[27], face01 = myClothes[28], face04 = myClothes[29], face06 = myClothes[30], face08 = myClothes[31], face09 = myClothes[32], face10 = myClothes[33], face12 = myClothes[34], face13 = myClothes[35], face14 = myClothes[36], face15 = myClothes[37], face16 = myClothes[38], face17 = myClothes[39], face19 = myClothes[40] })

		if IsDisabledControlJustReleased(0,24) or IsDisabledControlJustReleased(0,142) then
			SendNUIMessage({ type = "click" })
		end
		
		SetPlayerInvincible(Ped,true)

		if not DoesCamExist(cam) then
			cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
			SetCamCoord(cam,GetEntityCoords(Ped))
			SetCamRot(cam,0.0,0.0,0.0)
			SetCamActive(cam,true)
			RenderScriptCams(true,false,0,true,true)
			SetCamCoord(cam,GetEntityCoords(Ped))
		end

		local Coords = GetEntityCoords(Ped)
		local CamCoords = GetOffsetFromEntityInWorldCoords(Ped,0.0,0.5,0.0)
		SetCamCoord(cam,CamCoords["x"],CamCoords["y"],CamCoords["z"] + 0.7)
		PointCamAtCoord(cam,Coords["x"],Coords["y"],Coords["z"] + 0.7)

		defaultCharacter()
	else
		RenderScriptCams(false,false,0,1,0)
		SetPlayerInvincible(Ped,false)
		DestroyCam(cam,false)

		vRP.removeObjects()

		if Change then
			SetEntityCoords(Ped,Change,0,0,1)
			Change = false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFAULTCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function defaultCharacter()
    local Ped = PlayerPedId()

    if GetEntityModel(Ped) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(Ped,1,-1,0,1)
		SetPedComponentVariation(Ped,3,15,0,1)
		SetPedComponentVariation(Ped,4,61,0,1)
		SetPedComponentVariation(Ped,5,-1,0,1)
		SetPedComponentVariation(Ped,6,34,0,1)
		SetPedComponentVariation(Ped,7,-1,0,1)
		SetPedComponentVariation(Ped,8,15,0,1)
		SetPedComponentVariation(Ped,9,-1,0,1)
		SetPedComponentVariation(Ped,10,-1,0,1)
		SetPedComponentVariation(Ped,11,15,0,1)
    else
        SetPedComponentVariation(Ped,1,-1,0,1)
		SetPedComponentVariation(Ped,3,15,0,1)
		SetPedComponentVariation(Ped,4,17,0,1)
		SetPedComponentVariation(Ped,5,-1,0,1)
		SetPedComponentVariation(Ped,6,35,0,1)
		SetPedComponentVariation(Ped,7,-1,0,1)
		SetPedComponentVariation(Ped,8,7,0,1)
		SetPedComponentVariation(Ped,9,-1,0,1)
		SetPedComponentVariation(Ped,10,-1,0,1)
		SetPedComponentVariation(Ped,11,18,0,1)
    end

	ClearAllPedProps(Ped)

	TriggerEvent("barbershop:Apply",myClothes)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Open")
AddEventHandler("barbershop:Open",function(Item)
	OpenCreator(true,Item)
end)