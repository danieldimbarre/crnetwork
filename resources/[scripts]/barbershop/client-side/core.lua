-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local myClothes = { 0,100,0,100,0,0,0,0,0,0,0,-1,5,-1,-1,5,0,0,0,0,-1,5,0,-1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21 }
local mySkin = { 0,100,0,100,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(Data,Callback)
	myClothes = {}
	myClothes = { mySkin[1],mySkin[2],mySkin[3],mySkin[4],mySkin[5],mySkin[6],mySkin[7],mySkin[8],tonumber(Data["hair"]),tonumber(Data["haircolor"]),tonumber(Data["haircolor2"]),tonumber(Data["makeup"]),tonumber(Data["makeupintensity"]),tonumber(Data["makeupcolor"]),tonumber(Data["lipstick"]),tonumber(Data["lipstickintensity"]),tonumber(Data["lipstickcolor"]),tonumber(Data["eyebrow"]),tonumber(Data["eyebrowintensity"]),tonumber(Data["eyebrowcolor"]),tonumber(Data["beard"]),tonumber(Data["beardintensity"]),tonumber(Data["beardcolor"]),tonumber(Data["blush"]),tonumber(Data["blushintensity"]),tonumber(Data["blushcolor"]),mySkin[9],mySkin[10],mySkin[11],mySkin[12],mySkin[13],mySkin[14],mySkin[15],mySkin[16],mySkin[17],mySkin[18],mySkin[19],mySkin[20],mySkin[21],mySkin[22],mySkin[23] }

	if Data["value"] then
		OpenBarbershop(false)
		SetNuiFocus(false,false)
		vRP.stopAnim(false)
		vSERVER.updateSkin(myClothes)
		SendNUIMessage({ openBarbershop = false })
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
	local heading = GetEntityHeading(Ped)
	if Data == "left" then
		SetEntityHeading(Ped,heading + 10)
	elseif Data == "right" then
		SetEntityHeading(Ped,heading - 10)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Apply")
AddEventHandler("barbershop:Apply",function(status)
	myClothes = {}
	myClothes = { status[1] or 0, status[2] or 100, status[3] or 0, status[4] or 100, status[5] or 0, status[6] or 0, status[7] or 0, status[8] or 0, status[9] or 0, status[10] or 0, status[11] or 0, status[12] or -1, status[13] or 5, status[14] or -1, status[15] or -1, status[16] or 5, status[17] or 0, status[18] or -1, status[19] or 0, status[20] or 0, status[21] or -1, status[22] or 5, status[23] or 0, status[24] or -1, status[25] or 5, status[26] or 0, status[27] or 0, status[28] or 0, status[29] or 0, status[30] or 0, status[31] or 0, status[32] or 0, status[33] or 0, status[34] or 0, status[35] or 0, status[36] or 0, status[37] or 0, status[38] or 0, status[39] or 0, status[40] or 0, status[41] or 21 }

	mySkin = {}
	mySkin = { status[1] or 0, status[2] or 100, status[3] or 0, status[4] or 100, status[5] or 0, status[6] or 0, status[7] or 0, status[8] or 0,status[27] or 0, status[28] or 0, status[29] or 0, status[30] or 0, status[31] or 0, status[32] or 0, status[33] or 0, status[34] or 0, status[35] or 0, status[36] or 0, status[37] or 0, status[38] or 0, status[39] or 0, status[40] or 0, status[41] or 21 }

	local Ped = PlayerPedId()

    local weightFace = myClothes[2] / 100 + 0.0
    local weightSkin = myClothes[4] / 100 + 0.0

	SetPedHeadBlendData(Ped,myClothes[41],myClothes[1],0,myClothes[41],myClothes[1],0,weightFace,weightSkin,0.0,false)

	SetPedEyeColor(Ped,myClothes[3])

	if myClothes[5] == 0 then
		SetPedHeadOverlay(Ped,0,myClothes[5],0.0)
	else
		SetPedHeadOverlay(Ped,0,myClothes[5],1.0)
	end

	SetPedHeadOverlay(Ped,6,myClothes[6],1.0)

	if myClothes[7] == 0 then
		SetPedHeadOverlay(Ped,9,myClothes[7],0.0)
	else
		SetPedHeadOverlay(Ped,9,myClothes[7],1.0)
	end

	SetPedHeadOverlay(Ped,3,myClothes[8],1.0)

	SetPedComponentVariation(Ped,2,myClothes[9],0,1)
	SetPedHairColor(Ped,myClothes[10],myClothes[11])

	SetPedHeadOverlay(Ped,4,myClothes[12],myClothes[13] * 0.1)
	if myClothes[14] == -1 then
        SetPedHeadOverlayColor(Ped,4,0,0,0)
    else
	    SetPedHeadOverlayColor(Ped,4,2,myClothes[14],myClothes[14])
    end

	SetPedHeadOverlay(Ped,8,myClothes[15],myClothes[16] * 0.1)
	SetPedHeadOverlayColor(Ped,8,1,myClothes[17],myClothes[17])

	SetPedHeadOverlay(Ped,2,myClothes[18],myClothes[19] * 0.1)
	SetPedHeadOverlayColor(Ped,2,1,myClothes[20],myClothes[20])

	SetPedHeadOverlay(Ped,1,myClothes[21],myClothes[22] * 0.1)
	SetPedHeadOverlayColor(Ped,1,1,myClothes[23],myClothes[23])

	SetPedHeadOverlay(Ped,5,myClothes[24],myClothes[25] * 0.1)
	SetPedHeadOverlayColor(Ped,5,1,myClothes[26],myClothes[26])

	SetPedFaceFeature(Ped,0,myClothes[27] * 0.1)
	SetPedFaceFeature(Ped,1,myClothes[28] * 0.1)
	SetPedFaceFeature(Ped,4,myClothes[29] * 0.1)
	SetPedFaceFeature(Ped,6,myClothes[30] * 0.1)
	SetPedFaceFeature(Ped,8,myClothes[31] * 0.1)
	SetPedFaceFeature(Ped,9,myClothes[32] * 0.1)
	SetPedFaceFeature(Ped,10,myClothes[33] * 0.1)
	SetPedFaceFeature(Ped,12,myClothes[34] * 0.1)
	SetPedFaceFeature(Ped,13,myClothes[35] * 0.1)
	SetPedFaceFeature(Ped,14,myClothes[36] * 0.1)
	SetPedFaceFeature(Ped,15,myClothes[37] * 0.1)
	SetPedFaceFeature(Ped,16,myClothes[38] * 0.1)
	SetPedFaceFeature(Ped,17,myClothes[39] * 0.1)
	SetPedFaceFeature(Ped,19,myClothes[40] * 0.1)

	TriggerEvent("creator:updateFace",myClothes)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function OpenBarbershop(Enabled)
	local Ped = PlayerPedId()

	if Enabled then
		vRP.playAnim(true,{"mp_sleep","bind_pose_180"},true)
		vRP.playAnim(true,{"missfam5_yoga","a2_pose"},true)

		SetFollowPedCamViewMode(0)
		SetNuiFocus(true,true)
		SendNUIMessage({ openBarbershop = true,hair = myClothes[9],haircolor = myClothes[10],haircolor2 = myClothes[11],eyebrow = myClothes[18],eyebrowintensity = myClothes[19],eyebrowcolor = myClothes[20],beard = myClothes[21],beardintensity = myClothes[22],beardcolor = myClothes[23],blush = myClothes[24],blushintensity = myClothes[25],blushcolor = myClothes[26],lipstick = myClothes[15],lipstickintensity = myClothes[16],lipstickcolor = myClothes[17],makeup = myClothes[12],makeupintensity = myClothes[13],makeupcolor = myClothes[14],maxHair = GetNumberOfPedDrawableVariations(Ped,2)-1,maxHaircolors = GetNumHairColors()-1,maxMakeupcolor = GetNumMakeupColors()-1,maxBeard = GetPedHeadOverlayNum(1)-1,maxEyebrow = GetPedHeadOverlayNum(2)-1,maxMakeup = GetPedHeadOverlayNum(4)-1,maxBlush = GetPedHeadOverlayNum(5)-1,maxLipstick = GetPedHeadOverlayNum(8)-1 })

		if IsDisabledControlJustReleased(0,24) or IsDisabledControlJustReleased(0,142) then
			SendNUIMessage({ type = "click" })
		end

		SetPlayerInvincible(Ped,true)

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

		local Coords = GetEntityCoords(Ped)
		SetCamCoord(cam,Coords["x"] + 0.2,Coords["y"] + 0.5,Coords["z"] + 0.7)
		SetCamRot(cam,0.0,0.0,150.0)
	else
		RenderScriptCams(false,false,0,1,0)
		SetPlayerInvincible(Ped,false)
		DestroyCam(cam,false)

		vRP.removeObjects()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local Locations = {
	{ -813.37,-183.85,37.57 },
	{ 138.13,-1706.46,29.3 },
	{ -1280.92,-1117.07,7.0 },
	{ 1930.54,3732.06,32.85 },
	{ 1214.2,-473.18,66.21 },
	{ -33.61,-154.52,57.08 },
	{ -276.65,6226.76,31.7 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Table = {}

	for _,v in pairs(Locations) do
		table.insert(Table,{ v[1],v[2],v[3],2.5,"E","Barbearia","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:Insert",Table)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for _,v in pairs(Locations) do
					local Distance = #(Coords - vec3(v[1],v[2],v[3]))
					if Distance <= 2.5 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) and vSERVER.CheckWanted() then
							TriggerServerEvent("vRP:BucketClient","Enter")
							OpenBarbershop(true)
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncarea")
AddEventHandler("syncarea",function(x,y,z,Distance)
	ClearAreaOfVehicles(x,y,z,Distance + 0.0,false,false,false,false,false)
	ClearAreaOfEverything(x,y,z,Distance + 0.0,false,false,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("barbershop:Open")
AddEventHandler("barbershop:Open",function()
	TriggerServerEvent("vRP:BucketClient","Enter")
	OpenBarbershop(true)
end)