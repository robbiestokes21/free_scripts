--[[
    example_resource — client.
    A tiny demo: welcomes the player on spawn and adds a /example command that
    shows the running version. The real point of this resource is to demonstrate
    how version_check.lua is wired in (see fxmanifest.lua + version_check.lua).
--]]

local version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0) or '0.0.0.0'

-- Welcome the player once they spawn in.
AddEventHandler('playerSpawned', function()
    lib.notify({
        title = 'Example Resource',
        description = Config.WelcomeMessage,
        type = 'inform',
        position = Config.NotifyPosition,
    })
end)

-- /example — prove the script is alive and show its version.
RegisterCommand('example', function()
    lib.notify({
        title = 'Example Resource',
        description = ('Running version %s'):format(version),
        type = 'success',
        position = Config.NotifyPosition,
    })
end, false)
