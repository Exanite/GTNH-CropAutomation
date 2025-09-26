local gps = require('gps')
local database = require('database')
local scanner = require('scanner')
local action = require('action')
local config = require('config')
local robot = require('robot')

-- ====================== THE LOOP ======================

local function analyzeStorage(existingTarget)
    if not config.checkStorageBefore then
        return
    end
    local targetCropName = database.getFarm()[1].name
    local storage = database.getStorage()
    for slot=1, config.storageFarmArea, 1 do
        gps.go(gps.storageSlotToPos(slot))
        local crop = scanner.scan()
        if crop.name ~= 'air' then
            if (existingTarget == true and crop.name ~= targetCropName) then
                action.clearDown()
            elseif scanner.isWeed(crop, 'storage') then
                action.clearDown()
            else
                database.updateStorage(slot, crop)
            end
        end
    end
end

return {
    analyzeStorage = analyzeStorage
}