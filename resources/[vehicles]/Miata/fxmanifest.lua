-- Resource Metadata
fx_version 'adamant'
game 'gta5' 

lua54 'on'

author 'FIVEMODS'
description 'RS1200GS'

files {
    'data/**/*.meta',
    'data/**/*.xml',
    'data/**/*.dat',
    'data/**/*.ytyp',
	'audio/*',
	'audio/**/'
}

data_file 'HANDLING_FILE'            'data/**/handling*.meta'
data_file 'VEHICLE_LAYOUTS_FILE'    'data/**/vehiclelayouts*.meta'
data_file 'VEHICLE_LAYOUTS_FILE'    'data/**/vehiclelayouts_1*.meta'
data_file 'VEHICLE_METADATA_FILE'    'data/**/vehicles*.meta'
data_file 'CARCOLS_FILE'            'data/**/carcols*.meta'
data_file 'VEHICLE_VARIATION_FILE'    'data/**/carvariations*.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'data/**/*unlocks.meta'
data_file 'PTFXASSETINFO_FILE' 'data/**/ptfxassetinfo.meta'


data_file "AUDIO_WAVEPACK" "elegyx/dlc_elegyx"
data_file "AUDIO_GAMEDATA" "elegyx/elegyx_game.dat"
data_file "AUDIO_SOUNDDATA" "elegyx/elegyx_sounds.dat"



client_scripts {
    'vehicle_names.lua',
}