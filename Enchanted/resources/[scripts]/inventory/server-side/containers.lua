-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Cooldown = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local Itens = {
	{
		{ ["Item"] = "analgesic", ["Min"] = 1, ["Max"] = 3 },
		{ ["Item"] = "bandage", ["Min"] = 1, ["Max"] = 3 }
	},{
		{ ["Item"] = "radio", ["Min"] = 1, ["Max"] = 3 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CONTAINER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Container")
AddEventHandler("inventory:Container",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Cooldown[Number] or os.time() > Cooldown[Number] then
			if vRP.Task(source,3,10000) then
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Roubando",10000)
				vRPC.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)
				vRP.CallPolice(source,Passport,false,"Policia","Roubo ao Container",900,120,31,22)

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) and Number and (not Cooldown[Number] or os.time() > Cooldown[Number]) then
						vRPC.Destroy(source)
						Active[Passport] = nil
						Cooldown[Number] = os.time() + 3600
						Player(source)["state"]["Buttons"] = false

						vRP.MountContainer("Containers:"..Number,Itens,false)
						TriggerClientEvent("player:Residuals",source,"Resquício de Poeira.")
						TriggerClientEvent("chest:Open",source,"Containers:"..Number,"Custom",false,true)
					end

					Wait(100)
				until not Active[Passport]
			end
		else
			local Consult = vRP.GetSrvData("Containers:"..Number,false)
			if json.encode(Consult) ~= "[]" and (Cooldown[Number] - 3300) >= os.time() then
				TriggerClientEvent("chest:Open",source,"Containers:"..Number,"Custom",false,true)
			else
				TriggerClientEvent("Notify",source,"Atenção","Aguarde <b>"..Cooldown[Number] - os.time().."</b> segundos.","amarelo",5000)
			end
		end
	end
end)