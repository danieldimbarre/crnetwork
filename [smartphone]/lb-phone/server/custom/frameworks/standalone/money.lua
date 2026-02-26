if Config.Framework ~= "standalone" then
    return
end

local Active = {}

---Get the bank balance of a player
---@param source number
---@return integer
function GetBalance(source)
    local Passport = vRP.Passport(source)
    if not Passport then
        return 0
    end

    return vRP.GetBank(Passport)
end

---Add money to a player's bank account
---@param source number
---@param amount integer
---@return boolean success
function AddMoney(source,amount)
    local Passport = vRP.Passport(source)
    if not Passport or Active[Passport] then
        return false
    end

    Active[Passport] = true
    if vRP.GiveBank(Passport,amount) then
        Active[Passport] = nil
        return true
    end

    return false
end

---@param identifier string
---@param amount number
---@return boolean success
function AddMoneyOffline(identifier, amount)
    return false
end

---Remove money from a player's bank account
---@param source number
---@param amount integer
---@return boolean success
function RemoveMoney(source,amount)
    local Passport = vRP.Passport(source)
    if not Passport or Active[Passport] then
        return false
    end

    Active[Passport] = true
    if vRP.PaymentBank(Passport,amount) then
        Active[Passport] = nil
        return true
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
    if Active[Passport] then
        Active[Passport] = nil
    end
end)