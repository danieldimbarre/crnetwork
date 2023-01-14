fx_version "bodacious"
game "gta5"
lua54 "yes"
version "1.1.7"
author "ImagicTheCat"
creative_network "yes"
creator "yes"

client_scripts {
	"config/*",
	"lib/Utils.lua",
	"client/*"
}

server_scripts {
	"config/*",
	"lib/Utils.lua",
	"modules/vrp.lua",
	"modules/base.lua",
	"modules/drugs.lua",
	"modules/groups.lua",
	"modules/gui.lua",
	"modules/identity.lua",
	"modules/inventory.lua",
	"modules/money.lua",
	"modules/party.lua",
	"modules/rolepass.lua",
	"modules/player.lua",
	"modules/premium.lua",
	"modules/prepare.lua",
	"modules/queue.lua",
	"modules/vehicles.lua",
	"modules/salary.lua",
	"modules/Modules.lua"
}

files {
	"lib/*"
}

escrow_ignore {
	"lib/*",
	"config/*",
	"modules/vrp.lua",
	"modules/prepare.lua",
	"modules/Modules.lua",
	"client/Client.lua"
}
dependency '/assetpacks'