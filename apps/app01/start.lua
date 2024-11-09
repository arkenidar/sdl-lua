function Draw()
    SetDrawColor(0x00, 0xFF, 0x00)
    DrawRectangle(50, 50, 100, 100)

    SetDrawColor(0xFF, 0xFF, 0x00)
    DrawCircle(50, 50, 40)
end

function DrawRectangle(x, y, w, h)
    for px = x, x + w - 1 do
        for py = y, y + h - 1 do
            DrawPoint(px, py)
        end
    end
end

-- Calculate Euclidean distance between two 2D points
local function Distance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

function DrawCircle(cx, cy, r)
    for px = cx - r, cx + r - 1 do
        for py = cy - r, cy + r - 1 do
            if Distance(px, py, cx, cy) <= r then
                DrawPoint(px, py)
            end
        end
    end
end
