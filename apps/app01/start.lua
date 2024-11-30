package.path = package.path .. ";../?.lua"
require("common.draw")

require("common.image")
local Images = {}
Images.pattern = ImageLoadBMP("../assets/pattern.bmp")
Images.flower = ImageLoadBMP("../assets/flower.bmp")
-- ui check-box
Images.checkb_check = ImageLoadBMP("../assets/ui/check-box/box1.bmp")
Images.checkb_empty = ImageLoadBMP("../assets/ui/check-box/box0.bmp")

function Draw(dt)
    local window_width, window_height = WindowSize()
    local window_area = { 0, 0, window_width, window_height }
    DrawImage(Images.pattern, window_area)
    DrawImage(Images.flower, window_area)

    DrawColor(Color.blue)
    DrawRectangle { 50, 50, 100, 100 }

    DrawColor(Color.white, 0.6)
    DrawCircle({ 50, 50 }, 40)

    DrawColor(Color.red)
    DrawPoint(0, 0)

    --DrawImage(Images.flower, { 50, 60, Images.flower.width, Images.flower.height })
    function DrawImageSingle(name, x, y)
        DrawImage(Images[name], { x, y, Images[name].width, Images[name].height })
    end

    DrawImageSingle('flower', 50, 60)

    function DrawCheckBoxes(checkboxes_booleans, x, y, array_direction, spacing)
        local image_x, image_y = x, y
        for _, checkbox_boolean in ipairs(checkboxes_booleans) do
            local checkbox_image_name = checkbox_boolean and 'checkb_check' or 'checkb_empty'
            DrawImageSingle(checkbox_image_name, image_x, image_y)

            if array_direction == 'vertically' then
                image_y = image_y + Images[checkbox_image_name].height + spacing
            elseif array_direction == 'horizontally' then
                image_x = image_x + Images[checkbox_image_name].width + spacing
            end
        end
    end

    local checkboxes_booleans_1 = { true, false, true, true, true }
    DrawCheckBoxes(checkboxes_booleans_1, 50, 60, 'vertically', 10)

    local checkboxes_booleans_2 = { false, true, true, false, false }
    DrawCheckBoxes(checkboxes_booleans_2, 100, 60, 'horizontally', 2)
end

return { Draw = Draw }
