fx_version "bodacious"
game "gta5"
lua54 "yes"

client_scripts {
	"@vrp/config/Native.lua",
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

server_scripts {
	"@inventory/server-side/core.lua",
	"@vrp/lib/Utils.lua",
	"server-side/*"
}