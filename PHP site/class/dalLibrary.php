<?php
class dalLibrary{
	public static function CheckLinks(db $db,$UserName, $Password) {
        $query = "call Display_User('".$UserName."','".$Password."')";
        return $db->selectQeury($query);
    }
}
?>