-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("dynamic",Creative)
vSKINSHOP = Tunnel.getInterface("skinshop")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local CountClothes = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CODES
-----------------------------------------------------------------------------------------------------------------------------------------
local Codes = {
	["13"] = {
		["Message"] = "Oficial desmaiado/ferido",
		["Blip"] = 6
	},
	["20"] = {
		["Message"] = "Localização",
		["Blip"] = 6
	},
	["38"] = {
		["Message"] = "Abordagem de trânsito",
		["Blip"] = 6
	},
	["78"] = {
		["Message"] = "Apoio com prioridade",
		["Blip"] = 6
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:TENCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:Tencode")
AddEventHandler("dynamic:Tencode",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasService(Passport,"Policia") and Codes[Number] then
		local FullName = vRP.FullName(Passport)
		local Coords = vRP.GetEntityCoords(source)
		local Service = vRP.NumPermission("Policia")

		for Passports,Sources in pairs(Service) do
			async(function()
				if Number == "13" then
					TriggerClientEvent("sounds:Private",Sources,"deathcop",0.5)
				else
					vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				end

				TriggerClientEvent("NotifyPush",Sources,{ code = Number, title = Codes[Number]["Message"], x = Coords["x"], y = Coords["y"], z = Coords["z"], name = FullName, color = Codes[Number]["Blip"] })
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:ENTERSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:EnterService")
AddEventHandler("dynamic:EnterService",function(Permission)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Permission == "Policia" then
			if vRP.HasPermission(Passport,"LSPD") then
				vRP.ServiceEnter(source,Passport,"LSPD")
			elseif vRP.HasPermission(Passport,"BCPR") then
				vRP.ServiceEnter(source,Passport,"BCPR")
			elseif vRP.HasPermission(Passport,"BCSO") then
				vRP.ServiceEnter(source,Passport,"BCSO")
			end
		else
			vRP.ServiceEnter(source,Passport,Permission)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:EXITSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:ExitService")
AddEventHandler("dynamic:ExitService",function(Permission)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Permission == "Policia" then
			if vRP.HasPermission(Passport,"LSPD") then
				vRP.ServiceLeave(source,Passport,"LSPD")
			elseif vRP.HasPermission(Passport,"BCPR") then
				vRP.ServiceLeave(source,Passport,"BCPR")
			elseif vRP.HasPermission(Passport,"BCSO") then
				vRP.ServiceLeave(source,Passport,"BCSO")
			end
		else
			vRP.ServiceLeave(source,Passport,Permission)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Clothes()
	local Clothes = {}
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		CountClothes[Passport] = 2
		local Consult = vRP.GetSrvData("Clothes:"..Passport,true)

		if vRP.UserPremium(Passport) then
			local Hierarchy = vRP.LevelPremium(source)
			if Hierarchy == 1 then
				CountClothes[Passport] = 8
			elseif Hierarchy == 2 then
				CountClothes[Passport] = 6
			else
				CountClothes[Passport] = 4
			end
		end

		local Amount = CountClothes[Passport]
		for Table,_ in pairs(Consult) do
			if Amount > 0 then
				Clothes[#Clothes + 1] = Table
				Amount = Amount - 1
			end
		end
	end

	return Clothes
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:Clothes")
AddEventHandler("dynamic:Clothes",function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.GetSrvData("Clothes:"..Passport,true)
		local Split = splitString(Mode)
		local Name = Split[2]

		if Split[1] == "Save" then
			if CountTable(Consult) >= CountClothes[Passport] then
				TriggerClientEvent("Notify",source,"Armário","Limite atingide de roupas.","amarelo",5000)

				return false
			end

			local Keyboard = vKEYBOARD.Primary(source,"Nome")
			if Keyboard then
				local Check = sanitizeString(Keyboard[1],"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")

				if not Consult[Check] then
					Consult[Check] = vSKINSHOP.Customization(source)
					TriggerClientEvent("Notify",source,"Armário","<b>"..Check.."</b> adicionado.","verde",5000)
					vRP.SetSrvData("Clothes:"..Passport,Consult,true)
					TriggerClientEvent("dynamic:Clothes",source)
				else
					TriggerClientEvent("Notify",source,"Armário","Nome escolhido já existe em seu armário.","amarelo",5000)
				end
			end
		elseif Split[1] == "Delete" then
			if Consult[Name] then
				Consult[Name] = nil
				TriggerClientEvent("Notify",source,"Armário","<b>"..Name.."</b> removido.","verde",5000)
				vRP.SetSrvData("Clothes:"..Passport,Consult,true)
				TriggerClientEvent("dynamic:Clothes",source)
			else
				TriggerClientEvent("Notify",source,"Armário","A vestimenta salva não se encontra mais em seu armário.","amarelo",5000)
			end
		elseif Split[1] == "Apply" then
			if Consult[Name] then
				TriggerClientEvent("skinshop:Apply",source,Consult[Name])
				TriggerClientEvent("Notify",source,"Armário","<b>"..Name.."</b> aplicado.","verde",5000)
			else
				TriggerClientEvent("Notify",source,"Armário","A vestimenta salva não se encontra mais em seu armário.","amarelo",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if CountClothes[Passport] then
		CountClothes[Passport] = nil
	end
end)