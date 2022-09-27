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
Tunnel.bindInterface("admin",Creative)
vCLIENT = Tunnel.getInterface("admin")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- UGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ugroups",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport and parseInt(args[1]) > 0 then
		local Message = ""
		local Groups = vRP.Groups()
		local OtherPassport = args[1]
		for Permission,_ in pairs(Groups) do
			local Data = vRP.DataGroups(Permission)
			if Data[OtherPassport] then
				Message = Message..Permission.."<br>"
			end
		end

		if Message ~= "" then
			TriggerClientEvent("Notify",source,"verde",Message,10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinv",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") and parseInt(args[1]) > 0 then
			TriggerClientEvent("Notify",source,"verde","Limpeza concluída.",5000)
			vRP.ClearInventory(args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gem",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local Amount = parseInt(args[2])
			local OtherPassport = parseInt(args[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				TriggerClientEvent("Notify",source,"verde","Gemas entregues.",5000)
				vRP.Execute("accounts/AddGems",{ license = Identity["license"], gems = Amount })
				TriggerEvent("Discord","Gemstone","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Gemas:** "..Amount.."\n**Address:** "..GetPlayerEndpoint(source),3092790)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blips",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") then
			vRPC.BlipAdmin(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") then
			if args[1] then
				local OtherPassport = parseInt(args[1])
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					vRP.UpgradeThirst(OtherPassport,100)
					vRP.UpgradeHunger(OtherPassport,100)
					vRP.DowngradeStress(OtherPassport,100)
					vRPC.revivePlayer(ClosestPed,200)
				end
			else
				vRP.SetArmour(source,100)
				vRPC.revivePlayer(source,200)
				vRP.UpgradeThirst(Passport,100)
				vRP.UpgradeHunger(Passport,100)
				vRP.DowngradeStress(Passport,100)

				TriggerClientEvent("paramedic:Reset",source)

				vRPC.removeObjects(source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			if args[1] and args[2] and itemBody(args[1]) ~= nil then
				vRP.GenerateItem(Passport,args[1],parseInt(args[2]),true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item2",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			if args[1] and args[2] and args[3] and itemBody(args[1]) ~= nil then
				vRP.GenerateItem(args[3],args[1],parseInt(args[2]),true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport and args[1] then
		if vRP.HasGroup(Passport,"Moderator") then
			local OtherPassport = parseInt(args[1])
			vRP.Execute("characters/removeCharacter",{ id = OtherPassport })
			TriggerClientEvent("Notify",source,"verde","Personagem <b>"..OtherPassport.."</b> deletado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") then
			vRPC.noClip(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") and parseInt(args[1]) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..args[1].."</b> expulso.",5000)
			vRP.Kick(args[1],"Expulso da cidade.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local time = parseInt(args[2])
			local OtherPassport = parseInt(args[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				vRP.Kick(OtherPassport,"Banido.")
				vRP.Execute("banneds/InsertBanned",{ license = Identity["license"], time = time })
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..OtherPassport.."</b> banido por <b>"..time.."</b> dias.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") and parseInt(args[1]) > 0 then
			local OtherPassport = parseInt(args[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				vRP.Execute("banneds/RemoveBanned",{ license = Identity["license"] })
				TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..OtherPassport.."</b> desbanido.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") then
			local Keyboard = vKEYBOARD.keySingle(source,"Cordenadas:")
			if Keyboard then
				local Split = splitString(Keyboard[1],",")
				vRP.Teleport(source,Split[1] or 0,Split[2] or 0,Split[3] or 0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vKEYBOARD.keyCopy(source,"Cordenadas:",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") and parseInt(args[1]) > 0 and args[2] then
			TriggerClientEvent("Notify",source,"verde","Adicionado <b>"..args[2].."</b> ao passaporte <b>"..args[1].."</b>.",5000)
			vRP.SetPermission(args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") and parseInt(args[1]) > 0 and args[2] then
			TriggerClientEvent("Notify",source,"verde","Removido <b>"..args[2].."</b> ao passaporte <b>"..args[1].."</b>.",5000)
			vRP.RemovePermission(args[1],args[2])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") and parseInt(args[1]) > 0 then
			local ClosestPed = vRP.Source(args[1])
			if ClosestPed then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)

				vRP.Teleport(ClosestPed,Coords["x"],Coords["y"],Coords["z"])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") and parseInt(args[1]) > 0 then
			local ClosestPed = vRP.Source(args[1])
			if ClosestPed then
				local Ped = GetPlayerPed(ClosestPed)
				local Coords = GetEntityCoords(Ped)
				vRP.Teleport(source,Coords["x"],Coords["y"],Coords["z"])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") then
			vCLIENT.teleportWay(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) <= 100 then
		vCLIENT.teleportLimbo(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local vehicle = vRPC.vehicleHash(source)
			if vehicle then
				vRP.Archive("hash.txt",vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			TriggerClientEvent("admin:vehicleTuning",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local Vehicle,vehNet,vehPlate = vRPC.vehList(source,10)
			if Vehicle then
				TriggerClientEvent("inventory:repairAdmin",source,vehNet,vehPlate)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			TriggerClientEvent("syncarea",source,Coords["x"],Coords["y"],Coords["z"],100)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") then
			TriggerClientEvent("Notify",source,"azul","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices(),5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:PROPCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:PropCoords")
AddEventHandler("admin:PropCoords",function(Entity)
	vRP.Archive("coordenadas.txt",mathLength(Entity[4]["x"])..","..mathLength(Entity[4]["y"])..","..mathLength(Entity[4]["z"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.buttonTxt()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vRP.Archive(Passport..".txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source,args,rawCommand)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") and args[1] then
			TriggerClientEvent("chat:ClientMessage",-1,"Governador",rawCommand:sub(9))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,args,rawCommand)
	if source == 0 then
		TriggerClientEvent("chat:ClientMessage",-1,"Governador",rawCommand:sub(9))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source)
	if source == 0 then
		local playerList = vRP.Players()
		for Passport,_ in pairs(playerList) do
			vRP.Kick(Passport,"Desconectado, a cidade reiniciou.")
			Wait(100)
		end

		TriggerEvent("admin:KickAll")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local playerList = vRP.Players()
			for PassportPlayer,_ in pairs(playerList) do
				async(function()
					vRP.GenerateItem(PassportPlayer,tostring(args[1]),parseInt(args[2]),true)
				end)
			end

			TriggerClientEvent("Notify",source,"verde","Envio concluído.",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Checkpoint = 0
function Creative.raceCoords(vehCoords,leftCoords,rightCoords)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		Checkpoint = Checkpoint + 1

		vRP.Archive("races.txt","["..Checkpoint.."] = {")

		vRP.Archive("races.txt","{ "..mathLength(vehCoords["x"])..","..mathLength(vehCoords["y"])..","..mathLength(vehCoords["z"]).." },")
		vRP.Archive("races.txt","{ "..mathLength(leftCoords["x"])..","..mathLength(leftCoords["y"])..","..mathLength(leftCoords["z"]).." },")
		vRP.Archive("races.txt","{ "..mathLength(rightCoords["x"])..","..mathLength(rightCoords["y"])..","..mathLength(rightCoords["z"]).." }")

		vRP.Archive("races.txt","},")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = {}
RegisterCommand("spectate",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			if Spectate[Passport] then
				local Ped = GetPlayerPed(Spectate[Passport])
				if DoesEntityExist(Ped) then
					SetEntityDistanceCullingRadius(Ped,0.0)
				end

				TriggerClientEvent("admin:resetSpectate",source)
				Spectate[Passport] = nil
			else
				local nsource = vRP.Source(args[1])
				if nsource then
					local Ped = GetPlayerPed(nsource)
					if DoesEntityExist(Ped) then
						SetEntityDistanceCullingRadius(Ped,999999999.0)
						Wait(1000)
						TriggerClientEvent("admin:initSpectate",source,nsource)
						Spectate[Passport] = nsource
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Spectate[Passport] then
		Spectate[Passport] = nil
	end
end)