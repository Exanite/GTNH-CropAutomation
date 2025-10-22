local component = require('component')
local sides = require('sides')
local config = require('config')
local geolyzer = component.geolyzer


local function scan()
    local rawResult = geolyzer.analyze(sides.down)

    -- AIR
    if rawResult.name == 'minecraft:air' or rawResult.name == 'GalacticraftCore:tile.brightAir' then
        return {isCrop=true, name='air'}

    elseif rawResult.name == 'IC2:blockCrop' then

        -- EMPTY CROP STICK
        if rawResult['crop:name'] == nil then
            return {isCrop=true, name='emptyCrop'}

        -- FILLED CROP STICK
        else
            return {
                isCrop=true,
                name = rawResult['crop:name'],
                gr = rawResult['crop:growth'],
                ga = rawResult['crop:gain'],
                re = rawResult['crop:resistance'],
                tier = rawResult['crop:tier'],
                size = rawResult['crop:size'],
                max = rawResult['crop:maxSize']
            }
        end

    -- RANDOM BLOCK
    else
        return {isCrop=false, name='block'}
    end
end


local function isWeed(crop, farm)
    local result = false

    if crop.name == 'venomilia' and crop.gr > 7 then
        result = true
        print('is weed due to venomilia with gr > 7')
    end

    if crop.name == 'weed' then
        result = true
    end

    if crop.name == 'Grass' then
        result = true
    end

    if farm == 'working' then
        if crop.gr > config.workingMaxGrowth then
            result = true
            print('is weed due to exceeding workingMaxGrowth')
        end

        if crop.re > config.workingMaxResistance then
            result = true
            print('is weed due to exceeding workingMaxResistance')
        end
    elseif farm == 'storage' then
        if crop.gr > config.storageMaxGrowth then
            result = true
            print('is weed due to exceeding storageMaxGrowth')
        end

        if crop.re > config.storageMaxResistance then
            result = true
            print('is weed due to exceeding storageMaxResistance')
        end
    end

    return result
end


return {
    scan = scan,
    isWeed = isWeed
}
