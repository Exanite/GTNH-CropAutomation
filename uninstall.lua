local shell = require('shell')
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
    'setup.lua',
    'uninstall.lua'
}

-- UNINSTALL
for i=1, #scripts do
    shell.execute(string.format('rm %s', scripts[i]))
    print(string.format('Uninstalled %s', scripts[i]))
end
