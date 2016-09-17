
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="../js/ReportPaging.js"></script>
<link rel="stylesheet" type="text/css" href="../style/Paging.css">
<?php
class blReports{

    public static function getHtmlDeliverysReports(db $db) {
        $array = array();
        $html = "";
        try {
            $array = dalReports::getDeliverysReports($db); 
			 $html .= "<table class='dataReport'> ";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->DeliveryID ."</td><td>". $value->FName ."</td><td>". $value->Lname ."</td><td>".  $value->Date ."</td><td>".  $value->PickupAddress."</td><td>". $value->DropDownAddress ."</td><td>". $value->CourierID ."</td></tr>";
            }
			 $html .="</table></br>"; 
              $html .="<div id='pagination'></div>";   
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
    
	
       public static function getHtmlAllCouriersReports(db $db) {
        $array = array();
        $html = "";
        try {
            $array = dalReports::getAllCouriersReports($db);
			 $html .= "<table class='dataReport'> ";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->FName ."</td><td>". $value->Lname ."</td><td>". $value->CourierID ."</td><td>".  $value->Phone ."</td><td>".  $value->Address."</td></tr>";
            }
			 $html .="</table></br>";
              $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
     
	    public static function getHtmlAllCouriers(db $db) {
        $array = array();
        $html = "";
        try {
            $array = dalReports::getAllCouriersReports($db);
			 $html .= "<table class='dataReport'> ";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->FName ."</td><td>". $value->Lname ."</td><td><a href='reports.php?name=6&id=".$value->CourierID."'>".$value->CourierID."</a></td></tr>";
            }
			 $html .="</table></br>";
              $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
	
		public static function getHtmlSelectedCouriers(db $db, $id ) {
        $array = array();
        $html = "";
		$totalDeliveries=0;
        try {
            $array = dalReports::getSelectedCouriersReports($db, $id);
			 $html .= "<table class='dataReport'> ";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->Date ."</td><td>". $value->DeliveryID ."</td><td>".$value->PickupAddress."</td><td>".$value->DropDownAddress."</td><td>".$value->PickupTime."</td><td>".$value->DropDownTime."</td><td>".$value->FName."</td></tr>";
				$totalDeliveries++;
            }
			 $html .="</table></br>";
			  $html .="<b>"."The total deliveries for ". $value->CourierName." is: ".$totalDeliveries."</b>";
               $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
	
		public static function getHtmlAllCustomers(db $db ) {
        $array = array();
        $html = "";
        try {
            $array = dalReports::getAllCustomerReports($db, $id);
			 $html .= "<table class='dataReport'> ";
            foreach ($array as $value) {
				
                $html .= "<tr><td>". $value->FName ."</td><td>". $value->Lname ."</td><td><a href='reports.php?name=7&id=".$value->CustomerID."'>".$value->CustomerID."</a></td></tr>";
            }
			 $html .="</table></br>";
              $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }

			public static function getHtmlSelectedCustomer(db $db, $id ) {
        $array = array();
        $html = "";
		$totalDeliveries=0;
        try {
            $array = dalReports::getSelectedCustomerReports($db, $id);
			 $html .= "<table class='dataReport'> ";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->Date ."</td><td>". $value->FName ."</td><td>".$value->Lname."</td><td>".$value->DeliveryID."</td><td>".$value->PickupAddress."</td><td>".$value->DropDownAddress."</td></tr>";
				$totalDeliveries++;
            }
			 $html .="</table></br>";
			  $html .="<b>"."The total delivery for ". $value->FName." is: ".$totalDeliveries."</b>";
               $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
	
	public static function getHtmlShiftCouriers(db $db ) {
        $array = array();
        $html = "";
        try {
            $array = dalReports::getAllShiftCouriersReports($db);
			 $html .= "<table id='ShiftReport' class='dataReport'> ";
            foreach ($array as $value) {
				
                $html .= "<tr><td>". $value->FName ."</td><td>". $value->Lname ."</td><td>".$value->DeliveryID."</td><td>".$value->PickupAddress."</td><td>".$value->DropDownAddress."</td><td>".$value->AssignDelivery."</td><td>".$value->PickupDelivery."</td><td>".$value->DropDelivery."</td><td>".$value->ScooterLicense."</td><td>".$value->AssignScooter."</td><td>".$value->DropScooter."</td></tr>";

            }
			 $html .="</table></br>";
              $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
	
}
?>