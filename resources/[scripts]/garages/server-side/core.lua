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
Tunnel.bindInterface("garages",Creative)
vPLAYER = Tunnel.getInterface("player")
vCLIENT = Tunnel.getInterface("garages")
vKEYBOARD = Tunnel.getInterface("keyboard")
vHUD = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local vehSpawn = {}
local vehSignal = {}
local Propertys = {}
local searchTimers = {}
GlobalState["vehPlates"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.serverVehicle(Model,x,y,z,heading,vehPlate,nitroFuel,vehDoors,vehBody,vehFuel)
	local spawnVehicle = 0
	local myVeh = CreateVehicle(Model,x,y,z,heading,true,true)

	while not DoesEntityExist(myVeh) and spawnVehicle <= 1000 do
		spawnVehicle = spawnVehicle + 1
		Wait(100)
	end

	if DoesEntityExist(myVeh) then
		if vehPlate ~= nil then
			SetVehicleNumberPlateText(myVeh,vehPlate)
		else
			vehPlate = vRP.GeneratePlate()
			SetVehicleNumberPlateText(myVeh,vehPlate)
		end

		SetVehicleBodyHealth(myVeh,vehBody + 0.0)

		if not vehFuel then
			TriggerEvent("engine:tryFuel",vehPlate,100)
		end

		if vehDoors then
			local vehDoors = json.decode(vehDoors)
			if vehDoors ~= nil then
				for k,v in pairs(vehDoors) do
					if v then
						SetVehicleDoorBroken(myVeh,parseInt(k),true)
					end
				end
			end
		end

		local netVeh = NetworkGetNetworkIdFromEntity(myVeh)

		if Model ~= "wheelchair" then
			local Network = NetworkGetEntityFromNetworkId(netVeh)
			SetVehicleDoorsLocked(Network,2)

			local Nitro = GlobalState["Nitro"]
			Nitro[vehPlate] = nitroFuel or 0
			GlobalState:set("Nitro",Nitro,true)
		end

		return true,netVeh,myVeh
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
local Garages = {
	["1"] = { name = "Garage", payment = false },
	["2"] = { name = "Garage", payment = true },
	["3"] = { name = "Garage", payment = false },
	["4"] = { name = "Garage", payment = true },
	["5"] = { name = "Garage", payment = true },
	["6"] = { name = "Garage", payment = true },
	["7"] = { name = "Garage", payment = true },
	["8"] = { name = "Garage", payment = true },
	["9"] = { name = "Garage", payment = true },
	["10"] = { name = "Garage", payment = true },
	["11"] = { name = "Garage", payment = true },
	["12"] = { name = "Garage", payment = true },
	["13"] = { name = "Garage", payment = true },
	["14"] = { name = "Garage", payment = true },
	["15"] = { name = "Garage", payment = true },
	["16"] = { name = "Garage", payment = true },
	["17"] = { name = "Garage", payment = true },
	["18"] = { name = "Garage", payment = true },
	["19"] = { name = "Garage", payment = true },
	["20"] = { name = "Garage", payment = true },
	["21"] = { name = "Garage", payment = true },
	["22"] = { name = "Garage", payment = true },
	["23"] = { name = "Garage", payment = false },
	["24"] = { name = "Garage", payment = true },
	["25"] = { name = "Garage", payment = true },
	["26"] = { name = "Garage", payment = true },
	["27"] = { name = "Garage", payment = true },

	-- Paramedic
	["41"] = { name = "Paramedic", payment = false, perm = "Paramedic" },
	["42"] = { name = "heliParamedic", payment = false, perm = "Paramedic" },

	["43"] = { name = "Paramedic", payment = false, perm = "Paramedic" },
	["44"] = { name = "heliParamedic", payment = false, perm = "Paramedic" },

	-- ["45"] = { name = "Paramedic", payment = false, perm = "Paramedic" },

	-- Police
	["61"] = { name = "Police", payment = false, perm = "Police" },
	["62"] = { name = "heliPolice", payment = false, perm = "Police" },

	["63"] = { name = "Police", payment = false, perm = "Police" },
	["64"] = { name = "heliPolice", payment = false, perm = "Police" },

	["65"] = { name = "Police", payment = false, perm = "Police" },
	["66"] = { name = "heliPolice", payment = false, perm = "Police" },

	["67"] = { name = "Police", payment = false, perm = "Police" },
	["68"] = { name = "busPolice", payment = false, perm = "Police" },

	["69"] = { name = "Police", payment = false, perm = "Police" },

	["70"] = { name = "Police", payment = false, perm = "Police" },
	["71"] = { name = "heliPolice", payment = false, perm = "Police" },
	["72"] = { name = "busPolice", payment = false, perm = "Police" },

	["91"] = { name = "Ballas", payment = true, perm = "Ballas" },
	["92"] = { name = "Families", payment = true, perm = "Families" },
	["93"] = { name = "Vagos", payment = true, perm = "Vagos" },
	["94"] = { name = "Aztecas", payment = true, perm = "Aztecas" },
	["95"] = { name = "Bloods", payment = true, perm = "Bloods" },
	["96"] = { name = "Triads", payment = true, perm = "Triads" },
	["97"] = { name = "Razors", payment = true, perm = "Razors" },

	-- Boats
	["121"] = { name = "Boats", payment = false },
	["122"] = { name = "Boats", payment = false },
	["123"] = { name = "Boats", payment = false },
	["124"] = { name = "Boats", payment = false },
	["125"] = { name = "Boats", payment = false },
	["126"] = { name = "Boats", payment = false },

	-- Works
	["141"] = { name = "Lumberman", payment = false },
	["142"] = { name = "Driver", payment = false },
	["143"] = { name = "Garbageman", payment = false },
	["144"] = { name = "Transporter", payment = false },
	["145"] = { name = "Taxi", payment = false },
	["146"] = { name = "TowDriver", payment = false },
	["147"] = { name = "Garbageman", payment = false },
	["148"] = { name = "Garbageman", payment = false },
	["149"] = { name = "Taxi", payment = false },
	["150"] = { name = "Trucker", payment = false }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNALREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("signalRemove",function(vehPlate)
	vehSignal[vehPlate] = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEREVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("plateReveryone",function(vehPlate)
	if GlobalState["vehPlates"][vehPlate] then
		local vehPlates = GlobalState["vehPlates"]
		vehPlates[vehPlate] = nil
		GlobalState:set("vehPlates",vehPlates,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("plateEveryone",function(vehPlate)
	local vehPlates = GlobalState["vehPlates"]
	vehPlates[vehPlate] = true
	GlobalState:set("vehPlates",vehPlates,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("platePlayers",function(vehPlate,Passport)
	if not vRP.PassportPlate(vehPlate) then
		local vehPlates = GlobalState["vehPlates"]
		vehPlates[vehPlate] = Passport
		GlobalState:set("vehPlates",vehPlates,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKGARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
local workGarages = {
	["Paramedic"] = {
		"ambulancia",
	},
	["heliParamedic"] = {
		"maverick2"
	},
	["Police"] = {
		"fordraptor",
		"wra45",
		"wrbmwx6",
		"audir82",
		"tahoe",
		"wrsxr",
		"fordmustanggt2",
		"nspeedo"
	},
	["heliPolice"] = {
		"maverick2",
		"b412"
	},
	["busPolice"] = {
		"pbus",
		"riot"
	},
	["Driver"] = {
		"bus"
	},
	["Boats"] = {
		"dinghy",
		"jetmax",
		"marquis",
		"seashark",
		"speeder",
		"squalo",
		"suntrap",
		"toro",
		"tropic"
	},
	["Transporter"] = {
		"stockade"
	},
	["Lumberman"] = {
		"ratloader"
	},
	["TowDriver"] = {
		"flatbed",
		"towtruck",
		"towtruck2"
	},
	["Garbageman"] = {
		"trash"
	},
	["Taxi"] = {
		"taxi"
	},
	["Trucker"] = {
		"hauler",
		"hauler2",
		"packer",
		"phantom"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Vehicles(Garage)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Wanted(Passport) then
		if vRP.GetFine(source) > 0 then
			TriggerClientEvent("Notify",source,"vermelho","Multas pendentes encontradas.",3000)
			return false
		end

		if Garages[Garage]["perm"] then
			if not vRP.HasGroup(Passport,Garages[Garage]["perm"]) then
				return false
			end
		end

		local Vehicle = {}
		if string.sub(Garage,1,9) == "Propertys" then
			local Consult = vRP.Query("propertys/Exist",{ name = Garage })
			if Consult[1] then
				if parseInt(Consult[1]["Passport"]) == Passport or vRP.InventoryFull(Passport,"propertys-"..Consult[1]["Serial"]) then
					if os.time() > Consult[1]["Tax"] then
						TriggerClientEvent("Notify",source,"amarelo","Aluguel atrasado, procure um <b>Corretor de Imóveis</b>.",5000)
						return false
					end
				else
					return false
				end
			end
		end

		local Garage = Garages[Garage]["name"]
		if workGarages[Garage] then
			for k,v in pairs(workGarages[Garage]) do
				if vehicleExist(v) then
					table.insert(Vehicle,{ ["Model"] = v, ["name"] = vehicleName(v) })
				end
			end
		else
			local vehicle = vRP.Query("vehicles/UserVehicles",{ Passport = Passport })
			for k,v in pairs(vehicle) do
				if vehicleExist(v["vehicle"]) then
					if v["work"] == "false" then
						table.insert(Vehicle,{ ["Model"] = v["vehicle"], ["name"] = vehicleName(v["vehicle"]) })
					end
				end
			end
		end

		return Vehicle
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Impound()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local myVehicle = {}
		local vehicle = vRP.Query("vehicles/UserVehicles",{ Passport = Passport })

		for k,v in ipairs(vehicle) do
			if v["arrest"] >= os.time() then
				table.insert(myVehicle,{ ["Model"] = vehicle[k]["vehicle"], ["name"] = vehicleName(vehicle[k]["vehicle"]) })
			end
		end

		return myVehicle
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Impound")
AddEventHandler("garages:Impound",function(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local vehPrice = vehiclePrice(vehName)
		TriggerClientEvent("dynamic:closeSystem",source)

		if vHUD.Request(source,"A liberação do veículo tem o custo de <b>$"..parseFormat(vehPrice * 0.25).."</b> dólares, deseja prosseguir com a liberação do mesmo?","Sim, efetuar o pagamento","Não, decido depois") then
			if vRP.PaymentFull(Passport,source,vehPrice * 0.25) then
				vRP.Execute("vehicles/paymentArrest",{ Passport = Passport, vehicle = vehName })
				TriggerClientEvent("Notify",source,"verde","Veículo liberado.",5000)
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:TAX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Tax")
AddEventHandler("garages:Tax",function(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
		if vehicle[1] then
			if vehicle[1]["tax"] <= os.time() then
				local vehiclePrice = vehiclePrice(vehName) * 0.10

				if vRP.PaymentFull(Passport,source,vehiclePrice) then
					vRP.Execute("vehicles/updateVehiclesTax",{ Passport = Passport, vehicle = vehName })
					TriggerClientEvent("Notify",source,"verde","Pagamento concluído.",5000)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:TAX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Sell")
AddEventHandler("garages:Sell",function(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.GetFine(source) > 0 then
			TriggerClientEvent("Notify",source,"amarelo","Multas pendentes encontradas.",3000)
			return
		end

		local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
		if vehicle[1] then
			local vehType = vehicleType(vehName)
			if vehType == "rental" or vehType == "work" then
				return
			end

			local vehPrices = vehiclePrice(vehName) * 0.5
			if vHUD.Request(source,"Vender o veículo <b>"..vehicleName(vehName).."</b> por <b>$"..parseFormat(vehPrices).."</b>?","Sim, concluír venda","Não, mudei de ideia") then
				local vehicles = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
				if vehicles[1] then
					vRP.GiveBank(Passport,vehPrices)
					vRP.Execute("vehicles/removeVehicles",{ Passport = Passport, vehicle = vehName })
					vRP.Execute("entitydata/RemoveData",{ dkey = "vehMods:"..Passport..":"..vehName })
					vRP.Execute("entitydata/RemoveData",{ dkey = "vehChest:"..Passport..":"..vehName })
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Transfer")
AddEventHandler("garages:Transfer",function(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local myVehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
		if myVehicle[1] then
			TriggerClientEvent("dynamic:closeSystem",source)

			local Keyboard = vKEYBOARD.keySingle(source,"Passaporte:")
			if Keyboard then
				local OtherPassport = parseInt(Keyboard[1])
				local Identity = vRP.Identity(OtherPassport)
				if Identity then
					if vHUD.Request(source,"Transferir o veículo <b>"..vehicleName(vehName).."</b> para <b>"..Identity["name"].." "..Identity["name2"].."</b>?","Sim, transferir","Não, mudei de ideia") then
						local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = parseInt(OtherPassport), vehicle = vehName })
						if vehicle[1] then
							TriggerClientEvent("Notify",source,"amarelo","<b>"..Identity["name"].." "..Identity["name2"].."</b> já possui este modelo de veículo.",5000)
						else
							vRP.Execute("vehicles/moveVehicles",{ Passport = Passport, OtherPassport = parseInt(OtherPassport), vehicle = vehName })

							local Datatable = vRP.Query("entitydata/GetData",{ dkey = "vehMods:"..Passport..":"..vehName })
							if parseInt(#Datatable) > 0 then
								vRP.Execute("entitydata/SetData",{ dkey = "vehMods:"..OtherPassport..":"..vehName, dvalue = Datatable[1]["dvalue"] })
								vRP.Execute("entitydata/RemoveData",{ dkey = "vehMods:"..Passport..":"..vehName })
							end

							local Datatable = vRP.GetSrvData("vehChest:"..Passport..":"..vehName)
							vRP.SetSrvData("vehChest:"..OtherPassport..":"..vehName,Datatable)
							vRP.RemSrvData("vehChest:"..Passport..":"..vehName)

							TriggerClientEvent("Notify",source,"verde","Transferência concluída.",5000)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Spawn")
AddEventHandler("garages:Spawn",function(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local splitName = splitString(Table,"-")
		local garageName = splitName[2]
		local vehName = splitName[1]

		local Gemstone = vehicleGems(vehName)
		local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })

		if not vehicle[1] then
			if parseInt(Gemstone) > 0 then
				if vHUD.Request(source,"Alugar o veículo <b>"..vehicleName(vehName).."</b> por <b>"..Gemstone.."</b> gemas?","Sim, concluír aluguel","Não, mudei de ideia") then
					if vRP.PaymentGems(source,Gemstone) then
						vRP.Execute("vehicles/rentalVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "true" })
						TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..vehicleName(vehName).."</b> concluído.",5000)
						vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
						return
					end
				else
					return
				end
			else
				local vehPrice = vehiclePrice(vehName)
				if parseInt(vehPrice) > 0 then
					if vHUD.Request(source,"Comprar <b>"..vehicleName(vehName).."</b> por <b>$"..parseFormat(vehPrice).."</b> dólares?","Sim, concluír pagamento","Não, mudei de ideia") then
						if vRP.PaymentFull(Passport,source,vehPrice) then
							vRP.Execute("vehicles/addVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "true" })
							vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
						else
							TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
						end
					else
						return
					end
				else
					vRP.Execute("vehicles/addVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "true" })
					vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
				end
			end
		end

		if vehicle[1] then
			local vehPlates = GlobalState["vehPlates"]
			local vehPlate = vehicle[1]["plate"]

			if vehSpawn[vehPlate] then
				if not vehSignal[vehPlate] then
					if not searchTimers[Passport] then
						searchTimers[Passport] = os.time()
					end

					if os.time() >= parseInt(searchTimers[Passport]) then
						searchTimers[Passport] = os.time() + 60

						local vehNet = vehSpawn[vehPlate][3]
						local Network = NetworkGetEntityFromNetworkId(vehNet)
						if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 and GetVehicleNumberPlateText(Network) == vehPlate then
							vCLIENT.SearchBlip(source,GetEntityCoords(Network))
							TriggerClientEvent("Notify",source,"amarelo","Rastreador do veículo foi ativado por <b>30</b> segundos, lembrando que se o mesmo estiver em movimento a localização pode ser imprecisa.",10000)
						else
							if vehSpawn[vehPlate] then
								vehSpawn[vehPlate] = nil
							end

							if vehPlates[vehPlate] then
								vehPlates[vehPlate] = nil
								GlobalState:set("vehPlates",vehPlates,true)
							end

							TriggerClientEvent("Notify",source,"verde","A seguradora efetuou o resgate do seu veículo e o mesmo já se encontra disponível para retirada.",5000)
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","Rastreador só pode ser ativado a cada <b>60</b> segundos.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Rastreador está desativado.",5000)
				end
			else
				if vehicle[1]["tax"] <= os.time() then
					TriggerClientEvent("Notify",source,"amarelo","Taxa do veículo atrasada.",5000)
				elseif vehicle[1]["arrest"] >= os.time() then
					TriggerClientEvent("Notify",source,"amarelo","Veículo apreendido, dirija-se até o <b>Impound</b> e efetue o pagamento da liberação do mesmo.",5000)
				else
					if vehicle[1]["rental"] ~= 0 then
						if vehicle[1]["rental"] <= os.time() then
							if vHUD.Request(source,"Atualizar o aluguel do veículo <b>"..vehicleName(vehName).."</b> por <b>"..Gemstone.." gemas</b>?","Sim, concluír pagamento","Não, mudei de ideia") then
								if vRP.PaymentGems(source,Gemstone) then
									vRP.Execute("vehicles/rentalVehiclesUpdate",{ Passport = Passport, vehicle = vehName })
									TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..vehicleName(vehName).."</b> atualizado.",5000)
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
									return
								end
							else
								return
							end
						end
					end

					local Coords = vCLIENT.SpawnPosition(source,garageName)
					if Coords then
						local vehMods = nil
						local Datatable = vRP.Query("entitydata/GetData",{ dkey = "vehMods:"..Passport..":"..vehName })
						if parseInt(#Datatable) > 0 then
							vehMods = Datatable[1]["dvalue"]
						end

						if Garages[garageName]["payment"] then
							if vRP.UserPremium(Passport) then
								TriggerClientEvent("dynamic:closeSystem",source)
								local netExist,netVeh = Creative.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

								if netExist then
									vCLIENT.CreateVehicle(-1,vehName,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
									TriggerClientEvent("Notify",source,"azul",CompleteTimers(vehicle[1]["tax"] - os.time()),1000)
									TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
									vehSpawn[vehPlate] = { Passport,vehName,netVeh }

									vehPlates[vehPlate] = Passport
									GlobalState:set("vehPlates",vehPlates,true)
								end
							else
								local vehPrice = vehiclePrice(vehName)
								if vHUD.Request(source,"Retirar o veículo por <b>$"..parseFormat(vehPrice * 0.05).."</b> dólares?","Sim, efetuar o pagamento","Não, volto depois") then
									if vRP.GetBank(source) >= parseInt(vehPrice * 0.05) then
										TriggerClientEvent("dynamic:closeSystem",source)
										local netExist,netVeh = Creative.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

										if netExist then
											vCLIENT.CreateVehicle(-1,vehName,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
											TriggerClientEvent("Notify",source,"azul",CompleteTimers(vehicle[1]["tax"] - os.time()),1000)
											TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
											vehSpawn[vehPlate] = { Passport,vehName,netVeh }
											vRP.PaymentFull(Passport,source,vehPrice * 0.05)

											vehPlates[vehPlate] = Passport
											GlobalState:set("vehPlates",vehPlates,true)
										end
									else
										TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
									end
								end
							end
						else
							TriggerClientEvent("dynamic:closeSystem",source)
							local netExist,netVeh = Creative.serverVehicle(vehName,Coords[1],Coords[2],Coords[3],Coords[4],vehPlate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

							if netExist then
								vCLIENT.CreateVehicle(-1,vehName,netVeh,vehicle[1]["engine"],vehMods,vehicle[1]["windows"],vehicle[1]["tyres"])
								TriggerClientEvent("Notify",source,"azul",CompleteTimers(vehicle[1]["tax"] - os.time()),1000)
								TriggerEvent("engine:tryFuel",vehPlate,vehicle[1]["fuel"])
								vehSpawn[vehPlate] = { Passport,vehName,netVeh }

								vehPlates[vehPlate] = Passport
								GlobalState:set("vehPlates",vehPlates,true)
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car",function(source,args)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)
			local vehPlate = "VEH"..math.random(10000,99999)
			local netExist,netVeh,myVeh = Creative.serverVehicle(args[1],Coords["x"],Coords["y"],Coords["z"],heading,vehPlate,2000,nil,1000)

			if not netExist then
				return
			end

			vCLIENT.CreateVehicle(-1,args[1],netVeh,1000,nil,false,false)
			vehSpawn[vehPlate] = { Passport,vehName,netVeh }
			TriggerEvent("engine:tryFuel",vehPlate,100)
			SetPedIntoVehicle(Ped,myVeh,-1)

			local vehPlates = GlobalState["vehPlates"]
			vehPlates[vehPlate] = Passport
			GlobalState:set("vehPlates",vehPlates,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Moderator") then
			TriggerClientEvent("garages:Delete",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:VEHICLEKEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:vehicleKey")
AddEventHandler("garages:vehicleKey",function(entity)
	local source = source
	local vehPlate = entity[1]
	local Passport = vRP.Passport(source)
	if Passport then
		if GlobalState["vehPlates"][vehPlate] == Passport then
			vRP.GenerateItem(Passport,"vehkey-"..vehPlate,1,true,false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:lockVehicle")
AddEventHandler("garages:lockVehicle",function(vehNet,vehPlate)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if GlobalState["vehPlates"][vehPlate] == Passport then
			TriggerEvent("garages:keyVehicle",source,vehNet)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:KEYVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("garages:keyVehicle",function(source,vehNet)
	local Network = NetworkGetEntityFromNetworkId(vehNet)
	local doorStatus = GetVehicleDoorLockStatus(Network)

	if parseInt(doorStatus) <= 1 then
		TriggerClientEvent("Notify",source,"locked","Veículo trancado.",5000)
		TriggerClientEvent("sounds:Private",source,"locked",0.7)
		SetVehicleDoorsLocked(Network,2)
	else
		TriggerClientEvent("Notify",source,"unlocked","Veículo destrancado.",5000)
		TriggerClientEvent("sounds:Private",source,"unlocked",0.7)
		SetVehicleDoorsLocked(Network,1)
	end

	if not vRPC.inVehicle(source) then
		vRPC.playAnim(source,true,{"anim@mp_player_intmenu@key_fob@","fob_click"},false)
		Wait(350)
		vRPC.stopAnim(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.tryDelete(vehNet,vehEngine,vehBody,vehFuel,vehDoors,vehWindows,vehTyres,vehPlate)
	if vehSpawn[vehPlate] then
		local Passport = vehSpawn[vehPlate][1]
		local vehName = vehSpawn[vehPlate][2]

		if parseInt(vehEngine) <= 100 then
			vehEngine = 100
		end

		if parseInt(vehBody) <= 100 then
			vehBody = 100
		end

		if parseInt(vehFuel) >= 100 then
			vehFuel = 100
		end

		if parseInt(vehFuel) <= 0 then
			vehFuel = 0
		end

		local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
		if vehicle[1] ~= nil then
			vRP.Execute("vehicles/updateVehicles",{ Passport = Passport, vehicle = vehName, nitro = GlobalState["Nitro"][vehPlate] or 0, engine = parseInt(vehEngine), body = parseInt(vehBody), fuel = parseInt(vehFuel), doors = json.encode(vehDoors), windows = json.encode(vehWindows), tyres = json.encode(vehTyres) })
		end
	end

	TriggerEvent("garages:deleteVehicle",vehNet,vehPlate)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:deleteVehicle")
AddEventHandler("garages:deleteVehicle",function(vehNet,vehPlate)
	if vehNet ~= nil and vehPlate ~= nil then
		if GlobalState["vehPlates"][vehPlate] then
			local vehPlates = GlobalState["vehPlates"]
			vehPlates[vehPlate] = nil
			GlobalState:set("vehPlates",vehPlates,true)
		end

		if GlobalState["Nitro"][vehPlate] then
			local Nitro = GlobalState["Nitro"]
			Nitro[vehPlate] = nil
			GlobalState:set("Nitro",Nitro,true)
		end

		if vehSignal[vehPlate] then
			vehSignal[vehPlate] = nil
		end

		if vehSpawn[vehPlate] then
			vehSpawn[vehPlate] = nil
		end

		if string.sub(vehPlate,1,4) == "DISM" then
			local Passport = parseInt(string.sub(vehPlate,5,8)) - 1000
			local source = vRP.Source(Passport)
			if source then
				TriggerClientEvent("inventory:Disreset",source)
				TriggerClientEvent("Notify",source,"amarelo","O veículo do seu contrato foi encaminhado para o <b>Impound</b> e o <b>Lester</b> disse que você pode assinar um novo contrato quando quiser.",10000)
			end
		end

		local Network = NetworkGetEntityFromNetworkId(vehNet)
		if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
			if GetVehicleNumberPlateText(Network) == vehPlate then
				DeleteEntity(Network)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHSIGNAL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("vehSignal",function(vehPlate)
	return vehSignal[vehPlate]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Propertys")
AddEventHandler("garages:Propertys",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerClientEvent("dynamic:closeSystem",source)
		TriggerClientEvent("Notify",source,"amarelo","Selecione o local da garagem.",5000)

		local Hash = "prop_offroad_tyres02"
		local Application,Coords,Heading = vRPC.objectCoords(source,Hash)
		if Application then
			if #(Coords - exports["propertys"]:Coords(Name)) <= 25 then
				TriggerClientEvent("Notify",source,"amarelo","Selecione o local do veículo.",5000)

				local Open = Coords
				local Hash = "patriot"
				local Application,Coords,Heading = vRPC.objectCoords(source,Hash)
				if Application then
					if #(Coords - exports["propertys"]:Coords(Name)) <= 25 then
						local New = {
							["1"] = { mathLength(Open["x"]),mathLength(Open["y"]),mathLength(Open["z"] + 1) },
							["2"] = { mathLength(Coords["x"]),mathLength(Coords["y"]),mathLength(Coords["z"] + 1),mathLength(Heading) }
						}

						Garages[Name] = { name = "Garage", payment = false }

						Propertys[Name] = {
							["x"] = New["1"][1],
							["y"] = New["1"][2],
							["z"] = New["1"][3],
							["1"] = New["2"]
						}

						vRP.Execute("propertys/Garage",{ name = Name, garage = json.encode(New) })
						TriggerClientEvent("garages:Propertys",-1,Propertys)
					else
						TriggerClientEvent("Notify",source,"amarelo","A garagem precisa ser próximo da entrada.",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","A garagem precisa ser próximo da entrada.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Consult = vRP.Query("propertys/Garages")
	for _,v in pairs(Consult) do
		local Name = v["Name"]
		if not Propertys[Name] then
			local Consult = json.decode(v["Garage"])
			Garages[Name] = { name = "Garage", payment = false }

			Propertys[Name] = {
				["x"] = Consult["1"][1],
				["y"] = Consult["1"][2],
				["z"] = Consult["1"][3],
				["1"] = Consult["2"]
			}
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("garages:Propertys",source,Propertys)
end)