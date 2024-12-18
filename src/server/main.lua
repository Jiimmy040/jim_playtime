---@class cache
---@field players table
cache = {}
cache.players = {}

Citizen.CreateThread(function()
    local playerData = fetch.recievePlayerData()

    if type(playerData) == "table" and playerData then
        cache.players = playerData
    end

    vx.print.info(("Fetched %s player(s) from %s%s"):format(#cache.players, Config.TxDataPath, Config.playerDB))
end)

---@param source number
vx.callback.register("jim-playtime:playerLoaded", function(source)
    local playerData = fetch.getPlayerData(source)
    if not playerData then return end

    local player = ESX.GetPlayerFromId(source)
    local playerTime = utils.convertMs(playerData.txPlayer.playTime * 60 * 1000)
    local firstJoineDate = utils.convertTimeStamp(playerData.txPlayer.tsJoined)
    local timesJoined = playerData.timesJoined

    if Config.debug then
        vx.print.info('playerData', playerData)
        vx.print.info('playerTime', playerTime)
        vx.print.info('firstJoineDate', firstJoineDate)
        vx.print.info('timesJoined', timesJoined)
    end

    ---# Welcome Message
    vx.callback.await("jim-playtime:receiveNotification", source,
        (SharedConfig.Locales.welcomeMessage):format(player.getName()))

    ---# Playtime Message
    vx.callback.await("jim-playtime:receiveNotification", source,
        (SharedConfig.Locales.playTimeMessage):format(playerTime.days,
            playerTime.hours, playerTime.minutes, playerTime.seconds))

    ---# Times Joined Message
    vx.callback.await("jim-playtime:receiveNotification", source,
        (SharedConfig.Locales.timesJoinedMessage):format(timesJoined))

    ---# First Join Date Message
    vx.callback.await("jim-playtime:receiveNotification", source,
        (SharedConfig.Locales.firstJoinDateMessage):format(firstJoineDate))
end)

