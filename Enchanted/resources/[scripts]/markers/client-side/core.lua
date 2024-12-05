-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("markers")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Markers = {}
local Players = {}
local Pause = false
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATION
-----------------------------------------------------------------------------------------------------------------------------------------
local Information = {
	LSPD = {
		["Chefe"] = 3,
		["Capitão"] = 18,
		["Tenente"] = 6,
		["Sargento"] = 32,
		["Oficial"] = 42,
		["Cadete"] = 53
	},
	BCSO = {
		["Chefe"] = 3,
		["Capitão"] = 18,
		["Tenente"] = 6,
		["Sargento"] = 32,
		["Oficial"] = 42,
		["Cadete"] = 53
	},
	BCPR = {
		["Chefe"] = 3,
		["Capitão"] = 18,
		["Tenente"] = 6,
		["Sargento"] = 32,
		["Oficial"] = 42,
		["Cadete"] = 53
	},
	Paramedico = {
		["Chefe"] = 1,
		["Médico"] = 6,
		["Enfermeiro"] = 59,
		["Residente"] = 76
	},
	Corredor = {
		["Corredor"] = 8
	},
	Traficante = {
		["Traficante"] = 5
	},
	Boosting = {
		["Boosting"] = 47
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMARKERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Index,_ in pairs(Information) do
		AddStateBagChangeHandler(Index,("player:%s"):format(LocalPlayer["state"]["Source"]),function(Name,Key,Value)
			Active = Key

			if not Value then
				Active = false
				CleanMarkers()
			end
		end)
	end

	while true do
		local TimeDistance = 10000
		if LocalPlayer["state"]["Active"] and Active and Information[Active] then
			TimeDistance = 2500

			if IsPauseMenuActive() then
				if not Pause then
					Pause = true
					CleanMarkers()
				end

				local Users = vSERVER.Users()
				for Index,v in pairs(Users) do
					if Information[v.Permission] and Information[v.Permission][v.Level] and not Markers[Index] and ((LocalPlayer["state"]["Paramedico"] and v.Permission == "Paramedico") or (CheckPolice() and v.Permission ~= "Paramedico")) then
						CreateOrUpdateMarker(Index,v.Coords,v.Permission,v.Level)
					end
				end
			else
				if Pause then
					Pause = false
					CleanMarkers()
				end

				local Ped = PlayerPedId()
				if IsPedInAnyVehicle(Ped) then
					local List = GetPlayers()
					for Index,v in pairs(Players) do
						if List[Index] then
							if Information[v.Permission] and Information[v.Permission][v.Level] and not Markers[Index] and ((LocalPlayer["state"]["Paramedico"] and v.Permission == "Paramedico") or (CheckPolice() and v.Permission ~= "Paramedico")) then
								CreateOrUpdateMarker(Index,v.Coords,v.Permission,v.Level)
							end
						else
							if Markers[Index] then
								if DoesBlipExist(Markers[Index]) then
									RemoveBlip(Markers[Index])
								end

								Markers[Index] = nil
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Selected = {}
	local GamePool = GetGamePool("CPed")

	for _,Entity in ipairs(GamePool) do
		if IsPedAPlayer(Entity) then
			local Index = NetworkGetPlayerIndexFromPed(Entity)
			if Index and NetworkIsPlayerConnected(Index) then
				Selected[GetPlayerServerId(Index)] = Entity
			end
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANMARKERS
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanMarkers()
	for _,Blip in pairs(Markers) do
		if DoesBlipExist(Blip) then
			RemoveBlip(Blip)
		end
	end

	Markers = {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEORUPDATEMARKER
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateOrUpdateMarker(Index,Coords,Permission,Level)
	if Markers[Index] then
		MoveBlipSmooth(Markers[Index],Coords)
	else
		Markers[Index] = AddBlipForCoord(Coords)
		SetBlipSprite(Markers[Index],1)
		SetBlipDisplay(Markers[Index],4)
		SetBlipAsShortRange(Markers[Index],false)
		SetBlipColour(Markers[Index],Information[Permission][Level])
		SetBlipScale(Markers[Index],0.7)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("! "..Permission..":"..Level)
		EndTextCommandSetBlipName(Markers[Index])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVEBLIPSMOOTH
-----------------------------------------------------------------------------------------------------------------------------------------
function MoveBlipSmooth(Blip,Coords)
	if not DoesBlipExist(Blip) then
		return false
	end

	local Timer = 0.0
	local Init = GetBlipCoords(Blip)
	local LastUpdate = GetGameTimer()

	while Timer < 1.0 do
		local CurrentTime = GetGameTimer()
		if CurrentTime - LastUpdate > 10 then
			LastUpdate = CurrentTime
			Timer = Timer + 0.01

			SetBlipCoords(Blip,Init + (Coords - Init) * Timer)
		end

		Wait(1)
	end

	SetBlipCoords(Blip,Coords)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("markers:Add")
AddEventHandler("markers:Add",function(Source,Table)
	Players[Source] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:FULL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("markers:Full")
AddEventHandler("markers:Full",function(Table)
	Players = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKERS:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("markers:Remove")
AddEventHandler("markers:Remove",function(Source)
	if Players[Source] then
		if Markers[Source] then
			if DoesBlipExist(Markers[Source]) then
				RemoveBlip(Markers[Source])
			end

			Markers[Source] = nil
		end

		Players[Source] = nil
	end
end)