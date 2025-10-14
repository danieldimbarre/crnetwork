-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
tvRP = {}
Proxy.addInterface("vRP",tvRP)
Tunnel.bindInterface("vRP",tvRP)
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local BlipAdmin = false
local Information = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECORS
-----------------------------------------------------------------------------------------------------------------------------------------
DecorRegister("CREATIVE_PED",2)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELATIONSHIP
-----------------------------------------------------------------------------------------------------------------------------------------
AddRelationshipGroup("PLAYER")
AddRelationshipGroup("SURVIVAL")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRELATIONSHIP
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local PlayerHash = GetHashKey("PLAYER")
	local SurvivalHash = GetHashKey("SURVIVAL")

	SetRelationshipBetweenGroups(5,SurvivalHash,PlayerHash)
	SetRelationshipBetweenGroups(5,PlayerHash,SurvivalHash)
	SetRelationshipBetweenGroups(0,SurvivalHash,SurvivalHash)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Theme",function(Data,Callback)
	Callback(Theme)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPeds(Radius)
	local Selected = {}
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local GamePool = GetGamePool("CPed")
	local Radius = (Radius or 2.0) + 0.0001

	for _,Entitys in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entitys)
		if Ped ~= Entitys and Index and NetworkIsPlayerConnected(Index) and #(Coords - GetEntityCoords(Entitys)) <= Radius then
			Selected[#Selected + 1] = GetPlayerServerId(Index)
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTPED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestPed(Radius)
	local Selected = false
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local GamePool = GetGamePool("CPed")
	local Radius = (Radius or 2.0) + 0.0001

	for _,Entitys in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entitys)
		if IsPedAPlayer(Entitys) and Index and Ped ~= Entitys and NetworkIsPlayerConnected(Index) then
			local OtherCoords = GetEntityCoords(Entitys)
			local OtherDistance = #(Coords - OtherCoords)
			if OtherDistance <= Radius then
				Selected = GetPlayerServerId(Index)
				Radius = OtherDistance
			end
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Voip = {}
	local Selected = {}
	local GamePool = GetGamePool("CPed")

	for _,Entitys in pairs(GamePool) do
		local Index = NetworkGetPlayerIndexFromPed(Entitys)

		if Index and IsPedAPlayer(Entitys) and NetworkIsPlayerConnected(Index) then
			Selected[Entitys] = GetPlayerServerId(Index)
			Voip[Entitys] = Index
		end
	end

	return Selected,Voip
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Players()
	return GetPlayers()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.BlipAdmin()
	BlipAdmin = not BlipAdmin
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PlaySound(Dict,Name)
	PlaySoundFrontend(-1,Dict,Name,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTENALBLE
-----------------------------------------------------------------------------------------------------------------------------------------
function PassportEnable()
	if Information or IsPauseMenuActive() then
		return false
	end

	Information = true

	CreateThread(function()
		while Information do
			local Ped = PlayerPedId()
			local Players = GetPlayers()
			local Coords = GetEntityCoords(Ped)

			for _,v in ipairs(Players) do
				local Entitys = GetPlayerPed(v)
				if Ped ~= Entitys and DoesEntityExist(Entitys) and IsEntityOnScreen(Entitys) and HasEntityClearLosToEntity(Ped,Entitys,17) then
					local Passport = Player(v).state.Passport
					if Passport then
						local OtherCoords = GetEntityCoords(Entitys)
						if #(Coords - OtherCoords) <= 10.0 then
							local Head = GetPedBoneIndex(Entitys,0x796e)
							local HeadCoords = GetWorldPositionOfEntityBone(Entitys,Head)

							DrawText(HeadCoords,"~w~"..Passport)
						end
					end
				end
			end

			Wait(0)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function PassportDisable()
	Information = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERCOMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+Information",PassportEnable)
RegisterCommand("-Information",PassportDisable)
RegisterKeyMapping("+Information","Visualizar passaporte.","keyboard","F7")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local TextureDict = CreateRuntimeTxd("Textures")
	for _,TextureName in pairs(TexturePack) do
		local TextureFile = LoadResourceFile("vrp","config/textures/"..TextureName..".png")
		if TextureFile then
			local TextureBase64 = "data:image/png;base64,"..Base64(TextureFile)
			local TuntimeTexture = CreateRuntimeTexture(TextureDict,TextureName,512,512)
			SetRuntimeTextureImage(TuntimeTexture,TextureBase64)
		end
	end

	while true do
		local TimeDistance = 999
		if LocalPlayer.state.Active and BlipAdmin then
			local Ped = PlayerPedId()
			local Players,Voip = GetPlayers()

			for Entitys,source in pairs(Players) do
				if Ped ~= Entitys then
					local PlayerState = Player(source).state
					local Passport = PlayerState and PlayerState.Passport

					if Passport then
						TimeDistance = 0

						local Armour = GetPedArmour(Entitys)
						local Prefix = Talking and "~q~" or ""
						local Health = GetEntityHealth(Entitys)
						local CheckIn = math.max(Health - 100,0)
						local Head = GetPedBoneIndex(Entitys,0x796e)
						local Name = PlayerState.Name or "Carregando..."
						local Check = (CheckIn <= 0) and "Morto" or CheckIn
						local Talking = MumbleIsPlayerTalking(Voip[Entitys])
						local HeadCoords = GetWorldPositionOfEntityBone(Entitys,Head)
						local Message = ("%s%s~w~ | ~y~%s~w~ | ~g~%s~w~ | ~b~%s"):format(Prefix,Name,Passport,Check,Armour)

						DrawText(HeadCoords,Message)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText(Coords,Message)
	SetDrawOrigin(Coords.x,Coords.y,Coords.z + 0.5)

	SetTextFont(4)
	SetTextCentre(true)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,255)
	SetTextDropshadow(1,15,15,15,150)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(Message)
	EndTextCommandDisplayText(0.0,0.0)

	ClearDrawOrigin()
end