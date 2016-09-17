<!DOCTYPE html>
<html>
<head>
  <?php
  require_once "../class/config.php";	
  require_once "TableReports.php";
  $db->openConn();
  ?>
  <meta charset="utf-8">
  <title>Reports</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <LINK href="../style/reports.css" rel="stylesheet" type="text/css">
   <script src="../js/Reports.js"></script>
 </head>
 <body>
  <div class="container">
    <div id="nav-bar">
      <nav class="navbar navbar-inverse">
        <div class="container-fluid">

          <ul class="nav navbar-nav">
            <li><a href="HomeManager.php">Home</a></li>
            <li class="active"><a href="Reports.php">Reports</a></li>
            <li><a href="History.php">History</a></li>
            <li><a href="AddUser.php">Add User</a></li>
            <li><a href="UserManagement.php">User Managment</a></li>
            <li><a href="DeliveryManagment.php">Delivery Managment</a></li>
            <li><a href="login.php">Exit</a></li>
          </ul>
        </div>
      </nav>
      <div id="title">Reports</div>
      

      <div class="Menu" align="center">
       <div class="reportstyle"><br>
        <p> <u> Please select the report you want to view </u></p>
        <div class="ReportsLinks">
         <button type="button" class="ReportButton" onclick="reportBtn('1')"> Sweeping Courier report</button><br>
         <button type="button" class="ReportButton" onclick="reportBtn('2')">Daily report Deliveries</button><br>
         <button type="button" class="ReportButton" onclick="reportBtn('3')">detailed Courier report </button><br>
         <button type="button" class="ReportButton" onclick="reportBtn('4')">Detailed customer report</button><br>
         <button type="button" class="ReportButton" onclick="reportBtn('5')">Shift attendance report</button><br>
       </div>
     </div>


   </div>


   <div class="report">

    <?php
    switch(intval($_REQUEST["name"])){
      case 1:
      echo TableReports:: caseCouriers($db); 
      break;
      case 2:
      echo TableReports:: caseDelivery($db);
      break;
      case 3:
      echo TableReports:: caseCourier($db);
      break;
      case 4:
      echo TableReports:: caseCustomerReports($db);
      break;
      case 5:
      echo TableReports:: caseShiftCouriers($db);
      break;
      case 6:
      echo TableReports:: caseCourierSelected($db,$id);
      break;
      case 7:
      echo TableReports:: caseCustomerSelected($db,$id);
      break;
    }
    ?>
  </div>
</body>  
<?php
$db->closeConn();
?>      
</html>