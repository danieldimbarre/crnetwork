-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Answers = {}
local Mugshot = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMUGSHOTBASE64
-----------------------------------------------------------------------------------------------------------------------------------------
function GetMugShotBase64()
	local Ped = PlayerPedId()
	local Timeout = GetGameTimer() + 2000
	local Handle = RegisterPedheadshot(Ped)
	while (not Handle or not IsPedheadshotReady(Handle) or not IsPedheadshotValid(Handle)) and GetGameTimer() < Timeout do
		Wait(10)
	end

	local Texture = "none"
	if Handle and IsPedheadshotReady(Handle) and IsPedheadshotValid(Handle) then
		Mugshot = Handle
		Texture = GetPedheadshotTxdString(Handle)
	end

	SendNUIMessage({
		type = "convert",
		pMugShotTxd = Texture,
		removeImageBackGround = false,
		id = Ped
	})

	local p = promise.new()
	Answers[Ped] = p

	return Citizen.Await(p)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANSWER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Answer",function(Data,Callback)
	local Number = Data.Id
	if Answers[Number] then
		if Mugshot then
			UnregisterPedheadshot(Mugshot)
			Mugshot = false
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

	if Mugshot then
		UnregisterPedheadshot(Mugshot)
		Mugshot = false
	end

	Answers = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVATAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Avatar",function(Data,Callback)
	Callback(GetMugShotBase64())
end)