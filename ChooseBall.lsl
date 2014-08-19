integer weight = 6;

default
{
    state_entry() {
        llSetStatus(STATUS_PHYSICS, TRUE);   
        llSetStatus(STATUS_SANDBOX, TRUE); 
        llSetStatus(STATUS_PHANTOM, FALSE); 
   }

    
    dataserver(key id, string msg)
    {
        vector move;
        if (msg=="chosenRight") {
            move = <0,1,1>;
            llSetStatus(STATUS_PHYSICS, FALSE);  
            llSetPos(llList2Vector(llGetObjectDetails(id, [OBJECT_POS]), 0) + move);
        } else if (msg=="chosenLeft") {
            move = <0,-1,1>;
            llSetStatus(STATUS_PHYSICS, FALSE); 
            llSetPos(llList2Vector(llGetObjectDetails(id, [OBJECT_POS]), 0) + move); 
        } else if (msg=="unchosen") {
            llSetStatus(STATUS_PHYSICS, TRUE);  
            llSetStatus(STATUS_SANDBOX, TRUE); 
        }
    }
    touch_start(integer e) {
        llResetTime();   
    }
    touch_end(integer e) {
        if (llGetTime() < 0.5) {
            llSay(601023717, (string)weight);  
        } 
    }
}
