local time_ticks = GetTicks()
function DeltaTime()
    local dt -- elapsed time in fractions of seconds
    local delta_ticks = GetTicks() - time_ticks
    time_ticks = GetTicks()
    dt = delta_ticks / 1000 -- milliseconds to seconds
    return dt
end

function DrawRectangle(x, y, w, h)
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
