-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
SpawnCoords = vec3(-27.45,-145.84,56.99)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
Discord = {
	["Connect"] = "https://discord.com/api/webhooks/1113480222260609126/QjVcMnBxQIX7_rSfE2fLCeIAl3FesS4daK8gB__wJCVtivONHIMNqlLUtk-OMJLYKoJ0",
	["Disconnect"] = "https://discord.com/api/webhooks/1113480296281673790/s-JDA1HBpy94SsoWnoSftrwoTVpfAucxYe-_zWnY6fMu7aIVWm2rg-jcFp8U6XU1Z3Yz",
	["Airport"] = "https://discord.com/api/webhooks/1113480366129422376/70T3smGKMIHUzDLytynOnaNt3-WHJ2296fZ9n79LN1pzAZUCsNY-WZiC5lEUWcQR1ZCX",
	["Deaths"] = "https://discord.com/api/webhooks/1113480428536483953/e3DAxb0fY4EE7crVewmpXJMNMAaLhLu1Mf3mdRiRkxfFq_3p-kFOP_INuBMiAEi_BBT0",
	["Gemstone"] = "https://discord.com/api/webhooks/1113480490406645851/PJmZtmL2sv_NHkFm2HVuTyZr3DB3-tCuRo4Zn9zajJe4V9J6OAfzG9t5eutUaVDXUANc",
	["Login"] = "https://discord.com/api/webhooks/1113480593779462156/Ci9EAYI0di0C1sanKDDL00mnrb3i_-cwuL8mvEiSODZYqD-d5bQZ40oPTJGsMgrBuZ14",
	["Payments"] = "https://discord.com/api/webhooks/1113480661219672185/2FPqmWMr1zyOgw6k6AAyTpN5AZbd7-Oy8H_4fR792wU6VLLjhx3AXxzM0Jo8YP-n-Jdy",
	["Roles"] = "https://discord.com/api/webhooks/1113480727175114752/4UyJ9K9C4DopXeiGr5rEuCswwC6ENHJFyE7sw8XwcVGW0nFLjUR1ZNCtrunvWKrP_Agw",
	["Admin"] = "https://discord.com/api/webhooks/1113480880657285253/RDmpZmQtyZSF66C8da_jB_eYMFByvA2-xkXCKlYvLrMPR9BLfuyRO38JxClsAx8Ec9NH",
	["Loja"] = "https://discord.com/api/webhooks/1113480937112608768/iKTBezPanQAGjAeVxTP8pNxM_uVFgIYFjXDkpbOc8ZGnTa62D0Y31-vcBvl3WmPNggyj",
	["Peak"] = "https://discord.com/api/webhooks/1113481009153966233/QXPvrSlL-wiDlquNQ_mkTFvnzj1x0ZaNuSSySUBrmR0It7nU-oDntdWy_8XAYuHc6nDR",
	["Policia"] = "https://discord.com/api/webhooks/1113481075491090532/YLaa1-LF9gBMO-jIrPCQ8l-aIakuuKuLn2zpD8yIdYqr3xwUDxX0p2ueC3sXkHWkmUIR",
	["Paramedico"] = "https://discord.com/api/webhooks/1113481132760113265/t3orZDCs28P740Nj0CBb5JjZAY3UbgFbD83JUkIhUrwPfMxstFK5rpxXlawqbXhE481i",
	["Burgershot"] = "https://discord.com/api/webhooks/1113481188070400010/sP_ArkaCsny4vN1JkVvJe7ZEdbw8KZ0tQaeARM3KRsbrhA_ERshwmeRyFxfyzM2anLgG",
	["UwuCoffee"] = "https://discord.com/api/webhooks/1113481239115075584/8a-qmNRjufYowXU39BC6QPO3-5hslWtq4DJL7890iq3g5LTmInQiiYxnB8LczuoMRXxf",
	["Ballas"] = "https://discord.com/api/webhooks/1113481302398738442/ECuP1-FZxsJPBg4FrJkDtxD3iUTsLZ_rFr8N9foSL_z3v0rgEvkcSpI0EViXKpwgfHGl",
	["Vagos"] = "https://discord.com/api/webhooks/1113481350075383890/q4yeScFEdHXItPDOxPFKq0-4VQFRgjkzPonuETofPf2IwYaDrscjI8zbHE-7XuSWQKOO",
	["Families"] = "https://discord.com/api/webhooks/1113481403703767041/1e1NEWfyD-3oF59ILrURnXhuczyijNqgzWM3ZLcoSXMGfU26jzHQ5tNONEk0kD8bN15d",
	["Aztecas"] = "https://discord.com/api/webhooks/1113481450113740810/86ve2o6ghSYoDmbL-ps8S2zcQ_CxCAOTbrktMcUK-zmefkCsoBVGNx34Id4ebDgw-R4p",
	["Bloods"] = "https://discord.com/api/webhooks/1113481499220648006/czzjYIIpzDy7ZKMlEcdr1rY9ZeEP_lPDTcArOk8PlZ3nOB-l7Hghk41UFFMLOxsI-X8e",
	["DaNangBoys"] = "https://discord.com/api/webhooks/1115621966251049030/Itcyh2k2dC52LpIWjTgNLyuOgZm8rtPGlDFODjKulIy-P8nTiMK4ejqsT_oy8s_vmibP",
	["Leone"] = "https://discord.com/api/webhooks/1115622041844985896/cbeBw614sgts2qhlv5oBKi4qgJg_IUwiulV6grEsARFqSpcHfnkGn8V9ftBNTYCZooKp",
	["ONeilBrothers"] = "https://discord.com/api/webhooks/1115622123352903801/zWIN-dRTjqlnIROM7oWpHbka-fIy5_LZVKYMrCpbR8gn6LhgAsskJiLsoMYZYgUUjnT4",
	["Rednecks"] = "https://discord.com/api/webhooks/1115622178432495718/uKBe_IGVq5kFgLLBXlwIVoaipDGJEBuOtnODua0nASca8VdPDvaNlRHA7-YqBzxH0JF1",
	["Triads"] = "https://discord.com/api/webhooks/1115622245482635306/EXpwPzBNBWC_HzyAeqJ8mV5PJOkyd0ZGYobygcWRrTHKTuxft3f2i7HASnRUaXRDkmnT"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERITENS (Itens recebidos ao criar o personagem)
-----------------------------------------------------------------------------------------------------------------------------------------
CharacterItens = {
	["water"] = 1,
	["sandwich"] = 1,
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
-- GROUPSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
GroupServices = {
	["Policia"] = true,
	["Paramedico"] = true,
	["Burgershot"] = true,
	["UwuCoffee"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRESTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
ArrestItens = {
	["WEAPON_PICKAXE"] = true,
	["ATTACH_FLASHLIGHT"] = true,
	["ATTACH_CROSSHAIR"] = true,
	["ATTACH_SILENCER"] = true,
	["ATTACH_MAGAZINE"] = true,
	["ATTACH_GRIP"] = true,
	["explosives"] = true,
	["blocksignal"] = true,
	["vest"] = true,
	["joint"] = true,
	["weedsack"] = true,
	["cocaine"] = true,
	["cokesack"] = true,
	["codeine"] = true,
	["amphetamine"] = true,
	["meth"] = true,
	["methsack"] = true,
	["lockpick"] = true,
	["handcuff"] = true,
	["rope"] = true,
	["hood"] = true,
	["dollars2"] = true,
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
	["oxy"] = true,
	["crack"] = true,
	["heroin"] = true,
	["metadone"] = true,
	["soap"] = true,
	["racecoin"] = true,
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
		["Multiplier"] = 5,
		["List"] = {
			{ ["Item"] = "sapphire_pure", ["Min"] = 8, ["Max"] = 16 },
			{ ["Item"] = "emerald_pure", ["Min"] = 8, ["Max"] = 16 },
			{ ["Item"] = "ruby_pure", ["Min"] = 8, ["Max"] = 16 },
			{ ["Item"] = "gold_pure", ["Min"] = 8, ["Max"] = 16 },
			{ ["Item"] = "iron_pure", ["Min"] = 8, ["Max"] = 16 },
			{ ["Item"] = "lead_pure", ["Min"] = 8, ["Max"] = 16 },
			{ ["Item"] = "sulfur_pure", ["Min"] = 8, ["Max"] = 16 },
			{ ["Item"] = "tin_pure", ["Min"] = 8, ["Max"] = 16 },
			{ ["Item"] = "diamond_pure", ["Min"] = 8, ["Max"] = 16 },
			{ ["Item"] = "copper_pure", ["Min"] = 8, ["Max"] = 16 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GSRWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
GsrWeapons = {
	["WEAPON_SMG"] = true,
	["WEAPON_PISTOL"] = true,
	["WEAPON_PUMPSHOTGUN"] = true,
	["WEAPON_CARBINERIFLE"] = true,
	["WEAPON_TACTICALRIFLE"] = true,
	["WEAPON_STUNGUN"] = true,
	["WEAPON_COMBATPISTOL"] = true,
	["WEAPON_HEAVYPISTOL"] = true,
	["WEAPON_NIGHTSTICK"] = true,
	["WEAPON_MUSKET"] = true,
	["WEAPON_SAUER"] = true
}