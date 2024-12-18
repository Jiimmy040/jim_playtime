fx_version "cerulean"
game "gta5"
lua54 "yes"

author "Jiimmy040"
version "1.0.0"

server_scripts {
    "src/server/**/**",
    "config.server.lua"
}

client_scripts {
    "src/client/**/**",
}

shared_scripts {
    "@vx_lib/init.lua",
    "config.shared.lua"
}
