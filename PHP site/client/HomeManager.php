	<?php
	session_start();
		require_once "../class/config.php";
		$db->openConn();
		$res=dalLogin::checkUserAndPassword($db,$_SESSION["UserName"], $_SESSION["Password"]);
		
    if(!count($res))
    {
    	 header('Location:login.php');
    	//$db->printf($_SESSION);
        //echo $_SESSION["UserName"];
        //echo $_SESSION["Password"];
        exit();
    }

		?>
	<html>
	<head >
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
		<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDQ7ujRhOjh1vy5oI0QdJEUlsl912I3sDw&callback=initMap"
		type="text/javascript"></script>
		<title>Home Manager</title>

	</head>
	<LINK href="../style/HomeManager.css" rel="stylesheet" type="text/css">
		<meta charset="utf-8">
		<script type="text/javascript" src="../js/map.js"></script>
		<body>
			<div class="container">
				<div id="nav-bar">
					<nav class="navbar navbar-inverse">
						<div class="container-fluid">

							<ul class="nav navbar-nav">
								<li class="active"><a href="HomeManager.php">Home</a></li>
								<li><a href="Reports.php">Reports</a></li>
								<li><a href="History.php">History</a></li>
								<?php
								echo libraryHtml::navBar($db,$_SESSION["UserName"], $_SESSION["Password"]);
								?>
								<li><a href="login.php?destroy=<?php echo session_id();?>">Exit</a></li>
							</ul>
						</div>
					</nav>


					<div class="Menu" align="center">

						<div class="delivers">
							<div class="titleHeader">Courier shift</div>
							<div class="inputBox">
								<?php
								echo blHomePage::getHtmlUserCouriers($db); 

								?>
							</div>
						</div>
						<div class="Adelivery">
							<div class="titleHeader">Active Delivery</div>
							<div class="inputBox">
								<?php
								echo blHomePage::getHtmlActiveDelivery($db); 
					//$db->printf($res);
								?>   
							</div>
						</div>
						<div class="Wdelivery">
							<div class="titleHeader">Pending Delivery</div>
							<div class="inputBox">
								<?php
								echo blHomePage::getHtmlStandByDelivery($db); 

								?>
							</div>
						</div>
						<div class="NewUpdate">
							<div class="redTitle">Live Updates</div>
							<div><marquee direction="up" scrollamount="2">
								<?php
								echo blHomePage::getHtmlNewsAssign($db); 
								echo blHomePage::getHtmlNewsDrop($db);
								echo blHomePage::getHtmlNewsPickup($db);		
								?>
							</marquee></div>
						</div>

					</div>



					<div class="Map">
						<div class="Top" id="googleMap"> 
						</div>
						<div class="Bottom">
							<div class="searchByCostumer">
								<div class="titleHeader">Finding delivery by customer</div><span class="inputspan">Enter a customer<span>
								<div class=searchBox><input type="text" id=""></div>
							</div>
							<div class="searchByDeliver">
								<div class="titleHeader">Finding delivery by courier</div><span class="inputspan">Enter a courier<span>
								<div class=searchBox><input type="text" id=""></div>
							</div>
						</div>
					</div>
				</div> 
			</div> 
		</body>  
		</html>
		<?php
		$db->closeConn();
		?>      