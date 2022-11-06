-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module('vrp','lib/Tunnel')
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
arc = {}
Tunnel.bindInterface('npc', arc)
vSERVER = Tunnel.getInterface('npc')
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        for index, infos in pairs(config) do
            local ped = PlayerPedId()
            local dist = #(infos.coords - GetEntityCoords(ped))

            if not timers[index] then
                timers[index] = GetGameTimer()
            end


            if dist <= 50 and timers[index] < GetGameTimer() then
                timers[index] = GetGameTimer() + 10000
                vSERVER.spawnPeds(index)
            end
        end

        Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    for k,v in pairs(GetGamePool('CPed')) do
        DeleteEntity(v)
    end

    while true do
        for _, entity in pairs(GetGamePool('CPed')) do
            if  GetEntityModel(entity) == GetHashKey('csb_mweather') then
                if not DoesRelationshipGroupExist('arcade') then
                    AddRelationshipGroup('arcade')
                end

                SetRelationshipBetweenGroups(5, 'PLAYER', 'arcade') 
                SetRelationshipBetweenGroups(5, 'arcade' , 'PLAYER')
                SetRelationshipBetweenGroups(1, 'arcade' , 'arcade')

                if GetSelectedPedWeapon(entity) ~= GetHashKey('WEAPON_CARBINERIFLE') then
                    NetworkRequestControlOfEntity(entity)
                    repeat
                        Wait(100)
                    until NetworkHasControlOfDoor(entity)

                    SetPedKeepTask(entity,true)
                    SetPedDropsWeaponsWhenDead(entity,false)
                    TaskWanderInArea(entity, GetEntityCoords(entity), 7.0, 3, 1.0)


                    SetPedAccuracy(entity, 100)
                    SetPedCanPlayInjuredAnims(entity, true)
                    SetPedDiesWhenInjured(entity, true)
                    SetPedAsEnemy(entity, true)
                    SetPedCombatRange(entity, 2)
                    SetPedKeepTask(entity, true)
                    SetPedCombatMovement(entity, 2)
                    SetPedCombatAbility(entity, 100)
                    SetPedFleeAttributes(entity, 0,0)
                    SetPedCombatAttributes(entity, 46,1)
                    SetPedDropsWeaponsWhenDead(entity, false)
                    SetPedRelationshipGroupHash(entity, 'arcade')
                    TaskCombatHatedTargetsInArea(entity, GetEntityCoords(entity), 70.0)
                    TaskGuardSphereDefensiveArea(entity, GetEntityCoords(entity), 70.0, false, false)
                    GiveWeaponToPed(entity, 'WEAPON_CARBINERIFLE', 10000, false, true)
                    SetCurrentPedWeapon(entity, 'WEAPON_CARBINERIFLE', true)
                    SetPedInfiniteAmmo(entity, 'WEAPON_CARBINERIFLE', true)
                end
            end
        end

        Wait(1000)
    end
end)