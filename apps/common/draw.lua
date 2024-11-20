function DrawRectangle(rectangle)
    local x, y, w, h = rectangle[1], rectangle[2], rectangle[3], rectangle[4]
    x = math.floor(x)
    y = math.floor(y)
    w = math.floor(w)
    h = math.floor(h)
    for px = x, x + w - 1 do
        for py = y, y + h - 1 do
            DrawPoint(px, py)
        end
    end
end

-- Calculate Euclidean distance between two 2D points
function Distance(point1, point2)
    local x1, y1 = point1[1], point1[2]
    local x2, y2 = point2[1], point2[2]
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

function DrawCircle(center, radius)
    local cx, cy, r = center[1], center[2], radius
    cx = math.floor(cx)
    cy = math.floor(cy)
    r = math.floor(r)
    for px = cx - r, cx + r - 1 do
        for py = cy - r, cy + r - 1 do
            if Distance({ px, py }, { cx, cy }) <= r then
                DrawPoint(px, py)
            end
        end
    end
end

function PointInRectangle(point, rectangle)
    local x, y = point[1], point[2]
    local x1, y1, x2, y2 = FromWidthHeightToPoints(rectangle)
    return x >= x1 and x <= x2 and y >= y1 and y <= y2
end

function RandomColor()
    return { math.random(0, 255), math.random(0, 255), math.random(0, 255) }
end

function DrawColor(color, alpha)
    if alpha then alpha = math.floor(alpha * 255) end
    DrawColorRGBA(color[1], color[2], color[3], alpha or color[4])
end

function RectangleFromCenterAndSize(center, size)
    return { center[1] - size[1] / 2, center[2] - size[2] / 2, size[1], size[2] }
end

---@diagnostic disable-next-line: deprecated
Spread = unpack and unpack or table.unpack

function FromWidthHeightToPoints(xywh)
    return xywh[1], xywh[2], xywh[1] + xywh[3], xywh[2] + xywh[4]
end

function FromPointsToWidthHeight(point1, point2)
    local x_min, y_min = math.min(point1[1], point2[1]), math.min(point1[2], point2[2])
    local x_max, y_max = math.max(point1[1], point2[1]), math.max(point1[2], point2[2])
    return x_min, y_min, x_max - x_min, y_max - y_min
end

function DrawImage(image, area)
    if not area then
        area = { 0, 0, image.width, image.height }
    end
    for y = area[2], area[2] + area[4] - 1 do
        for x = area[1], area[1] + area[3] - 1 do
            local pixel = image.pixels[(y - area[2]) % image.height + 1][(x - area[1]) % image.width + 1]
            DrawColor({ pixel.r, pixel.g, pixel.b, pixel.a })
            DrawPoint(x, y)
        end
    end
end

Color = {

    black = { 0x00, 0x00, 0x00 },
    white = { 0xFF, 0xFF, 0xFF },

    red = { 0xFF, 0x00, 0x00 },
    green = { 0x00, 0xFF, 0x00 },
    blue = { 0x00, 0x00, 0xFF },

    yellow = { 0xFF, 0xFF, 0x00 },
    cyan = { 0x00, 0xFF, 0xFF },
    magenta = { 0xFF, 0x00, 0xFF },

    grey = { 0x80, 0x80, 0x80 },
    light_grey = { 0xC0, 0xC0, 0xC0 },
    dark_grey = { 0x40, 0x40, 0x40 },

    orange = { 0xFF, 0xA5, 0x00 },
    pink = { 0xFF, 0xC0, 0xCB },
    purple = { 0x80, 0x00, 0x80 },
    brown = { 0xA5, 0x2A, 0x2A },
    teal = { 0x00, 0x80, 0x80 },
    olive = { 0x80, 0x80, 0x00 },
    navy = { 0x00, 0x00, 0x80 },
    maroon = { 0x80, 0x00, 0x00 },
    lime = { 0x00, 0xFF, 0x00 },
    indigo = { 0x4B, 0x00, 0x82 },
    gold = { 0xFF, 0xD7, 0x00 },
    silver = { 0xC0, 0xC0, 0xC0 },
    sky_blue = { 0x87, 0xCE, 0xEB },
    violet = { 0xEE, 0x82, 0xEE },
    tan = { 0xD2, 0xB4, 0x8C },
    beige = { 0xF5, 0xF5, 0xDC },
    azure = { 0xF0, 0xFF, 0xFF },
    lavender = { 0xE6, 0xE6, 0xFA },
    salmon = { 0xFA, 0x80, 0x72 },
    khaki = { 0xF0, 0xE6, 0x8C },
    crimson = { 0xDC, 0x14, 0x3C },
    coral = { 0xFF, 0x7F, 0x50 },
    aqua = { 0x00, 0xFF, 0xFF },
    mint = { 0x3E, 0xB4, 0x89 },
    olive_drab = { 0x6B, 0x8E, 0x23 },
}
