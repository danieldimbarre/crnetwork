fx_version "bodacious"
game "gta5"
lua54 "yes"
version "2.1.0"
author "ImagicTheCat"
creative_network "yes"
creator "no"

client_scripts {
	"config/*",
	"lib/Utils.lua",
	"client/*"
}

server_scripts {
	"config/*",
	"lib/Utils.lua",
	"modules/vrp.lua",
	"modules/server.lua",
	"modules/prepare.lua"
}

files {
	"lib/*"
}