-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Answers = {}
local TextureNumber = 0
local MugshotsCache = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMUGSHOTBASE64
-----------------------------------------------------------------------------------------------------------------------------------------
function GetMugShotBase64(Ped,Transparent)
	if not Ped or Ped <= 0 then return "" end

	TextureNumber = TextureNumber + 1
	local Handle = RegisterPedheadshot(Ped)

	local Timeout = GetGameTimer() + 2000
	while (not Handle or not IsPedheadshotReady(Handle) or not IsPedheadshotValid(Handle)) and GetGameTimer() < Timeout do
		Wait(10)
	end

	local Texture = "none"
	if Handle and IsPedheadshotReady(Handle) and IsPedheadshotValid(Handle) then
		MugshotsCache[TextureNumber] = Handle
		Texture = GetPedheadshotTxdString(Handle)
	end

	SendNUIMessage({
		type = "convert",
		pMugShotTxd = Texture,
		removeImageBackGround = Transparent or false,
		id = TextureNumber
	})

	local p = promise.new()
	Answers[TextureNumber] = p

	return Citizen.Await(p)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANSWER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Answer",function(Data,Callback)
	local Number = Data.Id
	if Answers[Number] then
		if MugshotsCache[Number] then
			UnregisterPedheadshot(MugshotsCache[Number])
			MugshotsCache[Number] = nil
		end

		Answers[Number]:resolve(Data.Answer)
		Answers[Number] = nil
	end

	if Callback then
		Callback("Ok")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStop",function(Resoruce)
	if Resoruce ~= GetCurrentResourceName() then
		return false
	end

	for _,Handle in pairs(MugshotsCache) do
		UnregisterPedheadshot(Handle)
	end

	MugshotsCache = {}
	TextureNumber = 0
	Answers = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVATAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Avatar",function(Data,Callback)
	if Callback then
		Callback(GetMugShotBase64(PlayerPedId()))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("GetMugShotBase64",GetMugShotBase64)