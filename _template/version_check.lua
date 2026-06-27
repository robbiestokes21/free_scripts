--[[
    Drop-in update checker for free_scripts.
    Copy this file into your script folder and add it to fxmanifest server_scripts.
    Then edit SCRIPT_KEY below to match this script's key in versions.json.

    It runs on the downloader's server, reads this resource's `version` from the
    fxmanifest, fetches the public versions.json from GitHub, and prints whether
    an update is available. No token needed (public repo).
--]]

-- ── EDIT THIS ────────────────────────────────────────────────────────────────
local SCRIPT_KEY = 'fishing'                       -- this script's key in versions.json
local REPO       = 'robbiestokes21/free_scripts'   -- owner/repo
local BRANCH     = 'main'
-- ─────────────────────────────────────────────────────────────────────────────

local res = GetCurrentResourceName()
local localVersion = GetResourceMetadata(res, 'version', 0) or '0.0.0.0'

-- Parse "MAJOR.MINOR.PATCH.BUILD[-prerelease]" -> nums table, prerelease string.
local function parse(v)
    v = tostring(v):gsub('%s', '')
    local core, pre = v:match('^(.-)%-(.+)$')
    if not core or core == '' then core = v; pre = nil end
    local n = {}
    for x in core:gmatch('[^.]+') do n[#n + 1] = tonumber(x) or 0 end
    for i = 1, 4 do n[i] = n[i] or 0 end
    return n, (pre and pre ~= '') and pre:lower() or nil
end

-- Compare a vs b -> -1 (a<b), 0 (equal), 1 (a>b). A prerelease ranks below the
-- same final version (1.0.0-beta < 1.0.0).
local function cmp(a, b)
    local na, pa = parse(a)
    local nb, pb = parse(b)
    for i = 1, 4 do
        if na[i] ~= nb[i] then return na[i] < nb[i] and -1 or 1 end
    end
    if pa == pb then return 0 end
    if not pa then return 1 end
    if not pb then return -1 end
    return pa < pb and -1 or 1
end

CreateThread(function()
    local url = ('https://raw.githubusercontent.com/%s/%s/versions.json'):format(REPO, BRANCH)
    PerformHttpRequest(url, function(status, body)
        if status ~= 200 or not body or body == '' then
            print(('^3[%s] update check failed (HTTP %s)^7'):format(res, tostring(status)))
            return
        end
        local ok, data = pcall(json.decode, body)
        local remote = (ok and type(data) == 'table') and data[SCRIPT_KEY] or nil
        if not remote then
            print(('^3[%s] not listed in versions.json (key "%s")^7'):format(res, SCRIPT_KEY))
            return
        end
        local c = cmp(localVersion, remote)
        if c < 0 then
            print(('^1[%s] UPDATE AVAILABLE: %s -> %s  | https://github.com/%s^7'):format(res, localVersion, remote, REPO))
        elseif c > 0 then
            print(('^3[%s] running ahead of published (%s > %s)^7'):format(res, localVersion, remote))
        else
            print(('^2[%s] up to date (%s)^7'):format(res, localVersion))
        end
    end, 'GET', '', { ['User-Agent'] = 'fivem-update-check' })
end)
