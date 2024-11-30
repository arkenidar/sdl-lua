package.path = package.path .. ";../?.lua"
require("common.draw")

require("common.image")
local Images = {}
Images.pattern = ImageLoadBMP("../assets/pattern.bmp")
Images.flower = ImageLoadBMP("../assets/flower.bmp")

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

    DrawImageSingle('flower', 50 , 60)
end

return { Draw = Draw }
