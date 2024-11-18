package.path = package.path .. ";../?.lua"
require("common.draw")
local Pointer = require("common.pointer")

local position = { x = 20, y = 30 }
local tricolor = {
    Color.green,
    Color.white,
    Color.red,
}
function Draw()
    local actionable_button_xywh = { 160, 50, 80, 40 }
    local flag_part_width, flag_part_height = 30, 50

    Pointer.process_input()
    -- update tricolor flag colors
    local click_inside_actionable_button = Pointer.click and
        PointInRectangle({ Pointer.x, Pointer.y }, actionable_button_xywh)
    if click_inside_actionable_button then
        print("click at", Pointer.x, Pointer.y, "inside the rectangle")
        tricolor = { RandomColor(), RandomColor(), RandomColor() }
        Pointer.click = false -- prevent other clicks
    end
    -- update tricolor flag positioning
    if Pointer.click then
        print("click at", Pointer.x, Pointer.y)
        position = { x = Pointer.x - (flag_part_width * 3 / 2), y = Pointer.y - (flag_part_height / 2) }
    end

    -- draw tricolor flag parts
    local function DrawTricolorPart(index)
        DrawColor(tricolor[index])
        DrawRectangle { position.x + flag_part_width * (index - 1), position.y,
            flag_part_width, flag_part_height }
    end

    DrawTricolorPart(1)
    DrawTricolorPart(2)
    DrawTricolorPart(3)

    -- draw button
    DrawColor(Color.magenta)
    DrawRectangle(actionable_button_xywh)

    -- draw pointer
    local squareSize = 20
    DrawColor(Color.black)
    DrawRectangle(
        RectangleFromCenterAndSize({ Pointer.x, Pointer.y },
            { squareSize, squareSize }))
end

print("Hello, World!")
print("Hello from Italy!")

return { Draw = Draw }
