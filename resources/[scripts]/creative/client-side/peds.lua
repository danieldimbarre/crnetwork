-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local localPeds = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local pedList = {
	{ -- Caminhoneiro
		Distance = 100,
		Coords = { 1239.87,-3257.2,7.09,274.97 },
		Model = "s_m_m_trucker_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ballas
		Distance = 100,
		Coords = { 95.58,-1985.56,20.44,317.49 },
		Model = "ig_g",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Families
		Distance = 100,
		Coords = { -31.47,-1434.84,31.49,0.0 },
		Model = "ig_g",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Vagos
		Distance = 100,
		Coords = { 347.45,-2069.06,20.89,320.32 },
		Model = "ig_g",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Aztecas
		Distance = 100,
		Coords = { 512.29,-1803.52,28.51,246.62 },
		Model = "ig_g",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Bloods
		Distance = 100,
		Coords = { 230.55,-1753.35,28.98,232.45 },
		Model = "ig_g",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Cassino
		Distance = 25,
		Coords = { 1112.05,228.11,-49.64,144.57 },
		Model = "s_f_y_casino_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Concessionária
		Distance = 100,
		Coords = { 1224.78,2728.01,38.0,178.59 },
		Model = "ig_ramp_hic",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- TowDriver
		Distance = 30,
		Coords = { -193.23,-1162.39,23.67,274.97 },
		Model = "g_m_m_armboss_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Coveiro
		Distance = 100,
		Coords = { -1745.92,-204.83,57.39,320.32 },
		Model = "g_m_m_armboss_01",
		anim = { "timetable@trevor@smoking_meth@base","base" }
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2440.58,4736.35,34.29,317.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2432.5,4744.58,34.31,317.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2424.47,4752.37,34.31,317.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2416.28,4760.8,34.31,317.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2408.6,4768.88,34.31,317.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2400.32,4777.48,34.53,317.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2432.46,4802.66,34.83,137.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2440.62,4794.22,34.66,137.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2448.65,4786.57,34.64,137.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2456.88,4778.08,34.49,137.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2464.53,4770.04,34.37,137.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2473.38,4760.98,34.31,137.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2495.03,4762.77,34.37,137.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2503.13,4754.08,34.31,137.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2511.34,4746.04,34.31,137.50 },
		Model = "a_c_cow"
	},
	{ -- Leiteiro
		Distance = 100,
		Coords = { 2519.56,4737.35,34.29,137.50 },
		Model = "a_c_cow"
	},
	{ -- Prefeitura
		Distance = 30,
		Coords = { -542.87,-198.35,38.23,65.2 },
		Model = "ig_barry",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Prefeitura
		Distance = 30,
		Coords = { -551.27,-203.09,38.23,343.0 },
		Model = "ig_barry",
		anim = { "anim@heists@prison_heistig1_p1_guard_checks_bus","loop" }
	},
	{ -- Prefeitura
		Distance = 30,
		Coords = { -544.76,-185.81,52.2,303.31 },
		Model = "ig_barry",
		anim = { "anim@heists@prison_heistig1_p1_guard_checks_bus","loop" }
	},
	{ -- Taxi
		Distance = 50,
		Coords = { -1039.34,-2730.8,20.2,235.28 },
		Model = "a_m_y_stlat_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Weeds
		Distance = 100,
		Coords = { -1174.54,-1571.4,4.35,124.73 },
		Model = "g_f_y_ballas_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal - Certo
		Distance = 100,
		Coords = { -1403.59,-628.61,28.68,170.08 },
		Model = "g_f_y_ballas_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Police
		Distance = 100,
		Coords = { 392.56,-1632.1,29.28,28.35 },
		Model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		Distance = 100,
		Coords = { 381.17,-1634.05,29.28,343.0 },
		Model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		Distance = 100,
		Coords = { 382.12,-1617.63,29.28,232.45 },
		Model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		Distance = 100,
		Coords = { 377.58,791.66,187.64,130.4 },
		Model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		Distance = 100,
		Coords = { -479.48,6011.12,31.29,175.75 },
		Model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		Distance = 100,
		Coords = { -459.37,6016.01,31.49,42.52 },
		Model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		Distance = 100,
		Coords = { 463.15,-982.33,43.69,87.88 },
		Model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		Distance = 100,
		Coords = { 443.49,-974.47,25.7,181.42 },
		Model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		Distance = 100,
		Coords = { 1844.42,3707.33,33.97,255.12 },
		Model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		Distance = 100,
		Coords = { 1839.35,3691.23,33.97,269.3 },
		Model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		Distance = 100,
		Coords = { -271.7,6321.75,32.42,0.0 },
		Model = "s_m_m_paramedic_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		Distance = 100,
		Coords = { -253.92,6339.42,32.42,5.67 },
		Model = "s_m_m_paramedic_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		Distance = 100,
		Coords = { 338.19,-586.91,74.16,252.29 },
		Model = "s_m_m_paramedic_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		Distance = 100,
		Coords = { 340.08,-576.19,28.8,73.71 },
		Model = "s_m_m_paramedic_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 812.88,-782.08,26.17,269.3 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 24.9,-1346.8,29.49,269.3 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 2556.74,381.24,108.61,357.17 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 1164.82,-323.65,69.2,96.38 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { -706.15,-914.53,19.21,85.04 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { -47.38,-1758.68,29.42,42.52 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 373.1,326.81,103.56,257.96 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { -3242.75,1000.46,12.82,354.34 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 1728.47,6415.46,35.03,240.95 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 1960.2,3740.68,32.33,297.64 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 2677.8,3280.04,55.23,331.66 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 1697.31,4923.49,42.06,325.99 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { -1819.52,793.48,138.08,127.56 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 1391.69,3605.97,34.98,198.43 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { -2966.41,391.55,15.05,85.04 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { -3039.54,584.79,7.9,14.18 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 1134.33,-983.11,46.4,274.97 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 1165.28,2710.77,38.15,175.75 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { -1486.72,-377.55,40.15,130.4 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { -1221.45,-907.92,12.32,31.19 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 161.2,6641.66,31.69,223.94 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { -160.62,6320.93,31.58,311.82 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 15,
		Coords = { 548.7,2670.73,42.16,96.38 },
		Model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 15,
		Coords = { 1696.88,3758.39,34.69,133.23 },
		Model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 15,
		Coords = { 248.17,-51.78,69.94,340.16 },
		Model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 15,
		Coords = { 841.18,-1030.12,28.19,266.46 },
		Model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 15,
		Coords = { -327.07,6082.22,31.46,130.4 },
		Model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 15,
		Coords = { -659.18,-938.47,21.82,85.04 },
		Model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 15,
		Coords = { -1309.43,-394.56,36.7,343.0 },
		Model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 15,
		Coords = { -1113.41,2698.19,18.55,127.56 },
		Model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 15,
		Coords = { 2564.83,297.46,108.73,269.3 },
		Model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 15,
		Coords = { -3168.32,1087.46,20.84,150.24 },
		Model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 15,
		Coords = { 16.91,-1107.56,29.79,158.75 },
		Model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 15,
		Coords = { 814.84,-2155.14,29.62,357.17 },
		Model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Life Invader
		Distance = 20,
		Coords = { -1083.15,-245.88,37.76,209.77 },
		Model = "ig_barry",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		Distance = 30,
		Coords = { -172.89,6381.32,31.48,223.94 },
		Model = "u_m_y_baygor",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		Distance = 30,
		Coords = { 1690.07,3581.68,35.62,212.6 },
		Model = "u_m_y_baygor",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		Distance = 15,
		Coords = { 326.5,-1074.43,29.47,0.0 },
		Model = "u_m_y_baygor",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		Distance = 15,
		Coords = { 114.39,-4.85,67.82,204.1 },
		Model = "u_m_y_baygor",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Central
		Distance = 50,
		Coords = { 46.65,-1749.7,29.62,51.03 },
		Model = "ig_cletus",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Central
		Distance = 50,
		Coords = { 2747.31,3473.07,55.67,249.45 },
		Model = "ig_cletus",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		Distance = 50,
		Coords = { -428.54,-1728.29,19.78,70.87 },
		Model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		Distance = 50,
		Coords = { 180.07,2793.29,45.65,283.47 },
		Model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		Distance = 50,
		Coords = { -195.42,6264.62,31.49,42.52 },
		Model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Jewelry
		Distance = 15,
		Coords = { -628.79,-238.7,38.05,311.82 },
		Model = "cs_gurk",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Oxy Store
		Distance = 30,
		Coords = { -1636.74,-1092.17,13.08,320.32 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Transporter
		Distance = 20,
		Coords = { 264.74,219.99,101.67,343.0 },
		Model = "ig_casey",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lenhador
		Distance = 50,
		Coords = { 2433.45,5013.46,46.99,314.65 },
		Model = "a_m_o_ktown_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pescador
		Distance = 50,
		Coords = { 1509.64,3788.7,33.51,266.46 },
		Model = "a_f_y_beach_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Motorista
		Distance = 30,
		Coords = { 452.97,-607.75,28.59,266.46 },
		Model = "u_m_m_edtoh",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		Distance = 50,
		Coords = { 82.98,-1553.55,29.59,51.03 },
		Model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		Distance = 50,
		Coords = { 287.77,2843.9,44.7,121.89 },
		Model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		Distance = 50,
		Coords = { -413.97,6171.58,31.48,320.32 },
		Model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { -1127.26,-1439.35,5.22,303.31 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { 78.26,-1388.91,29.37,178.59 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { -706.73,-151.38,37.41,116.23 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { -166.69,-301.55,39.73,249.45 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { -817.5,-1074.03,11.32,119.06 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { -1197.33,-778.98,17.32,31.19 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { -1447.84,-240.03,49.81,45.36 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { -0.07,6511.8,31.88,311.82 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { 1691.6,4818.47,42.06,2.84 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { 123.21,-212.34,54.56,255.12 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { 621.24,2753.37,42.09,90.71 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { 1200.68,2707.35,38.22,85.04 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { -3172.39,1055.31,20.86,246.62 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { -1096.53,2711.1,19.11,127.56 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		Distance = 20,
		Coords = { 422.7,-810.25,29.49,357.17 },
		Model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		Distance = 10,
		Coords = { 1326.43,-1651.63,52.27,39.69 },
		Model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		Distance = 10,
		Coords = { -1150.39,-1425.4,4.95,34.02 },
		Model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		Distance = 10,
		Coords = { 320.05,183.3,103.59,161.58 },
		Model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		Distance = 10,
		Coords = { -3172.82,1073.41,20.83,249.45 },
		Model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		Distance = 10,
		Coords = { 1863.42,3751.76,33.03,119.06 },
		Model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		Distance = 10,
		Coords = { -292.11,6196.32,31.49,314.65 },
		Model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Taxista
		Distance = 30,
		Coords = { 894.9,-179.15,74.7,240.95 },
		Model = "a_m_y_stlat_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Taxista
		Distance = 30,
		Coords = { 1696.19,4785.25,42.02,93.55 },
		Model = "a_m_y_stlat_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caçador
		Distance = 10,
		Coords = { -679.13,5839.52,17.32,226.78 },
		Model = "ig_hunter",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caçador
		Distance = 30,
		Coords = { -695.56,5802.12,17.32,65.2 },
		Model = "a_m_o_ktown_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pescador
		Distance = 30,
		Coords = { -1816.64,-1193.73,14.31,334.49 },
		Model = "a_f_y_eastsa_03",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Barbearia
		Distance = 15,
		Coords = { -821.82,-183.36,37.56,212.6 },
		Model = "a_f_y_hipster_04",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Barbearia
		Distance = 15,
		Coords = { 137.12,-1710.54,29.28,138.9 },
		Model = "a_f_y_hipster_04",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Barbearia
		Distance = 15,
		Coords = { -1284.59,-1118.98,6.99,90.71 },
		Model = "a_f_y_hipster_04",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Barbearia
		Distance = 15,
		Coords = { 1934.17,3729.63,32.84,212.6 },
		Model = "a_f_y_hipster_04",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Barbearia
		Distance = 15,
		Coords = { 1210.2,-474.01,66.2,73.71 },
		Model = "a_f_y_hipster_04",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Barbearia
		Distance = 15,
		Coords = { -34.04,-150.15,57.07,340.16 },
		Model = "a_f_y_hipster_04",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Barbearia
		Distance = 15,
		Coords = { -280.72,6228.2,31.69,42.52 },
		Model = "a_f_y_hipster_04",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for k,v in pairs(pedList) do
			local Distance = #(Coords - vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3]))
			if Distance <= v["Distance"] then
				if not localPeds[k] and LocalPlayer["state"]["Route"] < 900000 then
					if LoadModel(v["Model"]) then
						localPeds[k] = CreatePed(4,v["Model"],v["Coords"][1],v["Coords"][2],v["Coords"][3] - 1,v["Coords"][4],false,false)
						SetPedArmour(localPeds[k],100)
						SetEntityInvincible(localPeds[k],true)
						FreezeEntityPosition(localPeds[k],true)
						SetBlockingOfNonTemporaryEvents(localPeds[k],true)

						SetModelAsNoLongerNeeded(v["Model"])

						if v["Model"] == "s_f_y_casino_01" then
							SetPedDefaultComponentVariation(localPeds[k])
							SetPedComponentVariation(localPeds[k],0,3,0,0)
							SetPedComponentVariation(localPeds[k],1,0,0,0)
							SetPedComponentVariation(localPeds[k],2,3,0,0)
							SetPedComponentVariation(localPeds[k],3,0,1,0)
							SetPedComponentVariation(localPeds[k],4,1,0,0)
							SetPedComponentVariation(localPeds[k],6,1,0,0)
							SetPedComponentVariation(localPeds[k],7,1,0,0)
							SetPedComponentVariation(localPeds[k],8,0,0,0)
							SetPedComponentVariation(localPeds[k],10,0,0,0)
							SetPedComponentVariation(localPeds[k],11,0,0,0)
							SetPedPropIndex(localPeds[k],1,0,0,false)
						end

						if v["anim"] ~= nil then
							if LoadAnim(v["anim"][1]) then
								TaskPlayAnim(localPeds[k],v["anim"][1],v["anim"][2],8.0,8.0,-1,1,0,0,0,0)
							end
						end
					end
				end
			else
				if localPeds[k] then
					if DoesEntityExist(localPeds[k]) then
						DeleteEntity(localPeds[k])
					end

					localPeds[k] = nil
				end
			end
		end

		Wait(1000)
	end
end)