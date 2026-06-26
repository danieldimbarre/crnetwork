local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

local PoliceRadar = false
local PoliceFreeze = false
local RadarVisible = false
local HandlingBackup = {}
local RadarData = { front = false, back = false }

RegisterKeyMapping('toggleRadar', 'Ativar/Desativar radar das viaturas.', 'keyboard', 'N')
RegisterKeyMapping('toggleFreeze', 'Travar/Destravar radar das viaturas.', 'keyboard', 'M')

local function ComputeTier(Vehicle)
	if not Vehicle or not DoesEntityExist(Vehicle) then
		return false
	end

	local Override = Entity(Vehicle).state.InterceptorClass
	
	if Override then
		return Override
	end

	local Model = vRP.VehicleModel(Vehicle)
	
	return exports.vrp:VehiclePerformance(Model) or false
end

local function Rank(Class)
	return InterceptorConfig.Rank[Class] or 0
end

local function ResolveAuto(ModelCfg, Performance)
	local PerfRank = Rank(Performance)
	
	if PerfRank == 0 then
		return nil
	end

	local Above,AboveRank
	local Highest,HighestRank

	for Key in pairs(ModelCfg) do
		local Value = Rank(Key)

		if Value >= PerfRank and (not AboveRank or Value < AboveRank) then
			Above, AboveRank = Key, Value
		end

		if not HighestRank or Value > HighestRank then
			Highest, HighestRank = Key, Value
		end
	end

	return Above or Highest
end

local function RefreshSiren(Vehicle)
	if Vehicle and DoesEntityExist(Vehicle) then
		exports.vehcontrol:RefreshSiren(Vehicle)
	end
end

local function RestoreHandling(Vehicle)
	local Backup = HandlingBackup[Vehicle]
	if Backup then
		if DoesEntityExist(Vehicle) then
			for Field, Value in pairs(Backup) do
				SetVehicleHandlingFloat(Vehicle, 'CHandlingData', Field, Value)
			end
			
			ModifyVehicleTopSpeed(Vehicle, 1.0)
		end

		HandlingBackup[Vehicle] = nil
	end
end

local function ApplyHandling(Vehicle, Handling)
	RestoreHandling(Vehicle)

	HandlingBackup[Vehicle] = {}
	for Field,Value in pairs(Handling) do
		HandlingBackup[Vehicle][Field] = GetVehicleHandlingFloat(Vehicle, 'CHandlingData', Field)
		SetVehicleHandlingFloat(Vehicle, 'CHandlingData', Field, Value + 0.0)
	end

	ModifyVehicleTopSpeed(Vehicle, 1.0)
end

CreateThread(function()
	while true do
		Wait(30000)
		for Vehicle in pairs(HandlingBackup) do
			if not DoesEntityExist(Vehicle) then
				HandlingBackup[Vehicle] = nil
			end
		end
	end
end)

local function WorstClass(ModelCfg)
	local Worst ,WorstRank
	
	for Key in pairs(ModelCfg) do
		local Value = Rank(Key)
		
		if not WorstRank or Value < WorstRank then
			Worst, WorstRank = Key, Value
		end
	end

	return Worst
end

AddStateBagChangeHandler('InterceptorClass', nil, function(Name, Key, Value)
	CreateThread(function()
		local NetId = tonumber((Name:gsub('entity:', '')))
		
		if not NetId then 
		    return 
		end

		local Tries = 0
		while not NetworkDoesNetworkIdExist(NetId) and Tries < 50 do
			Wait(100)
			Tries = Tries + 1
		end
		
		if not NetworkDoesNetworkIdExist(NetId) then 
		    return 
		end

		local Vehicle = NetToVeh(NetId)
		
		Tries = 0
		while (not Vehicle or not DoesEntityExist(Vehicle)) and Tries < 50 do
			Wait(100)
			Vehicle = NetToVeh(NetId)
			Tries = Tries + 1
		end

		if not Vehicle or not DoesEntityExist(Vehicle) then 
		    return 
		end

		local Model = vRP.VehicleModel(Vehicle)
		local Entry = Value and InterceptorConfig.Models[Model] and InterceptorConfig.Models[Model][Value]

		if Entry and Entry.Handling then
			ApplyHandling(Vehicle,Entry.Handling)
		else
			RestoreHandling(Vehicle)
		end

		RefreshSiren(Vehicle)
	end)
end)

local function ApplyClass(Vehicle,Label)
	if Vehicle and DoesEntityExist(Vehicle) then
		Entity(Vehicle).state:set('InterceptorClass', Label, true)
	end
end

local function ClearClass(Vehicle)
	if Vehicle and DoesEntityExist(Vehicle) then
		Entity(Vehicle).state:set('InterceptorClass', nil, true)
	end
end

AddEventHandler('interceptor:SetClass', function(ClassKey)
	if not CheckPolice() then
		return
	end

	local Ped = PlayerPedId()
	if not IsPedInAnyPoliceVehicle(Ped) then
		TriggerEvent('Notify', 'Interceptor', 'Entre em uma viatura.', 'amarelo', 5000)

		return
	end

	TriggerEvent('dynamic:Close')

	local Vehicle = GetVehiclePedIsUsing(Ped)

	local Model = vRP.VehicleModel(Vehicle)
	local ModelCfg = InterceptorConfig.Models[Model]
	if not ModelCfg then
		TriggerEvent('Notify', 'Interceptor','Esta viatura não possui classes configuradas.', 'amarelo', 5000)

		return
	end

	local Label

	if ClassKey == 'Auto' then
		if not RadarData.front then
			TriggerEvent('Notify', 'Interceptor', 'Sem alvo no radar para detecção automática.', 'vermelho', 5000)

			return
		end

		local Auto = ResolveAuto(ModelCfg, RadarData.front)
		if not Auto then
			ClearClass(Vehicle)
			TriggerEvent('Notify', 'Interceptor', 'Sem classe automática para esta viatura.', 'amarelo', 5000)

			return
		end

		Label = Auto
	else
		if not ModelCfg[ClassKey] then
			return
		end

		Label = ClassKey
	end

	ApplyClass(Vehicle, Label)
	TriggerEvent('Notify', 'Interceptor', 'Classe '..Label..' aplicada.', 'verde', 5000)
end)

AddEventHandler('gameEventTriggered', function(eventName, arguments)
    if eventName ~= 'CEventNetworkPlayerEnteredVehicle' then
        return
    end

    if arguments[1] ~= PlayerId() then
        return
    end
    
    if not CheckPolice() or not IsPedInAnyPoliceVehicle(PlayerPedId()) then
        return
    end
    
    local Vehicle = arguments[2]

	local Model = vRP.VehicleModel(Vehicle)
	local ModelCfg = InterceptorConfig.Models[Model]

	if ModelCfg and not Entity(Vehicle).state.InterceptorClass then
		local Worst = WorstClass(ModelCfg)
		
		if Worst then
			ApplyClass(Vehicle,Worst)
		end
	end
end)

local function ScanSide(Vehicle, Slot, Offset)
	local Origin = GetOffsetFromEntityInWorldCoords(Vehicle, 0.0, 1.0, 1.0)
	local Target = GetOffsetFromEntityInWorldCoords(Vehicle, 0.0, Offset, 0.0)
	local Shape = StartShapeTestCapsule(Origin, Target, 3.0, 10, Vehicle, 7)

	local Result,Found = 1
	while Result == 1 do
		Result,_,_,_,Found = GetShapeTestResult(Shape)
		Wait(0)
	end

	if IsEntityAVehicle(Found) then
		local Model = vRP.VehicleModel(Found)
		local Class = ComputeTier(Found)

		RadarData[Slot] = Class or RadarData[Slot]

		SendNUIMessage({
			action = 'slot',
			slot = Slot,
			data = {
				plate = GetVehicleNumberPlateText(Found),
				model = exports.vrp:VehicleName(Model),
				speed = GetEntitySpeed(Found) * 3.6,
				class = Class
			}
		})
	end
end

CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		local Active = PoliceRadar and IsPedInAnyPoliceVehicle(Ped) and CheckPolice() and not IsPauseMenuActive()

		if PoliceRadar and IsPedInAnyPoliceVehicle(Ped) then
			TimeDistance = 100
		end

		if Active then
			if not RadarVisible then
				RadarVisible = true
				SendNUIMessage({ action = 'toggle', state = true })
				SendNUIMessage({ action = 'freeze', state = PoliceFreeze })
			end

			if not PoliceFreeze then
				local Vehicle = GetVehiclePedIsUsing(Ped)
				ScanSide(Vehicle,'front',InterceptorConfig.Range)
				ScanSide(Vehicle,'back',-InterceptorConfig.Range)
			end
		elseif RadarVisible then
			RadarVisible = false
			SendNUIMessage({ action = 'toggle', state = false })
		end

		Wait(TimeDistance)
	end
end)

RegisterCommand('toggleRadar',function()
	local Ped = PlayerPedId()
	if IsPedInAnyPoliceVehicle(Ped) and not IsPauseMenuActive() and CheckPolice() then
		if PoliceRadar then
			PoliceRadar = false
			PoliceFreeze = false
			RadarVisible = false
			RadarData = { front = false, back = false }
			SendNUIMessage({ action = 'reset' })
		else
			PoliceRadar = true
			RadarVisible = true
			SendNUIMessage({ action = 'toggle', state = true })
			SendNUIMessage({ action = 'freeze', state = PoliceFreeze })
		end
	end
end)

RegisterCommand('toggleFreeze',function()
	local Ped = PlayerPedId()
	if IsPedInAnyPoliceVehicle(Ped) and not IsPauseMenuActive() and PoliceRadar and CheckPolice() then
		PoliceFreeze = not PoliceFreeze
		SendNUIMessage({ action = 'freeze', state = PoliceFreeze })
	end
end)

exports('Tier',function(Vehicle)
	return ComputeTier(Vehicle) or nil
end)

exports('SirenSet', function(Vehicle)
	if not Vehicle or not DoesEntityExist(Vehicle) then
		return nil
	end

	local Class = Entity(Vehicle).state.InterceptorClass
	
	if not Class then
		return nil
	end

	local Model = vRP.VehicleModel(Vehicle)
	local Entry = InterceptorConfig.Models[Model] and InterceptorConfig.Models[Model][Class]
	
	return (Entry and Entry.SirenLock) or InterceptorConfig.DefaultSiren
end)

exports('ClassesForVehicle', function()
	local Ped = PlayerPedId()
	
	if not IsPedInAnyVehicle(Ped) then
		return nil
	end

	local Vehicle = GetVehiclePedIsUsing(Ped)
	local Model = vRP.VehicleModel(Vehicle)
	local ModelCfg = InterceptorConfig.Models[Model]
	
	if not ModelCfg then
		return nil
	end

	local Keys = {}
	for Key in pairs(ModelCfg) do
		Keys[#Keys + 1] = Key
	end

	table.sort(Keys,function(A,B)
		return Rank(A) > Rank(B)
	end)

	return Keys
end)

exports('CurrentClass', function()
	local Ped = PlayerPedId()
	
	if not IsPedInAnyVehicle(Ped) then
		return nil
	end

	local Vehicle = GetVehiclePedIsUsing(Ped)
	
	return Entity(Vehicle).state.InterceptorClass or nil
end)