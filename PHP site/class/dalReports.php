
<?php

class dalReports {

    public static function getDeliverysReports(db $db) {
        $query = "call Display_All_Delivery()";
        return $db->selectQeury($query);
    }

	    public static function getAllCouriersReports(db $db) {
        $query = "call Display_All_Couriers()";
        return $db->selectQeury($query);
    }
	  public static function getSelectedCouriersReports(db $db, $id) {
        $query = "call DisplaySpecificCourier('".$id."')";
        return $db->selectQeury($query);
    }

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
	
}
?>