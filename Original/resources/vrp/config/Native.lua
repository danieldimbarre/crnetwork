-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadModel(Hash)
	if IsModelInCdimage(Hash) and IsModelValid(Hash) then
		local Loops = 0
		while not HasModelLoaded(Hash) or Loops >= 1000 do
			RequestModel(Hash)
			Loops = Loops + 1
			Wait(1)
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadAnim(Dict)
	local Loops = 0
	while not HasAnimDictLoaded(Dict) or Loops >= 1000 do
		RequestAnimDict(Dict)
		Loops = Loops + 1
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADTEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadTexture(Library)
	local Loops = 0
	while not HasStreamedTextureDictLoaded(Library) or Loops >= 1000 do
		RequestStreamedTextureDict(Library,false)
		Loops = Loops + 1
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADMOVEMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadMovement(Library)
	local Loops = 0
	while not HasAnimSetLoaded(Library) or Loops >= 1000 do
		RequestAnimSet(Library)
		Loops = Loops + 1
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADPTFXASSET
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadPtfxAsset(Library)
	local Loops = 0
	while not HasNamedPtfxAssetLoaded(Library) or Loops >= 1000 do
		RequestNamedPtfxAsset(Library)
		Loops = Loops + 1
		Wait(1)
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADNETWORK
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadNetwork(Network)
	local Loops = 0
	while not NetworkDoesNetworkIdExist(Network) or Loops >= 1000 do
		Loops = Loops + 1
		Wait(1)
	end

	if NetworkDoesNetworkIdExist(Network) then
		local Object = NetToEnt(Network)

		if DoesEntityExist(Object) then
			Loops = 0
			while not NetworkHasControlOfEntity(Object) or Loops >= 1000 do
				NetworkRequestControlOfEntity(Object)
				Loops = Loops + 1
				Wait(1)
			end

			Loops = 0
			while not IsEntityAMissionEntity(Object) or Loops >= 1000 do
				SetEntityAsMissionEntity(Object,true,true)
				Loops = Loops + 1
				Wait(1)
			end

			return Object
		end
	end

	return false
end