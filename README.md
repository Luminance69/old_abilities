# dota 7.99

How to use the kv filter: (This assumes you have cloned the repo and run npm install in the root folder)

First, open `scripts/settings.json`:

Note: all values which cannot be converted to numbers (e.g. strings, empty "", etc.) will be ignored.

To add a specific key to be filtered a specific way:

`"key": "filter_name",`

example:

`"FollowRange": "vector",`

`"ProjectileModel": "ignore",`

`"AttackRate": "time",`

To add a specific base-key combo:

`"base/key" "filter_name",`

example:

`"elder_titan_earth_splitter/crack_time": "time",`

`"item_blink/blink_range_clamp": "vector",`

`"npc_dota_neutral_ogre_magi/AttackAnimationPoint": "time",`

To add a wild card, which will be matched with anything containing the phrase:

`"$key": "filter_name",`

Example:

`"$duration": "time",`

`"$radius": "vector",`

`"$Bounty": "eco",`

Notes: All keys ARE case sensitive. Base-key combo's are checked first, followed by regular keys, followed by wild cards. Abilities/units/items can be entered as a key, and will be skipped if value is `"ignore"`. Each filter is used to determine the modification made to the number:

`"ignore":`

    `return value`

`"time":`

    `return value`

`"multiply":`

    `return value * 100`

`"crit":`

    `return (value - 100) * 100 + 100`

Note: if no filter is specified, `value * 100` is used.

Notes: To continue you will need to have installed python https://www.python.org/downloads/. Once python is installed, run `pip install vdf` in console (this just installs a package to convert python to KV files)

Once you would like to test your settings, run the file:

`scripts/filter.bat` (windows)

`scripts/filter.sh` (linux/macos)

Then simply run dota tools as normal, and enter `DOTA_LAUNCH_CUSTOM_GAME dota_799 dota` into the console (can be opened from the very right button in the top-left of Asset Browser)

Running this will also generate all the base dota KV files in root/src, as well as json equivalents
