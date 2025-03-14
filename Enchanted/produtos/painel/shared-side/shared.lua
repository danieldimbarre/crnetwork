-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
Config = {
	MaxAmountTags = 3,
	MaxAmountAnnouncements = 5,

	BankTaxWithdraw = 1.0,
	BankTaxTransfer = 1.0,

	Permissions = { -- ( -1 = Ninguém tem permissão | 0 = Todos tem permissão | 2 = 2 e 1 tem permissão )
		Management = {
			View = 0,
			Invite = 2,
			Dismiss = 2,
			Hierarchy = 2
		},
		Announcements = {
			View = 0,
			Create = 2,
			Update = 2,
			Destroy = 2
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
		}
	},

	OtherPermissions = {
		Ballas = {
			Management = {
				View = 0,
				Invite = 2,
				Dismiss = 2,
				Hierarchy = 2
			},
			Announcements = {
				View = 0,
				Create = 2,
				Update = 2,
				Destroy = 2
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
			}
		}
	}
}