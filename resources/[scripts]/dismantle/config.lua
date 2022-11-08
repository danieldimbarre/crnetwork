config = {
    parts = {
        ['wheel_lf'] = { index = 0, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.0 },
        ['wheel_lr'] = { index = 4, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.0 },
        ['wheel_rf'] = { index = 1, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.0 },
        ['wheel_rr'] = { index = 5, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.0 },
        ['wheel_lm1'] = { index = 2, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.0},
        ['wheel_rm1'] = { index = 3, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.0 },
    
        ['door_dside_f'] = { index = 0, type = 'doors', text = '~g~E~w~ Retirar Porta', dist = 0.7 },
        ['door_dside_r'] = { index = 2, type = 'doors', text = '~g~E~w~ Retirar Porta', dist = 0.7 },
        ['door_pside_f'] = { index = 1, type = 'doors', text = '~g~E~w~ Retirar Porta', dist = 0.7 },
        ['door_pside_r'] = { index = 3, type = 'doors', text = '~g~E~w~ Retirar Porta', dist = 0.7 },
        ['bonnet'] = { index = 4, type = 'doors', text = '~g~E~w~ Retirar Capô', dist = 2.0 },
        ['boot'] = { index = 5, type = 'doors', text = '~g~E~w~ Retirar Porta-malas', dist = 1.7 },
    },

    itens = {
        ['wheels'] = { 
            [0] = { -- id é = index
                { 'roda', math.random(1, 1) },
                { 'suspensiond', math.random(0, 1) },
                { 'brakec', math.random(0, 1) },
                
                
            },
            [1] = {
                { 'roda', 1 },
                
                
            },
            [2] = {
                { 'roda', 1 },
                
            },
            [3] = {
                { 'roda', 1 },
                
                
            },
            [4] = {
                { 'roda', 1 },
                
            },
            [5] = {
                { 'roda', 1 },
                
            },
        },
        ['doors'] = { 
            [0] = { -- id é = index
                { 'porta', math.random(1, 1) },
                { 'dirtydollars', 3000 },
                
                
            },
            [1] = {
                { 'porta', math.random(1, 1) },
                
            },
            [2] = {
                { 'capo', 1 },
                
                
               
            },
            [3] = {
                { 'portamala', 1 },
                
                
            },

            [4] = {
                { 'capo', math.random(1, 1) },
                { 'enginec', math.random(0, 1) },
                { 'transmissionc', math.random(0, 1) },
                
            },
            [5] = {
                { 'portamala', 1 },
                
                
            },
        },
    },

    locations = {
        vector3(993.7,-113.36,74.07),
    },

    permiss = { 'Admin', 'dismantle' }, -- permissões

    animCooldown = 3, --SEGUNDOS
    consumeItem = { 'macarico', 1 }, -- item, quantidade
}