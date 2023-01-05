fx_version "bodacious"
game "gta5"

client_script "client-side/*"

files {
	"audio/**/*",
	"audio/**/**/*",
	"data/**/*"
}

data_file "CARCOLS_FILE" "data/**/carcols.meta"
data_file "HANDLING_FILE" "data/**/handling.meta"
data_file "VEHICLE_LAYOUTS_FILE" "data/**/vehiclelayouts.meta"
data_file "VEHICLE_METADATA_FILE" "data/**/vehicles.meta"
data_file "VEHICLE_VARIATION_FILE" "data/**/carvariations.meta"

data_file "AUDIO_WAVEPACK" "audio/**/dlc_*"
data_file "AUDIO_GAMEDATA" "audio/**/*_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/**/*_sounds.dat"