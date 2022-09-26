-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAIRS
-----------------------------------------------------------------------------------------------------------------------------------------
local Chairs = {
	-- BurgerShot
	{ ["Coords"] = vec3(-1195.44,-883.55,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1194.96,-884.31,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1193.82,-882.47,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1193.30,-883.22,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1192.98,-881.81,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1192.48,-882.60,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1191.01,-881.64,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1191.52,-880.80,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1189.33,-879.31,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1189.85,-879.69,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1188.14,-879.62,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1187.72,-880.32,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1187.08,-881.23,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1187.89,-881.76,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1185.99,-882.92,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1186.81,-883.47,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1183.18,-886.96,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1183.96,-887.49,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1182.06,-888.64,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1182.87,-889.20,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1180.97,-891.36,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1181.82,-891.92,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1181.00,-890.16,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1181.41,-889.55,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1183.94,-892.23,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1183.43,-892.91,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1184.89,-893.88,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1185.38,-893.11,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1185.72,-894.48,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1186.22,-893.72,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1187.37,-895.61,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1187.89,-894.86,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1191.19,-885.34,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1190.86,-885.78,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1191.12,-886.88,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1191.76,-887.33,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1192.77,-887.12,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1193.15,-886.60,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1189.26,-892.31,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1189.65,-891.76,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1189.37,-890.67,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1188.82,-890.28,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1187.85,-890.23,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1187.50,-890.74,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1193.91,-887.50,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1192.99,-888.86,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1191.30,-891.31,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1190.44,-892.68,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1188.91,-896.76,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1189.62,-897.21,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1190.85,-897.04,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1191.33,-896.33,14.0), ["Heading"] = 303, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1200.55,-887.10,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1203.02,-888.78,14.0), ["Heading"] = 213, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1180.80,-900.72,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1185.43,-904.10,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1184.68,-903.58,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1188.82,-903.77,14.0), ["Heading"] = 330, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1187.79,-901.57,14.0), ["Heading"] = 309, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1188.45,-900.58,14.0), ["Heading"] = 289, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1186.65,-899.34,14.0), ["Heading"] = 199, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1177.39,-895.82,14.0), ["Heading"] = 123, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1179.68,-896.44,14.0), ["Heading"] = 294, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1178.90,-897.46,14.0), ["Heading"] = 324, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1177.84,-899.15,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1177.11,-898.76,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(-1176.38,-898.29,14.0), ["Heading"] = 33, ["Offset"] = 0.50 },
	-- PizzaThis
	{ ["Coords"] = vec3(808.50,-755.33,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(808.50,-754.45,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(806.95,-755.33,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(806.95,-754.49,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(806.38,-755.42,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(806.38,-754.52,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(804.85,-755.42,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(804.85,-754.44,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(804.28,-755.32,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(804.28,-754.50,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(802.75,-755.45,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(802.75,-754.45,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(802.2,-755.28,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(802.2,-754.39,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(800.64,-755.34,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(800.64,-754.50,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(799.34,-756.80,26.78), ["Heading"] = 180, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(799.33,-758.38,26.78), ["Heading"] = 0, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(799.43,-758.97,26.78), ["Heading"] = 180, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(799.43,-760.52,26.78), ["Heading"] = 0, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(808.13,-751.56,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(806.01,-751.53,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(804.23,-751.53,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(802.05,-751.59,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(800.12,-751.51,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(798.04,-751.58,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(799.06,-748.86,26.78), ["Heading"] = 90, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(796.97,-748.79,26.78), ["Heading"] = 270, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(799.48,-754.09,26.78), ["Heading"] = 160, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(799.50,-756.05,26.78), ["Heading"] = 5, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(795.12,-750.46,26.78), ["Heading"] = 205, ["Offset"] = 0.50 },
	{ ["Coords"] = vec3(795.22,-752.64,26.78), ["Heading"] = 355, ["Offset"] = 0.50 },
	-- UwuCafé
	{ ["Coords"] = vec3(-573.94,-1058.86,22.34), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.04,-1058.84,22.34), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.9,-1060.65,22.34), ["Heading"] = 0, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.07,-1060.69,22.34), ["Heading"] = 0, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.86,-1062.48,22.34), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.06,-1062.45,22.34), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.86,-1064.31,22.34), ["Heading"] = 0, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.06,-1064.28,22.34), ["Heading"] = 0, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.9,-1066.19,22.34), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.02,-1066.16,22.34), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.95,-1068.02,22.34), ["Heading"] = 0, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.1,-1068.05,22.34), ["Heading"] = 0, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-577.58,-1052.5,22.20), ["Heading"] = 42.41, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-579.69,-1052.49,22.20), ["Heading"] = 329, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-580.83,-1050.91,22.20), ["Heading"] = 267, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-576.91,-1050.75,22.20), ["Heading"] = 108.24, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-591.26,-1049.2,22.20), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-590.56,-1049.16,22.20), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-589.81,-1049.12,22.20), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-598.29,-1050.07,22.20), ["Heading"] = 268, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-598.28,-1050.97,22.20), ["Heading"] = 268, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.58,-1053.56,26.42), ["Heading"] = 270, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.6,-1052.84,26.42), ["Heading"] = 270, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-573.58,-1052.08,26.42), ["Heading"] = 270, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-569.87,-1066.14,26.42), ["Heading"] = 90, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-569.85,-1066.92,26.42), ["Heading"] = 90, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-569.89,-1067.76,26.42), ["Heading"] = 90, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-569.87,-1068.54,26.42), ["Heading"] = 90, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-571.01,-1069.26,26.42), ["Heading"] = 0, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-572.6,-1069.26,26.42), ["Heading"] = 0, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-577.0,-1062.51,26.42), ["Heading"] = 0, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-578.7,-1058.0,26.42), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-578.0,-1058.02,26.42), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-577.28,-1058.03,26.42), ["Heading"] = 180, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-577.12,-1065.24,26.42), ["Heading"] = 165, ["Offset"] = 0.35 },
	{ ["Coords"] = vec3(-578.79,-1065.32,26.42), ["Heading"] = 200, ["Offset"] = 0.35 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(Chairs) do
		AddBoxZone("Chairs:"..Number,v["Coords"],0.35,0.35,{
			name = "Chairs:"..Number,
			heading = v["Heading"],
			minZ = v["Coords"]["z"] - 1.0,
			maxZ = v["Coords"]["z"] + 0.5
		},{
			shop = Number,
			Distance = 5.25,
			options = {
				{
					event = "target:SitChair",
					label = "Sentar",
					tunnel = "client"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SITCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:SitChair")
AddEventHandler("target:SitChair",function(Number)
	if not Previous then
		local Ped = PlayerPedId()
		local Coords = Chairs[Number]["Coords"]
		TaskStartScenarioAtPosition(Ped,"PROP_HUMAN_SEAT_CHAIR_UPRIGHT",Coords["x"],Coords["y"],Coords["z"] - Chairs[Number]["Offset"],Chairs[Number]["Heading"] + 1.0,-1,true,true)
		Previous = GetEntityCoords(Ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:UpChair")
AddEventHandler("target:UpChair",function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 1,false,false,false,false)
		Previous = nil
	end
end)