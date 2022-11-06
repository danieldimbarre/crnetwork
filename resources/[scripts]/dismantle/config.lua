config = {
    parts = {
        ['wheel_lf'] = { index = 0, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.4 },
        ['wheel_lr'] = { index = 4, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.4 },
        ['wheel_rf'] = { index = 1, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.4 },
        ['wheel_rr'] = { index = 5, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.4 },
        ['wheel_lm1'] = { index = 2, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.4 },
        ['wheel_rm1'] = { index = 3, type = 'wheels', text = '~g~E~w~ Retirar Roda', dist = 1.4 },
    
        ['door_dside_f'] = { index = 0, type = 'doors', text = '~g~E~w~ Retirar Porta', dist = 0.7 },
        ['door_dside_r'] = { index = 2, type = 'doors', text = '~g~E~w~ Retirar Porta', dist = 0.7 },
        ['door_pside_f'] = { index = 1, type = 'doors', text = '~g~E~w~ Retirar Porta', dist = 0.7 },
        ['door_pside_r'] = { index = 3, type = 'doors', text = '~g~E~w~ Retirar Porta', dist = 0.7 },
        ['bonnet'] = { index = 4, type = 'bonnet', text = '~g~E~w~ Retirar Capô', dist = 2.0 },
        ['boot'] = { index = 5, type = 'boot', text = '~g~E~w~ Retirar Porta-malas', dist = 1.7 },
    },

    itens = {
        ['wheels'] = { 
            { 'tyres', 1 },
        },
        ['doors'] = { 
            { 'porta', 1 },
        },
    },

    locations = {
        vector3(993.7,-113.36,74.07),
    },

    permiss = { 'Admin', 'dismantle' }, -- permissões

    animCooldown = 3, --SEGUNDOS
    consumeItem = { 'toolbox', 1 }, -- item, quantidade
}