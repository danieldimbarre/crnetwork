-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
Groups = {
	["Admin"] = {
		["Admin"] = true
	},
	["Moderator"] = {
		["Admin"] = true,
		["Moderator"] = true
	},
	["Police"] = {
		["Police"] = true
	},
	["waitPolice"] = {
		["waitPolice"] = true
	},
	["Paramedic"] = {
		["Paramedic"] = true
	},
	["waitParamedic"] = {
		["waitParamedic"] = true
	},
	["Emergency"] = {
		["Police"] = true,
		["Paramedic"] = true
	},
	["Mechanic"] = {
		["Mechanic"] = true
	},
	["Mafia2"] = {
		["Mafia2"] = true
	},
	["Mafia1"] = {
		["Mafia1"] = true
	},
	["BurgerShot"] = {
		["BurgerShot"] = true
	},
	["PizzaThis"] = {
		["PizzaThis"] = true
	},
	["UwuCoffee"] = {
		["UwuCoffee"] = true
	},
	["BeanMachine"] = {
		["BeanMachine"] = true
	},
	["Restaurants"] = {
		["BurgerShot"] = true,
		["PizzaThis"] = true,
		["UwuCoffee"] = true,
		["BeanMachine"] = true
	},
	["Ballas"] = {
		["Ballas"] = true
	},
	["Vagos"] = {
		["Vagos"] = true
	},
	["Families"] = {
		["Families"] = true
	},
	["Aztecas"] = {
		["Aztecas"] = true
	},
	["Bloods"] = {
		["Bloods"] = true
	},
	["Triads"] = {
		["Triads"] = true
	},
	["Razors"] = {
		["Razors"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Groupment()
	return Groups
end