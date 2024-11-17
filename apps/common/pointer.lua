local Pointer = {}
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

return Pointer
