-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Cooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON:ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("prison:Itens")
AddEventHandler("prison:Itens",function(OtherSource)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport or not OtherSource or not vRP.HasService(Passport,"Policia") or vRP.GetHealth(source) <= 100 then
		return false
	end

	local OtherPassport = vRP.Passport(OtherSource)
	if not OtherPassport then
		return false
	end

	TriggerClientEvent("Notify",source,"Sucesso","Objetos apreendidos.","verde",5000)
	exports.inventory:CleanWeapons(OtherPassport)
	vRP.ArrestItens(OtherPassport)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON:VEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("prison:Vehicle")
AddEventHandler("prison:Vehicle",function(Entity)
	local source = source
	local Plate = Entity[1]
	local Passport = vRP.Passport(source)
	if not Passport or not Plate then
		return false
	end

	if not vRP.Request(source,"Garagem","Apreender o veículo?") then
		return false
	end

	local Consult = vRP.SingleQuery("vehicles/plateVehicles",{ Plate = Plate })
	if not Consult then
		return false
	end

	if not Consult.Arrest then
		vRP.Update("vehicles/Arrest",{ Plate = Plate })
		TriggerClientEvent("Notify",source,"Departamento Policial","Veículo apreendido.","policia",5000)
	else
		TriggerClientEvent("Notify",source,"Departamento Policial","Veículo já se encontra apreendido.","policia",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON:PLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("prison:Plate")
AddEventHandler("prison:Plate",function(Entitys)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport or not vRP.HasService(Passport,"Policia") then
		return false
	end

	local Plate = (Entitys and Entitys[1]) or (function()
		TriggerClientEvent("dynamic:Close",source)

		local Keyboard = vKEYBOARD.Primary(source,"Placa")
		return Keyboard and Keyboard[1]
	end)()

	if not Plate then
		return false
	end

	local OtherPassport = vRP.PassportPlate(Plate)
	if not OtherPassport then
		return false
	end

	local Identity = vRP.Identity(OtherPassport)
	if not Identity then
		return false
	end

	local Message = string.format("<b>Passaporte:</b> %s<br><b>Telefone:</b> %s<br><b>Nome:</b> %s %s",Identity.id,vRP.Phone(OtherPassport),Identity.Name,Identity.Lastname)
	TriggerClientEvent("Notify",source,"Emplacamento",Message,"policia",10000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON:SERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("prison:Service")
AddEventHandler("prison:Service",function()
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
		return false
	end

	local CurrentTimer = os.time()
	if Cooldown[Passport] and Cooldown[Passport] > CurrentTimer then
		return false
	end

	local Identity = vRP.Identity(Passport)
	if not Identity or Identity.Prison <= 0 then
		return false
	end

	Cooldown[Passport] = CurrentTimer + 60
	vRP.UpdatePrison(Passport)
end)