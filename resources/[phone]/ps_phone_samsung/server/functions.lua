-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy  = module("vrp","lib/Proxy")
local lib    = loadmodule(GetCurrentResourceName(),"lib/lib")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- variabless
-----------------------------------------------------------------------------------------------------------------------------------------
local blips   = {}
local queries = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- database set
-----------------------------------------------------------------------------------------------------------------------------------------
DB = {}

DB.prepare = function(name, query)
    queries[name] = query
end

DB.execute = function(name, params)
    local query = queries[name]

    if query == nil then
        query = name
    end

    local r = async()
    if Config.DBConector == "GHMattiMySQL" then
        if query == nil then
            local _params = {}
            _params._ = true

            for k,v in pairs(params) do
                _params["@"..k] = v
            end

            params = _params
        end

        exports['GHMattiMySQL']:QueryAsync(query, params, function(affected)
            r(affected or 0)
        end)
    elseif Config.DBConector == "ghmattimysql" then
        exports.ghmattimysql:execute(query, params, function(data)
            r(data.affectedRows or 0)
        end)
    elseif Config.DBConector == "oxmysql" then
        exports.oxmysql:execute(query, params, function(data)
            r(data or 0)
        end)
    else
        exports.oxmysql:execute(query, params, function(data)
            r(data or 0)
        end)
    end

    return r:wait()
end

DB.query = function(name, params)
    local query = queries[name]

    if query == nil then
        query = name
    end

    local rows = {}
    
    if Config.DBConector == "GHMattiMySQL" then
        if query == nil then
            local _params = {}
            _params._ = true

            for k,v in pairs(params) do
                _params["@"..k] = v
            end

            params = _params
        end

        local r = async()

        exports['GHMattiMySQL']:QueryResultAsync(query, params, function(rows)
            r(rows,#rows)
        end)

        rows = r:wait()
    elseif Config.DBConector == "ghmattimysql" then
        rows = exports.ghmattimysql:executeSync(query, params)
    elseif Config.DBConector == "oxmysql" then
        rows = exports.oxmysql:executeSync(query, params)
    else
        rows = exports.oxmysql:executeSync(query, params)
    end
    return rows
end

DB.insert = function(name, params)
    local query = queries[name]

    if query == nil then
        query = name
    end

    local r = async()
    if Config.DBConector == "ghmattimysql" then
        exports.ghmattimysql:insert(query, params, function(id)
            r(id or 0)
        end)
    elseif Config.DBConector == "oxmysql" then
        exports.oxmysql:insert(query, params, function(id)
            r(id or 0)
        end)
    else
        exports.oxmysql:insert(query, params, function(id)
            r(id or 0)
        end)
    end

    return r:wait()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserSource
-----------------------------------------------------------------------------------------------------------------------------------------
getUserSource = function(user_id)
    return vRP.Source(tonumber(user_id))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserId
-----------------------------------------------------------------------------------------------------------------------------------------
getUserId = function(source)
    return vRP.Passport(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserIdentity
-----------------------------------------------------------------------------------------------------------------------------------------
getUserIdentity = function(user_id)
    return vRP.Identity(user_id)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserFullName
-----------------------------------------------------------------------------------------------------------------------------------------
getUserFullName = function(user_id)
    local identity = getUserIdentity(user_id)
    local name = identity["name"].." "..identity["name2"]
    return name
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserByPhone
-----------------------------------------------------------------------------------------------------------------------------------------
getUserByPhone = function(phone)
    local data = vRP.UserPhone(phone)
    if data ~= false then
        return data.id
    end
    return vRP.UserPhone(phone)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUsers
-----------------------------------------------------------------------------------------------------------------------------------------
getUsers = function()
    return vRP.Players()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getHasPermission
-----------------------------------------------------------------------------------------------------------------------------------------
getHasPermission = function(user_id, perm)
    return vRP.HasPermission(user_id,perm)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- checkIteminInvetory
-----------------------------------------------------------------------------------------------------------------------------------------
checkIteminInvetory = function(user_id, item, amount)
    local check = vRP.InventoryItemAmount(user_id, item)
    if check[1] >= amount then
        return true
    else
        return false
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- giveInventoryItem
-----------------------------------------------------------------------------------------------------------------------------------------
giveInventoryItem = function(user_id, item, amount)
    return vRP.GiveItem(user_id, item, amount, true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUsersByPermission
-----------------------------------------------------------------------------------------------------------------------------------------
getUsersByPermission = function(group)
    return vRP.NumPermission(group)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- treatUsersByPermission
-----------------------------------------------------------------------------------------------------------------------------------------
treatUsersByPermission = function(id)
    local player = id
    local user_id = getUserId(player)
    return player,user_id
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- createBlipTimeout
-----------------------------------------------------------------------------------------------------------------------------------------
createBlipTimeout = function(source,idgens,x,y,z,title,timeout)
    local idgens = lib.newIDGenerator()
    local id = idgens:gen()
    TriggerClientEvent(GetCurrentResourceName()..':addblip',source,id,x,y,z,358,71,title,0.6,false)
    SetTimeout(timeout,function() 
        TriggerClientEvent(GetCurrentResourceName()..':removeblip',source,id)
        idgens:free(id) 
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- requestAcceptorNot
-----------------------------------------------------------------------------------------------------------------------------------------
requestAcceptorNot = function(source,title,timeout)
    vHUD = Tunnel.getInterface("hud")
    return vHUD.Request(source,title,"Sim","Não")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- checkPlayerHandcuffed
-----------------------------------------------------------------------------------------------------------------------------------------
checkPlayerHandcuffed = function(source)
    return Player(source)["state"]["Handcuff"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getBankMoney
-----------------------------------------------------------------------------------------------------------------------------------------
getBankMoney = function(user_id)
    return vRP.GetBank(user_id)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- addBankMoney
-----------------------------------------------------------------------------------------------------------------------------------------
addBankMoney = function(user_id, amount)
    vRP.GiveBank(user_id, tonumber(amount), "Private")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- remBankMoney
-----------------------------------------------------------------------------------------------------------------------------------------
remBankMoney = function(user_id, amount)
    vRP.PaymentBank(user_id, tonumber(amount))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- expulseUser
-----------------------------------------------------------------------------------------------------------------------------------------
expulseUser = function(user_id, message)
    vRP.Kick(user_id, message)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- formatnumber
-----------------------------------------------------------------------------------------------------------------------------------------
formatnumber = function(number)
	local left,num,right = string.match(number,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserData
-----------------------------------------------------------------------------------------------------------------------------------------
getUserData = function(user_id, key)
    local consult = vRP.Query("playerdata/GetData",{ Passaport = tonumber(user_id), dkey = key })
	if consult[1] then
		return consult[1]["dvalue"]
	else
		return "{}"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- setUserData
-----------------------------------------------------------------------------------------------------------------------------------------
setUserData = function(user_id, key, data)
    vRP.Execute("playerdata/SetData", { Passaport = tonumber(user_id), dkey = key, dvalue = data })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserFines
-----------------------------------------------------------------------------------------------------------------------------------------
getUserFines = function(user_id)
    local source = source
    local fines = {}
    local finesamount = vRP.GetFines(source) or 0

    if finesamount == "" then
        return fines
    end
    
    if tonumber(finesamount) > 0 then
        local data = {
            id     = 1,
            status = false,
            date   = os.date("%d/%m/%Y"),
            amount = tonumber(finesamount)
        }
        table.insert(fines,data)
    end

    return fines
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getUserFine
-----------------------------------------------------------------------------------------------------------------------------------------
getUserFine = function(source, id)
    local fines = {}
    local finesamount = vRP.GetFines(source)

    if tonumber(finesamount) > 0 then
        return tonumber(finesamount)
    end

    return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- payFines
-----------------------------------------------------------------------------------------------------------------------------------------
payFines = function(user_id, id)
    local source = source
    local amount = getUserFine(source, id)
    return vRP.RemoveFine(user_id,amount,source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- sendnotify
-----------------------------------------------------------------------------------------------------------------------------------------
sendnotify = function(source, type, message, time)
    if time == nil then
        time = 5000
    end

    if source then
        if type == "sucesso" then
            type = "verde"
        elseif type == "negado" then
            type = "vermelho"
        elseif type == "aviso" then
            type = "amarelo"
        elseif type == "importante" then
            type = "azul"
        end
        
        TriggerClientEvent("Notify",source,type,message,time)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- sendnotifypush
-----------------------------------------------------------------------------------------------------------------------------------------
sendnotifypush = function(source,title,message,x,y,z,name,phone)
    if source then 
        TriggerClientEvent("NotifyPush",source,{ code = 20, title = title, x = x, y = y, z = z, name = name, phone = phone, text = message, time = "Recebido às "..os.date("%H:%M"), blipColor = 25 })
    end
end