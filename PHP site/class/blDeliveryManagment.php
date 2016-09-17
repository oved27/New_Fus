
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="../js/DeliveryManagmentPaging.js"></script>
<link rel="stylesheet" type="text/css" href="../style/Paging.css">
<?php
class blDeliveryManagment{
	public static function getHtmlSelectedCustomer(db $db, $id ) {
		
		
        $array = array();
        $html = "";
        try {
            $array = dalDeliveryManagment::getSelectedCustomer($db, $id);
			 $html .= "<table class='dataDelivery'>";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->FName ."</td><td>". $value->Lname ."</td><td>". $value->CourierFName."</td><td>". $value->courierLName."</td><td><a href='DeliveryManagment.php?name=1&id=".$value->DeliveryID."'>".$value->DeliveryID."</td><td>".$value->AssignTime ."</td><td>".  $value->PickupTime."</td><td>". $value->DropDownTime."</td><td>". $value->IsActive."</td></tr>";
            }
			 $html .="</table></br>";
               $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
	}
	
		public static function getHtmlSelectedCourier(db $db, $id ) {
		
		
        $array = array();
        $html = "";
        try {
            $array = dalDeliveryManagment::getSelectedCourier($db, $id);
			 $html .= "<table class='dataDelivery'>";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->FName."</td><td>". $value->Lname."</td><td>". $value->FirstName."</td><td>". $value->LastName ."</td><td><a href='DeliveryManagment.php?name=1&id=".$value->DeliveryID."'>".$value->DeliveryID."</td><td>".$value->
				AssignTime ."</td><td>".$value->PickupTime."</td><td>". $value->DropDownTime."</td><td>". $value->IsActive."</td></tr>";
            }
			 $html .="</table></br>";
               $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
	}
	
		public static function getHtmlCouriersDelivery(db $db, $id ) {
		
		
        $array = array();
        $html = "";
        try {
			
            $array = dalDeliveryManagment::getCouriersDelivery($db, $id);
			 $html .= "<table class='dataDelivery'>";
           foreach ($array as $value) {
			   
                $html .= "<tr>
							<td>"."Courier First name:	". $value->FName."</td><td>"."</td></tr>
						<tr><td>"."Courier Last name:	". $value->Lname ."</td><td>".""."</td></tr>
						<tr><td>"."Customer first name:	". $value->customerFirstName ."</td><td>".""."</td></tr>
						<tr><td>"."Customer Last name:	". $value->customeLastName ."</td><td>".""."</td></tr>
						<tr><td>"."Delivery ID: ".$value->DeliveryID."</td><td>"."<a href='DeliveryManagment.php?name=6&id=".$value->DeliveryID."'/>"."Change courier"."</td></tr>
						<tr><td>"."Assign Time: ".$value->AssignTime."</td><td>"."<a href='DeliveryManagment.php?name=2&id=".$value->DeliveryID."'/>"."Update"."</td></tr>
						<tr><td>"."PickupTime: 	".$value->PickupTime."</td><td>"."<a href='DeliveryManagment.php?name=3&id=".$value->DeliveryID."'/>"."Update"."</td></tr>
						<tr><td>"."DropDownTime:". $value->DropDownTime."</td><td>"."<a href='DeliveryManagment.php?name=4&id=".$value->DeliveryID."'/>"."Update"."</td></tr>
						<tr><td>"."IsActive:	". $value->IsActive."</td><td>"."<a href='DeliveryManagment.php?name=5&id=".$value->DeliveryID."'/>"."Update"."</td></tr>";
           }
			 $html .="</table></br>";
             //  $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
	}
	
		public static function UpdateHtmlcaseAssignTime(db $db, $id ) {
       $array = array();
        $html = "";
        try {
			
            $array = dalDeliveryManagment::updateAssignTime($db, $id);
			 $html .= "<table class='dataDelivery'>";
           foreach ($array as $value) {
			   
                $html .= "<tr>
							<td>"."First name:	". $value->FName."</td><td>"."</td></tr>
						<tr><td>"."Last name:	". $value->Lname ."</td><td>".""."</td></tr>
						<tr><td>"."Delivery ID: ".$value->DeliveryID."</td><td>".""."</td></tr>
						<tr><td>"."Assign Time: ".$value->AssignTime."</td><td>"."<a href='DeliveryManagment.php?name=2&id=".$value->DeliveryID."'/>"."Update"."</td></tr>
						<tr><td>"."PickupTime: 	".$value->PickupTime."</td><td>"."<a href='DeliveryManagment.php?name=3&id=".$value->DeliveryID."'/>"."Update"."</td></tr>
						<tr><td>"."DropDownTime:". $value->DropDownTime."</td><td>"."<a href='DeliveryManagment.php?name=4&id=".$value->DeliveryID."'/>"."Update"."</td></tr>
						<tr><td>"."IsActive:	". $value->IsActive."</td><td>"."<a href='DeliveryManagment.php?name=5&id=".$value->DeliveryID."'/>"."Update"."</td></tr>";
           }
			 $html .="</table></br>";
             //  $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
	}
	
	public static function updateHtmlStatusTime(db $db, $id, $opt ) {
		
		
       // $UpdateAnswer =0;
        $html = "";
        try {
			
            $html .= dalDeliveryManagment::updateStatusTime($db, $id,$opt);

             //  $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
	}
	
	public static function checkHtmlIfTimeExist(db $db, $id,$opt) {
		
		
    //    $UpdateAnswer =0;
        $html = "";
        try {
			
            $html = dalDeliveryManagment::checkIfTimeExist($db, $id,$opt);
	//	$html.=$UpdateAnswer;
             //  $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
	}
	

    public static function getHtmlChangeCourier(db $db, $id) {
        $array = array();
        $html = "";
        try {
            $array = dalDeliveryManagment::getChangeCourier($db, $id);
			 $html .= "<table class='dataDelivery'> ";
            foreach ($array as $value) {
                $html .= "<tr><td>". $value->FName ."</td><td>". $value->Lname ."</td><td><a href='DeliveryManagment.php?name=7&id=".$value->CourierID."&id2=".$id."'>".$value->CourierID."</a></td></tr>";
            }
			 $html .="</table></br>";
              $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
    }
	
	
		public static function updateHtmlNewCourier(db $db, $id, $id2 ) {
		
		
       // $UpdateAnswer =0;
        $html = "";
        try {
			
            $html .= dalDeliveryManagment::updateNewCourier($db, $id,$id2);

             //  $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
	}
	
			public static function updateHtmlDeliverIsCancel(db $db, $id ) {
		
		
       // $UpdateAnswer =0;
        $html = "";
        try {
			
            $html .= dalDeliveryManagment::updateDeliverIsCancel($db, $id);

             //  $html .="<div id='pagination'></div>";  
        } catch (Exception $e) {
            return $e->getMessage();
        }
        return $html;
	}
	
}
?>