require("utils")

local position = { x = 20, y = 30 }
function Draw()
	local dx = DeltaTime() * 30
	--print("dx", dx)

	position.x = position.x + dx
	if position.x > 100 then position.x = 20 end

	local width, height = 30, 50

	SetDrawColor(0x00, 0xFF, 0x00)
	DrawRectangle(position.x + width * 0, position.y, width, height)
end