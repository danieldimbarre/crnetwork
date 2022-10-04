-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("creator")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Cam = -1
local myFace = { 0,100,0,100,0,0,0,0,0,0,0,-1,5,-1,-1,5,0,0,0,0,-1,5,0,-1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(Data,Callback)
	myFace = {}
	myFace = { tonumber(Data["fathers"]),tonumber(Data["kinship"]),tonumber(Data["eyecolor"]),tonumber(Data["skincolor"]),tonumber(Data["acne"]),tonumber(Data["stains"]),tonumber(Data["freckles"]),tonumber(Data["aging"]),tonumber(Data["hair"]),tonumber(Data["haircolor"]),tonumber(Data["haircolor2"]),tonumber(Data["makeup"]),tonumber(Data["makeupintensity"]),tonumber(Data["makeupcolor"]),tonumber(Data["lipstick"]),tonumber(Data["lipstickintensity"]),tonumber(Data["lipstickcolor"]),tonumber(Data["eyebrow"]),tonumber(Data["eyebrowintensity"]),tonumber(Data["eyebrowcolor"]),tonumber(Data["beard"]),tonumber(Data["beardintentisy"]),tonumber(Data["beardcolor"]),tonumber(Data["blush"]),tonumber(Data["blushintentisy"]),tonumber(Data["blushcolor"]),tonumber(Data["face00"]),tonumber(Data["face01"]),tonumber(Data["face04"]),tonumber(Data["face06"]),tonumber(Data["face08"]),tonumber(Data["face09"]),tonumber(Data["face10"]),tonumber(Data["face12"]),tonumber(Data["face13"]),tonumber(Data["face14"]),tonumber(Data["face15"]),tonumber(Data["face16"]),tonumber(Data["face17"]),tonumber(Data["face19"]),tonumber(Data["mothers"]) }

	if Data["value"] then
		SetNuiFocus(false,false)
		displayCreator(false)
		SendNUIMessage({ openCreator = false })

    	vRP.stopAnim(false)

		vSERVER.updateFace(myFace)
		TriggerEvent("skinshop:updateTattoo")
	end

	TriggerEvent("barbershop:Apply",myFace)

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
	elseif Data == "right" then
		SetEntityHeading(Ped,Heading - 10)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYCREATOR
-----------------------------------------------------------------------------------------------------------------------------------------
function displayCreator(enable)
	local Ped = PlayerPedId()

	if enable then
		SetEntityCoords(Ped,239.41,-1381.01,33.73 - 1,0,0,1)
		SetEntityHeading(Ped,136.07)
		SetFollowPedCamViewMode(0)
		SetNuiFocus(true,true)
		SendNUIMessage({ openCreator = true, maxHair = GetNumberOfPedDrawableVariations(Ped,2)-1, maxHaircolors = GetNumHairColors()-1, maxMakeupcolor = GetNumMakeupColors()-1, maxBeard = GetPedHeadOverlayNum(1)-1, maxEyebrow = GetPedHeadOverlayNum(2)-1, maxMakeup = GetPedHeadOverlayNum(4)-1, maxBlush = GetPedHeadOverlayNum(5)-1, maxLipstick = GetPedHeadOverlayNum(8)-1, fathers = myFace[1], mothers = myFace[41], kinship = myFace[2], eyecolor = myFace[3], skincolor = myFace[4], acne = myFace[5], stains = myFace[6], freckles = myFace[7], aging = myFace[8], hair = myFace[9], haircolor = myFace[10], haircolor2 = myFace[11], makeup = myFace[12], makeupintensity = myFace[13], makeupcolor = myFace[14], lipstick = myFace[15], lipstickintensity = myFace[16], lipstickcolor = myFace[17], eyebrow = myFace[18], eyebrowintensity = myFace[19], eyebrowcolor = myFace[20], beard = myFace[21], beardintensity = myFace[22], beardcolor = myFace[23], blush = myFace[24], blushintensity = myFace[25], blushcolor = myFace[26], face00 = myFace[27], face01 = myFace[28], face04 = myFace[29], face06 = myFace[30], face08 = myFace[31], face09 = myFace[32], face10 = myFace[33], face12 = myFace[34], face13 = myFace[35], face14 = myFace[36], face15 = myFace[37], face16 = myFace[38], face17 = myFace[39], face19 = myFace[40] })

		if IsDisabledControlJustReleased(0,24) or IsDisabledControlJustReleased(0,142) then
			SendNUIMessage({ type = "click" })
		end

		vRP.playAnim(false,{ "mp_sleep","bind_pose_180" },true)
		
		local Coords = GetOffsetFromEntityInWorldCoords(Ped,0,0.4,0)
		RenderScriptCams(false,false,0,1,0)
		DestroyCam(Cam,false)

		if not DoesCamExist(Cam) then
			Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
			SetCamActive(Cam,true)
			RenderScriptCams(true,false,0,true,true)
			SetCamCoord(Cam,Coords["x"],Coords["y"],Coords["z"] + 0.7)
			SetCamRot(Cam,0.0,0.0,GetEntityHeading(Ped) + 180)
		end

		defaultCharacter()
	else
		RenderScriptCams(false,false,0,1,0)
		DestroyCam(Cam,false)
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
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("creator:Open")
AddEventHandler("creator:Open",function()
	displayCreator(true)
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEFACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("creator:updateFace")
AddEventHandler("creator:updateFace",function(status)
	myFace = {}
	myFace = status
end) 