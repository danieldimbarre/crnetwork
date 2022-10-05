-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
local Treatment = false
local TreatmentTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Beds = {
	-- Medical Center Sul
	{ ["Coords"] = vec3(-668.41,321.74,88.92), ["Heading"] = 172.92 },
	{ ["Coords"] = vec3(-665.38,321.59,88.92), ["Heading"] = 167.25 },
	{ ["Coords"] = vec3(-662.78,321.24,88.92), ["Heading"] = 175.75 },
	{ ["Coords"] = vec3(-660.03,321.08,88.92), ["Heading"] = 167.25 },
	{ ["Coords"] = vec3(-657.16,320.8,88.92), ["Heading"] = 175.75 },
	{ ["Coords"] = vec3(-657.82,314.44,88.92), ["Heading"] = 354.34 },
	{ ["Coords"] = vec3(-661.01,314.39,88.92), ["Heading"] = 345.83 },
	{ ["Coords"] = vec3(-663.86,314.52,88.92), ["Heading"] = 354.34 },
	{ ["Coords"] = vec3(-667.08,314.87,88.9), ["Heading"] = 351.5 },
	{ ["Coords"] = vec3(-671.41,315.29,88.9), ["Heading"] = 354.34 },
	{ ["Coords"] = vec3(-676.15,315.62,88.9), ["Heading"] = 357.17 },
	{ ["Coords"] = vec3(-680.99,320.1,88.85), ["Heading"] = 266.46 },
	{ ["Coords"] = vec3(-680.59,324.7,88.92), ["Heading"] = 269.3 },

	{ ["Coords"] = vec3(-684.31,350.08,83.98), ["Heading"] = 172.92 },
	{ ["Coords"] = vec3(-685.63,350.29,83.98), ["Heading"] = 172.92 },
	{ ["Coords"] = vec3(-694.85,347.52,83.98), ["Heading"] = 266.46 },
	{ ["Coords"] = vec3(-695.34,341.25,83.98), ["Heading"] = 266.46 },

	{ ["Coords"] = vec3(-649.25,318.47,89.03), ["Heading"] = 354.34 },
	{ ["Coords"] = vec3(-648.56,327.12,89.03), ["Heading"] = 170.08 },

	{ ["Coords"] = vec3(-661.3,336.23,88.83), ["Heading"] = 164.41 },

	{ ["Coords"] = vec3(-669.71,336.93,89.03), ["Heading"] = 167.25 },
	-- Medical Center Norte
	{ ["Coords"] = vec3(-252.15,6323.11,32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-250.5,6321.87,32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-246.98,6317.95,32.33), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-245.27,6316.22,32.35), ["Heading"] = 133.23 },
	{ ["Coords"] = vec3(-251.03,6310.51,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-252.63,6312.12,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-254.39,6313.88,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-256.1,6315.58,32.35), ["Heading"] = 317.49 },
	{ ["Coords"] = vec3(-258.03,6317.12,32.35), ["Heading"] = 317.49 },
	-- Clandestine
	{ ["Coords"] = vec3(-471.87,6287.56,13.63), ["Heading"] = 53.86 }
	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(Beds) do
		AddBoxZone("Beds:"..Number,v["Coords"],1.0,1.0,{
			name = "Beds:"..Number,
			heading = v["Heading"],
			minZ = v["Coords"]["z"] - 0.01,
			maxZ = v["Coords"]["z"] + 0.01
		},{
			shop = Number,
			Distance = 1.5,
			options = {
				{
					event = "target:PutBed",
					label = "Deitar",
					tunnel = "client"
				},{
					event = "target:Treatment",
					label = "Tratamento",
					tunnel = "client"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PUTBED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:PutBed")
AddEventHandler("target:PutBed",function(Number)
	if not Previous then
		local Ped = PlayerPedId()
		Previous = GetEntityCoords(Ped)
		SetEntityCoords(Ped,Beds[Number]["Coords"]["x"],Beds[Number]["Coords"]["y"],Beds[Number]["Coords"]["z"] - 1,false,false,false,false)
		vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
		SetEntityHeading(Ped,Beds[Number]["Heading"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPBED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:UpBed")
AddEventHandler("target:UpBed",function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 1,false,false,false,false)
		Previous = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:TREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Treatment")
AddEventHandler("target:Treatment",function(Number)
	if not Previous then
		if vSERVER.CheckIn() then
			local Ped = PlayerPedId()
			Previous = GetEntityCoords(Ped)
			SetEntityCoords(Ped,Beds[Number]["Coords"]["x"],Beds[Number]["Coords"]["y"],Beds[Number]["Coords"]["z"] - 1,false,false,false,false)
			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
			SetEntityHeading(Ped,Beds[Number]["Heading"])

			TriggerEvent("inventory:preventWeapon",true)
			LocalPlayer["state"]["Commands"] = true
			LocalPlayer["state"]["Cancel"] = true
			TriggerEvent("paramedic:Reset")

			if GetEntityHealth(Ped) <= 100 then
				vRP.revivePlayer(101)
			end

			Treatment = true
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:StartTreatment")
AddEventHandler("target:StartTreatment",function()
	if not Treatment then
		LocalPlayer["state"]["Commands"] = true
		LocalPlayer["state"]["Cancel"] = true
		Treatment = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBEDS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if Previous and not IsEntityPlayingAnim(Ped,"anim@gangops@morgue@table@","body_search",3) then
			SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 1,false,false,false,false)
			Previous = nil
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Treatment then
			if GetGameTimer() >= TreatmentTimer then
				local Ped = PlayerPedId()
				local Health = GetEntityHealth(Ped)
				TreatmentTimer = GetGameTimer() + 1000

				if Health < 200 then
					SetEntityHealth(Ped,Health + 1)
				else
					Treatment = false
					LocalPlayer["state"]["Cancel"] = false
					LocalPlayer["state"]["Commands"] = false
					TriggerEvent("Notify","amarelo","Tratamento concluido.",5000)
				end
			end
		end

		Wait(1000)
	end
end)