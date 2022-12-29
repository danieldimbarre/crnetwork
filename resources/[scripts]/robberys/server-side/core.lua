-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("robberys",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Robberype = {}
local Active = {}
local Register = {}
local Actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
local Robberys = {
	["1"] = {
		["Coords"] = vec3(31.28,-1339.31,29.49),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["2"] = {
		["Coords"] = vec3(2549.46,387.92,108.61),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["3"] = {
		["Coords"] = vec3(1159.46,-314.0,69.2),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["4"] = {
		["Coords"] = vec3(-709.78,-904.12,19.21),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["5"] = {
		["Coords"] = vec3(-43.45,-1748.32,29.42),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["6"] = {
		["Coords"] = vec3(381.09,332.5,103.56),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["7"] = {
		["Coords"] = vec3(-3249.65,1007.46,12.82),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["8"] = {
		["Coords"] = vec3(1737.49,6419.37,35.03),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["9"] = {
		["Coords"] = vec3(543.68,2662.61,42.16),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["10"] = {
		["Coords"] = vec3(1961.89,3750.24,32.33),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["11"] = {
		["Coords"] = vec3(2674.36,3289.26,55.23),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["12"] = {
		["Coords"] = vec3(1707.96,4920.45,42.06),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["13"] = {
		["Coords"] = vec3(-1829.22,798.74,138.19),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["14"] = {
		["Coords"] = vec3(-2959.66,387.08,14.04),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["15"] = {
		["Coords"] = vec3(-3048.68,588.59,7.9),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["16"] = {
		["Coords"] = vec3(1126.81,-980.07,45.41),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["17"] = {
		["Coords"] = vec3(1169.33,2717.82,37.15),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["18"] = {
		["Coords"] = vec3(-1478.9,-375.48,39.16),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["19"] = {
		["Coords"] = vec3(-1220.9,-916.02,11.32),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["20"] = {
		["Coords"] = vec3(170.97,6642.43,31.69),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["21"] = {
		["Coords"] = vec3(-168.42,6318.78,30.58),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["22"] = {
		["Coords"] = vec3(819.29,-774.6,26.17),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["23"] = {
		["Coords"] = vec3(1693.58,3761.61,34.89),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["24"] = {
		["Coords"] = vec3(252.86,-51.62,70.14),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["25"] = {
		["Coords"] = vec3(841.06,-1034.76,28.39),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["26"] = {
		["Coords"] = vec3(-330.29,6085.55,31.65),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["27"] = {
		["Coords"] = vec3(-660.92,-934.1,22.02),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["28"] = {
		["Coords"] = vec3(-1304.97,-395.81,36.89),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["29"] = {
		["Coords"] = vec3(-1117.61,2700.27,18.75),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["30"] = {
		["Coords"] = vec3(2566.6,293.14,108.93),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["31"] = {
		["Coords"] = vec3(-3172.51,1089.42,21.03),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["32"] = {
		["Coords"] = vec3(23.69,-1106.46,29.96),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["33"] = {
		["Coords"] = vec3(808.87,-2158.5,29.78),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 30000, ["max"] = 45000 }
		}
	},
	["34"] = {
		["Coords"] = vec3(137.12,-1710.54,29.28),
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card04",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 15000, ["max"] = 20000 }
		}
	},
	["35"] = {
		["Coords"] = vec3(1210.2,-474.01,66.2),
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card04",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 15000, ["max"] = 20000 }
		}
	},
	["36"] = {
		["Coords"] = vec3(-1284.59,-1118.98,6.99),
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card04",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 15000, ["max"] = 20000 }
		}
	},
	["37"] = {
		["Coords"] = vec3(-821.84,-183.37,37.56),
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card04",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 15000, ["max"] = 20000 }
		}
	},
	["38"] = {
		["Coords"] = vec3(-34.04,-150.15,57.07),
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 4,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card04",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 15000, ["max"] = 20000 }
		}
	},
	["39"] = {
		["Coords"] = vec3(-1210.46,-336.45,38.10),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 10,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "goldbar", ["min"] = 225, ["max"] = 250 }
		}
	},
	["40"] = {
		["Coords"] = vec3(-353.54,-55.44,49.36),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 10,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "goldbar", ["min"] = 225, ["max"] = 250 }
		}
	},
	["41"] = {
		["Coords"] = vec3(311.51,-284.59,54.48),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 10,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "goldbar", ["min"] = 225, ["max"] = 250 }
		}
	},
	["42"] = {
		["Coords"] = vec3(147.18,-1046.23,29.68),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 10,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "goldbar", ["min"] = 225, ["max"] = 250 }
		}
	},
	["43"] = {
		["Coords"] = vec3(-2956.50,482.09,16.01),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 10,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "goldbar", ["min"] = 225, ["max"] = 250 }
		}
	},
	["44"] = {
		["Coords"] = vec3(1175.69,2712.89,38.41),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 10,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "goldbar", ["min"] = 225, ["max"] = 250 }
		}
	},
	["45"] = {
		["Coords"] = vec3(890.77,-2120.76,31.22),
		["name"] = "Bobcat",
		["type"] = "bobcat",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 8,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "goldbar", ["min"] = 150, ["max"] = 200 }
		}
	},
	["46"] = {
		["Coords"] = vec3(-631.3,-230.1,38.33),
		["name"] = "Joalheria",
		["type"] = "jewelry",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 8,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "goldbar", ["min"] = 150, ["max"] = 200 }
		}
	},
	["47"] = {
		["Coords"] = vec3(81.74,-1388.91,29.37),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["48"] = {
		["Coords"] = vec3(78.26,-1388.91,29.37),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["49"] = {
		["Coords"] = vec3(-706.73,-151.38,37.41),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["50"] = {
		["Coords"] = vec3(-166.69,-301.55,39.73),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["51"] = {
		["Coords"] = vec3(-817.5,-1074.03,11.32),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["52"] = {
		["Coords"] = vec3(-815.73,-1077.04,11.32),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["53"] = {
		["Coords"] = vec3(-1196.78,-778.57,17.32),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["54"] = {
		["Coords"] = vec3(-1197.83,-779.65,17.32),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["55"] = {
		["Coords"] = vec3(-1447.84,-240.03,49.81),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["56"] = {
		["Coords"] = vec3(-0.07,6511.8,31.88),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["57"] = {
		["Coords"] = vec3(-2.42,6514.33,31.88),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["58"] = {
		["Coords"] = vec3(1691.6,4818.47,42.06),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["59"] = {
		["Coords"] = vec3(122.97,-212.95,54.56),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["60"] = {
		["Coords"] = vec3(123.28,-211.47,54.56),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["61"] = {
		["Coords"] = vec3(621.22,2753.98,42.09),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["62"] = {
		["Coords"] = vec3(621.54,2752.56,42.09),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["63"] = {
		["Coords"] = vec3(1200.68,2707.35,38.22),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["64"] = {
		["Coords"] = vec3(1200.7,2703.84,38.22),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["65"] = {
		["Coords"] = vec3(-3172.68,1054.71,20.86),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["66"] = {
		["Coords"] = vec3(-3172.25,1056.19,20.86),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["67"] = {
		["Coords"] = vec3(-1096.53,2711.1,19.11),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["68"] = {
		["Coords"] = vec3(-1094.22,2708.54,19.11),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["69"] = {
		["Coords"] = vec3(422.7,-810.25,29.49),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["70"] = {
		["Coords"] = vec3(419.2,-810.32,29.49),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["71"] = {
		["Coords"] = vec3(25.44,-1345.7,29.49),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["72"] = {
		["Coords"] = vec3(25.47,-1347.86,29.49),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["73"] = {
		["Coords"] = vec3(2557.8,381.79,108.61),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["74"] = {
		["Coords"] = vec3(2555.65,381.85,108.61),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["75"] = {
		["Coords"] = vec3(1164.21,-322.89,69.2),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["76"] = {
		["Coords"] = vec3(1164.44,-324.53,69.2),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["77"] = {
		["Coords"] = vec3(-706.63,-913.68,19.21),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["78"] = {
		["Coords"] = vec3(-706.63,-915.72,19.21),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["79"] = {
		["Coords"] = vec3(-47.19,-1757.67,29.34),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["80"] = {
		["Coords"] = vec3(-48.5,-1759.22,29.34),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["81"] = {
		["Coords"] = vec3(373.39,325.65,103.56),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["82"] = {
		["Coords"] = vec3(373.89,327.75,103.56),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["83"] = {
		["Coords"] = vec3(373.39,325.65,12.82),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["84"] = {
		["Coords"] = vec3(373.89,327.75,12.82),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["85"] = {
		["Coords"] = vec3(1728.51,6414.3,35.03),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["86"] = {
		["Coords"] = vec3(1729.44,6416.24,35.03),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["87"] = {
		["Coords"] = vec3(1961.23,3740.04,32.33),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["88"] = {
		["Coords"] = vec3(1960.13,3741.89,32.33),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["89"] = {
		["Coords"] = vec3(2680.74,3281.31,55.23),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["90"] = {
		["Coords"] = vec3(2677.11,3281.04,55.23),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["91"] = {
		["Coords"] = vec3(1698.31,4923.38,42.06),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["92"] = {
		["Coords"] = vec3(1696.64,4924.54,42.06),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["93"] = {
		["Coords"] = vec3(-1820.46,793.82,138.08),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["94"] = {
		["Coords"] = vec3(-1819.09,792.32,138.08),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["95"] = {
		["Coords"] = vec3(1393.08,3605.96,34.98),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["96"] = {
		["Coords"] = vec3(-2967.02,390.91,15.05),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["97"] = {
		["Coords"] = vec3(-3038.74,585.65,7.9),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["98"] = {
		["Coords"] = vec3(-3040.79,584.97,7.9),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["99"] = {
		["Coords"] = vec3(1134.82,-982.36,46.4),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["100"] = {
		["Coords"] = vec3(1165.96,2710.21,38.15),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["101"] = {
		["Coords"] = vec3(-1486.67,-378.46,40.15),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["102"] = {
		["Coords"] = vec3(-1222.33,-907.82,12.32),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["103"] = {
		["Coords"] = vec3(160.84,6640.53,31.69),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["104"] = {
		["Coords"] = vec3(162.35,6642.07,31.69),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["105"] = {
		["Coords"] = vec3(-160.67,6321.81,31.58),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["106"] = {
		["Coords"] = vec3(548.01,2671.76,42.16),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	},
	["107"] = {
		["Coords"] = vec3(548.32,2669.62,42.16),
		["name"] = "Caixa Registradora",
		["type"] = "register",
		["cooldown"] = 1800,
		["duration"] = 30,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pliers",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarsz", ["min"] = 25, ["max"] = 27 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("robberys:Init")
AddEventHandler("robberys:Init",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Actived[Passport] then
		Actived[Passport] = true

		if Robberys[Number] then
			if not Robberys[Number]["avaiable"] then
				if not Robberype[Robberys[Number]["type"]] then
					Robberype[Robberys[Number]["type"]] = os.time()
				end

				if os.time() >= Robberype[Robberys[Number]["type"]] then
					local Service,Total = vRP.NumPermission(Robberys[Number]["group"])
					if Total >= Robberys[Number]["population"] then
						local Consult = vRP.InventoryItemAmount(Passport,Robberys[Number]["need"]["item"])
						if Consult[1] >= Robberys[Number]["need"]["amount"] then
							if not vRP.CheckDamaged(Consult[2]) then
								if Robberys[Number]["type"] == "register" then
									if not Register[Number] then
										Register[Number] = os.time()
									end

									if os.time() >= Register[Number] then
										Register[Number] = os.time() + Robberys[Number]["cooldown"]
										Active[Passport] = os.time() + Robberys[Number]["duration"]

										vRP.UpgradeStress(Passport,10)
										TriggerClientEvent("Progress",source,"Roubando",30000)
										Player(source)["state"]["Buttons"] = true
										vRPC.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)
										TriggerEvent("Wanted",source,Passport,300)

										for Passports,Sources in pairs(Service) do
											async(function()
												TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = Robberys[Number]["name"], x = Robberys[Number]["Coords"]["x"], y = Robberys[Number]["Coords"]["y"], z = Robberys[Number]["Coords"]["z"], time = "Recebido às "..os.date("%H:%M"), blipColor = 22 })
												vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
											end)
										end
									
										local Amount = 0
										repeat
											if os.time() >= Active[Passport] then
												Active[Passport] = nil
												vRPC.stopAnim(source,false)
												Player(source)["state"]["Buttons"] = false
											end

											for k,v in pairs(Robberys[Number]["payment"]) do
												local Payment = math.random(v["min"],v["max"])
												vRP.GenerateItem(Passport,v["item"],Payment,true)
												Amount = Amount + Payment
											end

											Wait(1000)
										until not Active[Passport]

										TriggerEvent("Discord","Robberys","**Passaporte:** "..Passport.."\n**Ação:** "..Robberys[Number]["name"].."-"..Number.."\n**Roubou:** "..Amount.."x "..itemName(v["item"]),3042892)
									else
										local Cooldown = parseInt(Register[Number] - os.time())
										TriggerClientEvent("Notify",source,"azul","Cofre está vazio, aguarde <b>"..Cooldown.."</b> segundos.",5000)
									end
								else
									if vRP.TakeItem(Passport,Consult[2],Robberys[Number]["need"]["amount"]) then
										Robberype[Robberys[Number]["type"]] = os.time() + Robberys[Number]["cooldown"]
										Robberys[Number]["timavaiable"] = os.time() + Robberys[Number]["duration"]
										Robberys[Number]["avaiable"] = true

										for Passports,Sources in pairs(Service) do
											async(function()
												TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = Robberys[Number]["name"], x = Robberys[Number]["Coords"]["x"], y = Robberys[Number]["Coords"]["y"], z = Robberys[Number]["Coords"]["z"], time = "Recebido às "..os.date("%H:%M"), blipColor = 22 })
												vRPC.PlaySound(Sources,"Beep_Green","DLC_HEIST_HACKING_SNAKE_SOUNDS")
											end)
										end

										TriggerClientEvent("Notify",source,"verde","Progresso de desencriptação do sistema iniciado, o mesmo vai estar concluído em <b>"..Robberys[Number]["duration"].."</b> segundos.",5000)
										TriggerEvent("Discord","Robberys","**Passaporte:** "..Passport.."\n**Ação:** "..Robberys[Number]["name"].."-"..Number,9317187)
									end
								end
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(Robberys[Number]["need"]["item"]).."</b> danificado.",5000)
							end
						else
							TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>"..Robberys[Number]["need"]["amount"].."x "..itemName(Robberys[Number]["need"]["item"]).."</b>.",5000)
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Contingente indisponível.",5000)
					end
				else
					local Cooldown = parseInt(Robberype[Robberys[Number]["type"]] - os.time())
					TriggerClientEvent("Notify",source,"azul","Cofre está vazio, aguarde <b>"..Cooldown.."</b> segundos.",5000)
				end
			else
				if os.time() >= Robberys[Number]["timavaiable"] then
					Robberys[Number]["avaiable"] = false

					for k,v in pairs(Robberys[Number]["payment"]) do
						local Amount = math.random(v["min"],v["max"])
						vRP.GenerateItem(Passport,v["item"],Amount,true)
						TriggerEvent("Discord","Robberys","**Passaporte:** "..Passport.."\n**Ação:** "..Robberys[Number]["name"].."-"..Number.."\n**Roubou:** "..Amount.."x "..itemName(v["item"]),3042892)
					end

					TriggerEvent("Wanted",source,Passport,600)
				else
					local Cooldown = parseInt(Robberys[Number]["timavaiable"] - os.time())
					TriggerClientEvent("Notify",source,"azul","Desencriptação em andamento, aguarde <b>"..Cooldown.."</b> segundos.",5000)
				end
			end
		end

		Actived[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("robberys:Cancel")
AddEventHandler("robberys:Cancel",function(source,Passport)
	if Active[Passport] then
		Active[Passport] = nil
		Player(source)["state"]["Buttons"] = false
		TriggerClientEvent("Progress",source,"Cancelando",1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("robberys:Init",source,Robberys)
end)