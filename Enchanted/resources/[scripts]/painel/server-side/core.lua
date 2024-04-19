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
Tunnel.bindInterface("painel",Creative)
vCLIENT = Tunnel.getInterface("painel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Information = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("painel",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and not Player(source)["state"]["Buttons"] and exports["chat"]:Open(source) then
		local Permission = vRP.GetUserType(Passport,"Work")
		if Permission then
			local Members = {}
			local Entitys = vRP.DataGroups(Permission)
			local Hierarchy = vRP.Hierarchy(Permission)

			for Index,Number in pairs(Entitys) do
				local OtherPassport = parseInt(Index)
				local Identity = vRP.Identity(OtherPassport)
				local OtherSource = vRP.Source(OtherPassport)
				if Identity then
					local Calculated = Dotted(NumberMinutes(os.time() - Identity["Login"]))
					local Activated = "Inativo a "..Calculated.." minutos."

					if OtherSource then
						Activated = "Ativo a "..Calculated.." minutos."
					end

					Members[#Members + 1] = {
						["id"] = OtherPassport,
						["online"] = OtherSource,
						["name"] = Identity["Name"].." "..Identity["Lastname"],
						["role"] = Hierarchy[Number],
						["phone"] = Activated,
						["role_id"] = Number
					}
				end
			end

			Information[Passport] = Permission

			vCLIENT.Open(source,{ ["groupName"] = Permission, ["members"] = Members, ["client_role"] = vRP.HasPermission(Passport,Permission) })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMISS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Dismiss(OtherPassport)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Information[Passport] and Passport ~= OtherPassport and vRP.HasGroup(Passport,Information[Passport],2) and vRP.HasPermission(OtherPassport,Information[Passport]) >= 2 then
		vRP.RemovePermission(OtherPassport,Information[Passport])
		TriggerClientEvent("Notify",source,"Sucesso","Passaporte removido.","verde",5000)

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVITE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Invite(OtherPassport)
	local source = source
	local Passport = vRP.Passport(source)
	local Identity = vRP.Identity(OtherPassport)
	local OtherSource = vRP.Source(OtherPassport)
	if Passport and Identity and OtherSource and Information[Passport] and Passport ~= OtherPassport and vRP.HasGroup(Passport,Information[Passport],2) then
		if vRP.AmountGroups(Information[Passport]) >= vRP.GroupLimit(Information[Passport]) then
			TriggerClientEvent("Notify",source,"Atenção","Limite de membros atingido.","amarelo",5000)

			return false
		end

		local GroupType = vRP.GroupType(Information[Passport])

		if GroupType == "Work" and Identity["Groups"] >= os.time() then
			TriggerClientEvent("Notify",source,"Atenção","O passaporte escolhido não pode ser convidado para um grupo no momento.","amarelo",5000)

			return false
		end

		if not GroupType or GroupType ~= "Work" or (GroupType == "Work" and not vRP.GetUserType(OtherPassport,"Work")) then
			if vRP.Request(OtherSource,"Grupos","Você foi convidado(a) para participar do grupo <b>"..Information[Passport].."</b>, gostaria de estar entrando do mesmo?") then
				if GroupType == "Work" then
					vRP.SetGroupsTimer(OtherPassport)
				end

				vRP.SetPermission(OtherPassport,Information[Passport])
				TriggerClientEvent("Notify",source,"Sucesso","Passaporte adicionado.","verde",5000)

				local Hierarchy = vRP.Hierarchy(Information[Passport])
				local Number = vRP.HasPermission(OtherPassport,Information[Passport])

				if Information[Passport] == "Policia" then
					local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = OtherPassport, Vehicle = "polchar" })
					if not Vehicle[1] then
						vRP.Query("vehicles/addVehicles",{ Passport = OtherPassport, Vehicle = "polchar", Plate = vRP.GeneratePlate(), Work = 0 })
					end
				end

				return {
					["id"] = OtherPassport,
					["online"] = vRP.Source(OtherPassport),
					["name"] = Identity["Name"].." "..Identity["Lastname"],
					["phone"] = Identity["Phone"],
					["role"] = Hierarchy[Number],
					["role_id"] = Number
				}
			else
				TriggerClientEvent("Notify",source,"Atenção","Convite para o grupo recusado.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"Atenção","O passaporte já pertence a outro grupo.","amarelo",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Hierarchy(OtherPassport,Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Information[Passport] and Passport ~= OtherPassport and vRP.Identity(OtherPassport) and vRP.HasGroup(Passport,Information[Passport],2) then
		local Hierarchy = vRP.Hierarchy(Information[Passport])
		if (Mode == "Promote" and vRP.HasPermission(OtherPassport,Information[Passport]) <= 2) or (Mode == "Demote" and vRP.HasPermission(OtherPassport,Information[Passport]) >= #Hierarchy) then
			return false
		end

		vRP.SetPermission(OtherPassport,Information[Passport],nil,Mode)
		TriggerClientEvent("Notify",source,"Sucesso","Hierarquia atualizada.","verde",5000)

		local Number = vRP.HasPermission(OtherPassport,Information[Passport])

		return { Hierarchy[Number],Number }
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Information[Passport] then
		Information[Passport] = nil
	end

	if Active[Passport] then
		Active[Passport] = nil
	end
end)