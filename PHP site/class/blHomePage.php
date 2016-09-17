<?php
class blHomePage {

    public static function getHtmlUserCouriers(db $db) {
        $array = array();
        $html = "";
        try {
            $array = dalHomePage::getUserCouriers($db);
            foreach ($array as $value) {
                $html .= "<span> " . $value->FName . "</span><br/>";
            }
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
    
    
      public static function getHtmlActiveDelivery(db $db) {
        $array = array();
        $html = "";
        try {
            $array = dalHomePage::getActiveDelivery($db);
            foreach ($array as $value) {
                $html .= "<span>" .  $value->PickupAddress." to ".$value->DropDownAddress. " ID: ".$value->DeliveryID."</span><br/>";
                 
            }
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
      public static function getHtmlStandByDelivery(db $db) {
        $array = array();
        $html = "";
        try {
            $array = dalHomePage::getStandByDelivery($db);
            foreach ($array as $value) {
                $html .= "<span>" .  $value->PickupAddress." to ".$value->DropDownAddress. " ID: ".$value->DeliveryID."</span><br/>";
            }
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
      public static function getHtmlNewsAssign(db $db) {
        $array = array();
        $html = "";
        try {
            $array = dalHomePage::getNewsUpdateAssign($db);
            foreach ($array as $value) {
                $html .= "<span>" .  $value->DeliveryID." was assign" ."</span><br/>";
                 
            }
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
        
      }
      
        public static function getHtmlNewsDrop(db $db) {
        $array = array();
        $html = "";
        try {
            $array = dalHomePage::getNewsUpdateDrop($db);
            foreach ($array as $value) {
                $html .= "<span>" .  $value->DeliveryID." was drop" ."</span><br/>";
                 
            }
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
        
      }
    
        public static function getHtmlNewsPickup(db $db) {
        $array = array();
        $html = "";
        try {
            $array = dalHomePage::getNewsUpdatePickup($db);
            foreach ($array as $value) {
                $html .= "<span>" .  $value->DeliveryID." was pickup" ."</span><br/>";
                 
            }
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
        
      }
      
     
}
