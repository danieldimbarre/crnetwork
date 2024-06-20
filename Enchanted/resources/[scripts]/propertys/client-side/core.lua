-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("propertys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Init = ""
local Blips = {}
local Chest = ""
local Theft = nil
local Hoverfy = {}
local Interior = ""
local Opened = false
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
					if #(Coords - v["Coords"]) <= 0.75 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) then
							local Consult = vSERVER.Propertys(Name)

							if Consult then
								if Consult == "Nothing" then
									exports["dynamic"]:AddButton("Invadir","Forçar a fechadura.","propertys:Robbery",Name,false,true)

									for Line,v in pairs(Informations) do
										if (Propertys[Name]["Galpão"] and Line == "Galpão") or (not Propertys[Name]["Galpão"] and Line ~= "Galpão") then
											if v["Vault"] then
												exports["dynamic"]:AddButton("Baú","Total de <yellow>"..v["Vault"].."Kg</yellow> no compartimento.","","",Line,false)
											end

											if v["Fridge"] then
												exports["dynamic"]:AddButton("Geladeira","Total de <yellow>"..v["Fridge"].."Kg</yellow> no compartimento.","","",Line,false)
											end

											exports["dynamic"]:AddButton("Credenciais","Máximo <yellow>1</yellow> proprietário e <yellow>3</yellow> adicionais.","","",Line,false)
											exports["dynamic"]:AddButton("Comprar com Dinheiro","Custo de <yellow>"..Currency..Dotted(v["Price"]).."</yellow>.","propertys:Buy",Name.."-"..Line.."-Dollar",Line,true)
											exports["dynamic"]:AddButton("Comprar com Diamantes","Custo de <yellow>"..Dotted(v["Gemstone"]).."</yellow>.","propertys:Buy",Name.."-"..Line.."-Gemstone",Line,true)
											exports["dynamic"]:SubMenu(Line,"Informações sobre o interior.",Line)
										end
									end

									exports["dynamic"]:openMenu()
								else
									if Consult ~= "Hotel" then
										exports["dynamic"]:AddButton("Entrar","Adentrar a propriedade.","propertys:Enter",Name,false,false)
										exports["dynamic"]:AddButton("Credenciais","Reconfigurar os cartões de acesso.","propertys:Credentials",Name,false,true)
										exports["dynamic"]:AddButton("Cartões","Comprar um novo cartão de acesso.","propertys:Item",Name,false,true)
										exports["dynamic"]:AddButton("Fechadura","Trancar/Destrancar a propriedade.","propertys:Lock",Name,false,true)
										exports["dynamic"]:AddButton("Garagem","Adicionar/Reajustar a garagem.","garages:Propertys",Name,false,true)
										exports["dynamic"]:AddButton("Vender","Se desfazer da propriedade.","propertys:Sell",Name,false,true)
										exports["dynamic"]:AddButton("Transferência","Mudar proprietário.","propertys:Transfer",Name,false,true)
										exports["dynamic"]:AddButton("Hipoteca",Consult["Tax"],"","",false,false)

										Interior = Consult["Interior"]

										exports["dynamic"]:openMenu()
									else
										Interior = "Hotel"

										TriggerEvent("propertys:Enter",Name,false)
									end
								end
							else
								exports["dynamic"]:AddButton("Invadir","Forçar a fechadura.","propertys:Robbery",Name,false,true)

								exports["dynamic"]:openMenu()
							end
						end
					end
				end
			elseif Interiors[Interior] then
				SetPlayerBlipPositionThisFrame(Propertys[Init]["Coords"]["x"],Propertys[Init]["Coords"]["y"])

				if Coords["z"] < (Interiors[Interior]["Exit"]["z"] - 25.0) then
					SetEntityCoords(Ped,Interiors[Interior]["Exit"],false,false,false,false)
				end

				if Robbery[Interior] and Robbery[Interior]["Furniture"] and Theft and Theft < GetGameTimer() and GetEntitySpeed(Ped) > 2 then
					vSERVER.Police(Propertys[Init]["Coords"])
					Theft = GetGameTimer() + 60000
				end

				for Line,v in pairs(Interiors[Interior]) do
					if #(Coords - v) <= 1.0 then
						TimeDistance = 1

						if Line == "Exit" and IsControlJustPressed(1,38) then
							if Theft and Robbery[Interior] and Robbery[Interior]["Furniture"] then
								for Index in pairs(Robbery[Interior]["Furniture"]) do
									exports["target"]:RemCircleZone("Robberys:"..Index)
								end
							end

							SetEntityCoords(Ped,Propertys[Init]["Coords"],false,false,false,false)
							vSERVER.Toggle(Init,"Exit")
							Interior = ""
							Theft = nil
							Chest = ""
							Init = ""
						elseif not Theft and (Line == "Vault" or Line == "Fridge") and IsControlJustPressed(1,38) and vSERVER.Permission(Init) then
							vRP.playAnim(false,{"amb@prop_human_bum_bin@base","base"},true)
							Opened = true
							Chest = Line

							TriggerEvent("inventory:Open",{
								Action = "Open",
								Type = "Chest",
								Resource = "propertys"
							})
						elseif not Theft and Line == "Clothes" and IsControlJustPressed(1,38) then
							ClothesMenu()
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
	exports["dynamic"]:AddButton("Guardar","Salvar suas vestimentas do corpo.","propertys:Clothes","Save",false,true)
	exports["dynamic"]:AddButton("Shopping","Abrir a loja de vestimentas.","skinshop:Open","",false,false)
	exports["dynamic"]:SubMenu("Vestir","Abrir lista com todas as vestimentas.","Apply")
	exports["dynamic"]:SubMenu("Remover","Abrir lista com todas as vestimentas.","Delete")

	local Clothes = vSERVER.Clothes()
	if parseInt(#Clothes) > 0 then
		for _,v in pairs(Clothes) do
			exports["dynamic"]:AddButton(v,"Vestir-se com as vestimentas.","propertys:Clothes","apply-"..v,"Apply",true)
			exports["dynamic"]:AddButton(v,"Remover a vestimenta salva.","propertys:Clothes","delete-"..v,"Delete",true)
		end
	end

	exports["dynamic"]:openMenu()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CLOTHESRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:ClothesReset")
AddEventHandler("propertys:ClothesReset",function()
	TriggerEvent("dynamic:Close")
	ClothesMenu()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Enter")
AddEventHandler("propertys:Enter",function(Name,Thefting)
	if Thefting then
		Interior = Thefting
		Theft = GetGameTimer() + 10000
		TriggerEvent("player:Residuals","Resquício de Línter")

		for Number,v in pairs(Robbery[Interior]["Furniture"]) do
			exports["target"]:AddCircleZone("Robberys:"..Number,v,0.1,{
				name = "Robberys:"..Number,
				heading = 0.0,
				useZ = true
			},{
				shop = Number,
				Distance = 1.25,
				options = {
					{
						event = "propertys:RobberyItem",
						label = "Roubar",
						tunnel = "server",
						service = Name
					}
				}
			})
		end
	else
		TriggerEvent("dynamic:Close")

		if not Hoverfy[Name] and Interiors[Interior] then
			local Tables = {}
			Hoverfy[Name] = true

			for Index,v in pairs(Interiors[Interior]) do
				local Message = "Saída"

				if Index == "Vault" then
					Message = "Baú"
				elseif Index == "Fridge" then
					Message = "Geladeira"
				elseif Index == "Clothes" then
					Message = "Armário"
				end

				Tables[#Tables + 1] = { v,0.75,"E",Message,"Pressione para acessar" }
			end

			TriggerEvent("hoverfy:Insert",Tables)
		end
	end

	Init = Name
	local Ped = PlayerPedId()
	vSERVER.Toggle(Init,"Enter")
	SetEntityCoords(Ped,Interiors[Interior]["Exit"],false,false,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mount",function(Data,Callback)
	local Primary,Secondary,PrimaryWeight,SecondaryWeight = vSERVER.Mount(Init,Chest)
	if Primary then
		Callback({ Primary = Primary, Secondary = Secondary, PrimaryMaxWeight = PrimaryWeight, SecondaryMaxWeight = SecondaryWeight })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	if Opened then
		Opened = false
		vRP.Destroy()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Take",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Take(Data["slot"],Data["amount"],Data["target"],Init,Chest)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Store",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"],Init,Chest)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	if MumbleIsConnected() then
		vSERVER.Update(Data["slot"],Data["target"],Data["amount"],Init,Chest)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVERSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Tables = {}
	for Name,v in pairs(Propertys) do
		Tables[#Tables + 1] = { v["Coords"],0.75,"E","Propriedade","Pressione para acessar" }
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

		TriggerEvent("Notify","Propriedades","Marcações desativadas.","default",10000)
	else
		for Name,v in pairs(Propertys) do
			if Name ~= "Hotel" then
				Blips[Name] = AddBlipForCoord(v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"])

				if v["Galpão"] then
					SetBlipSprite(Blips[Name],473)
				else
					SetBlipSprite(Blips[Name],374)
				end

				SetBlipScale(Blips[Name],0.5)
				SetBlipAsShortRange(Blips[Name],true)
				SetBlipColour(Blips[Name],GlobalState["Markers"][Name] and 35 or 43)
			end
		end

		TriggerEvent("Notify","Propriedades","Marcações ativadas.","default",10000)
	end
end)