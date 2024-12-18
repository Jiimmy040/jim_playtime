---@class fetch
fetch = {}

---@return table | nil
function fetch.loadPlayerData()
    local filePath = Config.TxDataPath .. Config.playerDB
    local file = io.open(filePath, "r")
    if not file then
        vx.print.error("Could not open playerDB.json file at path:", filePath)
        return nil
    end

    local content = file:read("*a")
    file:close()

    local playerData, pos, err = json.decode(content, 1, nil)
    if err then
        vx.print.error("Error parsing JSON:", err)
        return nil
    end

    return playerData
end

---@param source number
function fetch.timesJoined(source)
    local license = vx.player.getIdentifier(source, false, "license")
    local key = ("timesjoined.%s"):format(license)
    local timesJoined = GetResourceKvpInt(key)

    if not timesJoined then
        SetResourceKvpInt(key, 1)
        return 1
    else
        SetResourceKvpInt(key, timesJoined + 1)
        return timesJoined + 1
    end
end

---@return table | nil
function fetch.recievePlayerData()
    local playerData = fetch.loadPlayerData()
    if not playerData then
        return
    end

    for key, value in pairs(playerData) do
        if key == "players" then
            return value
        end
    end

    return nil
end

---@param source number
---@return table | nil
function fetch.getPlayerData(source)
    if #cache.players == 0 then return end
    local license = vx.player.getIdentifier(source, false, "license")
    local players = cache.players

    for __, player in pairs(players) do
        if player.license == license then
            return {
                txPlayer = player,
                timesJoined = fetch.timesJoined(source)
            }
        end
    end

    return nil
end
