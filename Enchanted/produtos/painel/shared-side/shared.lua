-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
Config = {
	MaxAmountTags = 3,
	MaxAmountAnnouncements = 5,

	BankTaxWithdraw = 1.0,
	BankTaxTransfer = 1.0,

	Webhook = "https://discord.com/api/webhooks/1349160239207022622/AzWyTtb7QJ-WaBZuCNSvii8hCtGc20XVyIC5GL2IA2w_Elsve9IrcHYO9QD2ApnecKPm",

	Permissions = { -- ( -1 = Ninguém tem permissão | 0 = Todos tem permissão | 2 = 2 e 1 tem permissão )
		Management = {
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
			View = 0,
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
				Create = 2,
				Dismiss = 2,
				Edit = 2
			},
			Announcements = {
				View = 0,
				Create = 2,
				Edit = 2,
				Delete = 2
			},
			Paramedic = {
				View = 0,
				Create = 0,
				Edit = 0,
				Delete = 0,
				MedicPlan = 0,
				Avatar = 0
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
			Price = 150000,
			Active = false,

			Type = "Members",
			Title = "Aumento de Limite",
			Description = "Adicionar um novo slot no limite máximo de membros do grupos.",
			Image = "nui://painel/web-side/images/user.svg"
		},{
			Increase = 2592000,
			Price = 30000000,
			Active = false,

			Type = "Premium",
			Title = "Benefícios de Grupo",
			Description = "Adquirir por <b>30 dias</b> as bonificações abaixo.<br>• Dobro de peso no compartimento dos membros",
			Image = "nui://painel/web-side/images/user.svg"
		}
	}
}