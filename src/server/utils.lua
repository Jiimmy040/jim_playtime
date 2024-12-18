---@class utils
utils = {}

---@param milliseconds number
function utils.convertMs(milliseconds)
    local seconds = math.floor(milliseconds / 1000)
    local minutes = math.floor(seconds / 60)
    local hours = math.floor(minutes / 60)
    local days = math.floor(hours / 24)

    hours = hours % 24
    minutes = minutes % 60

    return {
        days = days,
        hours = hours,
        minutes = minutes,
        seconds = seconds % 60
    }
end

---@param ts number
function utils.convertTimeStamp(ts)
    return os.date("%d-%m-%Y", ts)
end
