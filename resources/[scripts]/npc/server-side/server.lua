-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRPC = Tunnel.getInterface('vRP')
vRP = Proxy.getInterface('vRP')
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
arc = {}
Tunnel.bindInterface('npc', arc)
vCLIENT = Tunnel.getInterface('npc')
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState.createdPeds = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
function arc.spawnPeds(index)
    if config[index] then
        local createdPeds = GlobalState.createdPeds

        if not createdPeds[index] then
            createdPeds[index] = {}
        else
            for i, data in pairs(createdPeds[index]) do
                local entity = NetworkGetEntityFromNetworkId(data.entity)
                if DoesEntityExist(entity) and GetEntityHealth(entity) <= 0 then
                    DeleteEntity(entity)
                    createdPeds[index][i] = { entity = nil, timer = os.time() + config[index].timeRevive }
                end
            end
        end

        for i, data in pairs(config[index].peds) do
            if not createdPeds[index][i] or (createdPeds[index][i].timer and createdPeds[index][i].timer <= os.time()) then
                local ped = CreatePed(4, 'csb_mweather', data[1], data[2], data[3], data[4], true, true)
                repeat
                    Wait(50)
                until DoesEntityExist(ped)
                
                createdPeds[index][i] = { entity = NetworkGetNetworkIdFromEntity(ped) }
                SetPedArmour(ped, 100)
            end
        end
        
        GlobalState.createdPeds = createdPeds
        return true
    end

    return false
end