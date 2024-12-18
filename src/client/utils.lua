---@class utils
utils = {}

---@param message string
function utils.notification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(true, false)
end
