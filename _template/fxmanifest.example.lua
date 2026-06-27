-- Example fxmanifest for a free script that ships the update checker.
-- The two things that make version-checking work: a `version` line, and
-- version_check.lua in server_scripts.

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'fishing'
author 'robbiestokes21'
description 'Example free script'
version '1.0.0.0'          -- <-- bump this on every release (also update versions.json)

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
    'version_check.lua',   -- <-- the drop-in update checker
}
