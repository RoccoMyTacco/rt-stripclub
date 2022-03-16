fx_version 'cerulean'
game 'gta5'
description 'Stripclub by Rocco'
version '1.0'

ui_page {'html/index.html'}

client_scripts {
    'config.lua',
    'client/*.lua'
}

server_scripts {
    'config.lua',
    'server/main.lua'
}

exports {
    'GetActiveRegister',
    'GetActiveSongs',
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',
} 