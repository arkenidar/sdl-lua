local bit
if jit then
    --print("Running LuaJIT")
    --print("LuaJIT version: " .. jit.version)
    bit = require("bit")
else
    --print("Not running LuaJIT")
    bit = require("common.bit_operations")
end

local function readInt32(str, pos)
    local b1, b2, b3, b4 = str:byte(pos, pos + 3)
    return b1 + bit.lshift(b2, 8) + bit.lshift(b3, 16) + bit.lshift(b4, 24)
end

local function readInt16(str, pos)
    local b1, b2 = str:byte(pos, pos + 1)
    return b1 + bit.lshift(b2, 8)
end

function ImageLoadBMP(filename)
    local file = io.open(filename, "rb")
    if not file then
        return nil, "Could not open file"
    end

    -- Read BMP header
    local header = file:read(14)
    if header:sub(1, 2) ~= "BM" then
        file:close()
        return nil, "Not a BMP file"
    end

    -- Read DIB header
    local dibSize = readInt32(file:read(4), 1)
    local fullDibHeader = file:read(dibSize - 4)

    -- Parse header information
    local width = readInt32(fullDibHeader, 1)
    local height = readInt32(fullDibHeader, 5)
    local planes = readInt16(fullDibHeader, 9)
    local bitsPerPixel = readInt16(fullDibHeader, 11)
    local compression = readInt32(fullDibHeader, 13)
    local imageSize = readInt32(fullDibHeader, 17)
    local colorsUsed = readInt32(fullDibHeader, 29)

    -- Handle negative height (top-down BMP)
    local isTopDown = height < 0
    height = math.abs(height)

    -- Check for supported formats
    if compression ~= 0 and compression ~= 3 then -- BI_RGB or BI_BITFIELDS
        file:close()
        return nil, "Unsupported compression method"
    end

    -- Color masks for ARGB format
    local rMask, gMask, bMask, aMask
    if compression == 3 then  -- BI_BITFIELDS
        if dibSize >= 52 then -- V4 header or newer
            rMask = readInt32(fullDibHeader, 37)
            gMask = readInt32(fullDibHeader, 41)
            bMask = readInt32(fullDibHeader, 45)
            aMask = readInt32(fullDibHeader, 49)
        else
            -- Read color masks that follow the DIB header
            rMask = readInt32(file:read(4), 1)
            gMask = readInt32(file:read(4), 1)
            bMask = readInt32(file:read(4), 1)
            aMask = 0xFF000000
        end
    end

    -- Calculate row size (must be multiple of 4 bytes)
    local rowSize = math.floor((bitsPerPixel * width + 31) / 32) * 4

    -- Read color table if present
    local colorTable = {}
    if bitsPerPixel <= 8 then
        local numColors = colorsUsed
        if numColors == 0 then
            numColors = 2 ^ bitsPerPixel
        end
        for i = 1, numColors do
            local b, g, r, a = file:read(4):byte(1, 4)
            colorTable[i - 1] = { r = r, g = g, b = b, a = a or 255 }
        end
    end

    -- Read pixel data
    local pixels = {}
    local function getShiftAndMask(mask)
        if mask == 0 then return 0, 0 end
        local shift = 0
        while bit.band(mask, 1) == 0 do
            shift = shift + 1
            mask = bit.rshift(mask, 1)
        end
        return shift, mask
    end

    -- Get shift values for ARGB format
    local rShift, rMaskNorm = getShiftAndMask(rMask or 0x00FF0000)
    local gShift, gMaskNorm = getShiftAndMask(gMask or 0x0000FF00)
    local bShift, bMaskNorm = getShiftAndMask(bMask or 0x000000FF)
    local aShift, aMaskNorm = getShiftAndMask(aMask or 0xFF000000)

    for y = 1, height do
        local row = {}
        pixels[isTopDown and y or (height - y + 1)] = row

        for x = 1, width do
            local r, g, b, a = 0, 0, 0, 255

            if bitsPerPixel == 32 then
                local pixel = readInt32(file:read(4), 1)
                if compression == 3 then -- BI_BITFIELDS
                    r = bit.band(bit.rshift(bit.band(pixel, rMask), rShift), rMaskNorm)
                    g = bit.band(bit.rshift(bit.band(pixel, gMask), gShift), gMaskNorm)
                    b = bit.band(bit.rshift(bit.band(pixel, bMask), bShift), bMaskNorm)
                    a = bit.band(bit.rshift(bit.band(pixel, aMask), aShift), aMaskNorm)
                else -- Standard BGRA
                    b = bit.band(pixel, 0xFF)
                    g = bit.band(bit.rshift(pixel, 8), 0xFF)
                    r = bit.band(bit.rshift(pixel, 16), 0xFF)
                    a = bit.band(bit.rshift(pixel, 24), 0xFF)
                end
            elseif bitsPerPixel == 24 then
                b, g, r = file:read(3):byte(1, 3)
            elseif bitsPerPixel == 8 then
                local index = file:read(1):byte()
                local color = colorTable[index]
                r, g, b, a = color.r, color.g, color.b, color.a
            else
                file:close()
                return nil, "Unsupported bits per pixel: " .. bitsPerPixel
            end

            row[x] = { r = r, g = g, b = b, a = a }
        end

        -- Skip padding bytes
        local padding = rowSize - math.ceil(width * bitsPerPixel / 8)
        if padding > 0 then
            ---@diagnostic disable-next-line: discard-returns
            file:read(padding)
        end
    end

    file:close()

    return {
        width = width,
        height = height,
        bitsPerPixel = bitsPerPixel,
        compression = compression,
        hasAlpha = (bitsPerPixel == 32),
        pixels = pixels
    }
end
