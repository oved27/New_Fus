<?php

class TableDeliveyrManagment {
	static function caseCustomer(db $db,$id) {
        $html = <<<HTML
<div>
    <table class="dataDeliveryTitle">
        <tr>
            <td>Customer first name</td>
            <td>Customer last name</td>
			<td>Courier first name</td>
            <td>Courier last name</td>
			<td>Delivery ID</td>
			<td>Assign Time</td>
			<td>Pickup Time</td>
			<td>DropDown Time</td>
			<td>Active</td>
			
        </tr>
    </table>
</div>
HTML;
	return $html.blDeliveryManagment::getHtmlSelectedCustomer($db,$id); 
        
    }
		static function caseCourier(db $db,$id) {
        $html = <<<HTML
<div>
    <table class="dataDeliveryTitle">
        <tr>
			<td>Customer first name</td>
            <td>Customer last name</td>
            <td>Courier first name</td>
            <td>Courier last name</td>
			<td>Delivery ID</td>
			<td>Assign Time</td>
			<td>Pickup Time</td>
			<td>DropDown Time</td>
			<td>Active</td>
			
        </tr>
    </table>
</div>
HTML;
	return $html.blDeliveryManagment::getHtmlSelectedCourier($db,$id); 
        
    }
	
	static function caseCouriersDelivery(db $db,$id) {
        $html = <<<HTML
		<div>
			<table class="dataDeliveryTitle">
			<tr>
				<td>Delivery details</td>
				<td>Options</td>
			</tr>
			</table>
		</div>
HTML;
	$id=intval($_REQUEST["id"]);
		return $html.blDeliveryManagment::getHtmlCouriersDelivery($db,$id); 
        
    }
	
	static function updateStatusTime(db $db,$id,$opt) {
        $html = <<<HTML
		
HTML;
	$id=intval($_REQUEST["id"]);
		return $html.blDeliveryManagment::updateHtmlStatusTime($db,$id,$opt); 
        
    }

	static function checkIfTimeExist(db $db,$id,$opt) {
        $html = <<<HTML
		
HTML;
	$id=intval($_REQUEST["id"]);
		return $html.blDeliveryManagment::checkHtmlIfTimeExist($db,$id,$opt); 
        
    }
	
		
	
	   static function caseChangeCourier(db $db, $id) {
        $html = <<<HTML
<div>
    <table class="dataDeliveryTitle">
        <tr>
          <td>Courier first name</td>
            <td>Courier last name</td>
            <td>Courier ID</td>
        </tr>
    </table>
</div>
HTML;
$id=intval($_REQUEST["id"]);
$id2=intval($_REQUEST["id2"]);
        return $html.blDeliveryManagment::getHtmlChangeCourier($db, $id); 
    }

			
	static function caseNewCourier(db $db,$id,$id2) {
        $html = <<<HTML
		
HTML;
	$id=intval($_REQUEST["id"]);
		$id2=intval($_REQUEST["id2"]);
		return $html.blDeliveryManagment::updateHtmlNewCourier($db,$id,$id2); 
        
    }
	
	
	static function caseDeliverIsCancel(db $db,$id) {
        $html = <<<HTML
		
HTML;
	$id=intval($_REQUEST["id"]);
$id2=intval($_REQUEST["id2"]);
		return $html.blDeliveryManagment::updateHtmlDeliverIsCancel($db,$id); 
        
    }
	
}

?>