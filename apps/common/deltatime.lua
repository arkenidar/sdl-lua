local time_ticks = GetTicks()
function DeltaTime()
    local dt -- elapsed time in fractions of seconds
    local delta_ticks = GetTicks() - time_ticks
    time_ticks = GetTicks()
    dt = delta_ticks / 1000 -- milliseconds to seconds
    return dt
end
