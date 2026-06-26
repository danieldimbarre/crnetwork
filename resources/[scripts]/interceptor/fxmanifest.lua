fx_version "bodacious"
game "gta5"
lua54 "yes"

author 'Daniel Dimbarre'
version '1.0.0'
description 'Dynamic Vehicle Handling'

ui_page "web-side/index.html"

shared_scripts {
	"@vrp/lib/Utils.lua",
	"shared-side/*"
}

client_scripts {
	"@vrp/config/Native.lua",
	"@PolyZone/client.lua",
	"client-side/*"
}

files {
	"web-side/*",
	"web-side/assets/*",
	"web-side/fonts/*"
}
