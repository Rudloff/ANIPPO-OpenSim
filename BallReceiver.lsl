integer weightLeft = 0;
integer weightRight = 0;
string nameLeft;
string nameRight;
key leftID; key rightID;
default
{
    
    state_entry()
    {
        llListen(601023717, "", NULL_KEY, "");
    }
    listen(integer channel, string name, key id, string msg)
    {
        if (msg == "reset") {
            llSetText("", ZERO_VECTOR, 0);
            if (leftID) {
                if (leftID != NULL_KEY) {
                    osMessageObject(leftID, "unchosen");
                }
            }
            if (rightID) {
                if (rightID != NULL_KEY) {
                    osMessageObject(rightID, "unchosen");
                }
            }
            leftID = NULL_KEY;
            rightID = NULL_KEY;
            weightLeft = 0;
            weightRight = 0;
        } else {
            integer weight = (integer)msg;
            string curText =  llList2String(llGetPrimitiveParams([PRIM_TEXT]), 0);
            if (rightID == id) {
                weightRight = 0;
                nameRight = "";
                rightID = NULL_KEY;
                osMessageObject(id, "unchosen"); 
            } else if (leftID == id) {
                weightLeft = 0;
                nameLeft = "";
                leftID = NULL_KEY;
                osMessageObject(id, "unchosen"); 
            } else if (weightRight == 0) {
                weightRight = weight; 
                nameRight = name;
                rightID = id;
                osMessageObject(id, "chosenRight"); 
            } else if (weightLeft == 0) {
                weightLeft = weight; 
                nameLeft = name;
                leftID = id;
                osMessageObject(id, "chosenLeft"); 
            }
            if (weightRight > 0 && weightLeft > 0) {
                if (weightRight > weightLeft) {
                    llSetText(curText + "\n" + nameLeft + " < " + nameRight, <1.0, 1.0, 1.0>, 1);
                    llSay(0, "La boule de droite est plus lourde.");
                } else if (weightRight < weightLeft) {
                    llSetText(curText + "\n" + nameLeft + " > " + nameRight, <1.0, 1.0, 1.0>, 1);
                    llSay(0, "La boule de gauche est plus lourde.");
                } else {
                    llSetText(curText + "\n" + nameLeft + " = " + nameRight, <1.0, 1.0, 1.0>, 1);
                    llSay(0, "Les deux boules ont le même poids.");
                }
            }
        }
    }
    
    touch_start(integer e) {
        llSay(0, "Clique sur les boules pour les peser.");
    }
}
