
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="../js/HistoryPaging.js"></script>
<link rel="stylesheet" type="text/css" href="../style/Paging.css">
<?php
class blHistory{

    public static function getHtmlOrderedToday(db $db) {
        $array = array();
        $html = "";
		$totalDeliveries=0;
        try {
            $array = dalHistory::getOrderedToday($db); 
			 $html .= "<table class='dataHistory'> ";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->DeliveryID ."</td><td>". $value->FName ."</td><td>". $value->Lname ."</td><td>".  $value->PickupAddress ."</td><td>".  $value->DropDownAddress."</td><td>". $value->Phone."</td></tr>";
				$totalDeliveries++;
            }
			 $html .="</table></br>"; 
			  $html .="<b>"."The total deliveries order today are: ". $totalDeliveries."</b>";
              $html .="<div id='pagination'></div>";   
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
	
     public static function getHtmlDeliveryEOD(db $db) {
        $array = array();
        $html = "";
		$totalDeliveries=0;
        try {
            $array = dalHistory::getDeliveryEOD($db); 
			 $html .= "<table class='dataHistory'> ";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->DeliveryID ."</td><td>". $value->FName ."</td><td>". $value->Lname ."</td><td>".  $value->AssignTime ."</td><td>".  $value->PickupTime."</td><td>". $value->DropDownTime."</td></tr>";
				$totalDeliveries++;
            }
			 $html .="</table></br>"; 
			 $html .="<b>"."The total deliveries that treated today are: ". $totalDeliveries."</b>";
              $html .="<div id='pagination'></div>";   
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
	
	 public static function getHtmlActiveDelivery(db $db) {
        $array = array();
        $html = "";
		$totalDeliveries=0;
        try {
            $array = dalHistory::getActiveDelivery($db); 
			 $html .= "<table class='dataHistory'> ";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->DeliveryID ."</td><td>". $value->PickupAddress ."</td><td>". $value->DropDownAddress ."</td><td>".  $value->FName ."</td><td>".  $value->Lname."</td></tr>";
				$totalDeliveries++;
            }
			 $html .="</table></br>"; 
			  $html .="<b>"."The total active deliveries today are: ". $totalDeliveries."</b>";
              $html .="<div id='pagination'></div>";   
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
	
	 public static function getHtmlNonActiveDelivery(db $db) {
        $array = array();
        $html = "";
		$totalDeliveries=0;
        try {
            $array = dalHistory::getNonActiveDelivery($db); 
			 $html .= "<table class='dataHistory'> ";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->DeliveryID ."</td><td>". $value->PickupAddress ."</td><td>". $value->DropDownAddress ."</td><td>".  $value->FName ."</td><td>".  $value->Lname."</td></tr>";
				$totalDeliveries++;
            }
			 $html .="</table></br>"; 
			 $html .="<b>"."The total non active deliveries for today are: ". $totalDeliveries."</b>";
              $html .="<div id='pagination'></div>";   
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
	
	  public static function getHtmlDeliveryCancel(db $db) {
        $array = array();
        $html = "";
		$totalDeliveries=0;
        try {
            $array = dalHistory::getDeliveryCancel($db); 
			 $html .= "<table class='dataHistory'> ";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->DeliveryID ."</td><td>". $value->FName ."</td><td>". $value->Lname ."</td><td>".  $value->PickupAddress ."</td><td>".$value->Phone ."</td><td>" . $value->CancelTime."</td></tr>";
				$totalDeliveries++;
            }
			 $html .="</table></br>"; 
			 $html .="<b>"."The total deliveries were cancel today are: ". $totalDeliveries."</b>";
              $html .="<div id='pagination'></div>";   
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
	
	
	
	/*
      
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
			  $html .="The total delivery for ". $value->CourierName." is: ".$totalDeliveries;
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
			  $html .="The total delivery for ". $value->FName." is: ".$totalDeliveries;
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
			 $html .= "<table class='dataReport'> ";
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
	*/
}
?>