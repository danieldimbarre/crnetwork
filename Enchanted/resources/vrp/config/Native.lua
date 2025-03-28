-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadModel(Model)
	local Hash = (type(Model) == "string") and GetHashKey(Model) or Model

	if not IsModelInCdimage(Hash) or not IsModelValid(Hash) then
		return false
	end

	RequestModel(Hash)
	local CurrentTimer = GetGameTimer()
	while not HasModelLoaded(Hash) do
		if (GetGameTimer() - CurrentTimer) >= 10000 then
			return false
		end

		Wait(0)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadAnim(Dict)
	if HasAnimDictLoaded(Dict) then
		return true
	end

	RequestAnimDict(Dict)
	local CurrentTimer = GetGameTimer()
	while not HasAnimDictLoaded(Dict) do
		if (GetGameTimer() - CurrentTimer) >= 10000 then
			return false
		end

		Wait(0)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADTEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadTexture(Library)
	if HasStreamedTextureDictLoaded(Library) then
		return true
	end

	local CurrentTimer = GetGameTimer()
	RequestStreamedTextureDict(Library,false)
	while not HasStreamedTextureDictLoaded(Library) do
		if (GetGameTimer() - CurrentTimer) >= 10000 then
			return false
		end

		Wait(0)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADMOVEMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadMovement(Library)
	if HasAnimSetLoaded(Library) then
		return true
	end

	RequestAnimSet(Library)
	local CurrentTimer = GetGameTimer()
	while not HasAnimSetLoaded(Library) do
		if (GetGameTimer() - CurrentTimer) >= 10000 then
			return false
		end

		Wait(0)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADPTFXASSET
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadPtfxAsset(Library)
	if HasNamedPtfxAssetLoaded(Library) then
		return true
	end

	RequestNamedPtfxAsset(Library)
	local CurrentTimer = GetGameTimer()
	while not HasNamedPtfxAssetLoaded(Library) do
		if (GetGameTimer() - CurrentTimer) >= 10000 then
			return false
		end

		Wait(0)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADNETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadNetwork(Network)
	local CurrentTimer = GetGameTimer()
	while not NetworkDoesNetworkIdExist(Network) do
		if (GetGameTimer() - CurrentTimer) >= 10000 then
			return false
		end

		Wait(0)
	end

	local Entity = NetToEnt(Network)
	if not DoesEntityExist(Entity) then
		return false
	end

	local CurrentTimer = GetGameTimer()
	NetworkRequestControlOfEntity(Entity)
	while not NetworkHasControlOfEntity(Entity) do
		if (GetGameTimer() - CurrentTimer) >= 10000 then
			return false
		end

		Wait(0)
	end

	local CurrentTimer = GetGameTimer()
	SetEntityAsMissionEntity(Entity,true,true)
	while not IsEntityAMissionEntity(Entity) do
		if (GetGameTimer() - CurrentTimer) >= 10000 then
			return false
		end

		Wait(0)
	end

	return Entity,NetworkGetNetworkIdFromEntity(Entity)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckPolice()
	return LocalPlayer["state"]["LSPD"] or LocalPlayer["state"]["BCSO"] or LocalPlayer["state"]["SAPR"]
end