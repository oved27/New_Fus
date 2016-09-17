<?php

class TableHistory {
	   static function caseOrderdToday($db) {
        $html = <<<HTML
<div>
    <table class="dataHistoryTitle">
        <tr>
            <td>Delivery ID</td>
            <td>Customer first name</td>
            <td>Customer last name</td>
            <td>Pickup address</td>
			<td>DropDown address</td>
			<td>Customer phone</td>
            
        </tr>
    </table>
</div>
HTML;
        return $html.blHistory::getHtmlOrderedToday($db);
    }
		   static function caseDeliveryEOD($db) {
        $html = <<<HTML
<div>
    <table class="dataHistoryTitle">
        <tr>
            <td>Delivery ID</td>
            <td>Customer first name</td>
            <td>Customer last name</td>
            <td>Assign time</td>
			<td>Pickup time</td>
			<td>DropDown time</td>
            
        </tr>
    </table>
</div>
HTML;
        return $html.blHistory::getHtmlDeliveryEOD($db);
    }
	
			   static function caseActiveDelivery($db) {
        $html = <<<HTML
<div>
    <table class="dataHistoryTitle">
        <tr>
            <td>Delivery ID</td>
            <td>Pickup address</td>
            <td>Dropdown address</td>
            <td>Courier first name</td>
			<td>Courier last name</td>
        </tr>
    </table>
</div>
HTML;
        return $html.blHistory::getHtmlActiveDelivery($db);
    }
	
	static function caseNonActiveDelivery($db) {
        $html = <<<HTML
<div>
    <table class="dataHistoryTitle">
        <tr>
            <td>Delivery ID</td>
            <td>Pickup address</td>
            <td>Dropdown address</td>
            <td>Courier first name</td>
			<td>Courier last name</td>
        </tr>
    </table>
</div>
HTML;
        return $html.blHistory::getHtmlNonActiveDelivery($db);
    }
	
	
		static function caseDeliveryCancel($db) {
        $html = <<<HTML
<div>
    <table class="dataHistoryTitle">
        <tr>
            <td>Delivery ID</td>
			<td>Courier first name</td>
			<td>Courier last name</td>
            <td>Pickup address</td>
            <td>Customer's phone</td>
			<td>Cancel time</td>
				
            
        </tr>
    </table>
</div>
HTML;
        return $html.blHistory::getHtmlDeliveryCancel($db);
    }
	
	
}
?>