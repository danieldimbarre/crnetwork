fx_version "bodacious"
game "gta5"

shared_scripts {
	"config.lua"
}

client_scripts {
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server-side/*"
}
