fx_version "bodacious"
game "gta5"
lua54 "yes"
version "2.0.0"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}