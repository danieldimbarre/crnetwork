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
local cam = -1
local myFace = { 0,100,0,100,0,0,0,0,0,0,0,-1,5,-1,-1,5,0,0,0,0,-1,5,0,-1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(data)
	myFace = {}
	myFace = { tonumber(data["fathers"]),tonumber(data["kinship"]),tonumber(data["eyecolor"]),tonumber(data["skincolor"]),tonumber(data["acne"]),tonumber(data["stains"]),tonumber(data["freckles"]),tonumber(data["aging"]),tonumber(data["hair"]),tonumber(data["haircolor"]),tonumber(data["haircolor2"]),tonumber(data["makeup"]),tonumber(data["makeupintensity"]),tonumber(data["makeupcolor"]),tonumber(data["lipstick"]),tonumber(data["lipstickintensity"]),tonumber(data["lipstickcolor"]),tonumber(data["eyebrow"]),tonumber(data["eyebrowintensity"]),tonumber(data["eyebrowcolor"]),tonumber(data["beard"]),tonumber(data["beardintentisy"]),tonumber(data["beardcolor"]),tonumber(data["blush"]),tonumber(data["blushintentisy"]),tonumber(data["blushcolor"]),tonumber(data["face00"]),tonumber(data["face01"]),tonumber(data["face04"]),tonumber(data["face06"]),tonumber(data["face08"]),tonumber(data["face09"]),tonumber(data["face10"]),tonumber(data["face12"]),tonumber(data["face13"]),tonumber(data["face14"]),tonumber(data["face15"]),tonumber(data["face16"]),tonumber(data["face17"]),tonumber(data["face19"]),tonumber(data["mothers"]) }

	if data["value"] then
		SetNuiFocus(false)
		displayCreator(false)
		SendNUIMessage({ openCreator = false })

		local Ped = PlayerPedId()
		SetEntityVisible(Ped,false,false)
    	vRP.stopAnim(false)

		vSERVER.updateFace(myFace)
		TriggerEvent("skinshop:updateTattoo")
	end

	TriggerEvent("barbershop:Apply",myFace)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotate",function(data,cb)
	local Ped = PlayerPedId()
	local heading = GetEntityHeading(Ped)
	if data == "left" then
		SetEntityHeading(Ped,heading + 10)
	elseif data == "right" then
		SetEntityHeading(Ped,heading - 10)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYCREATOR
-----------------------------------------------------------------------------------------------------------------------------------------
function displayCreator(enable)
	local Ped = PlayerPedId()

	if enable then
		SetEntityCoords(Ped,239.31,-1381.13,33.73,0,0,1)
		SetEntityHeading(Ped,147.41)
		SetFollowPedCamViewMode(0)
		SetNuiFocus(true,true)
		SendNUIMessage({ openCreator = true, maxHair = GetNumberOfPedDrawableVariations(Ped,2)-1, maxHaircolors = GetNumHairColors()-1, maxMakeupcolor = GetNumMakeupColors()-1, maxBeard = GetPedHeadOverlayNum(1)-1, maxEyebrow = GetPedHeadOverlayNum(2)-1, maxMakeup = GetPedHeadOverlayNum(4)-1, maxBlush = GetPedHeadOverlayNum(5)-1, maxLipstick = GetPedHeadOverlayNum(8)-1, fathers = myFace[1], mothers = myFace[41], kinship = myFace[2], eyecolor = myFace[3], skincolor = myFace[4], acne = myFace[5], stains = myFace[6], freckles = myFace[7], aging = myFace[8], hair = myFace[9], haircolor = myFace[10], haircolor2 = myFace[11], makeup = myFace[12], makeupintensity = myFace[13], makeupcolor = myFace[14], lipstick = myFace[15], lipstickintensity = myFace[16], lipstickcolor = myFace[17], eyebrow = myFace[18], eyebrowintensity = myFace[19], eyebrowcolor = myFace[20], beard = myFace[21], beardintensity = myFace[22], beardcolor = myFace[23], blush = myFace[24], blushintensity = myFace[25], blushcolor = myFace[26], face00 = myFace[27], face01 = myFace[28], face04 = myFace[29], face06 = myFace[30], face08 = myFace[31], face09 = myFace[32], face10 = myFace[33], face12 = myFace[34], face13 = myFace[35], face14 = myFace[36], face15 = myFace[37], face16 = myFace[38], face17 = myFace[39], face19 = myFace[40] })

		if IsDisabledControlJustReleased(0,24) or IsDisabledControlJustReleased(0,142) then
			SendNUIMessage({ type = "click" })
		end

		SetEntityVisible(Ped,true,false)
		vRP.playAnim(false,{ "mp_sleep","bind_pose_180" },true)
		
		local Coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,0.4,0)
		RenderScriptCams(false,false,0,1,0)
		DestroyCam(cam,false)

		if not DoesCamExist(cam) then
			cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
			SetCamActive(cam,true)
			RenderScriptCams(true,false,0,true,true)
			SetCamCoord(cam,Coords["x"],Coords["y"],Coords["z"] + 0.7)
			SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId()) + 180)
		end

		defaultCharacter()

		DoScreenFadeIn(1000)
	else
		DoScreenFadeOut(0)

		RenderScriptCams(false,false,0,1,0)
		DestroyCam(cam,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFAULTCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function defaultCharacter()
    local Ped = PlayerPedId()

    if GetEntityModel(Ped) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(Ped,1,-1,0,2)
        SetPedComponentVariation(Ped,5,-1,0,2)
        SetPedComponentVariation(Ped,7,-1,0,2)
        SetPedComponentVariation(Ped,3,15,0,2)
        SetPedComponentVariation(Ped,4,61,0,2)
        SetPedComponentVariation(Ped,8,15,0,2)
        SetPedComponentVariation(Ped,6,16,0,2)
        SetPedComponentVariation(Ped,11,15,0,2)
        SetPedComponentVariation(Ped,9,-1,0,2)
        SetPedComponentVariation(Ped,10,-1,0,2)
        SetPedPropIndex(Ped,2,-1,0,2)
        SetPedPropIndex(Ped,6,-1,0,2)
        SetPedPropIndex(Ped,7,-1,0,2)
    else
        SetPedComponentVariation(Ped,1,-1,0,2)
        SetPedComponentVariation(Ped,5,-1,0,2)
        SetPedComponentVariation(Ped,7,-1,0,2)
        SetPedComponentVariation(Ped,3,15,0,2)
        SetPedComponentVariation(Ped,4,57,0,2)
        SetPedComponentVariation(Ped,8,15,0,2)
        SetPedComponentVariation(Ped,6,5,0,2)
        SetPedComponentVariation(Ped,11,105,0,2)
        SetPedComponentVariation(Ped,9,-1,0,2)
        SetPedComponentVariation(Ped,10,-1,0,2)
        SetPedPropIndex(Ped,2,-1,0,2)
        SetPedPropIndex(Ped,6,-1,0,2)
        SetPedPropIndex(Ped,7,-1,0,2)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false)
	SendNUIMessage({ openCreator = false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYCREATOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("creator:displayCreator")
AddEventHandler("creator:displayCreator",function(status)
	displayCreator(status)
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEFACE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("creator:updateFace")
AddEventHandler("creator:updateFace",function(status)
	myFace = {}
	myFace = status
end) 