<?php

class dalLogin {

    public static function checkUserAndPassword(db $db,$name,$password) {
        $query = "call Check_username_password('".$name."','".$password."')";
        //$query = "call Check_username_password(aaa,22)";
        return $db->selectQeury($query);
    }
}
