package.path = package.path .. ";../?.lua"
require("common.draw")

function Draw()
    SetDrawColor(0x00, 0xFF, 0x00)
    DrawRectangle(50, 50, 100, 100)

    SetDrawColor(0xFF, 0xFF, 0x00)
    DrawCircle(50, 50, 40)
end

return { Draw = Draw }
