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
	{ ["Coords"] = vec3(-668.3,321.73,87.92), ["Heading"] = 175.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-665.38,321.5,87.92), ["Heading"] = 175.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-662.67,321.23,87.92), ["Heading"] = 175.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-659.93,321.04,87.92), ["Heading"] = 175.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-657.01,320.77,87.92), ["Heading"] = 175.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-657.92,314.42,87.92), ["Heading"] = 355.0, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-661.01,314.42,87.92), ["Heading"] = 355.0, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-663.84,314.7,87.92), ["Heading"] = 355.0, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-667.05,314.9,87.92), ["Heading"] = 355.0, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-671.58,315.3,87.92), ["Heading"] = 355.0, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-676.24,315.7,87.92), ["Heading"] = 355.0, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-680.9,320.23,87.92), ["Heading"] = 265.0, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-680.55,324.8,87.92), ["Heading"] = 265.0, ["Distance"] = 1.25 },

	{ ["Coords"] = vec3(-684.31,350.09,82.98), ["Heading"] = 175.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-685.63,350.29,82.98), ["Heading"] = 175.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-694.84,347.52,82.98), ["Heading"] = 265.0, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-695.33,341.26,82.98), ["Heading"] = 265.0, ["Distance"] = 1.25 },

	{ ["Coords"] = vec3(-649.22,318.53,88.03), ["Heading"] = 355.0, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-648.49,327.05,88.03), ["Heading"] = 175.01, ["Distance"] = 1.25 },

	{ ["Coords"] = vec3(-661.3,336.23,87.83), ["Heading"] = 175.01, ["Distance"] = 1.25 },

	{ ["Coords"] = vec3(-669.7,336.9,88.03), ["Heading"] = 355.0, ["Distance"] = 1.25 },
	-- Medical Center Norte
	{ ["Coords"] = vec3(-252.15,6323.11,32.35), ["Heading"] = 133.23, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-250.5,6321.87,32.35), ["Heading"] = 133.23, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-246.98,6317.95,32.33), ["Heading"] = 133.23, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-245.27,6316.22,32.35), ["Heading"] = 133.23, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-251.03,6310.51,32.35), ["Heading"] = 317.49, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-252.63,6312.12,32.35), ["Heading"] = 317.49, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-254.39,6313.88,32.35), ["Heading"] = 317.49, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-256.1,6315.58,32.35), ["Heading"] = 317.49, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(-258.03,6317.12,32.35), ["Heading"] = 317.49, ["Distance"] = 1.25 },
	-- Prison
	{ ["Coords"] = vec3(1761.88,2591.57,45.66), ["Heading"] = 270.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(1761.88,2594.65,45.66), ["Heading"] = 270.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(1761.88,2597.73,45.66), ["Heading"] = 270.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(1771.98,2597.96,45.66), ["Heading"] = 90.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(1771.98,2594.88,45.66), ["Heading"] = 90.01, ["Distance"] = 1.25 },
	{ ["Coords"] = vec3(1771.98,2591.8,45.66), ["Heading"] = 90.01, ["Distance"] = 1.25 },
	-- Clandestine
	{ ["Coords"] = vec3(-471.87,6287.56,13.63), ["Heading"] = 53.86, ["Distance"] = 1.75 }
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
			Distance = v["Distance"],
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

		Wait(1000)
		ThreadBeds()
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
			LocalPlayer["state"]["Buttons"] = true
			LocalPlayer["state"]["Commands"] = true
			LocalPlayer["state"]["Cancel"] = true
			local Ped = PlayerPedId()
			Previous = GetEntityCoords(Ped)
			SetEntityCoords(Ped,Beds[Number]["Coords"]["x"],Beds[Number]["Coords"]["y"],Beds[Number]["Coords"]["z"] - 1,false,false,false,false)
			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
			SetEntityHeading(Ped,Beds[Number]["Heading"])

			TriggerEvent("inventory:preventWeapon",true)
			TriggerEvent("paramedic:Reset")

			if GetEntityHealth(Ped) <= 100 then
				exports["survival"]:Revive(101)
			end

			Treatment = true

			Wait(1000)
			ThreadBeds()
			ThreadTreatment(true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:StartTreatment")
AddEventHandler("target:StartTreatment",function()
	if not Treatment then
		LocalPlayer["state"]["Buttons"] = true
		LocalPlayer["state"]["Commands"] = true
		LocalPlayer["state"]["Cancel"] = true
		Treatment = true
		TriggerEvent("Notify","amarelo","Tratamento começou.",5000)

		Wait(1000)
		ThreadTreatment()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function ThreadBeds()
	CreateThread(function()
		while Previous do			
			local Ped = PlayerPedId()
			if not IsEntityPlayingAnim(Ped,"anim@gangops@morgue@table@","body_search",3) or LocalPlayer["state"]["usingPhone"] then
				SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 1,false,false,false,false)
				Previous = nil
				vRP.removeObjects()

				if Treatment then
					Treatment = false
					LocalPlayer["state"]["Cancel"] = false
					LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Buttons"] = false
					TriggerEvent("Notify","amarelo","Tratamento cancelado.",5000)
				end
			end

			Wait(1000)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function ThreadTreatment()
	CreateThread(function()
		while Treatment do
			if GetGameTimer() >= TreatmentTimer then
				local Ped = PlayerPedId()
				local Health = GetEntityHealth(Ped)
				TreatmentTimer = GetGameTimer() + 1000

				if Health <= 100 and Treatment then
					Treatment = false
					LocalPlayer["state"]["Cancel"] = false
					LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Buttons"] = false
					TriggerEvent("Notify","amarelo","Tratamento cancelado.",5000)
				end

				if Health < 200 then
					SetEntityHealth(Ped,Health + 1)
				else
					Treatment = false
					LocalPlayer["state"]["Cancel"] = false
					LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Buttons"] = false
					TriggerEvent("Notify","amarelo","Tratamento concluído.",5000)
				end
			end

			Wait(1000)
		end
	end)
end