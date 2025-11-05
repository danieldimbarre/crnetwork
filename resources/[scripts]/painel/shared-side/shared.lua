-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
Config = {
	BankTaxWithdraw = 1.0,
	BankTaxTransfer = 1.0,
	MedicPlanDuration = 604800,

	Permissions = { -- ( -1 = Ninguém tem permissão | 0 = Todos tem permissão | 2 = 2 e 1 tem permissão )
		Management = {
			View = 0,
			Create = 2,
			Dismiss = 2,
			Edit = 2
		},
		Paramedic = {
			View = -1,
			Create = -1,
			Edit = -1,
			Delete = -1,
			MedicPlan = -1,
			Avatar = -1
		},
		Announcements = {
			Create = 2,
			Edit = 2,
			Delete = 2
		},
		Tags = {
			View = 0,
			Create = 2,
			Edit = 2,
			Delete = 2,
			Assign = 2
		},
		Bank = {
			View = 0,
			Deposit = 0,
			Withdraw = 2,
			Transfer = 2
		},
		Perks = 1
	},

	OtherPermissions = {
		Paramedico = {
			Management = {
				View = 0,
				Create = 2,
				Dismiss = 2,
				Edit = 2
			},
			Paramedic = {
				View = 0,
				Create = 0,
				Edit = 0,
				Delete = 1,
				MedicPlan = 1,
				Avatar = 0
			},
			Announcements = {
				Create = 2,
				Edit = 2,
				Delete = 2
			},
			Tags = {
				View = 0,
				Create = 2,
				Edit = 2,
				Delete = 2,
				Assign = 2
			},
			Bank = {
				View = 0,
				Deposit = 0,
				Withdraw = 2,
				Transfer = 2
			},
			Perks = 1
		}
	},

	Perks = {
		{
			Increase = 1,
			Type = "Members",
			Title = "Aumento de Limite",
			Image = "nui://painel/web-side/images/user.svg",
			Description = "Aumenta o limite máximo de membros do grupo.",
			Price = { 150000,175000,200000,225000,250000,275000,300000,325000,350000,375000,400000,425000,450000,475000,500000,525000,550000,575000,600000,625000,650000,675000,700000,725000,750000,775000,800000,825000,850000,875000,900000,925000,950000,975000,1000000,1025000,1050000,1075000,1100000,1125000,1150000,1175000,1200000,1225000,1250000,1275000,1300000,1325000,1350000,1375000 }
		},{
			Price = 30000000,
			Type = "Premium",
			Increase = 2592000,
			Title = "Benefícios de Grupo",
			Description = "Adquirir por <b>30 dias</b> as bonificações abaixo.<br>• Dobro de peso no compartimento dos membros.",
			Image = "nui://painel/web-side/images/user.svg"
		},{
			Level = 10,
			Increase = 1,
			Type = "Tags",
			Price = 500000,
			Title = "Aumento de Tags",
			Description = "Aumenta o limite máximo de tags do grupo.",
			Image = "nui://painel/web-side/images/user.svg"
		},{
			Level = 10,
			Increase = 1,
			Price = 500000,
			Type = "Announces",
			Title = "Aumento de Anúncios",
			Description = "Aumenta o limite máximo de anúncios do grupo.",
			Image = "nui://painel/web-side/images/user.svg"
		}
	}
}