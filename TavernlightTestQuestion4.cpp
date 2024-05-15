void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool deletePlayerMem = false; //Flag to determine if the 'player' pointer needs to have it's memory freed up manually - Default is 'false'.
   
    if (!player) {                    //No 'recipient' player found.
        player = new Player(nullptr); //Player is assigned to dynamically here by using the 'new' keyword - Will need to manually free up the memory for this pointer.
        deletePlayerMem = true;       //Set the flag for deleting the 'player' pointer memory to 'true'.

        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player;    //Frees up the 'player' pointer memory.
            player = nullptr; //Assign pointer value to 'null' to remove reference.

            return;
        }
    }

    Item* item = Item::CreateItem(itemId); //Since 'item' is assigned to statically it will have it's memory automatically freed up.
    
    if (!item) {              //No item with 'itemId' found.
        if(deletePlayerMem) { //Since the 'player' pointer might have had a static assignment it's important to ensure that a 'delete' is necessary in order to avoid unpredictable behaviour.
            delete player;    //Free up 'player' pointer memory.
            player = nullptr; //Assign pointer value to 'null' to remove reference.
        }

        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT); //Send the 'item' to the inbox of 'player'.

    if (player->isOffline()) { //The 'player' is not online, so save result.
        IOLoginData::savePlayer(player);
    }
    
    //Since the 'player' pointer might have had a static assignment it's important to ensure that a 'delete' is necessary in order to avoid unpredictable behaviour.
    if(deletePlayerMem) {
        delete player;    //Free up 'player' pointer memory.
        player = nullptr; //Assign pointer value to 'null' to remove reference.
    }
}
