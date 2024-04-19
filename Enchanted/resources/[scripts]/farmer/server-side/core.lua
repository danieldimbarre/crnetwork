-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
for Number,v in pairs(Objects) do
	GlobalState["Farmer:"..Number] = 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Minerman")
AddEventHandler("farmer:Minerman",function(Number)
	local Tasks = 8
	local Valuation = 3
	local source = source
	local Detectable = false
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Number or type(Number) == "table" then
			exports["megazord"]:Discord("**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",source)
			Active[Passport] = true

			return false
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			Active[Passport] = true

			if vRP.ConsultItem(Passport,"pickaxe",1) then
				Detectable = true
			end

			if vRP.ConsultItem(Passport,"pickaxeplus",1) then
				Detectable = true
				Valuation = 4
				Tasks = 5
			end

			if Detectable then
				vRPC.CreateObjects(source,"melee@large_wpn@streamed_core","ground_attack_on_spot","prop_tool_pickaxe",1,18905,0.10,-0.1,0.0,-92.0,260.0,5.0)
				Player(source)["state"]["Buttons"] = true
				Player(source)["state"]["Cancel"] = true

				if vRP.Task(source,Tasks,15000) then
					if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
						GlobalState["Farmer:"..Number] = GlobalState["Work"] + 36

						local Experience = vRP.GetExperience(Passport,"Minerman")
						local Level = ClassCategory(Experience)

						if Level >= 3 and Level <= 5 then
							Valuation = Valuation + 1
						elseif Level >= 6 and Level <= 8 then
							Valuation = Valuation + 2
						elseif Level >= 9 then
							Valuation = Valuation + 3
						end

						if exports["party"]:DoesExist(Passport) then
							local Members = exports["party"]:Room(Passport,source,20)
							if Members and parseInt(#Members) >= 4 then
								Valuation = Valuation + (Valuation * 0.1)
							end
						end

						if exports["inventory"]:Buffs("Luck",Passport) then
							Valuation = Valuation + (Valuation * 0.5)
						end

						if vRP.UserPremium(Passport) then
							local Bonification = 1
							local Hierarchy = vRP.LevelPremium(source)
				
							if Hierarchy == 1 then
								Bonification = 2
							elseif Hierarchy == 2 then
								Bonification = 3
							end
				
							Valuation = Valuation + Bonification
						end

						if vRP.CheckWeight(Passport,"rock",Valuation) then
							vRP.GenerateItem(Passport,"rock",Valuation,true)
						else
							TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
							exports["inventory"]:Drops(Passport,source,"rock",Valuation)
						end

						vRP.PutExperience(Passport,"Minerman",1)
						vRP.UpgradeStress(Passport,1)
					end
				end

				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
				vRPC.Destroy(source)
			else
				TriggerClientEvent("Notify",source,"Aviso","<b>Picareta</b> não encontrada.","amarelo",5000)
			end

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUMBERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Lumberman")
AddEventHandler("farmer:Lumberman",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Number or type(Number) == "table" then
			exports["megazord"]:Discord("**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",source)
			Active[Passport] = true

			return false
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			Active[Passport] = true

			local Valuation = 3
			local Ped = GetPlayerPed(source)
			if DoesEntityExist(Ped) and GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_HATCHET") then
				vRPC.playAnim(source,false,{"lumberjackaxe@idle","idle"},true)
				TriggerClientEvent("Progress",source,"Cortando",11000)
				Player(source)["state"]["Buttons"] = true
				Player(source)["state"]["Cancel"] = true
				local timeProgress = 10

				repeat
					if timeProgress ~= 10 then
						Wait(400)
					end

					Wait(700)
					TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
					timeProgress = timeProgress - 1
				until timeProgress <= 0

				Wait(400)

				if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
					GlobalState["Farmer:"..Number] = GlobalState["Work"] + 30

					if exports["party"]:DoesExist(Passport) then
						local Members = exports["party"]:Room(Passport,source,20)
						if Members and parseInt(#Members) >= 2 then
							Valuation = Valuation + (Valuation * 0.5)
						end
					end

					if exports["inventory"]:Buffs("Luck",Passport) then
						Valuation = Valuation + (Valuation * 0.5)
					end

					if vRP.CheckWeight(Passport,"woodlog",Valuation) then
						vRP.GenerateItem(Passport,"woodlog",Valuation,true)
					else
						TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
						exports["inventory"]:Drops(Passport,source,"woodlog",Valuation)
					end

					vRP.UpgradeStress(Passport,1)
				end

				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
				vRPC.Destroy(source)
			else
				TriggerClientEvent("Notify",source,"Aviso","<b>Machado</b> não encontrado.","amarelo",5000)
			end

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSPORTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Transporter")
AddEventHandler("farmer:Transporter",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Number or type(Number) == "table" then
			exports["megazord"]:Discord("**Passaporte:** "..Passport.."\n**Função:** Payment do Farmer",source)
			Active[Passport] = true

			return false
		end

		if GlobalState["Farmer:"..Number] and GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
			Active[Passport] = true

			vRPC.playAnim(source,false,{"pickup_object","pickup_low"},true)
			TriggerClientEvent("Progress",source,"Coletando",1000)
			Player(source)["state"]["Buttons"] = true
			Player(source)["state"]["Cancel"] = true

			Wait(1000)

			if GlobalState["Work"] >= GlobalState["Farmer:"..Number] then
				GlobalState["Farmer:"..Number] = GlobalState["Work"] + 6

				local Valuation = 1
				if exports["inventory"]:Buffs("Luck",Passport) then
					Valuation = Valuation + 1
				end

				if vRP.CheckWeight(Passport,"pouch",Valuation) then
					vRP.GenerateItem(Passport,"pouch",Valuation,true)
				else
					TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
					exports["inventory"]:Drops(Passport,source,"pouch",Valuation)
				end

				vRP.UpgradeStress(Passport,1)
			end

			Player(source)["state"]["Buttons"] = false
			Player(source)["state"]["Cancel"] = false
			vRPC.Destroy(source)

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)