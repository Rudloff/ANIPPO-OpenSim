integer weight = 10;
vector basePos = <-2,1,2>;
default
{
    touch_start(integer e) {
        llMessageLinked(1, weight, "chosen", llGetKey());
    }
    
    link_message(integer sender_num, integer num, string msg, key id)
    {
        if (id == llGetKey()) {
            if (msg=="chosenRight") {
                llSetPos(<0,1,1>);
            } else if (msg=="chosenLeft") {
                llSetPos(<0,-1,1>);
            } else if (msg=="unchosen") {
                llSetPos(basePos);
            }
        }
    }
}
