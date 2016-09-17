
<html>
<head>
	<?php
	require_once "../class/config.php";	
	require_once "TableDeliveyrManagment.php";
	require_once "../class/dalDeliveryManagment.php";
	

	
	$db->openConn();
	?>
	<meta charset="utf-8">
	<title>Delivery Managment</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script> 
	
	<LINK href="../style/DeliveryManagment.css" rel="stylesheet" type="text/css">
		<script src="../js/DeliveryManagment.js"></script>
	</head>





	<body>
		<div class="container">
			<div id="nav-bar">
				<nav class="navbar navbar-inverse">
					<div class="container-fluid">

						<ul class="nav navbar-nav">
							<li><a href="HomeManager.php">Home</a></li>
							<li><a href="Reports.php">Reports</a></li>
							<li><a href="History.php">History</a></li>
							<li><a href="AddUser.php">Add User</a></li>
							<li><a href="UserManagement.php">User Managment</a></li>
							<li class="active"><a href="DeliveryManagment.php">Delivery Managment</a></li>
							<li><a href="login.php">Exit</a></li>
						</ul>
					</div>
				</nav>
			</div>
			<div id="title">Delivery Managment</div>
			<div id="container">

				

				<div class="menu" >
					<div class="DeliveryManagmentstyle">
						<div class="SearchByCustomer">
							Finding delivery according to customer
						</div><br> 
						<div>
							<form action="DeliveryManagment.php" method="GET">
								customer: <input type="text" name="SearchByCustomerText"  id="val1"/>
								<input class="buttonStatus" type = "submit" name="submit1" value="send"/>
							</form>

						</div>
						<div class="SearchByCourier">
							Finding delivery according to courier
						</div><br>
						<div>
							<form action="DeliveryManagment.php" method="GET">
								courier: <input type="text" name="SearchByCourierText" id="val2" />
								<input class="buttonStatus" type = "submit" name="submit2" value="send"/>
								
							</form>
						</div>
					</div>
				</div>



				<div class="DisplayDelivery">
					<div id="DeliveryContent">
						
						<?php
						$varID;

						if( isset($_GET['submit1']) ){
							$customerID = htmlentities($_GET['SearchByCustomerText']);
							$varID=$customerID;
							if(isset($customerID)){
								
								echo TableDeliveyrManagment:: caseCustomer($db, $customerID); 
								
							}
						}
	//echo ($_GET['val1']);
						
						if( isset($_GET['submit2']) ){
							
							$courier = htmlentities($_GET['SearchByCourierText']);

							
							if(isset($courier)){
								echo TableDeliveyrManagment:: caseCourier($db, $courier); 
								
							}
						}

						switch($_REQUEST["name"]){
							case "1":
							echo TableDeliveyrManagment:: caseCouriersDelivery($db,$id); 
							break;

							case 2:
							$opt=0;
							$ans=TableDeliveyrManagment::checkIfTimeExist($db,$id,$opt);
							if($ans==0){
								
								TableDeliveyrManagment::updateStatusTime($db,$id,$opt);
								echo TableDeliveyrManagment:: caseCouriersDelivery($db,$id);
							}
							else{
								
								echo TableDeliveyrManagment:: caseCouriersDelivery($db,$id);
							} 
							break;

							case 3:
							$opt=1;
							
							$ans=TableDeliveyrManagment::checkIfTimeExist($db,$id,$opt);
							if($ans==0){
								TableDeliveyrManagment::updateStatusTime($db,$id,$opt);
								echo TableDeliveyrManagment:: caseCouriersDelivery($db,$id);
							}
							else{
								echo TableDeliveyrManagment:: caseCouriersDelivery($db,$id);
							} 
							
							break;
							case 4:
							$opt=2;
							$ans=TableDeliveyrManagment::checkIfTimeExist($db,$id,$opt);
							if($ans==0){
								TableDeliveyrManagment::updateStatusTime($db,$id,$opt);
								echo TableDeliveyrManagment:: caseCouriersDelivery($db,$id);
							}
							else{
								echo TableDeliveyrManagment:: caseCouriersDelivery($db,$id);
							} 
							
							break;
							case 5:
							
							$var1=($_REQUEST['id']);
							TableDeliveyrManagment:: caseDeliverIsCancel($db,$id);
							
		//echo TableDeliveyrManagment::caseCourier($db,$var1);
							echo "delivery ".$var1." was cancel";
							break;
							case 6:
							echo TableDeliveyrManagment:: caseChangeCourier($db,$id);
							break;
							case 7:
							TableDeliveyrManagment:: caseNewCourier($db, $id, $id2);
							echo TableDeliveyrManagment::caseCouriersDelivery($db,$id);
							break;
							
						}
//case "Delivery":
						
						



						?>
					</div>
				</div>
			</div>
		</div>
	</body>  
	<?php
	$db->closeConn();
	?>     
	</html>