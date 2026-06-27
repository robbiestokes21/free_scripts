--[[
    example_resource — server.
    Just a startup log so you can see it loaded. version_check.lua (also in
    server_scripts) handles the update check separately on boot.
--]]

local version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0) or '0.0.0.0'

CreateThread(function()
    print(('^2[example_resource] loaded (v%s).^7'):format(version))
end)
