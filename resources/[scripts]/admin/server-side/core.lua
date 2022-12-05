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
vSKINSHOP = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- UGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ugroups",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") and parseInt(Message[1]) > 0 then
			local Messages = ""
			local Groups = vRP.Groups()
			local OtherPassport = Message[1]
			for Permission,_ in pairs(Groups) do
				local Data = vRP.DataGroups(Permission)
				if Data[OtherPassport] then
					Messages = Messages..Permission.."<br>"
				end
			end

			if Messages ~= "" then
				TriggerClientEvent("Notify",source,"verde",Messages,10000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinv",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 then
			TriggerClientEvent("Notify",source,"verde","Limpeza concluída.",5000)
			vRP.ClearInventory(Message[1])

			TriggerEvent("Discord","Admin","**clearinv**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1],nil)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearchest",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and Message[2] then
			local Consult = vRP.Query("chests/GetChests",{ name = Message[2] })
			if Consult[1] then
				TriggerClientEvent("Notify",source,"verde","Limpeza concluída.",5000)
				vRP.SetSrvData("Chest:"..Message[2],"{}",true)
				
				TriggerEvent("Discord","Admin","**clearchest**\n\n**Passaporte:** "..Passport.."\n**Chest:** "..Message[2],nil)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gem",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
			local Amount = parseInt(Message[2])
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				TriggerClientEvent("Notify",source,"verde","Gemas entregues.",5000)
				vRP.Query("accounts/AddGems",{ license = Identity["license"], gems = Amount })

				local OtherSource = vRP.Source(OtherPassport)
				if OtherSource then
					TriggerClientEvent("Notify",OtherSource,"azul","Você recebeu "..Amount.."x Gemas.",5000)
				end

				TriggerEvent("Discord","Gemstone","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Gemas:** "..Amount.."\n**Address:** "..GetPlayerEndpoint(source),3092790)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gems',function(source,Message)
	if source == 0 then
		local Passport = parseInt(Message[1])
		local Amount = parseInt(Message[2])
		
		local Source = vRP.Source(Passport)
		if Source then
			vRP.UpgradeGemstone(Passport,Amount)

			TriggerClientEvent("Notify",Source,"azul","Você recebeu "..Amount.."x Gemas.",5000)
		else
			local Identity = vRP.Identity(Passport)
			if Identity then
				vRP.Query("accounts/AddGems",{ license = Identity["license"], gems = Amount })
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
		if vRP.HasGroup(Passport,"Admin",2) then
			vRPC.BlipAdmin(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			if Message[1] then
				if Message[1] == "all" then
					local Text = ""
					local List = vRP.Players()
					for OtherPlayer,OtherSource in pairs(List) do
						async(function()
							vRP.UpgradeThirst(OtherPlayer,100)
							vRP.UpgradeHunger(OtherPlayer,100)
							vRP.DowngradeStress(OtherPlayer,100)
							vRP.Revive(OtherSource,200)

							TriggerClientEvent("paramedic:Reset",OtherSource)

							if Text == "" then
								Text = Text..OtherPlayer
							else
								Text = Text..", "..OtherPlayer
							end
						end)
					end
				else
					local OtherPlayer = parseInt(Message[1])
					local ClosestPed = vRP.Source(OtherPlayer)
					if ClosestPed then
						vRP.UpgradeThirst(OtherPlayer,100)
						vRP.UpgradeHunger(OtherPlayer,100)
						vRP.DowngradeStress(OtherPlayer,100)
						vRP.Revive(ClosestPed,200)

						TriggerClientEvent("paramedic:Reset",ClosestPed)
					end
				end
			else
				vRP.Revive(source,200,true)
				vRP.UpgradeThirst(Passport,100)
				vRP.UpgradeHunger(Passport,100)
				vRP.DowngradeStress(Passport,100)

				TriggerClientEvent("paramedic:Reset",source)

				vRPC.removeObjects(source)
			end

			if List then
				TriggerEvent("Discord","Admin","**god**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Text,nil)
			elseif OtherPlayer then
				TriggerEvent("Discord","Admin","**god**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPlayer,nil)
			else
				TriggerEvent("Discord","Admin","**god**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Passport,nil)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GODA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("goda",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Range = parseInt(Message[1])
			if Range then
				local Text = ""
				local Players = vRPC.ClosestPeds(source,Range)
				for _,v in pairs(Players) do
					async(function()
						local OtherPlayer = vRP.Passport(v[2])
						vRP.UpgradeThirst(OtherPlayer,100)
						vRP.UpgradeHunger(OtherPlayer,100)
						vRP.DowngradeStress(OtherPlayer,100)
						vRP.Revive(v[2],200)

						TriggerClientEvent("paramedic:Reset",v[2])

						if Text == "" then
							Text = Text..OtherPlayer
						else
							Text = Text..", "..OtherPlayer
						end
					end)
				end

				TriggerEvent("Discord","Admin","**goda**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Text,nil)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			if Message[1] and Message[2] and itemBody(Message[1]) ~= nil then
				local Amount = parseInt(Message[2])
				vRP.GenerateItem(Passport,Message[1],Amount,true)

				TriggerEvent("Discord","Admin","**item**\n\n**Passaporte:** "..Passport.."\n**Item:** "..Amount.."x "..itemName(Message[1]),nil)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item2",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			if Message[1] and Message[2] and parseInt(Message[3]) > 0 and itemBody(Message[1]) ~= nil then
				local Amount = parseInt(Message[2])
				vRP.GenerateItem(Message[3],Message[1],Amount,true)

				TriggerEvent("Discord","Admin","**item2**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[3].."\n**Item:** "..Amount.."x "..itemName(Message[1]),nil)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		if vRP.HasGroup(Passport,"Admin",2) then
			local OtherPassport = parseInt(Message[1])
			vRP.Query("characters/removeCharacter",{ id = OtherPassport })
			TriggerClientEvent("Notify",source,"verde","Personagem <b>"..OtherPassport.."</b> deletado.",5000)

			TriggerEvent("Discord","Admin","**delete**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport,nil)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			vRPC.noClip(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 then
			local OtherSource = vRP.Source(Message[1])
			if OtherSource then
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..Message[1].."</b> expulso.",5000)
				vRP.Kick(OtherSource,"Expulso da cidade.")

				TriggerEvent("Discord","Admin","**kick**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport,nil)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
			local Days = parseInt(Message[2])
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				vRP.Query("banneds/InsertBanned",{ license = Identity["license"], time = Days })
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..OtherPassport.."</b> banido por <b>"..Days.."</b> dias.",5000)
				TriggerEvent("Discord","Admin","**ban**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Tempo:** "..time.." dias",nil)

				local OtherSource = vRP.Source(OtherPassport)
				if OtherSource then
					vRP.Kick(OtherSource,"Banido.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 then
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				vRP.Query("banneds/RemoveBanned",{ license = Identity["license"] })
				TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..OtherPassport.."</b> desbanido.",5000)

				TriggerEvent("Discord","Admin","**unban**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport,nil)
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
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.keySingle(source,"Coordenadas:")
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
		if vRP.HasGroup(Passport,"Admin",2) then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vKEYBOARD.keyCopy(source,"Coordenadas:",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 and Message[2] and Message[3] then
			if (Message[2] == "Admin" or Message[2] == "Premium") and not vRP.HasGroup(Passport,"Admin",1) then
				return
			end

			local Groups = vRP.Groups()
			if Groups[Message[2]] then
				vRP.SetPermission(Message[1],Message[2],Message[3])
				TriggerClientEvent("Notify",source,"verde","Adicionado <b>"..Message[2].."</b> ao passaporte <b>"..Message[1].."</b>.",5000)

				local OtherSource = vRP.Source(Message[1])
				if OtherSource then
					TriggerClientEvent("player:Relationship",OtherSource,Message[2])
				end

				TriggerEvent("Discord","Admin","**group**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Grupo:** "..Message[2].."\n**Rank:** "..Message[3],nil)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 and Message[2] and Message[2] ~= "Admin" and Message[2] ~= "Premium" then
			local Groups = vRP.Groups()
			if Groups[Message[2]] then
				vRP.RemovePermission(Message[1],Message[2])
				TriggerClientEvent("Notify",source,"verde","Removido <b>"..Message[2].."</b> ao passaporte <b>"..Message[1].."</b>.",5000)

				local OtherSource = vRP.Source(Message[1])
				if OtherSource then
					TriggerClientEvent("player:Relationship",OtherSource,Message[2],true)
				end

				TriggerEvent("Discord","Admin","**ungroup**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Grupo:** "..Message[2],nil)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 then
			local ClosestPed = vRP.Source(Message[1])
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
RegisterCommand("tpto",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 then
			local ClosestPed = vRP.Source(Message[1])
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
		if vRP.HasGroup(Passport,"Admin",2) then
			vCLIENT.teleportWay(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMBO
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
			local vehicle = vRPC.VehicleHash(source)
			if vehicle then
				vKEYBOARD.keyCopy(source,"Hash:",vehicle)
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
		if vRP.HasGroup(Passport,"Admin",2) then
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
		if vRP.HasGroup(Passport,"Admin",2) then
			local Vehicle,Network,Plate = vRPC.VehicleList(source,10)
			if Vehicle then
				TriggerClientEvent("inventory:repairAdmin",source,Network,Plate)
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
		if vRP.HasGroup(Passport,"Admin",2) then
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
		if vRP.HasGroup(Passport,"Admin",2) then
			TriggerClientEvent("Notify",source,"azul","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices()..".",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ids",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Text = ""
			local List = vRP.Players()

			for OtherPlayer,_ in pairs(List) do
				if Text == "" then
					Text = Text..OtherPlayer
				else
					Text = Text..", "..OtherPlayer
				end
			end

			TriggerClientEvent("Notify",source,"azul","<b>IDs Conectados:</b> "..Text..".",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("id",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") and parseInt(Message[1]) > 0 then
			local Identity = vRP.Identity(Message[1])
			if Identity then
				TriggerClientEvent("Notify",source,"azul","<b>Passaporte:</b> "..Message[1].."<br><b>Nome:</b> "..Identity["name"].." "..Identity["name2"].."<br><b>Telefone:</b> "..Identity["phone"].."<br><b>Banco:</b> $"..parseFormat(Identity["bank"]),5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Coords")
AddEventHandler("admin:Coords",function(Coords)
	vRP.Archive("coordenadas.txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.buttonTxt()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
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
RegisterCommand("announce",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and Message[1] then
			TriggerClientEvent('smartphone:createSMS',-1,'Prefeitura',History:sub(9))

			TriggerEvent("Discord","Admin","**announce**\n\n**Passaporte:** "..Passport.."\n**Text:** "..History:sub(9),nil)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,Message,History)
	if source == 0 then
		TriggerClientEvent('smartphone:createSMS',-1,'Prefeitura',History:sub(9))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",2) then
			return
		end
	end

	local List = vRP.Players()
	for OtherPlayer,OtherSource in pairs(List) do
		async(function()
			TriggerClientEvent("admin:KickAll",OtherSource)
			Wait(1000)
			vRP.Kick(OtherSource,"Desconectado, a cidade reiniciou.")
			Wait(100)
		end)
	end

	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("save",function(source)
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin",2) then
			return
		end
	end

	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Text = ""
			local List = vRP.Players()

			for OtherPlayer,_ in pairs(List) do
				async(function()
					if Text == "" then
						Text = Text..OtherPlayer
					else
						Text = Text..", "..OtherPlayer
					end

					vRP.GenerateItem(OtherPlayer,Message[1],Message[2],true)
				end)
			end

			TriggerClientEvent("Notify",source,"verde","Envio concluído.",10000)

			TriggerEvent("Discord","Admin","**itemall**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Text.."\n**Item:** "..Message[2].."x "..itemName(Message[1]),nil)
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
RegisterCommand("spectate",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			if Spectate[Passport] then
				local Ped = GetPlayerPed(Spectate[Passport])
				if DoesEntityExist(Ped) then
					SetEntityDistanceCullingRadius(Ped,0.0)
				end

				TriggerClientEvent("admin:resetSpectate",source)
				Spectate[Passport] = nil
			else
				local nsource = vRP.Source(Message[1])
				if nsource then
					local Ped = GetPlayerPed(nsource)
					if DoesEntityExist(Ped) then
						SetEntityDistanceCullingRadius(Ped,999999999.0)
						Wait(1000)
						TriggerClientEvent("admin:initSpectate",source,nsource)
						Spectate[Passport] = nsource

						TriggerEvent("Discord","Admin","**spectate**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1],nil)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("reset",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = parseInt(Message[1])
		if vRP.HasGroup(Passport,"Admin",2) and OtherPassport > 0 then
			local Creator = vRP.UserData(Passport,"Creator")
			if Creator == 1 then
				vRP.Query("playerdata/SetData",{ Passport = OtherPassport, dkey = "Creator", dvalue = 0 })

				TriggerClientEvent("Notify",source,"verde","Reset concluído.",5000)

				TriggerEvent("Discord","Admin","**reset**\n\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport,nil)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUCKET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("bucket",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and Message[1] then
			local Route = parseInt(Message[1])
			if Message[2] then
				local OtherPassport = parseInt(Message[2])
				local OtherSource = vRP.Source(OtherPassport)
				if OtherSource then
					if Route > 0 then
						TriggerEvent("vRP:BucketServer",OtherSource,"Enter",Route)
					else
						TriggerEvent("vRP:BucketServer",OtherSource,"Exit")
					end
				end
			else
				if Route > 0 then
					TriggerEvent("vRP:BucketServer",source,"Enter",Route)
				else
					TriggerEvent("vRP:BucketServer",source,"Exit")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dm",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and Message[1] then
			local OtherSource = vRP.Source(Message[1])
			if OtherSource then
				local Keyboard = vKEYBOARD.keySingle(source,"Mensagem:")
				if Keyboard then
					TriggerClientEvent("chat:ClientMessage",OtherSource,"Prefeitura",Keyboard[1],"DM")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("services",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Text = ""
			local Groups = vRP.Groups()

			for Permission,_ in pairs(Groups) do
				local _,Total = vRP.NumPermission(Permission)

				if Text == "" then
					Text = Text.."<b>"..Permission..":</b> "..Total
				else
					Text = Text.."<br><b>"..Permission..":</b> "..Total
				end
			end

			TriggerClientEvent("Notify",source,"azul",Text,15000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOM
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	[1] = "hat",
	[2] = "pants",
	[3] = "vest",
	[4] = "bracelet",
	[5] = "backpack",
	[6] = "decals",
	[7] = "mask",
	[8] = "shoes",
	[9] = "tshirt",
	[10] = "torso",
	[11] = "accessory",
	[12] = "watch",
	[13] = "arms",
	[14] = "glass",
	[15] = "ear"
}

RegisterCommand("custom",function(source,args,rawCommand)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local Custom = vSKINSHOP.getCustomization(source)
			if Custom then
				local Text = ""
				local Count = 1

				repeat
					if Text == "" then
						Text = '["'..List[Count]..'"] = { item = '..Custom[List[Count]]["item"]..', texture = '..Custom[List[Count]]["texture"]..' }'
					else
						Text = Text..',\n["'..List[Count]..'"] = { item = '..Custom[List[Count]]["item"]..', texture = '..Custom[List[Count]]["texture"]..' }'
					end

					Count = Count + 1
				until Count == #List + 1

				Text = Text.."\n\n"

				vRP.Archive("custom.txt",Text)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debug",function(source,args,rawCommand)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			TriggerClientEvent("admin:DebugToggle",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:DEBUGINFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:DebugInformations")
AddEventHandler("admin:DebugInformations",function(Entity)
	local source = source
	vKEYBOARD.keyCopy(source,"Informations:",Entity[2]..","..mathLength(Entity[4]["x"])..","..mathLength(Entity[4]["y"])..","..mathLength(Entity[4]["z"])..","..mathLength(Entity[5]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:LOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Logs")
AddEventHandler("admin:Logs",function(Info)
	local source = source
	vKEYBOARD.keyCopy(source,"Log:",Info)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TXADMIN:EVENTS:SERVERSHUTTINGDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("txAdmin:events:serverShuttingDown",function(eventData)
    TriggerEvent("SaveServer")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TXADMIN:EVENTS:SCHEDULEDRESTART
-----------------------------------------------------------------------------------------------------------------------------------------
-- AddEventHandler("txAdmin:events:scheduledRestart",function(eventData)
-- 	if eventData.secondsRemaining == 60 then
--         CreateThread(function()
--             Wait(30000)
--             TriggerEvent("SaveServer")
--         end)
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Spectate[Passport] then
		Spectate[Passport] = nil
	end
end)