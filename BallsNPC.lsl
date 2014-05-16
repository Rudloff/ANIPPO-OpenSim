key proprio;
integer clic;
key     npc;
list wrongColors = ["noir", "blanc", "vert", "rouge", "rose", "orange", "turquoise", "violet", "mauve"];
default
{
    on_rez(integer nbr)
    {
        llResetScript();
    }
    state_entry()
    {
        proprio = llGetOwner();
        llListen( 0, "", NULL_KEY, "" ); 
    }
    touch_start(integer number)
    {
       
       if (proprio == llDetectedKey(0))
        {      
            ++clic;
            if (clic == 1)
            {
                vector npcPos = llGetPos() + <0.0, 0.0, 1.0>;
                npc = osNpcCreate("Jessica", "CM2", npcPos, "jessica");
                osNpcSay(npc, "Bonjour je m'appelle Jessica.");
            }      
            else if (clic == 2)
            {
                osNpcSay(npc, "Goodbye!");
                osNpcRemove(npc);
                npc = NULL_KEY;
                clic = 0;
            } 
            else
            {
                clic = 0;
            }
        } else {
            osNpcSay(npc, "Quelle est la couleur de la boule la plus lourde ?");
        }         
    }
    
    listen( integer channel, string name, key id, string message )
    {
        integer index = llListFindList( wrongColors, [message] );
        if (llToLower(message) == "bleu" )
        {
            osNpcSay(npc, "Oui, bravo " + name + " ! C'est bien la boule bleue qui est la plus lourde !" );
             llGiveInventory(id, "Medaille bleue");
        }
        else if (index != -1)
        {
            osNpcSay(npc, "Non " + name + ", ce n'est pas cette boule qui est la plus lourde." );
        } else if (llToLower(message) == "bonjour")
        {
            osNpcSay(npc, "Bonjour, je m'appelle Jessica. Est-ce que tu as vu les boules ? Dis-moi laquelle est la plus lourde et je te donnerai une récompense." );
        }
    }
}
