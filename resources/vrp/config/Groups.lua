-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
Groups = {
	["Admin"] = {
		["Parent"] = {
			["Admin"] = true
		},
		["Hierarchy"] = { "Administrador","Moderador","Suporte" },
		["Service"] = {}
	},
	["Premium"] = {
		["Parent"] = {
			["Premium"] = true
		},
		["Hierarchy"] = { "Master","MVP","VIP" },
		["Salary"] = { 1900,1300,900 },
		["Service"] = {}
	},
	["Police"] = {
		["Parent"] = {
			["Police"] = true
		},
		["Hierarchy"] = { "Chefe","Oficial" },
		["Salary"] = { 2000,2000 },
		["Service"] = {}
	},
	["Paramedic"] = {
		["Parent"] = {
			["Paramedic"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Salary"] = { 2000,2000 },
		["Service"] = {}
	},
	["Mechanic"] = {
		["Parent"] = {
			["Mechanic"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["BurgerShot"] = {
		["Parent"] = {
			["BurgerShot"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["PizzaThis"] = {
		["Parent"] = {
			["PizzaThis"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["UwuCoffee"] = {
		["Parent"] = {
			["UwuCoffee"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["BeanMachine"] = {
		["Parent"] = {
			["BeanMachine"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["Ballas"] = {
		["Parent"] = {
			["Ballas"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["Vagos"] = {
		["Parent"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["Families"] = {
		["Parent"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["Aztecas"] = {
		["Parent"] = {
			["Aztecas"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["Bloods"] = {
		["Parent"] = {
			["Bloods"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["Triads"] = {
		["Parent"] = {
			["Triads"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["Razors"] = {
		["Parent"] = {
			["Razors"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["Altruists"] = {
		["Parent"] = {
			["Altruists"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["Lost"] = {
		["Parent"] = {
			["Lost"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["Marabunta"] = {
		["Parent"] = {
			["Marabunta"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["Emergency"] = {
		["Parent"] = {
			["Police"] = true,
			["Paramedic"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {}
	},
	["Restaurants"] = {
		["Parent"] = {
			["BurgerShot"] = true,
			["PizzaThis"] = true,
			["UwuCoffee"] = true,
			["BeanMachine"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {}
	}
}