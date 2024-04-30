-----------------------------------------------------------------------------------------------------------------------------------------
-- WASHERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Washers(Service)
	local source = source
	local Emergencys = 800
	local Passport = vRP.Passport(source)
	if Passport and vRP.TakeItem(Passport,"wetdollar",3000) then
		if Service then
			local Task = vRP.Task(source,3,5000)
			Emergencys = Task and 1000 or 0
		end

		vRP.CallPolice(source,Passport,false,"Policia","Lavagem de Dinheiro",Emergencys,60,31,22)
		vRP.GenerateItem(Passport,"promissory",1)

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEYWASH:SWAP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("moneywash:Swap")
AddEventHandler("moneywash:Swap",function()
	local source = source
	local NameItem = "promissory"
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.InventoryItemAmount(Passport,NameItem)
		if Consult[1] > 0 and Consult[2] ~= "" and vRP.TakeItem(Passport,NameItem,Consult[1]) then
			local Amount = Consult[1] * 3000
			if not vRP.MaxItens(Passport,NameItem,Amount) and vRP.CheckWeight(Passport,NameItem,Amount) then
				TriggerClientEvent("Notify",source,"Sucesso","Troca concluída.","verde",5000)
				vRP.GenerateItem(Passport,"dollar",Amount)
			else
				TriggerClientEvent("Notify",source,"Mochila Sobrecarregada","Sua recompensa caiu no chão.","amarelo",5000)
				exports["inventory"]:Drops(Passport,source,"dollar",Amount)
			end
		else
			TriggerClientEvent("Notify",source,"Aviso","<b>"..ItemName(NameItem).."</b> não encontrado.","amarelo",5000)
		end
	end
end)