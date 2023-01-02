local currentMenuItemID = 0
local currentMenuItem = ""
local currentMenuItem2 = ""
local currentMenu = "mainMenu"
local currentCategory = 0
local currentResprayCategory = 0
local currentResprayType = 0
local currentWheelCategory = 0
local currentNeonSide = 0

local function roundNum(num,numDecimalPlaces)
	return tonumber(string.format("%."..(numDecimalPlaces or 0).."f",num))
end

local function toggleMenuContainer(state)
	SendNUIMessage({ toggleMenuContainer = true, state = state })
end

local function createMenu(menu,heading,subheading)
	SendNUIMessage({ createMenu = true, menu = menu, heading = heading, subheading = subheading })
end

local function destroyMenus()
	SendNUIMessage({ destroyMenus = true })
end

local function populateMenu(menu,id,item,item2)
	SendNUIMessage({ populateMenu = true, menu = menu, id = id, item = item, item2 = item2 })
end

local function finishPopulatingMenu(menu)
	SendNUIMessage({ finishPopulatingMenu = true, menu = menu })
end

local function updateMenuHeading(menu)
	SendNUIMessage({ updateMenuHeading = true, menu = menu })
end

local function updateMenuSubheading(menu)
	SendNUIMessage({ updateMenuSubheading = true, menu = menu })
end

local function updateMenuStatus(text)
	SendNUIMessage({ updateMenuStatus = true, statusText = text })
end

local function toggleMenu(state,menu)
	SendNUIMessage({ toggleMenu = true, state = state, menu = menu })
end

local function updateItem2Text(menu,id,text)
	SendNUIMessage({ updateItem2Text = true, menu = menu, id = id, item2 = text })
end

local function updateItem2TextOnly(menu,id,text)
	SendNUIMessage({ updateItem2TextOnly = true, menu = menu, id = id, item2 = text })
end

local function scrollMenuFunctionality(direction,menu)
	SendNUIMessage({ scrollMenuFunctionality = true, direction = direction, menu = menu })
end

local function playSoundEffect(soundEffect,volume)
	SendNUIMessage({ playSoundEffect = true, soundEffect = soundEffect, volume = volume })
end

local function isMenuActive(menu)
	local menuActive = false

	if menu == "modMenu" then
		for k,v in pairs(vehicleCustomisation) do 
			if (v["category"]:gsub("%s+","").."Menu") == currentMenu then
				menuActive = true

				break
			else
				menuActive = false
			end
		end
	elseif menu == "PinturaMenu" then
		for k,v in pairs(vehicleResprayOptions) do
			if (v["category"]:gsub("%s+","").."Menu") == currentMenu then
				menuActive = true

				break
			else
				menuActive = false
			end
		end
	elseif menu == "RodasMenu" then
		for k,v in pairs(vehicleWheelOptions) do
			if (v["category"]:gsub("%s+","").."Menu") == currentMenu then
				menuActive = true

				break
			else
				menuActive = false
			end
		end
	elseif menu == "NeonsMenu" then
		for k,v in pairs(vehicleNeonOptions["neonTypes"]) do
			if (v["name"]:gsub("%s+","").."Menu") == currentMenu then
				menuActive = true

				break
			else
				menuActive = false
			end
		end
	end

	return menuActive
end

local function updateCurrentMenuItemID(id,item,item2)
	currentMenuItemID = id
	currentMenuItem = item
	currentMenuItem2 = item2

	if isMenuActive("modMenu") then
		if currentCategory ~= 18 then
			PreviewMod(currentCategory,currentMenuItemID)
		end
	elseif isMenuActive("PinturaMenu") then
		PreviewColour(currentResprayCategory,currentResprayType,currentMenuItemID)
	elseif isMenuActive("RodasMenu") then
		if currentWheelCategory ~= -1 and currentWheelCategory ~= 20 then
			PreviewWheel(currentCategory,currentMenuItemID,currentWheelCategory)
		end
	elseif isMenuActive("NeonsMenu") then
		PreviewNeon(currentNeonSide,currentMenuItemID)
	elseif currentMenu == "JanelasMenu" then
		PreviewWindowTint(currentMenuItemID)
	elseif currentMenu == "CordoNeonMenu" then
		local r = vehicleNeonOptions["neonColours"][currentMenuItemID]["r"]
		local g = vehicleNeonOptions["neonColours"][currentMenuItemID]["g"]
		local b = vehicleNeonOptions["neonColours"][currentMenuItemID]["b"]

		PreviewNeonColour(r,g,b)
	elseif currentMenu == "CordoXenonMenu" then
		PreviewXenonColour(currentMenuItemID)
	elseif currentMenu == "EstampaPolicialMenu" then
		PreviewPoliceLivery(currentMenuItemID)
	elseif currentMenu == "PlacaMenu" then
		PreviewPlateIndex(currentMenuItemID)
	end
end

function InitiateMenus(isMotorcycle)
	local Ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(Ped)
	local vehclass = GetVehicleClass(vehicle)

	createMenu("mainMenu","Bem-vindo à Benny's Original Motorworks","Escolha uma categoria")

	for k,v in ipairs(vehicleCustomisation) do 
		local validMods,amountValidMods = CheckValidMods(v["category"],v["id"])

		if amountValidMods > 0 or v["id"] == 18 then
			populateMenu("mainMenu",v["id"],v["category"],"none")
		end
	end

	populateMenu("mainMenu",-1,"Pintura","none")

	if not isMotorcycle then
		populateMenu("mainMenu",-2,"Janelas","none")
		populateMenu("mainMenu",-3,"Neons","none")
	end

	populateMenu("mainMenu",22,"Xenons","none")
	populateMenu("mainMenu",23,"Rodas","none")

	if vehclass == 18 then
		populateMenu("mainMenu",24,"Estampa Policial","none")
		local livCount = GetVehicleLiveryCount(vehicle)
		if livCount > 0 then
			local temporaryLivery = GetVehicleLivery(vehicle)
			createMenu("EstampaPolicialMenu","Customização de Estampa Policial","Escolha uma estampa")
			for i = 0,livCount - 1 do
				populateMenu("EstampaPolicialMenu",i,"Estampa 0"..i + 1,"$100")

				if temporaryLivery == i then
					updateItem2Text("EstampaPolicialMenu",i,"Instalado")
				end
			end

			finishPopulatingMenu("EstampaPolicialMenu")
		end

		populateMenu("mainMenu",26,"Extras","none")
		createMenu("ExtrasMenu","Customização de Extras","Ativar / Desativar extras")

		for i = 1,12 do
			if DoesExtraExist(vehicle,i) then
				if IsVehicleExtraTurnedOn(vehicle,i) then
					populateMenu("ExtrasMenu",i,"Extras 0"..i,"Ativado")
				else
					populateMenu("ExtrasMenu",i,"Extras 0"..i,"Desativado")
				end
			end
		end

		finishPopulatingMenu("ExtrasMenu")
	end


	populateMenu("mainMenu",25,"Placa","none")

	finishPopulatingMenu("mainMenu")

	for k,v in ipairs(vehicleCustomisation) do 
		local validMods,amountValidMods = CheckValidMods(v["category"],v["id"])
		local currentMod,currentModName = GetCurrentMod(v["id"])

		if amountValidMods > 0 or v["id"] == 18 then
			if v["id"] == 11 or v["id"] == 12 or v["id"] == 13 or v["id"] == 15 or v["id"] == 16 then
				local tempNum = 0

				createMenu(v["category"]:gsub("%s+","").."Menu","Customização do "..v["category"],"Escolha uma atualização")

				for m,n in pairs(validMods) do
					tempNum = tempNum + 1

					populateMenu(v["category"]:gsub("%s+","").."Menu",n["id"],n["name"],"$"..vehicleCustomisationPrices[v["type"]][tempNum])

					if currentMod == n["id"] then
						updateItem2Text(v["category"]:gsub("%s+","").."Menu",n["id"],"Instalado")
					end
				end

				finishPopulatingMenu(v["category"]:gsub("%s+","").."Menu")
			elseif v["id"] == 18 then
				local currentTurboState = GetCurrentTurboState()
				createMenu(v["category"]:gsub("%s+","").."Menu","Customização do "..v["category"],"Ativar / Desativar turbo")

				populateMenu(v["category"]:gsub("%s+","").."Menu",0,"Desativado","$7500")
				populateMenu(v["category"]:gsub("%s+","").."Menu",1,"Ativado","$"..vehicleCustomisationPrices["turbo"])

				updateItem2Text(v["category"]:gsub("%s+","").."Menu",currentTurboState,"Instalado")

				finishPopulatingMenu(v["category"]:gsub("%s+","").."Menu")
			else
				createMenu(v["category"]:gsub("%s+","").."Menu","Customização do "..v["category"],"Escolha uma modificação")

				for m,n in pairs(validMods) do
					populateMenu(v["category"]:gsub("%s+","").."Menu",n["id"],n["name"],"$"..vehicleCustomisationPrices["cosmetics"])

					if currentMod == n["id"] then
						updateItem2Text(v["category"]:gsub("%s+","").."Menu",n["id"],"Instalado")
					end
				end

				finishPopulatingMenu(v["category"]:gsub("%s+","").."Menu")
			end
		end
	end

	createMenu("PinturaMenu","Pintura","Escolha uma categoria de cores")

	populateMenu("PinturaMenu",0,"Cor primária","none")
	populateMenu("PinturaMenu",1,"Cor secundária","none")
	populateMenu("PinturaMenu",2,"Cor perolada","none")
	populateMenu("PinturaMenu",3,"Cor da roda","none")
	populateMenu("PinturaMenu",4,"Cor interna","none")
	populateMenu("PinturaMenu",5,"Cor do painel","none")

	finishPopulatingMenu("PinturaMenu")

	createMenu("TiposdePinturaMenu","Tipos de Pintura","Escolha um tipo de cor")

	for k,v in ipairs(vehicleResprayOptions) do
		populateMenu("TiposdePinturaMenu",v["id"],v["category"],"none")
	end

	finishPopulatingMenu("TiposdePinturaMenu")

	for k,v in ipairs(vehicleResprayOptions) do 
		createMenu(v["category"].."Menu",v["category"],"Escolha uma cor")

		for m,n in ipairs(v["colours"]) do
			populateMenu(v["category"].."Menu",n["id"],n["name"],"$"..vehicleCustomisationPrices["respray"])
		end

		finishPopulatingMenu(v["category"].."Menu")
	end

	createMenu("RodasMenu","Customização das Rodas","Escolha uma categoria")

	for k,v in ipairs(vehicleWheelOptions) do 
		if isMotorcycle then
			if v["id"] == -1 or v["id"] == 20 or v["id"] == 6 then
				populateMenu("RodasMenu",v["id"],v["category"],"none")
			end
		else
			populateMenu("RodasMenu",v["id"],v["category"],"none")
		end
	end

	finishPopulatingMenu("RodasMenu")

	for k,v in ipairs(vehicleWheelOptions) do 
		if v["id"] == -1 then
			local currentCustomWheelState = GetCurrentCustomWheelState()
			createMenu(v["category"]:gsub("%s+","").."Menu",v["category"],"Ativar / Desativar rodas personalizadas")

			populateMenu(v["category"]:gsub("%s+","").."Menu",0,"Desativado","$0")
			populateMenu(v["category"]:gsub("%s+","").."Menu",1,"Ativado","$"..vehicleCustomisationPrices["customwheels"])

			updateItem2Text(v["category"]:gsub("%s+","").."Menu",currentCustomWheelState,"Instalado")

			finishPopulatingMenu(v["category"]:gsub("%s+","").."Menu")
		elseif v["id"] ~= 20 then
			if isMotorcycle then
				if v["id"] == 6 then
					local validMods,amountValidMods = CheckValidMods(v["category"],v.wheelID,v["id"])

					createMenu(v["category"].."Menu","Rodas "..v["category"],"Escolha uma roda")

					for m,n in pairs(validMods) do
						populateMenu(v["category"].."Menu",n["id"],n["name"],"$"..vehicleCustomisationPrices["wheels"])
					end

					finishPopulatingMenu(v["category"].."Menu")
				end
			else
				local validMods,amountValidMods = CheckValidMods(v["category"],v.wheelID,v["id"])

				createMenu(v["category"].."Menu","Rodas "..v["category"],"Escolha uma roda")

				for m,n in pairs(validMods) do
					populateMenu(v["category"].."Menu",n["id"],n["name"],"$"..vehicleCustomisationPrices["wheels"])
				end

				finishPopulatingMenu(v["category"].."Menu")
			end
		end
	end

	local currentWheelSmokeR,currentWheelSmokeG,currentWheelSmokeB = GetCurrentVehicleWheelSmokeColour()
	createMenu("FumaçadopneuMenu","Customização da Fumaça do Pneu","Escolha uma cor")

	for k,v in ipairs(vehicleTyreSmokeOptions) do
		populateMenu("FumaçadopneuMenu",k,v["name"],"$"..vehicleCustomisationPrices["wheelsmoke"])

		if v["r"] == currentWheelSmokeR and v["g"] == currentWheelSmokeG and v["b"] == currentWheelSmokeB then
			updateItem2Text("FumaçadopneuMenu",k,"Instalado")
		end
	end

	finishPopulatingMenu("FumaçadopneuMenu")

	local currentWindowTint = GetCurrentWindowTint()
	createMenu("JanelasMenu","Customização da Tonalidade das Janelas","Escolha uma tonalidade")

	for k,v in ipairs(vehicleWindowTintOptions) do
		populateMenu("JanelasMenu",v["id"],v["name"],"$"..vehicleCustomisationPrices["windowtint"])

		if currentWindowTint == v["id"] then
			updateItem2Text("JanelasMenu",v["id"],"Instalado")
		end
	end

	finishPopulatingMenu("JanelasMenu")

	local temporaryPlate = GetVehicleNumberPlateTextIndex(vehicle)
	createMenu("PlacaMenu","Customização do Tipo de Placa","Escolha o tipo")

	local plateTypes = {
		"San Andreas Cosmo",
		"San Andreas Supermesh",
		"San Andreas Outsider",
		"San Andreas Slicer",
		"San Andreas Elquatro",
		"San Andreas Dubbed"
	}

	for i = 0,#plateTypes - 1 do
		populateMenu("PlacaMenu",i,plateTypes[i+1],"$1000")

		if temporaryPlate == i then
			updateItem2Text("PlacaMenu",i,"Instalado")
		end
	end
	finishPopulatingMenu("PlacaMenu")

	createMenu("NeonsMenu","Customização do Neon","Escolha uma categoria")

	for k,v in ipairs(vehicleNeonOptions["neonTypes"]) do
		populateMenu("NeonsMenu",v["id"],v["name"],"none")
	end

	populateMenu("NeonsMenu",-1,"Cor do Neon","none")
	finishPopulatingMenu("NeonsMenu")

	for k,v in ipairs(vehicleNeonOptions["neonTypes"]) do
		local currentNeonState = GetCurrentNeonState(v["id"])
		createMenu(v["name"]:gsub("%s+","").."Menu","Customização do Neon","Ativar / Desativar neon")

		populateMenu(v["name"]:gsub("%s+","").."Menu",0,"Desativado","$0")
		populateMenu(v["name"]:gsub("%s+","").."Menu",1,"Ativado","$"..vehicleCustomisationPrices["neonside"])

		updateItem2Text(v["name"]:gsub("%s+","").."Menu",currentNeonState,"Instalado")

		finishPopulatingMenu(v["name"]:gsub("%s+","").."Menu")
	end

	local currentNeonR,currentNeonG,currentNeonB = GetCurrentNeonColour()
	createMenu("CordoNeonMenu","Customização da Cor do Neon","Escolha uma cor")

	for k,v in ipairs(vehicleNeonOptions["neonColours"]) do
		populateMenu("CordoNeonMenu",k,vehicleNeonOptions["neonColours"][k]["name"],"$"..vehicleCustomisationPrices["neoncolours"])

		if currentNeonR == vehicleNeonOptions["neonColours"][k]["r"] and currentNeonG == vehicleNeonOptions["neonColours"][k]["g"] and currentNeonB == vehicleNeonOptions["neonColours"][k]["b"] then
			updateItem2Text("CordoNeonMenu",k,"Instalado")
		end
	end

	finishPopulatingMenu("CordoNeonMenu")

	createMenu("XenonsMenu","Customização do Xenon","Escolha a categoria")

	populateMenu("XenonsMenu",0,"Xenon","none")
	populateMenu("XenonsMenu",1,"Cor do Xenon","none")

	finishPopulatingMenu("XenonsMenu")

	local currentXenonState = GetCurrentXenonState()
	createMenu("XenonMenu","Customização do Xenon","Ativar / Desativar xenons")

	populateMenu("XenonMenu",0,"Desativado","$0")
	populateMenu("XenonMenu",1,"Ativado","$"..vehicleCustomisationPrices["headlights"])

	updateItem2Text("XenonMenu",currentXenonState,"Instalado")

	finishPopulatingMenu("XenonMenu")

	local currentXenonColour = GetCurrentXenonColour()
	createMenu("CordoXenonMenu","Customização da Cor do Xenon","Escolha uma cor")

	for k,v in ipairs(vehicleXenonOptions["xenonColours"]) do
		populateMenu("CordoXenonMenu",v["id"],v["name"],"$"..vehicleCustomisationPrices["xenoncolours"])

		if currentXenonColour == v["id"] then
			updateItem2Text("CordoXenonMenu",v["id"],"Instalado")
		end
	end

	finishPopulatingMenu("CordoXenonMenu")
end

function DestroyMenus()
	destroyMenus()
end

function DisplayMenuContainer(state)
	toggleMenuContainer(state)
end

function DisplayMenu(state,menu)
	if state then
		currentMenu = menu
	end

	toggleMenu(state,menu)
	updateMenuHeading(menu)
	updateMenuSubheading(menu)
end

function MenuManager(state)
	if state then
		if currentMenuItem2 ~= "Instalado" then
			if isMenuActive("modMenu") then
				if currentCategory == 18 then
					if AttemptPurchase("turbo") then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				elseif currentCategory == 11 then
					if AttemptPurchase("engines",currentMenuItemID) then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				elseif currentCategory == 12 then
					if AttemptPurchase("brakes",currentMenuItemID) then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				elseif currentCategory == 13 then
					if AttemptPurchase("transmission",currentMenuItemID) then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				elseif currentCategory == 15 then
					if AttemptPurchase("suspension",currentMenuItemID) then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				elseif currentCategory == 16 then
					if AttemptPurchase("shield",currentMenuItemID) then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				else
					if AttemptPurchase("cosmetics") then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				end
			elseif isMenuActive("PinturaMenu") then
				if AttemptPurchase("respray") then
					ApplyColour(currentResprayCategory,currentResprayType,currentMenuItemID)
					playSoundEffect("respray",1.0)
					updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
					updateMenuStatus("Comprado")
				else
					updateMenuStatus("Dólares insuficientes.")
				end
			elseif isMenuActive("RodasMenu") then
				if currentWheelCategory == 20 then
					if AttemptPurchase("wheelsmoke") then
						local r = vehicleTyreSmokeOptions[currentMenuItemID]["r"]
						local g = vehicleTyreSmokeOptions[currentMenuItemID]["g"]
						local b = vehicleTyreSmokeOptions[currentMenuItemID]["b"]

						ApplyTyreSmoke(r,g,b)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				else
					if currentWheelCategory == -1 then
						local currentWheel = GetCurrentWheel()

						if currentWheel == -1 then
							updateMenuStatus("Não é possível aplicar pneus personalizados a rodas originais")
						else
							if AttemptPurchase("customwheels") then
								ApplyCustomWheel(currentMenuItemID)
								playSoundEffect("wrench",0.25)
								updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
								updateMenuStatus("Comprado")
							else
								updateMenuStatus("Dólares insuficientes.")
							end
						end
					else
						local currentWheel = GetCurrentWheel()
						local currentCustomWheelState = GetOriginalCustomWheel()

						if currentCustomWheelState and currentWheel == -1 then
							updateMenuStatus("Não é possível aplicar rodas originais com pneus personalizados")
						else
							if AttemptPurchase("wheels") then
								ApplyWheel(currentCategory,currentMenuItemID,currentWheelCategory)
								playSoundEffect("wrench",0.25)
								updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
								updateMenuStatus("Comprado")
							else
								updateMenuStatus("Dólares insuficientes.")
							end
						end
					end
				end
			elseif isMenuActive("NeonsMenu") then
				if AttemptPurchase("neonside") then
					playSoundEffect("wrench",0.25)
					ApplyNeon(currentNeonSide,currentMenuItemID)
					updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
					updateMenuStatus("Comprado")
				else
					updateMenuStatus("Dólares insuficientes.")
				end 
			else
				if currentMenu == "mainMenu" then
					currentMenu = currentMenuItem:gsub("%s+","").."Menu"
					currentCategory = currentMenuItemID

					toggleMenu(false,"mainMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "PinturaMenu" then
					currentMenu = "TiposdePinturaMenu"
					currentResprayCategory = currentMenuItemID

					toggleMenu(false,"PinturaMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "TiposdePinturaMenu" then
					currentMenu = currentMenuItem:gsub("%s+","").."Menu"
					currentResprayType = currentMenuItemID

					toggleMenu(false,"TiposdePinturaMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "RodasMenu" then
					local currentWheel,currentWheelName,currentWheelType = GetCurrentWheel()

					currentMenu = currentMenuItem:gsub("%s+","").."Menu"
					currentWheelCategory = currentMenuItemID

					if currentWheelType == currentWheelCategory then
						updateItem2Text(currentMenu,currentWheel,"Instalado")
					end

					toggleMenu(false,"RodasMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "NeonsMenu" then
					currentMenu = currentMenuItem:gsub("%s+","").."Menu"
					currentNeonSide = currentMenuItemID

					toggleMenu(false,"NeonsMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "XenonsMenu" then
					currentMenu = currentMenuItem:gsub("%s+","").."Menu"

					toggleMenu(false,"XenonsMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "JanelasMenu" then
					if AttemptPurchase("windowtint") then
						ApplyWindowTint(currentMenuItemID)
						playSoundEffect("respray",1.0)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				elseif currentMenu == "CordoNeonMenu" then
					if AttemptPurchase("neoncolours") then
						local r = vehicleNeonOptions["neonColours"][currentMenuItemID]["r"]
						local g = vehicleNeonOptions["neonColours"][currentMenuItemID]["g"]
						local b = vehicleNeonOptions["neonColours"][currentMenuItemID]["b"]

						ApplyNeonColour(r,g,b)
						playSoundEffect("respray",1.0)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				elseif currentMenu == "XenonMenu" then
					if AttemptPurchase("headlights") then
						ApplyXenonLights(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				elseif currentMenu == "CordoXenonMenu" then
					if AttemptPurchase("xenoncolours") then
						ApplyXenonColour(currentMenuItemID)
						playSoundEffect("respray",1.0)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				elseif currentMenu == "EstampaPolicialMenu" then
					if AttemptPurchase("policelivery") then
						ApplyPoliceLivery(currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")   
					end
				elseif currentMenu == "PlacaMenu" then
					if AttemptPurchase("plateindex") then
						ApplyPlateIndex(currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dólares insuficientes.")
					end
				elseif currentMenu == "ExtrasMenu" then
					ApplyExtra(currentMenuItemID)
					playSoundEffect("wrench",0.25)

					local Ped = PlayerPedId()
					local vehicle = GetVehiclePedIsUsing(Ped)
					if IsVehicleExtraTurnedOn(vehicle,currentMenuItemID) then
						updateItem2TextOnly(currentMenu,currentMenuItemID,"Ativado")
						updateMenuStatus("Ativado")
					else
						updateItem2TextOnly(currentMenu,currentMenuItemID,"Desativado")
						updateMenuStatus("Desativado")
					end
				end
			end
		else
			if currentMenu == "ExtrasMenu" then
				ApplyExtra(currentMenuItemID)
				playSoundEffect("wrench",0.25)

				local Ped = PlayerPedId()
				local vehicle = GetVehiclePedIsUsing(Ped)
				if IsVehicleExtraTurnedOn(vehicle,currentMenuItemID) then
					updateItem2TextOnly(currentMenu,currentMenuItemID,"Ativado")
					updateMenuStatus("Ativado")
				else
					updateItem2TextOnly(currentMenu,currentMenuItemID,"Desativado")
					updateMenuStatus("Desativado")
				end
			end
		end
	else
		updateMenuStatus("")

		if isMenuActive("modMenu") then
			toggleMenu(false,currentMenu)

			currentMenu = "mainMenu"

			if currentCategory ~= 18 then
				RestoreOriginalMod()
			end

			toggleMenu(true,currentMenu)
			updateMenuHeading(currentMenu)
			updateMenuSubheading(currentMenu)
		elseif isMenuActive("PinturaMenu") then
			toggleMenu(false,currentMenu)

			currentMenu = "TiposdePinturaMenu"

			RestoreOriginalColours()

			toggleMenu(true,currentMenu)
			updateMenuHeading(currentMenu)
			updateMenuSubheading(currentMenu)
		elseif isMenuActive("RodasMenu") then            
			if currentWheelCategory ~= 20 and currentWheelCategory ~= -1 then
				local currentWheel = GetOriginalWheel()

				updateItem2Text(currentMenu,currentWheel,"$"..vehicleCustomisationPrices["wheels"])

				RestoreOriginalWheels()
			end

			toggleMenu(false,currentMenu)

			currentMenu = "RodasMenu"

			toggleMenu(true,currentMenu)
			updateMenuHeading(currentMenu)
			updateMenuSubheading(currentMenu)
		elseif isMenuActive("NeonsMenu") then
			toggleMenu(false,currentMenu)

			currentMenu = "NeonsMenu"

			RestoreOriginalNeonStates()

			toggleMenu(true,currentMenu)
			updateMenuHeading(currentMenu)
			updateMenuSubheading(currentMenu)
		else
			if currentMenu == "mainMenu" then
				ExitBennys()
			elseif currentMenu == "PinturaMenu" or currentMenu == "JanelasMenu" or currentMenu == "RodasMenu" or currentMenu == "NeonsMenu" or currentMenu == "XenonsMenu" or currentMenu == "EstampaPolicialMenu" or currentMenu == "PlacaMenu" or currentMenu == "ExtrasMenu" then
				toggleMenu(false,currentMenu)

				if currentMenu == "JanelasMenu" then
					RestoreOriginalWindowTint()
				end

				if currentMenu == "EstampaPolicialMenu" then
					RestorePoliceLivery()
				end

				if currentMenu == "PlacaMenu" then
					RestorePlateIndex()
				end

				currentMenu = "mainMenu"

				toggleMenu(true,currentMenu)
				updateMenuHeading(currentMenu)
				updateMenuSubheading(currentMenu)
			elseif currentMenu == "TiposdePinturaMenu" then
				toggleMenu(false,currentMenu)

				currentMenu = "PinturaMenu"

				toggleMenu(true,currentMenu)
				updateMenuHeading(currentMenu)
				updateMenuSubheading(currentMenu)
			elseif currentMenu == "CordoNeonMenu" then
				toggleMenu(false,currentMenu)

				currentMenu = "NeonsMenu"

				RestoreOriginalNeonColours()

				toggleMenu(true,currentMenu)
				updateMenuHeading(currentMenu)
				updateMenuSubheading(currentMenu)
			elseif currentMenu == "XenonMenu" then
				toggleMenu(false,currentMenu)

				currentMenu = "XenonsMenu"

				toggleMenu(true,currentMenu)
				updateMenuHeading(currentMenu)
				updateMenuSubheading(currentMenu)
			elseif currentMenu == "CordoXenonMenu" then
				toggleMenu(false,currentMenu)

				currentMenu = "XenonsMenu"

				RestoreOriginalXenonColour()

				toggleMenu(true,currentMenu)
				updateMenuHeading(currentMenu)
				updateMenuSubheading(currentMenu)
			end
		end
	end
end

function MenuScrollFunctionality(direction)
	scrollMenuFunctionality(direction,currentMenu)
end

RegisterNUICallback("selectedItem",function(Data,Callback)
	updateCurrentMenuItemID(tonumber(Data["id"]),Data["item"],Data["item2"])

	Callback("Ok")
end)

RegisterNUICallback("updateItem2",function(Data,Callback)
	currentMenuItem2 = Data["item"]

	Callback("Ok")
end)