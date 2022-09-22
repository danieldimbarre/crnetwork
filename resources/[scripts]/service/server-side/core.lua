-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("service",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Permission = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("service:Toggle")
AddEventHandler("service:Toggle",function(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local splitName = splitString(Service,"-")
		local Name = splitName[1]

		if vRP.HasPermission(Passport,Name) then
			if Name == "Police" or Name == "Paramedic" then
				Player(source)["state"][Name] = false
				TriggerEvent("blipsystem:Exit",source)
				TriggerEvent("Salary:Remove",Passport,Name)
			end

			vRP.RemovePermission(Passport,Name)
			vRP.SetPermission(Passport,"wait"..Name)

			TriggerClientEvent("Notify",source,"azul","Saiu de serviço.",5000)
			TriggerClientEvent("service:Label",source,Name,"Entrar em Serviço",5000)
		elseif vRP.HasPermission(Passport,"wait"..Name) then
			if Name == "Police" or Name == "Paramedic" then
				Player(source)["state"][Name] = true
				TriggerEvent("Salary:Add",Passport,Name)
				TriggerEvent("blipsystem:Enter",source,Name,true)
			end

			vRP.SetPermission(Passport,Name)
			vRP.RemovePermission(Passport,"wait"..Name)

			TriggerClientEvent("Notify",source,"azul","Entrou em serviço.",5000)
			TriggerClientEvent("service:Label",source,Name,"Sair de Serviço",5000)
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
function Creative.Request()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Permission[Passport] then
		local Members = {}
		local Sources = vRP.Players()
		local Entitys = vRP.DataGroups(Permission[Passport])

		for Number,_ in pairs(Entitys) do
			local Number = parseInt(Number)
			local Identity = vRP.Identity(Number)
			if Identity then
				table.insert(Members,{ ["Name"] = Identity["name"].." "..Identity["name2"], ["Phone"] = Identity["phone"], ["Status"] = Sources[Number], ["Passport"] = Number })
			end
		end

		if Permission[Passport] == "Police" or Permission[Passport] == "Paramedic" then
			local Entitys = vRP.DataGroups("wait"..Permission[Passport])

			for Number,_ in pairs(Entitys) do
				local Number = parseInt(Number)
				local Identity = vRP.Identity(Number)
				if Identity then
					table.insert(Members,{ ["Name"] = Identity["name"].." "..Identity["name2"], ["Phone"] = Identity["phone"], ["Status"] = Sources[Number], ["Passport"] = Number })
				end
			end
		end

		return Members
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("service:Remove")
AddEventHandler("service:Remove",function(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport and Permission[Passport] and Number > 1 and Passport ~= Number then
		if vRP.HasPermission(Passport,"set"..Permission[Passport]) then
			vRP.RemovePermission(Number,Permission[Passport])
			vRP.RemovePermission(Number,"wait"..Permission[Passport])

			TriggerClientEvent("service:Update",source)
			TriggerClientEvent("Notify",source,"verde","Passaporte removido.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("service:Add")
AddEventHandler("service:Add",function(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport and Permission[Passport] and Number > 1 and Passport ~= Number and vRP.Identity(Number) then
		if vRP.HasPermission(Passport,"set"..Permission[Passport]) then
			vRP.RemovePermission(Number,Permission[Passport])
			vRP.RemovePermission(Number,"wait"..Permission[Passport])

			vRP.SetPermission(Number,Permission[Passport])
			TriggerClientEvent("Notify",source,"verde","Passaporte adicionado.",5000)
			TriggerClientEvent("service:Update",source)
		end
	end
end)