local function releaseStorage(player) --Keeping this function since there may be need to reset a player's storage value elsewhere.
    player:setStorageValue(1000, -1)
end

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        --[[Cannot use addEvent() to reset a storage value unless you lock the player from logging out.
            If a delay in setting the storage value to '-1' is necessary then 'os.time()'/'os.mtime()' can be used to count the value down instead.
            Additionally, it does not seem like there is a need to burden scheduler resources handling an event each time a player logs out just for this.]]
        releaseStorage(player)
    end
    return true
end