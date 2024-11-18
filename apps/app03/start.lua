package.path = package.path .. ";../?.lua"
require("common.draw")
require("common.deltatime")

local position = { x = 20, y = 5 }
function Draw()
	local dx = DeltaTime() * 30

	position.x = position.x + dx
	if position.x > 200 then position.x = 20 end

	local width, height = 100, 10

	DrawColor(Color.black)
	DrawRectangle { position.x, position.y, width, height }
end

return { Draw = Draw }
