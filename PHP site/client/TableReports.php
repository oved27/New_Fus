<?php

class TableReports {

    static function caseCouriers($db) {
        $html = <<<HTML
<div>
    <table class="dataReportTitle">
        <tr>
            <td>Courier first name</td>
            <td>Courier last name</td>
            <td>Courier ID</td>
            <td>Courier phone</td>
			<td>Courier address</td>
            
        </tr>
    </table>
</div>
HTML;
        return $html.blReports::getHtmlAllCouriersReports($db);
    }

	    static function caseDelivery($db) {
        $html = <<<HTML
<div>
    <table class="dataReportTitle">
        <tr>
           <td>Deliver id</td>
        <td>Customer First name</td>
		<td>Customer Last name</td>
		<td>Date</td>
        <td>Pickup Address</td>
        <td>Drop Address</td>
        <td>Courier ID </td>
        </tr>
    </table>
</div>
HTML;
        return $html.blReports::getHtmlDeliverysReports($db); 
    }
		   static function caseCourier($db) {
        $html = <<<HTML
<div>
    <table class="dataReportTitle">
        <tr>
          <td>Courier first name</td>
            <td>Courier last name</td>
            <td>Courier ID</td>
        </tr>
    </table>
</div>
HTML;
        return $html.blReports::getHtmlAllCouriers($db); 
    }
	
	 static function caseCourierSelected($db, $id) {
        $html = <<<HTML
<div>
    <table class="dataReportTitle">
        <tr>
          <td>Date</td>
            <td>Delivery ID</td>
            <td>Pickup Address</td>
			<td>Pickup Time</td>
			<td>DropDown Address</td>
			<td>DropDown Time</td>
			<td>Customer first name</td>
        </tr>
    </table>
</div>
HTML;
$id=intval($_REQUEST["id"]);
	return $html.blReports::getHtmlSelectedCouriers($db, $id); 
        
    }
	
	static function caseCustomerReports($db) {
        $html = <<<HTML
<div>
    <table class="dataReportTitle">
        <tr>
          <td>Customer first name</td>
            <td>Customer last name</td>
            <td>Customer ID</td>
        </tr>
    </table>
</div>
HTML;
        return $html.blReports::getHtmlAllCustomers($db); 
    }

		 static function caseCustomerSelected($db, $id) {
        $html = <<<HTML
<div>
    <table class="dataReportTitle">
        <tr>
          <td>Date</td>
            <td>Customer first name</td>
            <td>Customer last name</td>
			<td>Delivery ID</td>
			<td>Pickup Address</td>
			<td>DropDown Address</td>
        </tr>
    </table>
</div>
HTML;
$id=intval($_REQUEST["id"]);
	return $html.blReports::getHtmlSelectedCustomer($db,$id); 
        
    }
	
		static function caseShiftCouriers($db) {
        $html = <<<HTML
<div>
    <table class="dataReportTitle">
        <tr>
          <td>Courier first name</td>
		  <td>Courier last name</td>
		  <td>Delivery ID</td>
		  <td>Pickup Address</td>
		  <td>Drop Address</td>
		  <td>Assign delivery</td>
		  <td>Pickup delivery</td>
		  <td>Drop delivery</td>
		  <td>Scooter license</td>
		  <td>Assign Scooter</td>
		  <td>Drop Scooter</td>
			
        </tr>
    </table>
</div>
HTML;
        return $html.blReports::getHtmlShiftCouriers($db); 
    }
	
}
