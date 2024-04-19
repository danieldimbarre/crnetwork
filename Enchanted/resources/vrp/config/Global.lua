-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
DiscordBot = true
Whitelisted = true
BaseMode = "steam"
SalaryCooldown = 1800
ServerName = "Creative Network"
NameDefault = "Indivíduo Indigente"
ServerLink = "https://creativenetwork.dev.br/"
SpawnCoords = vec4(895.48,-179.38,73.7,240.95)
LeavePrisonCoords = vec3(1896.15,2604.44,45.75)
CreatorCoords = vec4(402.81,-996.55,-100.01,184.26)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INDEX
-----------------------------------------------------------------------------------------------------------------------------------------
TokenIndex = "DDDDDDD"
PhoneIndex = "DDD-DDD"
PlateIndex = "DDLLLDDD"
HashItemIndex = "DDLLDDLL"
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
ShortcutSlots = 5
ItemMaxRepair = 1
MaxSlotsInventory = 100
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
MinimumWeight = 25
DefaultWeight = 100
PremiumWeight = {
	[1] = 100,
	[2] = 50,
	[3] = 25
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROLEPASS
-----------------------------------------------------------------------------------------------------------------------------------------
RolepassPoint = 50
RolepassPointPremium = 100
RolepassInital = 1712518998
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODENAME
-----------------------------------------------------------------------------------------------------------------------------------------
ModeName = {
	["steam"] = "Steam",
	["license"] = "Rockstar"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
GroupsSetCooldown = 864000
Groups = {
	["Admin"] = {
		["Permission"] = {
			["Admin"] = true
		},
		["Hierarchy"] = { "Administrador","Moderador","Suporte" },
		["Salary"] = { 0,0,0 },
		["Service"] = {},
		["Client"] = true
	},
	["Premium"] = {
		["Permission"] = {
			["Premium"] = true
		},
		["Hierarchy"] = { "Ouro","Prata","Bronze" },
		["Salary"] = { 10000,5000,2500 },
		["Service"] = {},
		["Client"] = true
	},
	["Policia"] = {
		["Permission"] = {
			["Policia"] = true
		},
		["Hierarchy"] = { "Chefe","Capitão","Tenente","Sargento","Oficial","Cadete" },
		["Salary"] = { 8250,8000,7750,7500,7250,7000 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Paramedico"] = {
		["Permission"] = {
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Chefe","Médico","Enfermeiro","Residente" },
		["Salary"] = { 8250,8000,7750,7500 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Max"] = 30
	},
	["Camera"] = {
		["Permission"] = {
			["Camera"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {}
	},
	["Emergencia"] = {
		["Permission"] = {
			["Policia"] = true,
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Membro" },
		["Service"] = {}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERITENS (Itens recebidos ao criar o personagem)
-----------------------------------------------------------------------------------------------------------------------------------------
CharacterItens = {
	["cellphone"] = 1
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
GroupBlips = {
	["Policia"] = true,
	["Paramedico"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRESTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
ArrestItens = {
	["ATTACH_FLASHLIGHT"] = true,
	["ATTACH_CROSSHAIR"] = true,
	["ATTACH_SILENCER"] = true,
	["ATTACH_MAGAZINE"] = true,
	["ATTACH_GRIP"] = true,
	["blocksignal"] = true,
	["vest"] = true,
	["joint"] = true,
	["weedsack"] = true,
	["cocaine"] = true,
	["cokesack"] = true,
	["meth"] = true,
	["methsack"] = true,
	["lockpick"] = true,
	["handcuff"] = true,
	["rope"] = true,
	["hood"] = true,
	["dirtydollar"] = true,
	["WEAPON_HATCHET"] = true,
	["WEAPON_BAT"] = true,
	["WEAPON_FROST"] = true,
	["WEAPON_KATANA"] = true,
	["WEAPON_THERMAL"] = true,
	["WEAPON_KARAMBIT"] = true,
	["WEAPON_BATTLEAXE"] = true,
	["WEAPON_CROWBAR"] = true,
	["WEAPON_SWITCHBLADE"] = true,
	["WEAPON_GOLFCLUB"] = true,
	["WEAPON_HAMMER"] = true,
	["WEAPON_MACHETE"] = true,
	["WEAPON_POOLCUE"] = true,
	["WEAPON_STONE_HATCHET"] = true,
	["WEAPON_WRENCH"] = true,
	["WEAPON_KNUCKLE"] = true,
	["WEAPON_FLASHLIGHT"] = true,
	["WEAPON_NIGHTSTICK"] = true,
	["WEAPON_PISTOL"] = true,
	["WEAPON_PISTOL_MK2"] = true,
	["WEAPON_COMPACTRIFLE"] = true,
	["WEAPON_APPISTOL"] = true,
	["WEAPON_HEAVYPISTOL"] = true,
	["WEAPON_MACHINEPISTOL"] = true,
	["WEAPON_MICROSMG"] = true,
	["WEAPON_NAILGUN"] = true,
	["WEAPON_RPG"] = true,
	["WEAPON_MINISMG"] = true,
	["WEAPON_SNSPISTOL"] = true,
	["WEAPON_SNSPISTOL_MK2"] = true,
	["WEAPON_VINTAGEPISTOL"] = true,
	["WEAPON_PISTOL50"] = true,
	["WEAPON_COMBATPISTOL"] = true,
	["WEAPON_PARAFAL"] = true,
	["WEAPON_FNFAL"] = true,
	["WEAPON_FNSCAR"] = true,
	["WEAPON_QBZ83"] = true,
	["WEAPON_COLTXM177"] = true,
	["WEAPON_CARBINERIFLE"] = true,
	["WEAPON_CARBINERIFLE_MK2"] = true,
	["WEAPON_ADVANCEDRIFLE"] = true,
	["WEAPON_BULLPUPRIFLE"] = true,
	["WEAPON_BULLPUPRIFLE_MK2"] = true,
	["WEAPON_SPECIALCARBINE"] = true,
	["WEAPON_SPECIALCARBINE_MK2"] = true,
	["WEAPON_PUMPSHOTGUN"] = true,
	["WEAPON_PUMPSHOTGUN_MK2"] = true,
	["WEAPON_MUSKET"] = true,
	["WEAPON_SAUER"] = true,
	["WEAPON_SAWNOFFSHOTGUN"] = true,
	["WEAPON_SMG"] = true,
	["WEAPON_SMG_MK2"] = true,
	["WEAPON_TACTICALRIFLE"] = true,
	["WEAPON_HEAVYRIFLE"] = true,
	["WEAPON_ASSAULTRIFLE"] = true,
	["WEAPON_ASSAULTRIFLE_MK2"] = true,
	["WEAPON_ASSAULTSMG"] = true,
	["WEAPON_GUSENBERG"] = true,
	["WEAPON_STUNGUN"] = true,
	["WEAPON_RPG_AMMO"] = true,
	["WEAPON_NAIL_AMMO"] = true,
	["WEAPON_PISTOL_AMMO"] = true,
	["WEAPON_SMG_AMMO"] = true,
	["WEAPON_RIFLE_AMMO"] = true,
	["WEAPON_SHOTGUN_AMMO"] = true,
	["WEAPON_MUSKET_AMMO"] = true,
	["WEAPON_BRICK"] = true,
	["WEAPON_SNOWBALL"] = true,
	["WEAPON_SHOES"] = true,
	["WEAPON_MOLOTOV"] = true,
	["WEAPON_SMOKEGRENADE"] = true,
	["pager"] = true,
	["crack"] = true,
	["heroin"] = true,
	["metadone"] = true,
	["soap"] = true,
	["races"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRITENS
-----------------------------------------------------------------------------------------------------------------------------------------
RepairItens = {
	["repairkit01"] = true,
	["repairkit02"] = true,
	["repairkit03"] = true,
	["repairkit04"] = true,
	["sewingkit"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOXES
-----------------------------------------------------------------------------------------------------------------------------------------
Boxes = {
	["treasurebox"] = {
		["Multiplier"] = 1,
		["List"] = {
			{ ["Item"] = "dollar", ["Min"] = 4250, ["Max"] = 6250 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GSRWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
GsrWeapons = {
	["WEAPON_SMG"] = true,
	["WEAPON_STUNGUN"] = true,
	["WEAPON_PUMPSHOTGUN"] = true,
	["WEAPON_CARBINERIFLE"] = true,
	["WEAPON_TACTICALRIFLE"] = true,
	["WEAPON_CARBINERIFLE_MK2"] = true,
	["WEAPON_FNSCAR"] = true,
	["WEAPON_PUMPSHOTGUN_MK2"] = true,
	["WEAPON_SPECIALCARBINE_MK2"] = true,
	["WEAPON_COMBATPISTOL"] = true,
	["WEAPON_HEAVYPISTOL"] = true,
	["WEAPON_NIGHTSTICK"] = true,
	["WEAPON_MUSKET"] = true,
	["WEAPON_SAUER"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHESSTART
-----------------------------------------------------------------------------------------------------------------------------------------
ClothesStart = {
	["mp_m_freemode_01"] = {
		["pants"] = { item = 4, texture = 1 },
		["arms"] = { item = 0, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 273, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["shoes"] = { item = 1, texture = 6 },
		["mask"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["hat"] = { item = -1, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["pants"] = { item = 4, texture = 1 },
		["arms"] = { item = 14, texture = 0 },
		["tshirt"] = { item = 3, texture = 0 },
		["torso"] = { item = 338, texture = 2 },
		["vest"] = { item = 0, texture = 0 },
		["shoes"] = { item = 1, texture = 6 },
		["mask"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["hat"] = { item = -1, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 }
	}
}