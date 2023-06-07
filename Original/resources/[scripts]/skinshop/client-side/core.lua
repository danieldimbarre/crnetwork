-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("skinshop",Creative)
vSERVER = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Cam = -1
local Dataset = {}
local Previous = {}
local Animation = false
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
-- DATACATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
local DataCategory = {
	["arms"] = { type = "variation", id = 3 },
	["backpack"] = { type = "variation", id = 5 },
	["tshirt"] = { type = "variation", id = 8 },
	["torso"] = { type = "variation", id = 11 },
	["pants"] = { type = "variation", id = 4 },
	["vest"] = { type = "variation", id = 9 },
	["shoes"] = { type = "variation", id = 6 },
	["mask"] = { type = "variation", id = 1 },
	["hat"] = { type = "prop", id = 0 },
	["glass"] = { type = "prop", id = 1 },
	["ear"] = { type = "prop", id = 2 },
	["watch"] = { type = "prop", id = 6 },
	["bracelet"] = { type = "prop", id = 7 },
	["accessory"] = { type = "variation", id = 7 },
	["decals"] = { type = "variation", id = 10 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:Apply")
AddEventHandler("skinshop:Apply",function(Table)
	for Index,v in pairs(Dataset) do
		if not Table[Index] then
			Table[Index] = v
		end
	end

	Dataset = Table
	ApplyDataset(Dataset)
	vSERVER.updateClothes(Dataset)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETATTOO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:updateTattoo")
AddEventHandler("skinshop:updateTattoo",function()
	ApplyDataset(Dataset)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Skinshops = {
	{ -1124.28,-1442.92,5.22 },
	{ 74.88,-1400.08,29.37 },
	{ 80.42,-1400.13,29.37 },
	{ -709.09,-143.23,37.41 },
	{ -701.47,-156.89,37.41 },
	{ -166.04,-294.02,39.73 },
	{ -171.45,-308.83,39.73 },
	{ -828.87,-1076.69,11.32 },
	{ -826.14,-1081.52,11.32 },
	{ -1198.62,-770.67,17.3 },
	{ -1451.4,-247.0,49.82 },
	{ -1440.71,-235.17,49.82 },
	{ 10.38,6516.93,31.88 },
	{ 6.66,6521.02,31.88 },
	{ 1693.48,4829.94,42.06 },
	{ 1688.02,4829.23,42.06 },
	{ 129.04,-218.61,54.56 },
	{ 613.28,2756.72,42.09 },
	{ 1189.51,2710.73,38.22 },
	{ 1189.46,2705.23,38.22 },
	{ -3167.03,1048.69,20.86 },
	{ -1107.17,2706.14,19.11 },
	{ -1103.47,2702.0,19.11 },
	{ 426.08,-799.02,29.49 },
	{ 420.55,-799.1,29.49 },
	{ 1210.61,-1474.0,34.85 }, -- Bombeiros
	{ -1181.86,-900.55,13.99 }, -- BurgerShot
	{ 461.46,-998.05,31.19 }, -- Departamento LSPD
	{ 387.29,799.17,187.45 }, -- Departamento Ranger
	{ 1841.13,3679.86,34.19 }, -- Departamento Sheriff
	{ -437.49,6009.62,36.99 }, -- Departamento Sheriff
	{ 361.77,-1593.19,25.9 }, -- Departamento State
	{ -586.89,-1049.92,22.34 }, -- Uwu Café
	{ 300.2,-598.85,43.29 }, -- Hospital Sul
	{ -256.56,6327.32,32.42 }, -- Hospital Norte
	{ 841.11,-824.54,26.34 }, -- Mecânica Sul
	{ 801.62,-830.37,26.34 }, -- Mecânica Sul
	{ 810.31,-760.23,31.26 } -- Pizza This
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Table = {}

	for _,v in pairs(Skinshops) do
		table.insert(Table,{ v[1],v[2],v[3],2,"E","Loja de Roupas","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:Insert",Table)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for _,v in pairs(Skinshops) do
					local Distance = #(Coords - vec3(v[1],v[2],v[3]))
					if Distance <= 2 then
						TimeDistance = 1

						if IsControlJustPressed(0,38) and vSERVER.CheckWanted() then
							openMenu({
								{ menu = "character", label = "Roupas", selected = true },
								{ menu = "accessoires", label = "Utilidades", selected = false }
							})
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:OPENSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:openShop")
AddEventHandler("skinshop:openShop",function()
	TriggerEvent("dynamic:closeSystem")

	if vSERVER.CheckWanted() then
		openMenu({
			{ menu = "character", label = "Roupas", selected = true },
			{ menu = "accessoires", label = "Utilidades", selected = false }
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETOUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("resetOutfit",function(Data,Callback)
	ApplyDataset(json.decode(Previous))
	Dataset = json.decode(Previous)
	Previous = {}

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATERIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateRight",function(Data,Callback)
	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	SetEntityHeading(Ped,Heading + 30)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateLeft",function(Data,Callback)
	local Ped = PlayerPedId()
	local heading = GetEntityHeading(Ped)
	SetEntityHeading(Ped,heading - 30)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAXVALUES
-----------------------------------------------------------------------------------------------------------------------------------------
function MaxValues()
	local MaxValues = {
		["backpack"] = { type = "character", item = 0, texture = 0 },
		["arms"] = { type = "character", item = 0, texture = 0 },
		["tshirt"] = { type = "character", item = 0, texture = 0 },
		["torso"] = { type = "character", item = 0, texture = 0 },
		["pants"] = { type = "character", item = 0, texture = 0 },
		["shoes"] = { type = "character", item = 0, texture = 0 },
		["vest"] = { type = "character", item = 0, texture = 0 },
		["accessory"] = { type = "character", item = 0, texture = 0 },
		["decals"] = { type = "character", item = 0, texture = 0 },
		["mask"] = { type = "accessoires", item = 0, texture = 0 },
		["hat"] = { type = "accessoires", item = 0, texture = 0 },
		["glass"] = { type = "accessoires", item = 0, texture = 0 },
		["ear"] = { type = "accessoires", item = 0, texture = 0 },
		["watch"] = { type = "accessoires", item = 0, texture = 0 },
		["bracelet"] = { type = "accessoires", item = 0, texture = 0 }
	}

	local Ped = PlayerPedId()
	for Index,v in pairs(DataCategory) do
		if v["type"] == "variation" then
			MaxValues[Index]["item"] = GetNumberOfPedDrawableVariations(Ped,v["id"]) - 1
			MaxValues[Index]["texture"] = GetNumberOfPedTextureVariations(Ped,v["id"],GetPedDrawableVariation(Ped,v["id"])) - 1

			if MaxValues[Index]["texture"] <= 0 then
				MaxValues[Index]["texture"] = 0
			end
		end

		if v["type"] == "prop" then
			MaxValues[Index]["item"] = GetNumberOfPedPropDrawableVariations(Ped,v["id"]) - 1
			MaxValues[Index]["texture"] = GetNumberOfPedPropTextureVariations(Ped,v["id"],GetPedPropIndex(Ped,v["id"])) - 1

			if MaxValues[Index]["texture"] <= 0 then
				MaxValues[Index]["texture"] = 0
			end
		end
	end

	SendNUIMessage({ action = "updateMax", maxValues = MaxValues })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function openMenu(Menus)
	MaxValues()

	vRP.playAnim(true,{"mp_sleep","bind_pose_180"},true)
	vRP.playAnim(true,{"missfam5_yoga","a2_pose"},true)

	Previous = json.encode(Dataset)
	SendNUIMessage({ action = "open", menus = Menus, currentClothing = Dataset })

	SetNuiFocus(true,true)

	CamActive()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function CamActive()
	if DoesCamExist(Cam) then
		RenderScriptCams(false,false,0,1,0)
		DestroyCam(Cam,false)
	end

	local Ped = PlayerPedId()
	local Heading = GetEntityHeading(Ped)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,0,2.0,0)

	Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	SetCamActive(Cam,true)
	RenderScriptCams(true,false,0,true,true)
	SetCamCoord(Cam,Coords["x"],Coords["y"],Coords["z"] + 0.5)
	SetCamRot(Cam,0.0,0.0,Heading + 180)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setupCam",function(Data,Callback)
	if Data["value"] == 1 then
		local Coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,0.75,0)
		SetCamCoord(Cam,Coords["x"],Coords["y"],Coords["z"] + 0.6)
	elseif Data["value"] == 2 then
		local Coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(Cam,Coords["x"],Coords["y"],Coords["z"] + 0.2)
	elseif Data["value"] == 3 then
		local Coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(Cam,Coords["x"],Coords["y"],Coords["z"] - 0.5)
	else
		local Coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)
		SetCamCoord(Cam,Coords["x"],Coords["y"],Coords["z"] + 0.5)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYDATASET
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyDataset(Data)
	local Ped = PlayerPedId()

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
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(Data,Callback)
	if DoesCamExist(Cam) then
		RenderScriptCams(false,true,250,1,0)
		DestroyCam(Cam,false)
	end

	SetNuiFocus(false,false)
	vRP.removeObjects()

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(Data,Callback)
	ChangeDataset(Data)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKINONINPUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkinOnInput",function(Data,Callback)
	ChangeDataset(Data)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEDATASET
-----------------------------------------------------------------------------------------------------------------------------------------
function ChangeDataset(Data)
	local Ped = PlayerPedId()
	local Variation = Data["articleNumber"]

	if Data["clothingType"] == "pants" then
		if Data["type"] == "item" then
			SetPedComponentVariation(Ped,4,Variation,0,1)
			Dataset["pants"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedComponentVariation(Ped,4,GetPedDrawableVariation(Ped,4),Variation,1)
			Dataset["pants"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "arms" then
		if Data["type"] == "item" then
			SetPedComponentVariation(Ped,3,Variation,0,1)
			Dataset["arms"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedComponentVariation(Ped,3,GetPedDrawableVariation(Ped,3),Variation,1)
			Dataset["arms"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "tshirt" then
		if Data["type"] == "item" then
			SetPedComponentVariation(Ped,8,Variation,0,1)
			Dataset["tshirt"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedComponentVariation(Ped,8,GetPedDrawableVariation(Ped,8),Variation,1)
			Dataset["tshirt"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "vest" then
		if Data["type"] == "item" then
			SetPedComponentVariation(Ped,9,Variation,0,1)
			Dataset["vest"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedComponentVariation(Ped,9,Dataset["vest"]["item"],Variation,1)
			Dataset["vest"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "decals" then
		if Data["type"] == "item" then
			SetPedComponentVariation(Ped,10,Variation,0,1)
			Dataset["decals"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedComponentVariation(Ped,10,Dataset["decals"]["item"],Variation,1)
			Dataset["decals"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "accessory" then
		if Data["type"] == "item" then
			SetPedComponentVariation(Ped,7,Variation,0,1)
			Dataset
			["accessory"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedComponentVariation(Ped,7,Dataset["accessory"]["item"],Variation,1)
			Dataset["accessory"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "torso" then
		if Data["type"] == "item" then
			SetPedComponentVariation(Ped,11,Variation,0,1)
			Dataset["torso"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedComponentVariation(Ped,11,GetPedDrawableVariation(Ped,11),Variation,1)
			Dataset["torso"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "shoes" then
		if Data["type"] == "item" then
			SetPedComponentVariation(Ped,6,Variation,0,1)
			Dataset["shoes"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedComponentVariation(Ped,6,GetPedDrawableVariation(Ped,6),Variation,1)
			Dataset["shoes"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "mask" then
		if Data["type"] == "item" then
			SetPedComponentVariation(Ped,1,Variation,0,1)
			Dataset["mask"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedComponentVariation(Ped,1,GetPedDrawableVariation(Ped,1),Variation,1)
			Dataset["mask"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "hat" then
		if Data["type"] == "item" then
			if Variation ~= -1 then
				SetPedPropIndex(Ped,0,Variation,Dataset["hat"]["texture"],1)
			else
				ClearPedProp(Ped,0)
			end

			Dataset["hat"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedPropIndex(Ped,0,Dataset["hat"]["item"],Variation,1)
			Dataset["hat"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "glass" then
		if Data["type"] == "item" then
			if Variation ~= -1 then
				SetPedPropIndex(Ped,1,Variation,Dataset["glass"]["texture"],1)
				Dataset["glass"]["item"] = Variation
			else
				ClearPedProp(Ped,1)
			end
		elseif Data["type"] == "texture" then
			SetPedPropIndex(Ped,1,Dataset["glass"]["item"],Variation,1)
			Dataset["glass"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "ear" then
		if Data["type"] == "item" then
			if Variation ~= -1 then
				SetPedPropIndex(Ped,2,Variation,Dataset["ear"]["texture"],1)
			else
				ClearPedProp(Ped,2)
			end

			Dataset["ear"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedPropIndex(Ped,2,Dataset["ear"]["item"],Variation,1)
			Dataset["ear"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "watch" then
		if Data["type"] == "item" then
			if Variation ~= -1 then
				SetPedPropIndex(Ped,6,Variation,Dataset["watch"]["texture"],1)
			else
				ClearPedProp(Ped,6)
			end

			Dataset["watch"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedPropIndex(Ped,6,Dataset["watch"]["item"],Variation,1)
			Dataset["watch"]["texture"] = Variation
		end
	elseif Data["clothingType"] == "bracelet" then
		if Data["type"] == "item" then
			if Variation ~= -1 then
				SetPedPropIndex(Ped,7,Variation,Dataset["bracelet"]["texture"],1)
			else
				ClearPedProp(Ped,7)
			end

			Dataset["bracelet"]["item"] = Variation
		elseif Data["type"] == "texture" then
			SetPedPropIndex(Ped,7,Dataset["bracelet"]["item"],Variation,1)
			Dataset["bracelet"]["texture"] = Variation
		end
	end

	MaxValues()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVECLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("saveClothing",function(Data,Callback)
	vSERVER.updateClothes(Dataset)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setMask")
AddEventHandler("skinshop:setMask",function()
	if not Animation and not LocalPlayer["state"]["Buttons"] then
		Animation = true
		local Ped = PlayerPedId()
		vRP.playAnim(true,{"missfbi4","takeoff_mask"},true)

		Wait(1000)

		if GetPedDrawableVariation(Ped,1) == Dataset["mask"]["item"] then
			SetPedComponentVariation(Ped,1,0,0,1)
		else
			SetPedComponentVariation(Ped,1,Dataset["mask"]["item"],Dataset["mask"]["texture"],1)
		end

		vRP.removeObjects()
		Animation = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setHat")
AddEventHandler("skinshop:setHat",function()
	if not Animation and not LocalPlayer["state"]["Buttons"] then
		Animation = true
		local Ped = PlayerPedId()
		vRP.playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},true)

		Wait(1000)

		if GetPedPropIndex(Ped,0) == Dataset["hat"]["item"] then
			ClearPedProp(Ped,0)
		else
			SetPedPropIndex(Ped,0,Dataset["hat"]["item"],Dataset["hat"]["texture"],1)
		end

		vRP.removeObjects()
		Animation = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETGLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setGlasses")
AddEventHandler("skinshop:setGlasses",function()
	if not Animation and not LocalPlayer["state"]["Buttons"] then
		Animation = true
		local Ped = PlayerPedId()
		vRP.playAnim(true,{"clothingspecs","take_off"},true)

		Wait(1000)

		if GetPedPropIndex(Ped,1) == Dataset["glass"]["item"] then
			ClearPedProp(Ped,1)
		else
			SetPedPropIndex(Ped,1,Dataset["glass"]["item"],Dataset["glass"]["texture"],1)
		end

		vRP.removeObjects()
		Animation = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkShoes()
	local Number = 34
	local Ped = PlayerPedId()
	if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
		Number = 35
	end

	if Dataset["shoes"]["item"] ~= Number then
		Dataset["shoes"]["item"] = Number
		Dataset["shoes"]["texture"] = 0
		SetPedComponentVariation(Ped,6,Dataset["shoes"]["item"],Dataset["shoes"]["texture"],1)

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:toggleBackpack")
AddEventHandler("skinshop:toggleBackpack",function(Infos)
	local splitName = splitString(Infos,"-")
	local Model = parseInt(splitName[1])
	local Texture = parseInt(splitName[2])

	if Dataset["backpack"]["item"] == Model then
		Dataset["backpack"]["item"] = 0
		Dataset["backpack"]["texture"] = 0
	else
		Dataset["backpack"]["texture"] = Texture
		Dataset["backpack"]["item"] = Model
	end

	SetPedComponentVariation(PlayerPedId(),5,Dataset["backpack"]["item"],Dataset["backpack"]["texture"],1)

	vSERVER.updateClothes(Dataset)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Customization()
	return Dataset
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:DEFIBRILLATOR
-----------------------------------------------------------------------------------------------------------------------------------------
local Defibrillator = false
RegisterNetEvent("skinshop:Defibrillator")
AddEventHandler("skinshop:Defibrillator",function()
	if Defibrillator then
		Defibrillator = false
		SetPedComponentVariation(PlayerPedId(),5,0,0,1)
	else
		Defibrillator = true
		SetPedComponentVariation(PlayerPedId(),5,100,0,1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFIBRILLATOR
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Defibrillator()
	return Defibrillator
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
local BackWeight = false
CreateThread(function()
	while true do
		if Dataset["backpack"]["item"] ~= 0 and Dataset["backpack"]["item"] >= 100 then
			if not BackWeight then
				TriggerServerEvent("vRP:BackpackWeight",true)
				BackWeight = true
			end
		else
			if BackWeight then
				TriggerServerEvent("vRP:BackpackWeight",false)
				BackWeight = false
			end
		end

		Wait(1000)
	end
end)