Config = {}

Config.Token         = "ffHD71WDIdscf41dx7Lc0liXXn8nkGht92dsf6voUvpsRaMaOX5cp29kQ9FL"
Config.LicenseKey    = "1QXP-X5CI-4ALE-GYQF"
Config.RepeatTimeout = 2000
Config.CallRepeats   = 10
Config.OpenPhone     = "k"
Config.Webhook       = "https://discord.com/api/webhooks/1022232833059729490/TxcJA8AQ09i8sIGJ68oHbgwkSpAXQtOPpngivibPCkVNUjptbk6oM77TEJMimERRcBc5"
Config.WebhookBank   = "https://discord.com/api/webhooks/1022232833059729490/TxcJA8AQ09i8sIGJ68oHbgwkSpAXQtOPpngivibPCkVNUjptbk6oM77TEJMimERRcBc5"
Config.WebhookLogs   = "https://discord.com/api/webhooks/1022232833059729490/TxcJA8AQ09i8sIGJ68oHbgwkSpAXQtOPpngivibPCkVNUjptbk6oM77TEJMimERRcBc5"
Config.Field         = "files[]"
Config.VerifyItem    = true
Config.ItemPhone     = "cellphone"
Config.CallSystem    = "pmavoice" --tokovoip | mumblevoip | saltychat | pmavoice
Config.CheckLife     = 101
Config.IPAddress     = "http://127.0.0.1/"
Config.IPImagesItens = "http://127.0.0.1/vrp_itens/"
Config.Permission    = "Admin" -- Grupo de Permisssão para adicionar verificado
Config.NotifyAll     = true -- Ativar notificaçõpes globais no servidor
Config.AllPostsInsta = true -- Ativar todos os post dos instagram
Config.UseMoving     = true -- Usar o celular e andar
Config.NameVRPPlayer = "player" -- nome da vrp_player somente usado nas bases Summerz
Config.Locale        = "br"
Config.IntervalHelp  = 20000 --intervalo entre um chamado e outro para evitar flood (milisegundos)
Config.ButtonDisable = { --https://docs.fivem.net/docs/game-references/controls/
    0,
    1,
    2,
    22, 
    24, 
    26, 
    36, 
    37, 
    60, 
    62, 
    106,
    114,
    121,
    140,
    141,
    142,
    199,
    245,
    257,
    263,
    264,
    309,
    331,
}

Config.HelpList = {
    ['policia'] = {
        name        = "Emergência",
        description = "LSPD",
        text        = "Chame uma Unidade movél",
        message     = "Descreva a situação:",
        emergency   = true,
        staff       = false,
        image       = "https://i.lcpdfrusercontent.com/screenshots/monthly_2020_07/271590_20200630222342_1.png.a17364b16fdc65230dace2ac5c95e808.png",
        style       = "top: 15px;",
        groups      = {
            "Police"
        }
    },
    ['ems'] = {
        name        = "Emergência",
        description = "Chame uma unidade móvel",
        text        = "Chame uma Unidade movél",
        message    = "Descreva a situação:",
        emergency   = true,
        staff       = false,
        image       = "https://gtapolicemods.com/uploads/monthly_2020_11/Rambulance.png.d24e5be1cafdffe6786dd1f8dcd64678.png",
        style       = "top: 230px;",
        groups      = {
            "Emergency"
        }
    },
    ['mecanico'] = {
        name        = "Los Santos Customs",
        description = "Chame um Mecânico(a)",
        text        = "Chame um profissional mais próximo",
        message     = "Descreva seu problema:",
        emergency   = false,
        staff       = false,
        image       = "https://img.gta5-mods.com/q75/images/legion-square-car-show-map-editor-menyoo/2b001e-3.jpg",
        style       = "top: 460px;",
        groups      = {
            "Mechanic"
        }
    },
    -- ['staff'] = {
    --     name        = "FALAR COM A",
    --     description = "Prefeitura",
    --     text        = "Chame alguem da prefeitura",
    --     message     = "Descreva a situação:",
    --     emergency   = false,
    --     staff       = true,
    --     image       = "https://d2skuhm0vrry40.cloudfront.net/2017/articles/1/8/9/9/1/9/5/guia-gta-5-online-ganhar-dinheiro-facil-subir-de-reputacao-e-dicas-1494252847034.jpg/EG11/resize/1200x-1/guia-gta-5-online-ganhar-dinheiro-facil-subir-de-reputacao-e-dicas-1494252847034.jpg",
    --     style       = "top: 605px;",
    --     groups      = {
    --         "Admin",
    --         "Moderador",
    --         "manager.permissao",
    --         "suporte.permissao"
    --     }
    -- }
}

Config.NewsPermission = {
    "manager.permissao",
    "wazel.permissao"
}

Config.NewsAdvert = {
    title       = "Anuncie Aqui",
    description = "Anuncie seu serviço da cidade conosco da WAZEL",
    image       = "https://img.gta5-mods.com/q75/images/benny-s-tow-trucks-and-sast-tow-truck/4bcf6b-Screenshot(168).png"
}

Config.Client = {
    phone        = "000-000",
    disabledApps = {},
    hourserver   = false,
    blaze        = {
        minbet   = 100,
        limitbet = 10000
    }
}

Config.checkItemPhone = function(source, user_id, item)
    if checkIteminInvetory(user_id, item, 1) then
        return true
    else
        sendnotify(source,"negado",_("dont_have_cell"),5000)
        return false
    end
end

Config.iFood = {
    -- ['247'] = {
    --     name        = "247 Supermarket",
    --     category    = "Lanchonete",
    --     logo        = "https://static.wikia.nocookie.net/gtawiki/images/3/3a/V247Small.png/revision/latest?cb=20121217235947",
    --     banner      = "https://img.gta5-mods.com/q95/images/legion-square-247-mlo-fivem/d317f6-0_screenshots_20200209161558_1.jpg",
    --     location    = { x = 25.75, y = -1347.04, z = 29.5 },
    --     ordermode   = "take", --wait (entregador tem que falar com alguem para fazer pedido) | take entregador vai no local e pega os itens
    --     deliverytax = 5000,
    --     itens = {
    --         {
    --             index       = "xburguer",
    --             name        = "xBurguer",
    --             description = "Delicioso hambuguer",
    --             price       = 1000
    --         },            
    --         {
    --             index       = "cola",
    --             name        = "Coca-cola",
    --             description = "Coca-cola bem gelada",
    --             price       = 1000
    --         },            
    --         {
    --             index       = "batataf",
    --             name        = "Batata Frita",
    --             description = "Batata Frita bem quentinha",
    --             price       = 1000
    --         },            
    --         {
    --             index       = "pizza",
    --             name        = "Pizza",
    --             description = "Pizza italiana",
    --             price       = 1000
    --         }
    --     }
    -- }
}

--escolha o banco de dados que será usado
-- GHMattiMySQL (usa o conector GHMattiMySQL c#)
-- ghmattimysql (usa o conector ghmattimysql js)
-- oxmysql (usa o conetor oxmysql)
Config.DBConector = "oxmysql"

Config.Webhooks = {
    ['instagram'] = {
        name = "Instagram",
        image = "https://cdn.discordapp.com/attachments/782099781597003846/964522437859500063/instagram.png",
    },
    ['twitter'] = {
        name = "Twitter",
        image = "https://cdn.discordapp.com/attachments/782099781597003846/964522498282647582/twitter.png",
    },
    ['whatsapp'] = {
        name = "WhatsApp",
        image = "https://cdn.discordapp.com/attachments/782099781597003846/964522496458125312/whatsapp.png",
    },
    ['tinder'] = {
        name = "Tinder",
        image = "https://cdn.discordapp.com/attachments/782099781597003846/964522497666072606/tinder.png",
    },
    ['tor'] = {
        name = "TOR",
        image = "https://cdn.discordapp.com/attachments/782099781597003846/964522497888362496/tor.png",
    },
    ['olx'] = {
        name = "OLX",
        image = "https://cdn.discordapp.com/attachments/782099781597003846/964522496823033936/olx.png",
    },
    ['help'] = {
        name = "Chamados",
        image = "https://cdn.discordapp.com/attachments/782099781597003846/964522437641379852/help.png",
    },
    ['news'] = {
        name = "Noticias",
        image = "https://cdn.discordapp.com/attachments/782099781597003846/964522496642666506/noticias.png",
    },
    ['bank'] = {
        name = "Banco",
        image = "https://cdn.discordapp.com/attachments/782099781597003846/964522435724591104/banco.png",
    }
}

return Config