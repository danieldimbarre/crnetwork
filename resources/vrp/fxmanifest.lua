fx_version "bodacious"
game "gta5"
lua54 "yes"
version "1.7.1"
author "ImagicTheCat"
creative_network "yes"

ui_page "gui/index.html"

client_scripts {
	"config/Global.lua",
	"config/Vehicle.lua",
	"config/Native.lua",
	"config/Item.lua",
	"lib/Utils.lua",
	"client/*",
	"config/Client.lua"
}

server_scripts {
	"config/Global.lua",
	"config/Groups.lua",
	"config/Vehicle.lua",
	"config/Rewards.lua",
	"config/Discord.lua",
	"config/Item.lua",
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
	"modules/pass.lua",
	"modules/player.lua",
	"modules/premium.lua",
	"modules/prepare.lua",
	"modules/queue.lua",
	"modules/vehicles.lua",
	"config/Modules.lua"
}

files {
	"lib/*",
	"gui/*"
}

escrow_ignore {
	"lib/*",
	"gui/*",
	"config/*",
	"modules/vrp.lua",
	"modules/prepare.lua"
}
dependency '/assetpacks'