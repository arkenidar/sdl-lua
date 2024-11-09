if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    -- launched through "lldebugger" (ms-vscode)
    require("lldebugger").start()
end

require("utils")

local position = { x = 20, y = 30 }
function Draw()
    local width, height = 30, 50

    Pointer.process_input()
    if Pointer.click then
        print("click at", Pointer.x, Pointer.y)
        position = { x = Pointer.x - (width * 3 / 2), y = Pointer.y - (height / 2) }
    end

    SetDrawColor(0x00, 0xFF, 0x00)
    DrawRectangle(position.x + width * 0, position.y, width, height)

    SetDrawColor(0xFF, 0xFF, 0xFF)
    DrawRectangle(position.x + width * 1, position.y, width, height)

    SetDrawColor(0xFF, 0x00, 0x00)
    DrawRectangle(position.x + width * 2, position.y, width, height)
end

print("Hello, World!")
print("Hello from Italy!")
