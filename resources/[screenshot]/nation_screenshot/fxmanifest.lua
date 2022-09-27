fx_version "adamant"
game "gta5"

ui_page_preload 'yes'

ui_page "nui/index.html"

files {
	"nui/**",
}

client_scripts {
	"@vrp/lib/Utils.lua",
	"lib/NativeUI.lua",
	"lib/cinematicCam_config.lua",
	"lib/cinematicCam_client.lua",
	"client_config.lua",
	"client.lua"
} 

server_script {
	"@vrp/lib/Utils.lua",
	"lib/cinematicCam_server.lua",
	"server_config.lua",
	"server.lua"
}

