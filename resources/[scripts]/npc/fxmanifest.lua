fx_version 'bodacious'
game 'gta5'

shared_scripts {
	'config.lua'
}

client_scripts {
	'@vrp/lib/utils.lua',
	'client-side/*'
}

server_scripts {
	'@vrp/lib/itemlist.lua',
	'@vrp/lib/utils.lua',
	'server-side/*'
}