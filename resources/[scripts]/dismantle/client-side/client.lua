-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
local vRP = Proxy.getInterface('vRP')
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local arc = {}
Tunnel.bindInterface('dismantle', arc)
local vSERVER = Tunnel.getInterface('dismantle')
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local removing, inDismantle, dismantleVehicle, dismantleCoords = false, false, nil, nil
local lock = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICETHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timer = 1000
		for _, coords in pairs(config.locations) do
			local ped = PlayerPedId()
			local dist = #(GetEntityCoords(ped) - coords)
			local vehicle = GetVehiclePedIsIn(ped, false)

			if not inDismantle and dist <= 3.5 and DoesEntityExist(vehicle) then
				timer = 0
				DrawMarker(23,coords[1], coords[2], coords[3] - 0.55,0.0,0.0,0.0,0.0,0.0,0.0,2.75,2.75,0.0,46,110,76,100,0,0,0,0)
				if IsControlJustPressed(1, 38) then
					if checkVehicleParts(vehicle) and vSERVER.checkConditions(GetVehicleNumberPlateText(vehicle)) then
						inDismantle = true
						dismantleVehicle = vehicle
						dismantleCoords = coords
						serviceDismantle()
					end
				end
			end
		end

		Wait(timer)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
function serviceDismantle()
	TriggerEvent('Notify', 'amarelo', 'Desmanche iniciado, saia do veículo para retirar as peças!', 5000)
	vSERVER.blockRepair(VehToNet(dismantleVehicle))

	while inDismantle and dismantleVehicle and DoesEntityExist(dismantleVehicle) do
		local timer = 1000
		local ped = PlayerPedId()
		local dist = #(GetEntityCoords(ped) - GetEntityCoords(dismantleVehicle))
		local vehicleDistByDismantle = #(dismantleCoords - GetEntityCoords(dismantleVehicle))

		if dist <= 5 and not IsPedInAnyVehicle(ped, false) then
			timer = 0
			
			local finished = true
			for bone, infos in pairs(config.parts) do
				local x, y, z = table.unpack(GetWorldPositionOfEntityBone(dismantleVehicle, GetEntityBoneIndexByName(dismantleVehicle, bone)))
				if x ~= 0.0 then
					local partDist = #(GetEntityCoords(ped) - vector3(x, y, z))

					if infos.type == 'doors' and GetIsDoorValid(dismantleVehicle, infos.index) and not IsVehicleDoorDamaged(dismantleVehicle, infos.index) then
						DrawText3D(x,y,z, infos.text)
						finished = false
					end

					if infos.type == 'wheels' and not IsVehicleTyreBurst(dismantleVehicle, infos.index, true) then
						DrawText3D(x,y,z, infos.text)
						finished = false
					end

					if IsControlPressed(1, 38) and not removing then
						local partIndex, partType = nearestPart(infos.dist)
						if partType then
							removing = true
							lock = GetGameTimer() + (config.animCooldown * 1000)

							if partType == 'wheels' then
								vRP.playAnim(false,{'anim@amb@clubhouse@tutorial@bkr_tut_ig3@','machinic_loop_mechandplayer'},false)
								repeat
									if lock and lock <= GetGameTimer() then
										SetVehicleTyreBurst(dismantleVehicle, partIndex, true, true)
										vSERVER.giveItem(partType)
										lock = nil
									end
									Wait(100)
								until lock == nil
							elseif partType == 'doors' then
								vRP.playAnim(false,{ task = 'WORLD_HUMAN_WELDING' },false)
								repeat
									if lock and lock <= GetGameTimer() then
										SetVehicleDoorBroken(dismantleVehicle, partIndex, true)
										vSERVER.giveItem(partType)
										lock = nil
									end
									Wait(100)
								until lock == nil
							else
								lock = nil
							end

							vRP.stopAnim()
						end
					end
				end
			end
			
			if removing then
				removing = false
			end

			if finished then
				TriggerEvent('Notify', 'verde', 'Desmanche finalizado, chassi do veículo será levado para o ferro velho', 5000)
				FreezeEntityPosition(dismantleVehicle, true)
				Wait(4000)
				TriggerEvent('garages:Delete', dismantleVehicle)
			break end
		end

		Wait(timer)
	end

	inDismantle = false
	dismantleVehicle = nil
	dismantleCoords = nil

	TriggerEvent('Notify', 'amarelo', 'Serviço de desmanche foi finalizado!', 5000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPART
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPart(radius)
	if DoesEntityExist(dismantleVehicle) then
		local prop = {}
		for bone, infos in pairs(config.parts) do
			local continue = false
			
			if infos.type == 'wheels' and not IsVehicleTyreBurst(dismantleVehicle, infos.index, true) then
				continue = true
			elseif infos.type == 'doors' and GetIsDoorValid(dismantleVehicle, infos.index) and not IsVehicleDoorDamaged(dismantleVehicle, infos.index) then
				continue = true
			end
			
			if continue and infos.dist then
				local x, y, z = table.unpack(GetWorldPositionOfEntityBone(dismantleVehicle, GetEntityBoneIndexByName(dismantleVehicle, bone)))
				if x ~= 0.0 then
					local partDist = #(GetEntityCoords(PlayerPedId()) - vector3(x, y, z))
					if not prop[1] and partDist <= radius and partDist <= infos.dist then
						prop = { infos.index, infos.type, partDist }
					elseif prop[1] and prop[2] and prop[3] and partDist < radius and partDist < prop[3] and partDist <= infos.dist then
						prop = { infos.index, infos.type, partDist }
					end
				end
			end
		end

		return prop[1], prop[2] or false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKVEHICLEPARTS
-----------------------------------------------------------------------------------------------------------------------------------------
function checkVehicleParts(vehicle)
	local isDismantled = false
	if DoesEntityExist(vehicle) then
		for bone, infos in pairs(config.parts) do
			local x, y, z = table.unpack(GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, bone)))
			if x ~= 0.0 then
				local partDist = #(GetEntityCoords(ped) - vector3(x, y, z))

				if infos.type == 'doors' and GetIsDoorValid(vehicle, infos.index) and not IsVehicleDoorDamaged(vehicle, infos.index) then
					isDismantled = true
				end

				if infos.type == 'wheels' and not IsVehicleTyreBurst(vehicle, infos.index, true) then
					isDismantled = true
				end
			end
		end
	end

	return isDismantled
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cancelDismantle",function()
	if lock then
		lock = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("cancelDismantle","Cancelar desmanche","keyboard","F6")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText('STRING')
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
	end
end