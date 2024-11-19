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
    -- screen borders handling
    -- for e.g. draw pointer checks
    if WindowSize then
        local screen_width, screen_height = WindowSize()
        Pointer.screen_wh = { screen_width, screen_height }
    else
        Pointer.screen_wh = nil
    end
    if Pointer.screen_wh then
        local on_borders = Pointer.x == 0 or Pointer.y == 0
            or Pointer.x == (Pointer.screen_wh[1] - 1)
            or Pointer.y == (Pointer.screen_wh[2] - 1)

        if Pointer.screen_wh and on_borders
        then
            Pointer.x = nil
            Pointer.y = nil
        end
    end
    Pointer.inside = Pointer.x and Pointer.y
end

return Pointer
