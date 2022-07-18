-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("service",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Permission = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Toggle")
AddEventHandler("service:Toggle",function(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local splitName = splitString(Service,"-")
		local serviceName = splitName[1]

		if vRP.HasPermission(Passport,serviceName) then
			if serviceName == "Lspd" or serviceName == "Sheriff" or serviceName == "Corrections" or serviceName == "Ranger" or serviceName == "State" then
				vRP.BlankPermission(Passport,"Police")
				TriggerEvent("blipsystem:Exit",source)
				Player(source)["state"]["Police"] = false
				TriggerEvent("Salary:Remove",Passport,"Emergency")
			end

			if serviceName == "Paramedic" then
				TriggerEvent("blipsystem:Exit",source)
				vRP.BlankPermission(Passport,serviceName)
				Player(source)["state"]["Paramedic"] = false
				TriggerEvent("Salary:Remove",Passport,"Emergency")
			end

			vRP.RemovePermission(Passport,serviceName)
			vRP.SetPermission(Passport,"wait"..serviceName)

			TriggerClientEvent("Notify",source,"azul","Saiu de serviço.",5000)
			TriggerClientEvent("service:Label",source,serviceName,"Entrar em Serviço",5000)
		elseif vRP.HasPermission(Passport,"wait"..serviceName) then
			if serviceName == "Lspd" or serviceName == "Sheriff" or serviceName == "Corrections" or serviceName == "Ranger" or serviceName == "State" then
				TriggerEvent("blipsystem:Enter",source,serviceName,true)
				TriggerEvent("Salary:Add",Passport,"Emergency")
				Player(source)["state"]["Police"] = true
			end

			if serviceName == "Paramedic" then
				TriggerEvent("blipsystem:Enter",source,"Paramedic",true)
				TriggerEvent("Salary:Add",Passport,"Emergency")
				Player(source)["state"]["Paramedic"] = true
			end

			vRP.SetPermission(Passport,serviceName)
			vRP.RemovePermission(Passport,"wait"..serviceName)

			TriggerClientEvent("Notify",source,"azul","Entrou em serviço.",5000)
			TriggerClientEvent("service:Label",source,serviceName,"Sair de Serviço",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("painel",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport and args[1] then
		if vRP.HasPermission(Passport,"set"..args[1]) then
			Permission[Passport] = args[1]
			TriggerClientEvent("service:Open",source,args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Request()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Permission[Passport] then
		local Members = {}
		local Sources = vRP.Players()
		local Selected = Permission[Passport]
		local Entitys = vRP.DataGroups(Selected)

		for Passport,v in pairs(Entitys) do
			local Passport = parseInt(Passport)
			local Identity = vRP.Identity(Passport)
			if Identity then
				table.insert(Members,{ ["Name"] = Identity["name"].." "..Identity["name2"], ["Phone"] = Identity["phone"], ["Status"] = Sources[Passport], ["Passport"] = Passport })
			end
		end

		if Selected == "Lspd" or Selected == "State" or Selected == "Ranger" or Selected == "Sheriff" or Selected == "Corrections" or Selected == "Paramedic" then
			local Entitys = vRP.DataGroups("wait"..Selected)

			for Passport,v in pairs(Entitys) do
				local Passport = parseInt(Passport)
				local Identity = vRP.Identity(Passport)
				if Identity then
					table.insert(Members,{ ["Name"] = Identity["name"].." "..Identity["name2"], ["Phone"] = Identity["phone"], ["Status"] = Sources[Passport], ["Passport"] = Passport })
				end
			end
		end

		return Members
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Remove")
AddEventHandler("service:Remove",function(Passport)
	local source = source
	local Passport = parseInt(Passport)
	local Passport = vRP.Passport(source)
	if Passport and Permission[Passport] and Passport > 1 and Passport ~= Passport then
		if vRP.HasPermission(Passport,"set"..Permission[Passport]) then
			vRP.CleanPermission(Passport)
			TriggerClientEvent("service:Update",source)
			TriggerClientEvent("Notify",source,"verde","Passaporte removido.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Add")
AddEventHandler("service:Add",function(Passport)
	local source = source
	local Passport = parseInt(Passport)
	local Passport = vRP.Passport(source)
	if Passport and Permission[Passport] and Passport > 1 and Passport ~= Passport then
		if vRP.HasPermission(Passport,"set"..Permission[Passport]) then
			vRP.CleanPermission(Passport)
			vRP.SetPermission(Passport,Permission[Passport])
			TriggerClientEvent("Notify",source,"verde","Passaporte adicionado.",5000)
			TriggerClientEvent("service:Update",source)
		end
	end
end)