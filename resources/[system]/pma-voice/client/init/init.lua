-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local success = pcall(function()
		local micClicksKvp = GetResourceKvpString("pma-voice_enableMicClicks")
		if not micClicksKvp then
			SetResourceKvp("pma-voice_enableMicClicks","true")
		else
			micClicks = micClicksKvp
		end
	end)

	if not success then
		SetResourceKvp("pma-voice_enableMicClicks","true")
		micClicks = "true"
	end

	sendUIMessage({ uiEnabled = true, voiceModes = json.encode(Cfg.voiceModes), voiceMode = mode - 1 })

	local radioChannel = LocalPlayer["state"]["radioChannel"]
	local callChannel = LocalPlayer["state"]["callChannel"]

	if radioChannel ~= 0 then
		setRadioChannel(not radioChannel and 0 or radioChannel)
	end

	if callChannel ~= 0 then
		setCallChannel(not callChannel and 0 or callChannel)
	end
end)