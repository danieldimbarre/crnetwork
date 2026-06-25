Smoke = {}
GlobalState["ActiveSmokes"] = {}

AddEventHandler('explosionEvent', function(sender, ev) 
    if ev.explosionType ~= 19 and ev.explosionType ~= 20 then
        return
    end

    local x, y, z = ev.posX, ev.posY, ev.posZ
    local now = os.time() * 1000

    local smokeId = #Smoke + 1
    local smokeData = {
        id = smokeId,
        x = x,
        y = y,
        z = z,
        createdAt = now,
        expiresAt = now + 15000
    }

    Smoke[smokeId] = smokeData

    local activeSmokesList = {}
            
    for id, smoke in pairs(Smoke) do
        if smoke.expiresAt > os.time() * 1000 then
            table.insert(activeSmokesList, smoke)
        end
    end

    GlobalState["ActiveSmokes"] = activeSmokesList

    TriggerClientEvent("client:startSmoke", -1, x, y, z, smokeData.expiresAt - smokeData.createdAt, smokeData.id)

    SetTimeout(15000, function()
        Smoke[smokeId] = nil
        local updatedList = {}

        for id, smoke in pairs(Smoke) do
            if smoke.expiresAt > os.time() * 1000 then
                table.insert(updatedList, smoke)
            end
        end

        GlobalState["ActiveSmokes"] = updatedList
    end)
end)
