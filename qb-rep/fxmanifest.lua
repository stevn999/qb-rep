-- Resource Metadata
fx_version 'bodacious'
games { 'gta5' }

author 'VaanULTRA'
description 'Repping other peeps'
version '1.0.0'

server_scripts {
    'config.lua',
    'server/main.lua'
}

dependencies {
    'qb-core',
}
[[
    /rep [playerID] gives a rep point to another player
    /checkrep [*playerID] checks the reputation of a player leave player ID blank to check yourself
    /diss [playerID] takes a rep point from another player
]]