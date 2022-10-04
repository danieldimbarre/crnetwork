local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nation_screenshot")
func = {}
Tunnel.bindInterface("nation_screenshot", func)

local Diretory = {
    ["male"] = {
        [285] = "head",
        [350] = "leftarm",
        [446] = "rightarm",
        [553] = "leftleg",
        [608] = "rightleg"
    },
    ["female"] = {
        [296] = "head",
        [358] = "leftarm",
        [453] = "rightarm",
        [561] = "leftleg",
        [616] = "rightleg"
    }
}

local Paste = "torso"
local PhotoCount = 1
---------------------------------------------------------------------------
-----------------------REQUEST DA SCREENSHOT--------------------------
---------------------------------------------------------------------------

function func.takeScreenshot(gender, key, component, data, texture)
    local source = source
    local fileName = 'energy-images/'..gender..'/'..key..'/'..component..'.png'
    if texture then
        fileName = 'energy-images/'..gender..'/'..key..'/'..component..'_'..texture..'.png'
    end
    if key == "tattoo" then
        if Diretory[gender][component] then
            Paste = Diretory[gender][component]
            PhotoCount = 1
        end

        fileName = 'energy-images/'..gender..'/'..key..'/'..Paste..'/'..PhotoCount..'.png'
        PhotoCount = PhotoCount + 1
    elseif key == "overlay" then
        fileName = 'energy-images/'..gender..'/tattoo/hair/'..component..'.png'
    end
    exports['screenshot-basic']:requestClientScreenshot(source, {
        fileName = fileName,
        encoding = 'png',
        quality = 1.0,
        crop = {
            offsetX = data.offsetX,
            offsetY = data.offsetY,
            width = data.width,
            height = data.height
        }
        }, function(err, data)
            print('data', data, not err)
            fclient._requestScreenshot(source, gender, key, component, not err, texture or "")
        end
    )
end


---------------------------------------------------------------------------
-----------------------VERIFICAÇÃO DE PERMISSÃO--------------------------
---------------------------------------------------------------------------


function func.checkPermission(permission)
    local source = source
    local user_id = vRP.Passport(source)
    if type(permission) == "table" then
        for i, perm in pairs(permission) do
            if vRP.HasPermission(user_id, perm) then
                return true
            end
        end
        return false
    end
    return vRP.HasPermission(user_id, permission)
end


