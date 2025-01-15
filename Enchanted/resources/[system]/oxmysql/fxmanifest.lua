fx_version "bodacious"
game "gta5"
lua54 "yes"

version "2.12.0"

dependencies {
	"/server:7290"
}

server_script "server-side/server.js"

provide "mysql-async"