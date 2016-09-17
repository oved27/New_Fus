
<?php

class dalDeliveryManagment {

   		  public static function getSelectedCustomer(db $db, $id) {
		$query = "call Display_Customer_Delivery('".$id."')";
        return $db->selectQeury($query);
    }
	
	   		  public static function getSelectedCourier(db $db, $id) {
		$query = "call DisplaySpecificCourier('".$id."')";
        return $db->selectQeury($query);
    }
		public static function getCouriersDelivery(db $db, $id) {
			$query = "call Display_Delivery_By_Courier('".$id."')";
        return $db->selectQeury($query);
    }
	
			public static function updateStatusTime(db $db, $id, $opt) {
				
			$query = "call Update_All_Time('".$id."','".$opt."')";
			echo $db->updateQeury($query);
		return;
    }
	
		public static function checkIfTimeExist(db $db, $id,$opt) {
				$query = "check_If_Time_Exist('".$id."','".$opt."')";
        return $db->selectQeury2($query);
    }
	
		public static function getChangeCourier(db $db, $id) {
			$query = "call Display_all_Courier_Beside_This('".$id."')";
        return $db->selectQeury($query);
    }
	
	public static function updateNewCourier(db $db, $id, $id2) {
				
			$query = "call Change_Courier('".$id2."','".$id."')";
			echo $db->updateQeury($query);
		return;
    }
	
		public static function updateDeliverIsCancel(db $db, $id) {
				
			$query = "call Update_Cancel_Delivery('".$id."')";
			echo $db->updateQeury($query);
		return;
    }
}

?>