-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
PercetageSelling = 0.5 -- Porcentagem a receber ao vender o veículo
PercentageTaxs = 0.15 -- Porcentagem a cobrar pela taxa mensal do veículo
PercentageArrest = 0.1 -- Porcentagem a cobrar para liberar o veículo apreendido
PercentageImpost = 0.25 -- Porcentagem de imposto ao comprar um veículo
CarPermission = "Admin" -- Permissão para utilizar o comando /car
DvPermission = "Admin" -- Permissão para utilizar o comando /dv
LockPermission = "Policia" -- Permissão para destrancar qualquer veículo
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
Garages = {
	["1"] = { ["Name"] = "Garage" },
	["2"] = { ["Name"] = "Garage" },
	["3"] = { ["Name"] = "Garage" },
	["4"] = { ["Name"] = "Garage" },
	["5"] = { ["Name"] = "Garage" },
	["6"] = { ["Name"] = "Garage" },
	["7"] = { ["Name"] = "Garage" },
	["8"] = { ["Name"] = "Garage" },
	["9"] = { ["Name"] = "Garage" },
	["10"] = { ["Name"] = "Garage" },
	["11"] = { ["Name"] = "Garage" },
	["12"] = { ["Name"] = "Garage" },
	["13"] = { ["Name"] = "Garage" },
	["14"] = { ["Name"] = "Garage" },
	["15"] = { ["Name"] = "Garage" },
	["16"] = { ["Name"] = "Garage" },
	["17"] = { ["Name"] = "Garage" },
	["18"] = { ["Name"] = "Garage" },
	["19"] = { ["Name"] = "Garage" },
	["20"] = { ["Name"] = "Garage" },
	["21"] = { ["Name"] = "Garage" },
	["22"] = { ["Name"] = "Garage" },
	["23"] = { ["Name"] = "Garage" },
	["24"] = { ["Name"] = "Garage" },
	["25"] = { ["Name"] = "Garage" },
	["26"] = { ["Name"] = "Garage" },

	-- Paramedic
	["41"] = { ["Name"] = "Paramedico", ["Permission"] = "Paramedico" },
	["42"] = { ["Name"] = "Paramedico2", ["Permission"] = "Paramedico" },
	["43"] = { ["Name"] = "Cadeira", ["Permission"] = "Paramedico" },

	-- Police
	["51"] = { ["Name"] = "Policia", ["Permission"] = "Policia" },
	["52"] = { ["Name"] = "Policia2", ["Permission"] = "Policia" },
	["53"] = { ["Name"] = "Policia3", ["Permission"] = "Policia" },

	-- Boats
	["121"] = { ["Name"] = "Boats" },
	["122"] = { ["Name"] = "Boats" },
	["123"] = { ["Name"] = "Boats" },
	["124"] = { ["Name"] = "Boats" },

	["131"] = { ["Name"] = "Helicopters" },

	-- Works
	["141"] = { ["Name"] = "Lumberman" },
	["142"] = { ["Name"] = "Driver" },
	["143"] = { ["Name"] = "Garbageman" },
	["144"] = { ["Name"] = "Transporter" },
	["145"] = { ["Name"] = "Garbageman" },
	["146"] = { ["Name"] = "Garbageman" },
	["147"] = { ["Name"] = "Trucker" },
	["148"] = { ["Name"] = "Taxi" },
	["149"] = { ["Name"] = "Grime" },
	["150"] = { ["Name"] = "Towed" },
	["151"] = { ["Name"] = "Milkman" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
Works = {
	["Helicopters"] = {
		"maverick",
		"volatus",
		"supervolito",
		"havok"
	},
	["Paramedico"] = {
		"lguard",
		"blazer2",
		"firetruk",
		"ambulance2"
	},
	["Paramedico2"] = {
		"maverick2"
	},
	["Policia"] = {
		"ballerpol",
		"elegy2pol",
		"fugitivepol",
		"komodapol",
		"kurumapol",
		"nc700pol",
		"oracle2pol",
		"polchall",
		"polchar",
		"police3pol",
		"policepol",
		"policetpol",
		"poltang",
		"polvic",
		"r1250pol",
		"schafter2pol",
		"sheriff2pol",
		"silveradopol",
		"sultanrspol",
		"tahoepol",
		"tailgater2pol",
		"tauruspol"
	},
	["Policia2"] = {
		"polas350"
	},
	["Policia3"] = {
		"pbus",
		"riot"
	},
	["Driver"] = {
		"bus"
	},
	["Boats"] = {
		"dinghy",
		"jetmax",
		"marquis",
		"seashark",
		"speeder",
		"squalo",
		"suntrap",
		"toro",
		"tropic"
	},
	["Transporter"] = {
		"stockade"
	},
	["Lumberman"] = {
		"ratloader"
	},
	["Garbageman"] = {
		"trash"
	},
	["Trucker"] = {
		"packer"
	},
	["Taxi"] = {
		"taxi"
	},
	["Grime"] = {
		"boxville2"
	},
	["Towed"] = {
		"flatbed"
	},
	["Cadeira"] = {
		"wheelchair"
	},
	["Milkman"] = {
		"youga2"
	}
}