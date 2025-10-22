local shell = require('shell')
local args = {...}
local branch = 'main'
local repo = 'https://raw.githubusercontent.com/Exanite/GTNH-CropAutomation/'
local scripts = {
    'action.lua',
    'autoSpread.lua',
    'autoStat.lua',
    'autoTier.lua',
    'config.lua',
    'database.lua',
    'events.lua',
    'gps.lua',
    'scanner.lua',
    'uninstall.lua'
}

-- INSTALL
for i=1, #scripts do
    shell.execute(string.format('wget -f %s%s/%s', repo, branch, scripts[i]))
end
