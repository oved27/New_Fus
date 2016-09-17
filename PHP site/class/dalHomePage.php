<?php

class dalHomePage {

    public static function getUserCouriers(db $db) {
        $query = "call Display_All_Active_Couriers()";
        return $db->selectQeury($query);
    }

    public static function getActiveDelivery(db $db) {
        $query = "call Display_Delivery_Status(1)";
        return $db->selectQeury($query);
    }
        public static function getStandByDelivery(db $db) {
        $query = "call Display_Delivery_Status(0)";
        return $db->selectQeury($query);
    }
        public static function getNewsUpdateAssign(db $db) {
        $query = "CALL `Display_Assign_Last_Hour`()";
        return $db->selectQeury($query);
    }
         public static function getNewsUpdateDrop(db $db) {
        $query = "call Display_Drop_Last_Hour()";
        return $db->selectQeury($query);
    }
            public static function getNewsUpdatePickup(db $db) {
        $query = "call Display_Pickup_Last_Hour()";
        return $db->selectQeury($query);
    }
}
