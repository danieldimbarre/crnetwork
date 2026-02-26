-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
Informations = {
	Amethyst = {
		Price = 2000000,
		Gemstone = 100000
	},
	Amber = {
		Price = 2000000,
		Gemstone = 100000
	},
	Sapphire = {
		Price = 2000000,
		Gemstone = 100000
	},
	Emerald = {
		Price = 2000000,
		Gemstone = 100000
	},
	Topaz = {
		Price = 2000000,
		Gemstone = 100000
	},
	Opal = {
		Price = 2000000,
		Gemstone = 100000
	},
	Jade = {
		Price = 2000000,
		Gemstone = 100000
	},
	Pearl = {
		Price = 2000000,
		Gemstone = 100000
	},
	Aquamarine = {
		Price = 2000000,
		Gemstone = 100000
	},
	Turquoise = {
		Price = 2000000,
		Gemstone = 100000
	},
	Onyx = {
		Price = 2000000,
		Gemstone = 100000
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Informations",function()
	local Selected
	local Count = 0
	for Name in pairs(Informations) do
		Count = Count + 1
		if math.random(Count) == 1 then
			Selected = Name
		end
	end

	return Selected
end)