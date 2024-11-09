---@diagnostic disable-next-line: deprecated
Spread = unpack and unpack or table.unpack

Pointer = {}
function Pointer.process_input()
    local mx, my, down = InputPoint()
    -- position, x, y
    Pointer.position = { mx, my }
    Pointer.x = Pointer.position[1]
    Pointer.y = Pointer.position[2]
    -- click and down
    Pointer.down_previously = Pointer.down
    Pointer.down = down
    Pointer.click = false
    if Pointer.down and not Pointer.down_previously then
        Pointer.click = true
    end
end

function DrawRectangle(x, y, w, h)
    for px = x, x + w - 1 do
        for py = y, y + h - 1 do
            DrawPoint(px, py)
        end
    end
end
