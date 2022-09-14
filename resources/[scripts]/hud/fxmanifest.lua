fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/server.lua",
	"server-side/nitro.lua",
	"server-side/reposed.lua",
	"server-side/wanted.lua"
}

files {
	"web-side/*",
	"web-side/**/*"
}