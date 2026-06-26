-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local AmmoMax = -1
local AmmoMin = -1
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:WEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:Weapon",function(Status,Name)
	if Status then
		Active = true

		while Active do
			local Ped = PlayerPedId()
			local Hash = exports.vrp:ItemIndex(Name) or Name
			local _,Min = GetAmmoInClip(Ped,Hash)
			local Max = GetAmmoInPedWeapon(Ped,Hash)

			if AmmoMax ~= Max or AmmoMin ~= Min then
				AmmoMax = Max
				AmmoMin = Min

				if (Max - Min) <= 0 then
					Max = 0
				else
					Max = Max - Min
				end

				SendNUIMessage({ Action = "Weapons", Payload = { Name = exports.vrp:ItemName(Name), Current = Min, Stored = Max } })
			end

			Wait(100)
		end
	else
		SendNUIMessage({ Action = "Weapons" })
		Active = false
		AmmoMax = -1
		AmmoMin = -1
	end
end)