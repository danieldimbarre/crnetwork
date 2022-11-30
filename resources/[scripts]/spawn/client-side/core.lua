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
-- SPAWN:OPENED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("spawn:Opened",function()
	DoScreenFadeIn(0)
	DisplayRadar(false)
	ShutdownLoadingScreen()
	ShutdownLoadingScreenNui()
	TriggerServerEvent("Queue:Connect")

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
			if v["Skin"] == nil then
				v["Skin"] = "mp_m_freemode_01"
			end

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
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CharacterChosen",function(Data,Callback)
	for _,v in pairs(Peds) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end
	end

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
-- JUSTSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:justSpawn")
AddEventHandler("spawn:justSpawn",function(Open,Barbershop)
	local Ped = PlayerPedId()
	RenderScriptCams(false,false,0,true,true)
	SetCamActive(Camera,false)
	DestroyCam(Camera,true)
	Camera = nil

	if Open then
		local Coords = GetEntityCoords(Ped)
		Camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",Coords["x"],Coords["y"],Coords["z"] + 200.0,270.00,0.0,0.0,80.0,0,0)
		SetCamActive(Camera,true)
		RenderScriptCams(true,false,1,true,true)

		SendNUIMessage({ Action = "Location", Table = Locate })
	else
		SetEntityVisible(Ped,true,false)
		TriggerEvent("hud:Active",true)
		SetNuiFocus(false,false)
		Destroy = false

		if Barbershop then
			Wait(1000)
			TriggerEvent("barbershop:Open")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Close")
AddEventHandler("spawn:Close",function()
	SendNUIMessage({ Action = "Close", Table = Locate })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Chosen",function(Data,Callback)
	local Ped = PlayerPedId()

	if Data["hash"] == "spawn" then
		TriggerEvent("hud:Active",true)
		SetNuiFocus(false,false)

		RenderScriptCams(false,false,0,true,true)
		SetEntityVisible(Ped,true,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,true)
		Destroy = false
		Camera = nil

		Wait(1000)

		TriggerServerEvent("vRP:justObjects")
	else
		Destroy = false

		Wait(1000)

		SetCamRot(Camera,270.0)
		SetCamActive(Camera,true)
		local speed = 0.7
		weight = 270.0
		Destroy = true

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
-- DATASET
-----------------------------------------------------------------------------------------------------------------------------------------
local Dataset = {
	["pants"] = { item = 0, texture = 0 },
	["arms"] = { item = 0, texture = 0 },
	["tshirt"] = { item = 1, texture = 0 },
	["torso"] = { item = 0, texture = 0 },
	["vest"] = { item = 0, texture = 0 },
	["shoes"] = { item = 0, texture = 0 },
	["mask"] = { item = 0, texture = 0 },
	["backpack"] = { item = 0, texture = 0 },
	["hat"] = { item = -1, texture = 0 },
	["glass"] = { item = 0, texture = 0 },
	["ear"] = { item = -1, texture = 0 },
	["watch"] = { item = -1, texture = 0 },
	["bracelet"] = { item = -1, texture = 0 },
	["accessory"] = { item = 0, texture = 0 },
	["decals"] = { item = 0, texture = 0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function Clothes(Ped,Data)
	for Index,v in pairs(Dataset) do
		if not Data[Index] then
			Data[Index] = {
				["item"] = v["item"],
				["texture"] = v["texture"]
			}
		end
	end

	SetPedComponentVariation(Ped,4,Data["pants"]["item"],Data["pants"]["texture"],1)
	SetPedComponentVariation(Ped,3,Data["arms"]["item"],Data["arms"]["texture"],1)
	SetPedComponentVariation(Ped,5,Data["backpack"]["item"],Data["backpack"]["texture"],1)
	SetPedComponentVariation(Ped,8,Data["tshirt"]["item"],Data["tshirt"]["texture"],1)
	SetPedComponentVariation(Ped,9,Data["vest"]["item"],Data["vest"]["texture"],1)
	SetPedComponentVariation(Ped,11,Data["torso"]["item"],Data["torso"]["texture"],1)
	SetPedComponentVariation(Ped,6,Data["shoes"]["item"],Data["shoes"]["texture"],1)
	SetPedComponentVariation(Ped,1,Data["mask"]["item"],Data["mask"]["texture"],1)
	SetPedComponentVariation(Ped,10,Data["decals"]["item"],Data["decals"]["texture"],1)
	SetPedComponentVariation(Ped,7,Data["accessory"]["item"],Data["accessory"]["texture"],1)

	if Data["hat"]["item"] ~= -1 and Data["hat"]["item"] ~= 0 then
		SetPedPropIndex(Ped,0,Data["hat"]["item"],Data["hat"]["texture"],1)
	else
		ClearPedProp(Ped,0)
	end

	if Data["glass"]["item"] ~= -1 and Data["glass"]["item"] ~= 0 then
		SetPedPropIndex(Ped,1,Data["glass"]["item"],Data["glass"]["texture"],1)
	else
		ClearPedProp(Ped,1)
	end

	if Data["ear"]["item"] ~= -1 and Data["ear"]["item"] ~= 0 then
		SetPedPropIndex(Ped,2,Data["ear"]["item"],Data["ear"]["texture"],1)
	else
		ClearPedProp(Ped,2)
	end

	if Data["watch"]["item"] ~= -1 and Data["watch"]["item"] ~= 0 then
		SetPedPropIndex(Ped,6,Data["watch"]["item"],Data["watch"]["texture"],1)
	else
		ClearPedProp(Ped,6)
	end

	if Data["bracelet"]["item"] ~= -1 and Data["bracelet"]["item"] ~= 0 then
		SetPedPropIndex(Ped,7,Data["bracelet"]["item"],Data["bracelet"]["texture"],1)
	else
		ClearPedProp(Ped,7)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBER
-----------------------------------------------------------------------------------------------------------------------------------------
function Barber(Ped,Status)
	local Clothes = {}
	for Number = 1,41 do
		Clothes[Number] = Status[Number] or 0
	end

    local Face = Clothes[2] / 100 + 0.0
    local Skin = Clothes[4] / 100 + 0.0

	SetPedHeadBlendData(Ped,Clothes[41],Clothes[1],0,Clothes[41],Clothes[1],0,Face,Skin,0.0,false)

	SetPedEyeColor(Ped,Clothes[3])

	if Clothes[5] == 0 then
		SetPedHeadOverlay(Ped,0,Clothes[5],0.0)
	else
		SetPedHeadOverlay(Ped,0,Clothes[5],1.0)
	end

	SetPedHeadOverlay(Ped,6,Clothes[6],1.0)

	if Clothes[7] == 0 then
		SetPedHeadOverlay(Ped,9,Clothes[7],0.0)
	else
		SetPedHeadOverlay(Ped,9,Clothes[7],1.0)
	end

	SetPedHeadOverlay(Ped,3,Clothes[8],1.0)

	SetPedComponentVariation(Ped,2,Clothes[9],0,1)
	SetPedHairColor(Ped,Clothes[10],Clothes[11])

	SetPedHeadOverlay(Ped,4,Clothes[12],Clothes[13] * 0.1)
	SetPedHeadOverlayColor(Ped,4,1,Clothes[14],Clothes[14])

	SetPedHeadOverlay(Ped,8,Clothes[15],Clothes[16] * 0.1)
	SetPedHeadOverlayColor(Ped,8,1,Clothes[17],Clothes[17])

	SetPedHeadOverlay(Ped,2,Clothes[18],Clothes[19] * 0.1)
	SetPedHeadOverlayColor(Ped,2,1,Clothes[20],Clothes[20])

	SetPedHeadOverlay(Ped,1,Clothes[21],Clothes[22] * 0.1)
	SetPedHeadOverlayColor(Ped,1,1,Clothes[23],Clothes[23])

	SetPedHeadOverlay(Ped,5,Clothes[24],Clothes[25] * 0.1)
	SetPedHeadOverlayColor(Ped,5,1,Clothes[26],Clothes[26])

	SetPedFaceFeature(Ped,0,Clothes[27] * 0.1)
	SetPedFaceFeature(Ped,1,Clothes[28] * 0.1)
	SetPedFaceFeature(Ped,4,Clothes[29] * 0.1)
	SetPedFaceFeature(Ped,6,Clothes[30] * 0.1)
	SetPedFaceFeature(Ped,8,Clothes[31] * 0.1)
	SetPedFaceFeature(Ped,9,Clothes[32] * 0.1)
	SetPedFaceFeature(Ped,10,Clothes[33] * 0.1)
	SetPedFaceFeature(Ped,12,Clothes[34] * 0.1)
	SetPedFaceFeature(Ped,13,Clothes[35] * 0.1)
	SetPedFaceFeature(Ped,14,Clothes[36] * 0.1)
	SetPedFaceFeature(Ped,15,Clothes[37] * 0.1)
	SetPedFaceFeature(Ped,16,Clothes[38] * 0.1)
	SetPedFaceFeature(Ped,17,Clothes[39] * 0.1)
	SetPedFaceFeature(Ped,19,Clothes[40] * 0.1)
end