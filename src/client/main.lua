---@param message string
vx.callback.register("jim-playtime:receiveNotification", function(message)
    if not message then return vx.print.error("No message received from server") end

    utils.notification(message)
end)

---# ESX
RegisterNetEvent('esx:playerLoaded', function()
    vx.callback.await("jim-playtime:playerLoaded", false)
end)


---# QBCORE
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    vx.callback.await("jim-playtime:playerLoaded", false)
end)
