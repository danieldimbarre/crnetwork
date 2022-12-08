fx_version "bodacious"
game "gta5"
lua54 "yes"
version "1.3.0"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}

shared_scripts {
	"@vrp/config/Global.lua",
	"shared-side/*"
}

escrow_ignore {
	"client-side/command.lua",
	"shared-side/*"
}
dependency '/assetpacks'