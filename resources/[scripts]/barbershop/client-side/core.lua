-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local myClothes = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(Data,Callback)
	myClothes = {}
	myClothes = { tonumber(Data["fathers"]),tonumber(Data["kinship"]),tonumber(Data["eyecolor"]),tonumber(Data["skincolor"]),tonumber(Data["acne"]),tonumber(Data["stains"]),tonumber(Data["freckles"]),tonumber(Data["aging"]),tonumber(Data["hair"]),tonumber(Data["haircolor"]),tonumber(Data["haircolor2"]),tonumber(Data["makeup"]),tonumber(Data["makeupintensity"]),tonumber(Data["makeupcolor"]),tonumber(Data["lipstick"]),tonumber(Data["lipstickintensity"]),tonumber(Data["lipstickcolor"]),tonumber(Data["eyebrow"]),tonumber(Data["eyebrowintensity"]),tonumber(Data["eyebrowcolor"]),tonumber(Data["beard"]),tonumber(Data["beardintentisy"]),tonumber(Data["beardcolor"]),tonumber(Data["blush"]),tonumber(Data["blushintentisy"]),tonumber(Data["blushcolor"]),tonumber(Data["face00"]),tonumber(Data["face01"]),tonumber(Data["face04"]),tonumber(Data["face06"]),tonumber(Data["face08"]),tonumber(Data["face09"]),tonumber(Data["face10"]),tonumber(Data["face12"]),tonumber(Data["face13"]),tonumber(Data["face14"]),tonumber(Data["face15"]),tonumber(Data["face16"]),tonumber(Data["face17"]),tonumber(Data["face19"]),tonumber(Data["mothers"]) }

	if Data["value"] then
		SetNuiFocus(false,false)
		displayBarbershop(false)
		vSERVER.updateSkin(myClothes)
		SendNUIMessage({ openBarbershop = false })
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
	myClothes = { status[1] or 0, status[2] or 0, status[3] or 0, status[4] or 0, status[5] or 0, status[6] or 0, status[7] or 0, status[8] or 0, status[9] or 0, status[10] or 0, status[11] or 0, status[12] or 0, status[13] or 0, status[14] or 0, status[15] or 0, status[16] or 0, status[17] or 0, status[18] or 0, status[19] or 0, status[20] or 0, status[21] or 0, status[22] or 0, status[23] or 0, status[24] or 0, status[25] or 0, status[26] or 0, status[27] or 0, status[28] or 0, status[29] or 0, status[30] or 0, status[31] or 0, status[32] or 0, status[33] or 0, status[34] or 0, status[35] or 0, status[36] or 0, status[37] or 0, status[38] or 0, status[39] or 0, status[40] or 0, status[41] or 0 }

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
	SetPedHeadOverlayColor(Ped,4,1,myClothes[14],myClothes[14])

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
-- DISPLAYBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function displayBarbershop(enable)
	local Ped = PlayerPedId()

	if enable then
		SetEntityHeading(PlayerPedId(),332.21)
		SetFollowPedCamViewMode(0)
		SetNuiFocus(true,true)
		SendNUIMessage({ openBarbershop = true, maxHair = GetNumberOfPedDrawableVariations(Ped,2) - 1, fathers = myClothes[1], mothers = myClothes[41], kinship = myClothes[2], eyecolor = myClothes[3], skincolor = myClothes[4], acne = myClothes[5], stains = myClothes[6], freckles = myClothes[7], aging = myClothes[8], hair = myClothes[9], haircolor = myClothes[10], haircolor2 = myClothes[11], makeup = myClothes[12], makeupintensity = myClothes[13], makeupcolor = myClothes[14], lipstick = myClothes[15], lipstickintensity = myClothes[16], lipstickcolor = myClothes[17], eyebrow = myClothes[18], eyebrowintensity = myClothes[19], eyebrowcolor = myClothes[20], beard = myClothes[21], beardintentisy = myClothes[22], beardcolor = myClothes[23], blush = myClothes[24], blushintentisy = myClothes[25], blushcolor = myClothes[26], face00 = myClothes[27], face01 = myClothes[28], face04 = myClothes[29], face06 = myClothes[30], face08 = myClothes[31], face09 = myClothes[32], face10 = myClothes[33], face12 = myClothes[34], face13 = myClothes[35], face14 = myClothes[36], face15 = myClothes[37], face16 = myClothes[38], face17 = myClothes[39], face19 = myClothes[40] })

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

		local x,y,z = table.unpack(GetEntityCoords(Ped))
		SetCamCoord(cam,x + 0.2,y + 0.5,z + 0.7)
		SetCamRot(cam,0.0,0.0,150.0)
	else
		SetPlayerInvincible(Ped,false)
		RenderScriptCams(false,false,0,1,0)
		DestroyCam(cam,false)
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
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if Resource ~= GetCurrentResourceName() then
		return
	end

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

						if IsControlJustPressed(1,38) and vSERVER.checkShares() then
							displayBarbershop(true)
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