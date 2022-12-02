fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "ui/index.html"
shared_script "shared.lua"

client_scripts {
	"@vrp/config/Native.lua",
	"@vrp/lib/Utils.lua",

	"client/*",
	"client/**/*",
	"client/**/**/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",

	"server/*",
	"server/**/*",
	"server/**/**/*"
}

files {
	"ui/*",
	"ui/**/*"
}