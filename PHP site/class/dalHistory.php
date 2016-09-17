
<?php

class dalHistory {

    public static function getOrderedToday(db $db) {
        $query = "call Dispaly_Today_Deliveries()";
        return $db->selectQeury($query);
    }

	    public static function getDeliveryEOD(db $db) {
        $query = "call Display_EOD_Delivery()";
        return $db->selectQeury($query);
    }
	
	  public static function getActiveDelivery(db $db ){
        $query = "call Display_Delivery_Status(1)";
        return $db->selectQeury($query);
    }
	
	 public static function getNonActiveDelivery(db $db ){
        $query = "call Display_Delivery_Status(0)";
        return $db->selectQeury($query);
    }
	
	 public static function getDeliveryCancel(db $db ){
        $query = "call Display_Cancel_Delivery()";
        return $db->selectQeury($query);
    }
	
	
	/*

	 public static function getAllCustomerReports(db $db) {
        $query = "call Display_All_Customers()";
        return $db->selectQeury($query);
    }
	
		  public static function getSelectedCustomerReports(db $db, $id) {
        $query = "call Display_Customer_Delivery('".$id."')";
        return $db->selectQeury($query);
    }
	
	  public static function TotalCustomerDelivery(db $db, $id) {
        $query = "call Display_Total_Customer_Deliveries('".$id."')";
        return $db->selectQeury($query);
    }
	
		  public static function getAllShiftCouriersReports(db $db) {
        $query = "call Display_Shift_Couriers()";
        return $db->selectQeury($query);
    }
	*/
}
?>