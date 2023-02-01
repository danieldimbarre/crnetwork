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
		["Hierarchy"] = { "VIP","MVP","Master" },
		["Salary"] = { 900,1200,1500 },
		["Service"] = {}
	},
	["Nitro"] = {
		["Parent"] = {
			["Nitro"] = true
		},
		["Hierarchy"] = { "Nitro" },
		["Salary"] = { 400 },
		["Service"] = {}
	},
	["Police"] = {
		["Parent"] = {
			["Police"] = true
		},
		["Hierarchy"] = { "Comando","Major","Capitão","Tenente","Sargento","Cabo","Soldado","Aluno" },
		["Salary"] = { 2700,2600,2500,2400,2300,2200,2100,2000 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Paramedic"] = {
		["Parent"] = {
			["Paramedic"] = true
		},
		["Hierarchy"] = { "Diretor","Supervisor","Médico","Enfermeiro","Paramédico" },
		["Salary"] = { 2500,2300,2200,2100,2000 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Law"] = {
		["Parent"] = {
			["Law"] = true
		},
		["Hierarchy"] = { "Juiz","Promotor","Advogado" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Mechanic"] = {
		["Parent"] = {
			["Mechanic"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro","Mecânico" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Taxi"] = {
		["Parent"] = {
			["Taxi"] = true
		},
		["Hierarchy"] = { "Chefe","Membro" },
		["Service"] = {}
	},
	["BurgerShot"] = {
		["Parent"] = {
			["BurgerShot"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["PizzaThis"] = {
		["Parent"] = {
			["PizzaThis"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["UwuCoffee"] = {
		["Parent"] = {
			["UwuCoffee"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["BeanMachine"] = {
		["Parent"] = {
			["BeanMachine"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Ballas"] = {
		["Parent"] = {
			["Ballas"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Vagos"] = {
		["Parent"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Families"] = {
		["Parent"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Aztecas"] = {
		["Parent"] = {
			["Aztecas"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["YoungBoys"] = {
		["Parent"] = {
			["YoungBoys"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Triads"] = {
		["Parent"] = {
			["Triads"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Razors"] = {
		["Parent"] = {
			["Razors"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Tribo"] = {
		["Parent"] = {
			["Tribo"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Lost"] = {
		["Parent"] = {
			["Lost"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Marabunta"] = {
		["Parent"] = {
			["Marabunta"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Dracing"] = {
		["Parent"] = {
			["Dracing"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Favela01"] = {
		["Parent"] = {
			["Favela01"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Favela02"] = {
		["Parent"] = {
			["Favela02"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Favela03"] = {
		["Parent"] = {
			["Favela03"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Favela04"] = {
		["Parent"] = {
			["Favela04"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Service"] = {},
		["Type"] = "Work"
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
	},
	["Facs"] = {
		["Parent"] = {
			["Ballas"] = true,
			["Vagos"] = true,
			["Families"] = true,
			["Tribo"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {}
	},
	["Favelas"] = {
		["Parent"] = {
			["Favela01"] = true,
			["Favela02"] = true,
			["Favela03"] = true,
			["Favela04"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {}
	}
}