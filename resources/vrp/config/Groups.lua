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
		["Hierarchy"] = { "Platina","Ouro","Prata","Bronze" },
		["Salary"] = { 2500,2250,2000,1750 },
		["Service"] = {}
	},
	["Police"] = {
		["Parent"] = {
			["Police"] = true
		},
		["Hierarchy"] = { "Chefe","Capitão","Tenente","Sargento","Corporal","Oficial","Cadete" },
		["Salary"] = { 2500,2250,2000,1750,1500,1500,1500 },
		["Service"] = {}
	},
	["Paramedic"] = {
		["Parent"] = {
			["Paramedic"] = true
		},
		["Hierarchy"] = { "Chefe","Conselheiro","Membro" },
		["Salary"] = { 2500,2250,2000 },
		["Service"] = {}
	},
	["Mechanic"] = {
		["Parent"] = {
			["Mechanic"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["BurgerShot"] = {
		["Parent"] = {
			["BurgerShot"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["PizzaThis"] = {
		["Parent"] = {
			["PizzaThis"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["UwuCoffee"] = {
		["Parent"] = {
			["UwuCoffee"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["BeanMachine"] = {
		["Parent"] = {
			["BeanMachine"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["Ballas"] = {
		["Parent"] = {
			["Ballas"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["Vagos"] = {
		["Parent"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["Families"] = {
		["Parent"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["Aztecas"] = {
		["Parent"] = {
			["Aztecas"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["Bloods"] = {
		["Parent"] = {
			["Bloods"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["Triads"] = {
		["Parent"] = {
			["Triads"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["Razors"] = {
		["Parent"] = {
			["Razors"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["Altruists"] = {
		["Parent"] = {
			["Altruists"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["Lost"] = {
		["Parent"] = {
			["Lost"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {}
	},
	["Marabunta"] = {
		["Parent"] = {
			["Marabunta"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
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