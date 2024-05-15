function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount)) --Runs the 'selectGuildQuery' and saves the output.
    
    if resultId == nil then --If no rows were returned by 'result' then print out the following message.
        print(string.format("No guilds with max members less than %d found.", memberCount))
    else
        repeat --Loop through each 'name' and print them out.
            local guildName = result.getString(resultId, "name")
            print(guildName)
        until(result.next(resultId))

        result.free(resultId) --Free up the 'resultId' memory.
    end
end