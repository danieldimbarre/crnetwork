-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Showform = {}
local Textform = {
	{
		["Coords"] = vec3(843.18,-721.66,32.15),
		["Text"] = "Testando essa bagaceira",
		["Seconds"] = GetGameTimer() + 10000
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTEXTFORM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number,v in pairs(Textform) do
			local Distance = #(Coords - v["Coords"])
			if Distance <= 10 and GetGameTimer() <= v["Seconds"] then
				TimeDistance = 1
				local _,X,Y = GetScreenCoordFromWorldCoord(v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"])
				if not Showform[Number] then
					SendNUIMessage({ Action = "Textform", Mode = "Create", Number = Number, x = X, y = Y })
					Showform[Number] = true
				end

				SendNUIMessage({ Action = "Textform", Mode = "Update", Text = v["Text"], Number = Number, x = X, y = Y })
			else
				if Showform[Number] then
					SendNUIMessage({ Action = "Textform", Mode = "Remove", Number = Number })
					Showform[Number] = nil
				end
			end
		end

		Wait(TimeDistance)
	end
end)