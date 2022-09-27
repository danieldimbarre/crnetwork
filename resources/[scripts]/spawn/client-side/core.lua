-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Peds = {}
local Camera = nil
local Destroy = false
local Character = true
-----------------------------------------------------------------------------------------------------------------------------------------
-- POORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Poords = {
	{ 233.85,-1387.59,29.55,136.07,"rcmbarry","base" },
	{ 235.15,-1388.42,29.55,113.39,"amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" },
	{ 232.75,-1386.38,29.55,160.92,"anim@amb@casino@hangout@ped_female@stand@02a@base","base" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Locate = {
	{ ["x"] = -2205.92, ["y"] = -370.48, ["z"] = 13.29, ["name"] = "Great Ocean", ["hash"] = 1 },
	{ ["x"] = -250.35, ["y"] = 6209.71, ["z"] = 31.49, ["name"] = "Duluoz Avenue", ["hash"] = 2 },
	{ ["x"] = 1694.37, ["y"] = 4794.66, ["z"] = 41.92, ["name"] = "Grapedseed Avenue", ["hash"] = 3 },
	{ ["x"] = 1858.94, ["y"] = 3741.78, ["z"] = 33.09, ["name"] = "Armadillo Avenue", ["hash"] = 4 },
	{ ["x"] = 328.0, ["y"] = 2617.89, ["z"] = 44.48, ["name"] = "Senora Road", ["hash"] = 5 },
	{ ["x"] = 308.33, ["y"] = -232.25, ["z"] = 54.07, ["name"] = "Hawick Avenue", ["hash"] = 6 },
	{ ["x"] = 449.71, ["y"] = -659.27, ["z"] = 28.48, ["name"] = "Integrity Way", ["hash"] = 7 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	DoScreenFadeOut(0)
	DisplayRadar(false)
	ShutdownLoadingScreen()
	ShutdownLoadingScreenNui()
	TriggerServerEvent("Queue:Connect")
	LocalPlayer["state"]["Invisible"] = true

	local Ped = PlayerPedId()
	SetEntityCoords(Ped,231.99,-1389.94,30.48,false,false,false,false)
	SetEntityVisible(Ped,false,false)
	FreezeEntityPosition(Ped,true)
	SetEntityInvincible(Ped,true)
	SetEntityHealth(Ped,100)
	SetPedArmour(Ped,0)

	local Characters = vSERVER.Characters()
	if parseInt(#Characters) > 0 then
		for Number,v in pairs(Characters) do
			if LoadModel(v["Skin"]) then
				Peds[Number] = CreatePed(4,v["Skin"],Poords[Number][1],Poords[Number][2],Poords[Number][3],Poords[Number][4],false,false)
				SetEntityInvincible(Peds[Number],true)
				FreezeEntityPosition(Peds[Number],true)
				SetBlockingOfNonTemporaryEvents(Peds[Number],true)
				SetModelAsNoLongerNeeded(v["Skin"])

				if LoadAnim(Poords[Number][5]) then
					TaskPlayAnim(Peds[Number],Poords[Number][5],Poords[Number][6],8.0,8.0,-1,1,0,0,0,0)
				end

				Clothes(Peds[Number],v["Clothes"])
				Barber(Peds[Number],v["Barber"])

				for Hash,Component in pairs(v["Tattoos"]) do
					SetPedDecoration(Peds[Number],GetHashKey(Component[1]),GetHashKey(Hash))
				end
			end
		end
	end

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	SetCamActive(Camera,true)
	RenderScriptCams(true,true,1,true,true)
	SetCamCoord(Camera,231.99,-1389.94,31.0)
	SetCamRot(Camera,0.0,0.0,320.25,2)

	SendNUIMessage({ Action = "Spawn", Table = Characters })
	SetNuiFocus(true,true)

	DoScreenFadeIn(1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CharacterChosen",function(Data,Callback)
	DoScreenFadeOut(0)

	Delete()

	vSERVER.CharacterChosen(Data["passport"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("NewCharacter",function(Data,Callback)
	vSERVER.NewCharacter(Data["name"],Data["name2"],Data["sex"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:JUSTSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:justSpawn")
AddEventHandler("spawn:justSpawn",function(Open,NewCharacter)
	if Camera then
		RenderScriptCams(false,false,0,true,true)
		SetCamActive(Camera,false)
		DestroyCam(Camera,true)
		Camera = nil
	end
	
	if NewCharacter then
		Character = not NewCharacter
	end

	if not Character then
		local Ped = PlayerPedId()
		if Open then
			Wait(2000)

			local Coords = GetEntityCoords(Ped)
			Camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",Coords["x"],Coords["y"],Coords["z"] + 200.0,270.00,0.0,0.0,80.0,0,0)
			SetCamActive(Camera,true)
			RenderScriptCams(true,false,1,true,true)

			SendNUIMessage({ Action = "Location", Table = Locate })
		else
			LocalPlayer["state"]["Invisible"] = false
			SetEntityVisible(Ped,true,false)
			TriggerEvent("hud:Active",true)
			SetNuiFocus(false,false)
			Destroy = false

			Wait(1000)
		end

		DoScreenFadeIn(1000)
	else
		TriggerServerEvent("creator:newCharacter")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:SPAWNCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:SpawnClose")
AddEventHandler("spawn:SpawnClose",function()
	Delete()

	SendNUIMessage({ Action = "SpawnClose" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Chosen",function(Data,Callback)
	local Ped = PlayerPedId()

	if Data["hash"] == "spawn" then
		DoScreenFadeOut(0)

		TriggerEvent("hud:Active",true)
		SetNuiFocus(false,false)

		LocalPlayer["state"]["Invisible"] = false
		RenderScriptCams(false,false,0,true,true)
		SetEntityVisible(Ped,true,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,true)
		Destroy = false
		Camera = nil

		Wait(1000)

		TriggerServerEvent("vRP:justObjects")
		DoScreenFadeIn(1000)
	else
		Destroy = false
		DoScreenFadeOut(0)

		Wait(1000)

		SetCamRot(Camera,270.0)
		SetCamActive(Camera,true)
		local speed = 0.7
		weight = 270.0
		Destroy = true

		DoScreenFadeIn(1000)

		SetEntityCoords(Ped,Locate[Data["hash"]]["x"],Locate[Data["hash"]]["y"],Locate[Data["hash"]]["z"],false,false,false,false)
		local Coords = GetEntityCoords(Ped)

		SetCamCoord(Camera,Coords["x"],Coords["y"],Coords["z"] + 200.0)
		local i = Coords["z"] + 200.0

		while i > Locate[Data["hash"]]["z"] + 1.5 do
			i = i - speed
			SetCamCoord(Camera,Coords["x"],Coords["y"],i)

			if i <= Locate[Data["hash"]]["z"] + 35.0 and weight < 360.0 then
				if speed - 0.0078 >= 0.05 then
					speed = speed - 0.0078
				end

				weight = weight + 0.75
				SetCamRot(Camera,weight)
			end

			if not Destroy then
				break
			end

			Wait(0)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function Delete()
	for _,v in pairs(Peds) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function Clothes(Ped,data)
	if not data["backpack"] then
		data["backpack"] = {}
		data["backpack"]["item"] = 0
		data["backpack"]["texture"] = 0
	end

	SetPedComponentVariation(Ped,4,data["pants"]["item"] or 0,data["pants"]["texture"] or 0,1)
	SetPedComponentVariation(Ped,3,data["arms"]["item"] or 0,data["arms"]["texture"] or 0,1)
	SetPedComponentVariation(Ped,5,data["backpack"]["item"] or 0,data["backpack"]["texture"] or 0,1)
	SetPedComponentVariation(Ped,8,data["tshirt"]["item"] or 0,data["tshirt"]["texture"] or 0,1)
	SetPedComponentVariation(Ped,9,data["vest"]["item"] or 0,data["vest"]["texture"] or 0,1)
	SetPedComponentVariation(Ped,11,data["torso"]["item"] or 0,data["torso"]["texture"] or 0,1)
	SetPedComponentVariation(Ped,6,data["shoes"]["item"] or 0,data["shoes"]["texture"] or 0,1)
	SetPedComponentVariation(Ped,1,data["mask"]["item"] or 0,data["mask"]["texture"] or 0,1)
	SetPedComponentVariation(Ped,10,data["decals"]["item"] or 0,data["decals"]["texture"] or 0,1)
	SetPedComponentVariation(Ped,7,data["accessory"]["item"] or 0,data["accessory"]["texture"] or 0,1)

	if data["hat"]["item"] ~= -1 and data["hat"]["item"] ~= 0 then
		SetPedPropIndex(Ped,0,data["hat"]["item"],data["hat"]["texture"],1)
	else
		ClearPedProp(Ped,0)
	end

	if data["glass"]["item"] ~= -1 and data["glass"]["item"] ~= 0 then
		SetPedPropIndex(Ped,1,data["glass"]["item"],data["glass"]["texture"],1)
	else
		ClearPedProp(Ped,1)
	end

	if data["ear"]["item"] ~= -1 and data["ear"]["item"] ~= 0 then
		SetPedPropIndex(Ped,2,data["ear"]["item"],data["ear"]["texture"],1)
	else
		ClearPedProp(Ped,2)
	end

	if data["watch"]["item"] ~= -1 and data["watch"]["item"] ~= 0 then
		SetPedPropIndex(Ped,6,data["watch"]["item"],data["watch"]["texture"],1)
	else
		ClearPedProp(Ped,6)
	end

	if data["bracelet"]["item"] ~= -1 and data["bracelet"]["item"] ~= 0 then
		SetPedPropIndex(Ped,7,data["bracelet"]["item"],data["bracelet"]["texture"],1)
	else
		ClearPedProp(Ped,7)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBER
-----------------------------------------------------------------------------------------------------------------------------------------
function Barber(Ped,status)
	myClothes = {}
	myClothes = { status[1] or 0, status[2] or 0, status[3] or 0, status[4] or 0, status[5] or 0, status[6] or 0, status[7] or 0, status[8] or 0, status[9] or 0, status[10] or 0, status[11] or 0, status[12] or 0, status[13] or 0, status[14] or 0, status[15] or 0, status[16] or 0, status[17] or 0, status[18] or 0, status[19] or 0, status[20] or 0, status[21] or 0, status[22] or 0, status[23] or 0, status[24] or 0, status[25] or 0, status[26] or 0, status[27] or 0, status[28] or 0, status[29] or 0, status[30] or 0, status[31] or 0, status[32] or 0, status[33] or 0, status[34] or 0, status[35] or 0, status[36] or 0, status[37] or 0, status[38] or 0, status[39] or 0, status[40] or 0, status[41] or 0 }

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
end