-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Multiplier = { 3,5 }
Permission = "Admin"
EventName = "Evento de Natal"
EventProp = "prop_mil_crate_01"
MessageStart = "O evento começou!"
MessageFinish = "O evento terminou!"
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPONETS
-----------------------------------------------------------------------------------------------------------------------------------------
Components = {
	["1"] = vec4(1159.61,3069.23,40.49,105.77),
	["2"] = vec4(1155.73,3060.93,40.25,36.09),
	["3"] = vec4(1149.98,3065.65,40.48,281.94)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOTS
-----------------------------------------------------------------------------------------------------------------------------------------
Loots = {
	{ ["Item"] = "analgesic", ["Chance"] = 100, ["Min"] = 3, ["Max"] = 5 },
	{ ["Item"] = "meth", ["Chance"] = 100, ["Min"] = 3, ["Max"] = 5 },
	{ ["Item"] = "gauze", ["Chance"] = 100, ["Min"] = 3, ["Max"] = 5 },
	{ ["Item"] = "dirtydollar", ["Chance"] = 25, ["Min"] = 7500, ["Max"] = 9999 },
	-- MUNIÇÕES
	{ ["Item"] = "WEAPON_RIFLE_AMMO", ["Chance"] = 50, ["Min"] = 100, ["Max"] = 125 },
	{ ["Item"] = "WEAPON_SMG_AMMO", ["Chance"] = 50, ["Min"] = 75, ["Max"] = 100 },
	{ ["Item"] = "WEAPON_PISTOL_AMMO", ["Chance"] = 50, ["Min"] = 50, ["Max"] = 75 },
	-- PISTOLAS
	{ ["Item"] = "WEAPON_SNSPISTOL_MK2", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_PISTOL_MK2", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_VINTAGEPISTOL", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_SNSPISTOL", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_PISTOL50", ["Chance"] = 15, ["Min"] = 1, ["Max"] = 1 },
	-- SUBMETRALHADORAS
	{ ["Item"] = "WEAPON_MACHINEPISTOL", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_ASSAULTSMG", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_MINISMG", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_SMG_MK2", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_APPISTOL", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_GUSENBERG", ["Chance"] = 10, ["Min"] = 1, ["Max"] = 1 },
	-- RIFLES
	{ ["Item"] = "WEAPON_ADVANCEDRIFLE", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_COMPACTRIFLE", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_BULLPUPRIFLE", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_ASSAULTRIFLE", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_HEAVYRIFLE", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 1 },
	{ ["Item"] = "WEAPON_SPECIALCARBINE", ["Chance"] = 5, ["Min"] = 1, ["Max"] = 1 }
}