fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'example_resource'
author 'robbiestokes21'
description 'Example free script showing how to wire in the update checker.'

-- (1) Declare a version. This is what the update checker compares.
--     Scheme: MAJOR.MINOR.PATCH.BUILD[-prerelease]
version '1.0.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
    -- (2) Add the drop-in update checker. That's the whole integration.
    'version_check.lua',
}
