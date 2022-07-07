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
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local Webhook = "https://discordapp.com/api/webhooks/941921168036884480/m8tNc3UoVWDHayiBGr2qaV8YEOpu8zM949dYUoHZikJgTAjy8Xvb32ocGq3eaF_JSweA"
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

		if vRP.hasPermission(Passport,serviceName) then
			if serviceName == "Lspd" or serviceName == "Sheriff" or serviceName == "Corrections" or serviceName == "Ranger" or serviceName == "State" then
				vRP.removePermission(Passport,"Police")
				TriggerEvent("blipsystem:Exit",source)
				Player(source)["state"]["Police"] = false
				TriggerEvent("Salary:Remove",Passport,"Emergency")
			end

			if serviceName == "Paramedic" then
				TriggerEvent("blipsystem:Exit",source)
				vRP.removePermission(Passport,serviceName)
				Player(source)["state"]["Paramedic"] = false
				TriggerEvent("Salary:Remove",Passport,"Emergency")
			end

			vRP.remPermission(Passport,serviceName)
			vRP.setPermission(Passport,"wait"..serviceName)

			TriggerClientEvent("Notify",source,"azul","Saiu de serviço.",5000)
			TriggerClientEvent("service:Label",source,serviceName,"Entrar em Serviço",5000)
		elseif vRP.hasPermission(Passport,"wait"..serviceName) then
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

			vRP.setPermission(Passport,serviceName)
			vRP.remPermission(Passport,"wait"..serviceName)

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
		if vRP.hasPermission(Passport,"set"..args[1]) then
			Permission[Passport] = args[1]
			TriggerClientEvent("service:Open",source,args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Roles = {
	["Ranger"] = "941921989503889408",
	["State"] = "941921989503889408",
	["Corrections"] = "941921989503889408",
	["Lspd"] = "941921989503889408",
	["Sheriff"] = "941921989503889408",
	["Paramedic"] = "941922007484858429",
	["BurgerShot"] = "969807066824843335",
	["PizzaThis"] = "969807069429518336",
	["UwuCoffee"] = "969807075028922408",
	["BeanMachine"] = "969807077335760926",
	["Ballas"] = "973835350269108274",
	["Families"] = "973835355683946496",
	["Vagos"] = "973835358724816906",
	["Aztecas"] = "973835361283350598",
	["Bloods"] = "973835363854458911",
	["Triads"] = "973997099387588619",
	["Razors"] = "973997103770664961"
}
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
		if vRP.hasPermission(Passport,"set"..Permission[Passport]) then
			vRP.cleanPermission(Passport)
			TriggerClientEvent("Notify",source,"verde","Passaporte removido.",5000)

			local Identity = vRP.Identity(Passport)
			if Identity then
				local Account = vRP.Account(Identity["license"])
				if Account and Roles[Permission[Passport]] then
					PerformHttpRequest(Webhook,function(err,text,headers) end,"POST",json.encode({
						username = "CR Network",
						content = Account["discord"].." "..Roles[Permission[Passport]].." Remover"
					}),{ ["Content-Type"] = "application/json" })
				end
			end

			TriggerClientEvent("service:Update",source)
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
		if vRP.hasPermission(Passport,"set"..Permission[Passport]) then
			vRP.cleanPermission(Passport)
			vRP.setPermission(Passport,Permission[Passport])
			TriggerClientEvent("Notify",source,"verde","Passaporte adicionado.",5000)

			local Identity = vRP.Identity(Passport)
			if Identity then
				local Account = vRP.Account(Identity["license"])
				if Account and Roles[Permission[Passport]] then
					PerformHttpRequest(Webhook,function(err,text,headers) end,"POST",json.encode({
						username = "CR Network",
						content = Account["discord"].." "..Roles[Permission[Passport]].." Adicionar"
					}),{ ["Content-Type"] = "application/json" })
				end
			end

			TriggerClientEvent("service:Update",source)
		end
	end
end)