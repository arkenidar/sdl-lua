package.path = package.path .. ";../?.lua"
require("common.draw")
require("common.deltatime")

require("3d_app")

---@diagnostic disable-next-line: lowercase-global
function draw_pixel(rgb, xy)
  DrawColor { rgb[1] * 255, rgb[2] * 255, rgb[3] * 255 }
  DrawPoint(xy[1], xy[2])
end

function Draw()
  update(DeltaTime())
  draw()
end

return { Draw = Draw }
