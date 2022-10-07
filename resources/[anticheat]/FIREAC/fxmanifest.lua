
--[[[
        -----------------------------------
        -----------------------------------
        ---- Copyright 2022 by FIREAC® ----
        -----------------------------------
        ------ Dev By AmIrReZa#2080 -------
        -----------------------------------

]]

-- 【 𝗥𝗲𝘀𝗼𝘂𝗿𝗰𝗲 𝗠𝗲𝘁𝗮𝗱𝗮𝘁𝗮 】--
fx_version 'cerulean'
game 'gta5'

-- 【 𝗜𝗡𝗙𝗢 】--
author 'https://discord.gg/drwWFkfu6x'
description 'FIERAC'
version '6.0.1'

-- 【 𝗦𝗵𝗮𝗿𝗲𝗱 】--
shared_scripts {
   -- 【 𝗔𝗻𝘁𝗶 𝗖𝗵𝗲𝗮𝘁 】--
    'tables/*.lua',
    'whitelists/*.lua',
    'configs/*.lua'
}

-- 【 𝗖𝗹𝗶𝗲𝗻𝘁 】--
client_script 'src/fire-client.lua'

-- 【 𝗦𝗲𝗿𝘃𝗲𝗿 】--
server_scripts {
    'src/fire-server.lua',
}

-- 【 𝗔𝗱𝗺𝗶𝗻 𝗠𝗲𝗻𝘂 】--
client_scripts {
    '@menuv/menuv.lua',
    'src/fire-menu.lua',
}
dependency 'menuv'
