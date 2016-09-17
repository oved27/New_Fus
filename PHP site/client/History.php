<!DOCTYPE html>
<html>
<head>
  <?php
  require_once "../class/config.php";	
  require_once "TableHistory.php";
  $db->openConn();
  ?>
  <meta charset="utf-8">
  <title>History</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  <LINK href="../style/History.css" rel="stylesheet" type="text/css">
    <script src="../js/History.js"></script>
  </head>
  <body>
   <div class="container">
    <div id="nav-bar">
      <nav class="navbar navbar-inverse">
        <div class="container-fluid">

          <ul class="nav navbar-nav">
            <li><a href="HomeManager.php">Home</a></li>
            <li><a href="Reports.php">Reports</a></li>
            <li class="active"><a href="History.php">History</a></li>
            <li><a href="AddUser.php">Add User</a></li>
            <li><a href="UserManagement.php">User Managment</a></li>
            <li><a href="DeliveryManagment.php">Delivery Managment</a></li>
            <li><a href="login.php">Exit</a></li>
          </ul>
        </div>
      </nav>
      <div class="Title">Delivery History</div>
      

      <div class="Menu" align="center">
       <div class="Historystyle"><br>
        <p> <u> Please select the report you want to view </u></p>
        <div class="HistoryLinks">
         <button type="button" class="HistoryButton" onclick="HistoryBtn('1')"> Orders booked today
         </button><br>
         <button type="button" class="HistoryButton" onclick="HistoryBtn('2')">EOD history
         </button><br>
         <button type="button" class="HistoryButton" onclick="HistoryBtn('3')"> Booking activities
         </button><br>
         <button type="button" class="HistoryButton" onclick="HistoryBtn('4')">Orders inactive
         </button><br>
         <button type="button" class="HistoryButton" onclick="HistoryBtn('5')">Cancelled orders
         </button><br>
       </div>
     </div>


   </div>

   <div class="History">
     <?php
     switch(intval($_REQUEST["name"])){
      case 1:
      
      echo TableHistory:: caseOrderdToday($db); 
      break;
      case 2:
      echo TableHistory:: caseDeliveryEOD($db);
      break;
      case 3:
      echo TableHistory:: caseActiveDelivery($db);
      break;
      case 4:
      echo TableHistory:: caseNonActiveDelivery($db);
      break;
      case 5:
      echo TableHistory:: caseDeliveryCancel($db);
      break;

    }
    ?>
  </div>
</body>  
<?php
$db->closeConn();
?> 

</html>