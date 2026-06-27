# example_resource

A minimal, working example of a free script with the **built-in update checker**.
Use it as a copy-paste starting point for your own free scripts.

## What to look at

| File | Why it matters |
| --- | --- |
| `fxmanifest.lua` | Has a `version '1.0.0.0'` line **and** lists `version_check.lua` in `server_scripts`. Those two lines are the entire integration. |
| `version_check.lua` | The drop-in checker. Only the top line is edited: `local SCRIPT_KEY = 'example_resource'` (must match the key in the repo's `versions.json`). |
| `client/main.lua` | Demo: `/example` command + spawn welcome. |
| `server/main.lua` | Demo: startup log. |

## How the update check behaves

On server boot you'll see one of these in the console:

```
[example_resource] up to date (1.0.0.0)
[example_resource] UPDATE AVAILABLE: 1.0.0.0 -> 1.1.0.0 | https://github.com/robbiestokes21/free_scripts
```

It reads this script's version from the fxmanifest and compares it to
[`../versions.json`](../versions.json) in this repo. No token needed.

## Try it
1. Copy the `example_resource` folder into your server's `resources`.
2. `ensure example_resource` in `server.cfg`.
3. Start the server, watch the console, then run `/example` in-game.

## Make your own
1. Duplicate this folder, rename it.
2. Set `name` + `version` in `fxmanifest.lua`.
3. In `version_check.lua`, set `SCRIPT_KEY` to your script's name.
4. Add your script to `versions.json` at the repo root.
