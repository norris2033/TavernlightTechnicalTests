function removeMemberFromPlayerParty(playerId, membername) --Renamed to 'removeMemberFromPlayerParty()'.
    local player = Player(playerId) --Made 'player' local to prevent unnecessary global variables.
    local party = player:getParty()
    local members = party:getMembers() --Make a local copy of the 'party' members.
    local leader = party:getLeader()
    local playerToRemove = Player(membername)

    if members == nil or members == 0 then --Check for both 'nil' and 0 party members to ensure a multi-player party is currently formed.
        print(string.format("You aren't currently in a party with any other members."))
    elseif playerToRemove:getId() == leader:getId() then --Prevent the current party leader from being removed.
        print(string.format("Cannot remove the current party leader. Set the leader to a different party member and try again."))
        --[[I opted to prevent the leader from being removed instead of setting a new leader and then removing 'membername' in order to force the player
            to confirm that this is in fact the action they want to take.]]
    else
        local memberRemoved = false

        for k,v in pairs(members) do  --Loop through the 'party' member values with a key/value pair.
            if v == playerToRemove then 
                party:removeMember(playerToRemove) --Removes the 'Player()' profile with the matching 'membername' from 'party'.
                memberRemoved = true
                print(string.format("%s was removed from the party.", membername)) --Indicate that the 'membername' player has been removed from the party.
            end
        end

        if not memberRemoved then --Indicate that the 'membername' player has not been removed from the party successfully.
            print(string.format("Unable to remove %s from the party.", membername))
        end
    end

    --[[Alternative solution:
        If the output from 'getParty()' can be coaxed into a table set where the 'membername' values we are looking through are stored as keys,
        then we can optimize our search by discarding the for loop in the 'else' section in favor of what is below.
        However this may not be possible or necessary for this single use case, so I included it this way as more of a thought excersise.
    if party[membername] ~= nil then                                       --Check to see if 'membername' is represented in the 'party' set.
        party:removeMember(playerToRemove)                             --Removes the 'Player()' profile with the matching 'membername' from 'party'.
        print(string.format("%s was removed from the party.", membername)) --Indicate that the player has been removed from the party.
    else
        print(string.format("Unable to remove %s from the party.", membername)) --Indicate that the player hasn't been removed from the party.
    end ]]
end