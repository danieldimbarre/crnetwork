local ActiveSmokes = {}
local SmokeTracking = {}

local function ensurePtfxDict(dict)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
        while not HasNamedPtfxAssetLoaded(dict) do
            Wait(0)
        end
    end
end

AddStateBagChangeHandler('ActiveSmokes', nil, function(bagName, key, value, reserved)
    if value and type(value) == 'table' then
        for _, smokeData in ipairs(value) do
            if not SmokeTracking[smokeData.id] then
                TriggerEvent('client:startSmoke', smokeData.x, smokeData.y, smokeData.z, smokeData.expiresAt - smokeData.createdAt, smokeData.id)
            end
        end
    end
end)

RegisterNetEvent('client:startSmoke', function(x, y, z, time, smokeId)
    smokeId = smokeId or math.random(1000000, 9999999)
    
    if SmokeTracking[smokeId] then
        return
    end
    
    SmokeTracking[smokeId] = true
    local coords = vector3(x, y, z)

    ensurePtfxDict("core")

    local fxHandles = {}

    UseParticleFxAssetNextCall("core")
    
    local centerFx = StartParticleFxLoopedAtCoord(
        "exp_grd_grenade_smoke",
        coords.x, coords.y, coords.z + 0.0,
        0.0, 0.0, 0.0,
        1.8,  
        false, false, false, false
    )

    if centerFx ~= -1 then
        table.insert(fxHandles, centerFx)
    end

    for i = 1, 12 do
        local angle = (i / 12) * (2.0 * math.pi)
        local offsetX = math.cos(angle) * 0.0
        local offsetY = math.sin(angle) * 0.0

        UseParticleFxAssetNextCall("core")
        local fx = StartParticleFxLoopedAtCoord(
            "exp_grd_grenade_smoke",
            coords.x + offsetX,
            coords.y + offsetY,
            coords.z + 0.0,
            0.0, 0.0, 0.0,
            1.5, 
            false, false, false, false
        )

        if fx ~= -1 then
            table.insert(fxHandles, fx)
        end
    end

    CreateThread(function()
        Wait(time)
        for _, fx in ipairs(fxHandles) do
            StopParticleFxLooped(fx, false)
        end
        SmokeTracking[smokeId] = nil
    end)
end)
