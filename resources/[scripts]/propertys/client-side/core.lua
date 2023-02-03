-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("propertys",Creative)
vSERVER = Tunnel.getInterface("propertys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Init = ""
local Blips = {}
local Chest = ""
local Markers = {}
local Interior = ""
local Propertys = {}
local Informations = {}
local Objects = {}
local Thef = false
local Timers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THEFTCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local TheftCoords = {
	["Emerald"] = {
		["1"] = vec3(25.39,-20.13,-24.01),
		["2"] = vec3(23.97,-20.68,-24.01),
		["3"] = vec3(19.07,-29.69,-24.01),
		["4"] = vec3(30.62,-28.19,-24.01)
	},
	["Diamond"] = {
		["1"] = vec3(51.54,-53.8,-24.01),
		["2"] = vec3(45.95,-46.48,-24.01),
		["3"] = vec3(54.44,-45.33,-24.01)
	},
	["Ruby"] = {
		["1"] = vec3(104.18,-96.84,-24.01),
		["2"] = vec3(99.04,-103.27,-24.01),
		["3"] = vec3(96.53,-98.03,-24.2),
		["4"] = vec3(96.91,-108.13,-24.2)
	},
	["Sapphire"] = {
		["1"] = vec3(71.78,86.03,-24.2),
		["2"] = vec3(66.54,81.56,-24.2),
		["3"] = vec3(91.36,76.1,-24.2),
		["4"] = vec3(88.59,77.39,-24.2),
		["5"] = vec3(88.3,69.57,-24.2),
		["6"] = vec3(83.89,81.95,-24.01),
		["7"] = vec3(60.19,70.16,-24.6)
	},
	["Amethyst"] = {
		["1"] = vec3(165.69,-147.98,-17.79),
		["2"] = vec3(166.79,-149.55,-17.79),
		["3"] = vec3(159.46,-152.56,-17.79),
		["4"] = vec3(157.14,-160.16,-19.19),
		["5"] = vec3(149.71,-165.48,-19.19),
		["6"] = vec3(138.85,-152.03,-19.19),
		["7"] = vec3(160.09,-156.67,-19.19),
		["8"] = vec3(150.4,-157.34,-23.99)
	},
	["Amber"] = {
		["1"] = vec3(122.59,-111.75,-23.59),
		["2"] = vec3(127.99,-112.24,-23.59),
		["3"] = vec3(129.87,-124.0,-23.99),
		["4"] = vec3(120.15,-123.04,-23.99),
		["5"] = vec3(120.27,-123.62,-27.4),
		["6"] = vec3(129.45,-124.63,-27.38),
		["7"] = vec3(129.09,-121.58,-27.38),
		["8"] = vec3(122.34,-116.17,-31.21),
		["9"] = vec3(122.26,-110.26,-23.59),
		["10"] = vec3(124.49,-118.62,-27.4)
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			if Init == "" then
				for Name,v in pairs(Propertys) do
					if #(Coords - v) <= 1.0 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) then
							local Option,Table = vSERVER.Propertys(Name)

							if Option == "Corretor" then
								for Line,v in pairs(Table) do
									exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","propertys:Buy",Name.."-"..Line,Line,true)
									exports["dynamic"]:AddButton("Valor","Custo de <yellow>$"..parseFormat(v["Price"]).."</yellow> dólares.","","",Line,false)
									exports["dynamic"]:AddButton("Compartimento","Total de <yellow>"..v["Vault"].."Kg</yellow> no baú e <yellow>"..v["Fridge"].."Kg</yellow> na geladeira.","","",Line,false)
									exports["dynamic"]:SubMenu(Line,"Informações sobre o interior.",Line)
								end

								exports["dynamic"]:openMenu()
							elseif Option == "Player" then
								Interior = Table["Interior"]

								if string.sub(Name,1,9) == "Propertys" then
									exports["dynamic"]:AddButton("Entrar","Adentrar a propriedade.","propertys:Enter",Name,false,false)
									exports["dynamic"]:AddButton("Credenciais","Reconfigurar os cartões de acesso.","propertys:Credentials",Name,false,true)
									exports["dynamic"]:AddButton("Fechadura","Trancar/Destrancar a propriedade.","propertys:Lock",Name,false,true)
									exports["dynamic"]:AddButton("Baú","Aumentar tamanho do baú.","propertys:Vault",Name,false,true)
									exports["dynamic"]:AddButton("Garagem","Adicionar/Reajustar a garagem.","garages:Propertys",Name,false,true)
									exports["dynamic"]:AddButton("Hipoteca","Próximo pagamento em "..Table["Tax"]..".","","",false,false)
									exports["dynamic"]:AddButton("Vender","Se desfazer da propriedade.","propertys:Sell",Name,false,true)

									exports["dynamic"]:openMenu()
								else
									TriggerEvent("propertys:Enter",Name)
								end
							end
						end
					end
				end
			else
				if Informations[Interior] then
					SetPlayerBlipPositionThisFrame(Propertys[Init]["x"],Propertys[Init]["y"])

					if Coords["z"] < (Informations[Interior]["Exit"]["z"] - 25.0) then
						SetEntityCoords(Ped,Informations[Interior]["Exit"],false,false,false,false)
					end

					for Line,v in pairs(Informations[Interior]) do
						if #(Coords - v) <= 1.0 then
							TimeDistance = 1

							if Line == "Exit" and IsControlJustPressed(1,38) then
								SetEntityCoords(Ped,Propertys[Init],false,false,false,false)
								TriggerServerEvent("propertys:Toggle",Init)
								Interior = ""
								Chest = ""
								Init = ""

								if Thef then
									Thef = false

									for Number,_ in pairs(Objects) do
										exports["target"]:RemCircleZone("Propertys:"..Number)
									end

									Objects = {}
								end
							elseif not Thef and (Line == "Vault" or Line == "Fridge") and IsControlJustPressed(1,38) then
								SendNUIMessage({ Action = "Show" })
								SetNuiFocus(true,true)
								Chest = Line
							elseif not Thef and Line == "Clothes" and IsControlJustPressed(1,38) then
								ClothesMenu()
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHESMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function ClothesMenu()
	exports["dynamic"]:AddButton("Guardar","Salvar suas vestimentas do corpo.","propertys:Clothes","save",false,true)
	exports["dynamic"]:AddButton("Shopping","Abrir a loja de vestimentas.","skinshop:openShop","",false,false)
	exports["dynamic"]:SubMenu("Vestir","Abrir lista com todas as vestimentas.","apply")
	exports["dynamic"]:SubMenu("Remover","Abrir lista com todas as vestimentas.","delete")

	local Clothes = vSERVER.Clothes()
	if parseInt(#Clothes) > 0 then
		for k,v in pairs(Clothes) do
			exports["dynamic"]:AddButton(v["name"],"Vestir-se com as vestimentas.","propertys:Clothes","apply-"..v["name"],"apply",true)
			exports["dynamic"]:AddButton(v["name"],"Remover a vestimenta salva.","propertys:Clothes","delete-"..v["name"],"delete",true)
		end
	end

	exports["dynamic"]:openMenu()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CLOTHESRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:ClothesReset")
AddEventHandler("propertys:ClothesReset",function()
	TriggerEvent("dynamic:closeSystem")
	ClothesMenu()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Enter")
AddEventHandler("propertys:Enter",function(Name,Invade,Robbery)
	Init = Name
	local Ped = PlayerPedId()
	TriggerEvent("dynamic:closeSystem")
	TriggerServerEvent("propertys:Toggle",Init)

	if Invade then
		Interior = Invade
	end

	SetEntityCoords(Ped,Informations[Interior]["Exit"],false,false,false,false)

	if Robbery then
		Thef = true

		for Number,Coords in pairs(TheftCoords[Interior]) do
			Objects[Number] = true

			exports["target"]:AddCircleZone("Propertys:"..Number,Coords,0.5,{
				name = "Propertys:"..Number,
				heading = 3374176
			},{
				Distance = 1.2,
				shop = Number,
				options = {
					{
						event = "propertys:Robberys",
						label = "Roubar",
						tunnel = "server"
					}
				}
			})
		end

		while Thef do
			if GetGameTimer() <= Timers then
				local Ped = PlayerPedId()
				local Speed = GetEntitySpeed(Ped)
				if Speed > 2 then
					Timers = GetGameTimer() + 10000
					TriggerServerEvent("propertys:CallPolice",Init)
				end
			end

			Wait(1000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Request",function(Data,Callback)
	local Inventory,Chest,InvPeso,InvMax,ChestPeso,ChestMax = vSERVER.OpenChest(Init,Chest)
	if Inventory then
		Callback({ Inventory = Inventory, Chest = Chest, InvPeso = InvPeso, InvMax = InvMax, ChestPeso = ChestPeso, ChestMax = ChestMax })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SendNUIMessage({ Action = "Hide" })
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Take",function(Data,Callback)
	vSERVER.Take(Data["item"],Data["slot"],Data["amount"],Data["target"],Init,Chest)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Store",function(Data,Callback)
	vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"],Init,Chest)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	vSERVER.Update(Data["slot"],Data["target"],Data["amount"],Init,Chest)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Update")
AddEventHandler("propertys:Update",function()
	SendNUIMessage({ Action = "Request" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:WEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Weight")
AddEventHandler("propertys:Weight",function(InvPeso,InvMax,ChestPeso,ChestMax)
	SendNUIMessage({ Action = "Weight", InvPeso = InvPeso, InvMax = InvMax, ChestPeso = ChestPeso, ChestMax = ChestMax })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Table")
AddEventHandler("propertys:Table",function(PropTable,PropInfos,PropMarkers)
	Markers = PropMarkers
	Propertys = PropTable
	Informations = PropInfos

	local Tables = {}
	for _,v in pairs(Propertys) do
		Tables[#Tables + 1] = { v["x"],v["y"],v["z"],1.0,"E","Propriedade","Pressione para acessar" }
	end

	for _,Intern in pairs(Informations) do
		for Line,v in pairs(Intern) do
			local Message = "Saída"

			if Line == "Vault" then
				Message = "Baú"
			elseif Line == "Fridge" then
				Message = "Geladeira"
			elseif Line == "Clothes" then
				Message = "Armário"
			end

			Tables[#Tables + 1] = { v["x"],v["y"],v["z"],1.0,"E",Message,"Pressione para acessar" }
		end
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Blips")
AddEventHandler("propertys:Blips",function()
	if json.encode(Blips) ~= "[]" then
		for _,v in pairs(Blips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end

		Blips = {}

		TriggerEvent("Notify","amarelo","Marcações desativadas.",10000)
	else
		for Name,v in pairs(Propertys) do
			Blips[Name] = AddBlipForCoord(v["x"],v["y"],v["z"])
			SetBlipSprite(Blips[Name],374)
			SetBlipAsShortRange(Blips[Name],true)
			SetBlipColour(Blips[Name],Markers[Name] and 35 or 43)
			SetBlipScale(Blips[Name],0.4)
		end

		TriggerEvent("Notify","verde","Marcações ativadas.",10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:MARKERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Markers")
AddEventHandler("propertys:Markers",function(PropMarkers)
	Markers = PropMarkers
end)