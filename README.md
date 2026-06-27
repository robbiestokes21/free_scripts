# Free FiveM Scripts

Free, open-source FiveM resources by **robbiestokes21**. Use them, fork them,
learn from them.

## Repo structure

Each script lives in its own folder. Download the folder you want and drop it
into your server's `resources`.

```
free_scripts/
├── versions.json        # latest published version of every script (used by the update checker)
├── _template/           # drop-in update checker + example manifest (not a script)
│   ├── version_check.lua
│   └── fxmanifest.example.lua
├── fishing/             # example: a script
│   ├── fxmanifest.lua
│   ├── version_check.lua
│   ├── client/
│   └── server/
└── ...
```

## Scripts

_(none published yet)_

| Script | Folder | Description |
| --- | --- | --- |
| – | – | – |

## Built-in update checking

Every script ships a small `version_check.lua`. On server start it reads the
script's `version` from its `fxmanifest.lua`, fetches this repo's
[`versions.json`](versions.json), and prints to the console whether an update is
available:

```
[fishing] up to date (1.0.0.0)
[fishing] UPDATE AVAILABLE: 1.0.0.0 -> 1.1.0.0 | https://github.com/robbiestokes21/free_scripts
```

No setup or token needed by the person running it — this repo is public.

## Versioning

Scheme: `MAJOR.MINOR.PATCH.BUILD[-prerelease]` (e.g. `1.0.0.0`, `1.2.0-beta`).
A `-prerelease` ranks **below** the same final version.

---

## Adding the update checker to a NEW script (for the author)

1. **Create the folder**: `free_scripts/<yourscript>/`.
2. **Add a version** to its `fxmanifest.lua`:
   ```lua
   version '1.0.0.0'
   ```
3. **Copy** `_template/version_check.lua` into the script folder, and edit the
   one line at the top:
   ```lua
   local SCRIPT_KEY = 'yourscript'   -- must match the key you add to versions.json
   ```
4. **Reference it** in the script's `fxmanifest.lua`:
   ```lua
   server_scripts {
       'server/main.lua',
       'version_check.lua',
   }
   ```
   (See `_template/fxmanifest.example.lua` for a full example.)
5. **Register the version** in [`versions.json`](versions.json):
   ```json
   {
     "yourscript": "1.0.0.0"
   }
   ```

### Releasing an update
Bump the `version` in the script's `fxmanifest.lua` **and** its entry in
`versions.json`, then commit & push. Every server running the script will see
the new version on their next restart.

## License

[MIT](LICENSE) — free to use, modify, and distribute.
