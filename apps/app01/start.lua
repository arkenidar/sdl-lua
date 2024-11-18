package.path = package.path .. ";../?.lua"
require("common.draw")

function Draw()
    DrawColor(Color.dark_grey)
    DrawRectangle { 50, 50, 100, 100 }

    DrawColor(Color.grey)
    DrawCircle({ 50, 50 }, 40)
end

return { Draw = Draw }
