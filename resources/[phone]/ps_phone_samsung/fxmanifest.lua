fx_version 'bodacious'
games { 'gta5' }

author 'Pequi Shop'
description 'Script for phone'
version '1.2.5'

ui_page "html/index.html"

shared_scripts {
    "config.lua",
    "locale.lua",
    "locales/*.lua",
	"lib/*.lua",
}

client_scripts {
    "@vrp/config/Native.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/lib/Utils.lua",
	'locale.lua',
	'locales/*.lua',
    'client/*.lua',
}

server_scripts {
    "@vrp/config/Native.lua",
    "@vrp/config/Vehicle.lua",
    "@vrp/config/Item.lua",
	"@vrp/lib/Utils.lua",
	'locale.lua',
	'locales/*.lua',
    'server/*.lua',
}

files {
    'html/*',
    'html/**/*',
    'html/**/**/*',
}