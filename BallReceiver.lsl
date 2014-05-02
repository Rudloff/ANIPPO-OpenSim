integer weightLeft = 0;
integer weightRight = 0;
key leftID; key rightID;
default
{
    link_message(integer sender_num, integer weight, string msg, key id)
    {
        if (rightID == id) {
            weightRight = 0;
            rightID = NULL_KEY;
            llMessageLinked(LINK_ALL_CHILDREN, weight, "unchosen", id); 
        } else if (leftID == id) {
            weightLeft = 0;
            leftID = NULL_KEY;
            llMessageLinked(LINK_ALL_CHILDREN, weight, "unchosen", id); 
        } else if (weightRight == 0) {
            weightRight = weight; 
            rightID = id;
            llMessageLinked(LINK_ALL_CHILDREN, weight, "chosenRight", id);  
        } else if (weightLeft == 0) {
            weightLeft = weight; 
            leftID = id;
            llMessageLinked(LINK_ALL_CHILDREN, weight, "chosenLeft", id);
        }
        if (weightRight > 0 && weightLeft > 0) {
            if (weightRight > weightLeft) {
                llSay(0, "La boule de droite est plus lourde.");
            } else if (weightRight < weightLeft) {
                llSay(0, "La boule de gauche est plus lourde.");
            } else {
                llSay(0, "Les deux boules ont le même poids.");
            }
        }
    }
}
