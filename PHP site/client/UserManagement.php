<!DOCTYPE html>
<html>
<head>
<?php
error_reporting(E_ALL & ~E_NOTICE);
	require_once "../class/config.php";
	require_once "../class/dalUserManagement.php";	
	
	$db->openConn();
	?>
  <meta charset="utf-8">
  <title>User Management</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  	

  <LINK href="../style/UserManagment.css" rel="stylesheet" type="text/css">
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
            <li class="active"><a href="UserManagement.php">User Managment</a></li>
            <li><a href="DeliveryManagment.php">Delivery Managment</a></li>
            <li><a href="login.php">Exit</a></li>
          </ul>
        </div>
      </nav>
	  			<?php
				$FirstNameErr = $LastNameErr = $PhoneErr = $AddressErr = $UserNameErr = $roleErr = $UserPasswordErr = "";
				$FirstName = $LastName = $UserName = $Phone = $Address =  $role= $UserPassword ="";
				if ($_SERVER["REQUEST_METHOD"] == "POST") {
					if (empty($_POST["FirstName"])) {
						$FirstNameErr = "First Name is required";
					} else {
						$FirstName = test_input($_POST["FirstName"]);
					}
					
					if (empty($_POST["LastName"])) {
						$LastNameErr = "Last Name is required";
					} else {
						$LastName = test_input($_POST["LastName"]);
					}
						
					if (empty($_POST["UserName"])) {
						$UserNameErr = "UserName is required";
					} else {
						$UserName = test_input($_POST["UserName"]);
					}
					
					if (empty($_POST["Phone"])) {
						$PhoneErr = "Phone is required";
					} else {
						$Phone = test_input($_POST["Phone"]);
					}
					
					if (empty($_POST["Address"])) {
						$AddressErr = "Address is required";
					} else {
						$Address = test_input($_POST["Address"]);
					}
					if (empty($_POST["role"])) {
						$roleErr = "role is required";
					} else {
						$role = test_input($_POST["role"]);
					}
					if (empty($_POST["UserPassword"])) {
						$UserPasswordErr = "User Password is required";
					} else {
						if (empty($_POST["ConfirmPassword"])) {
						$UserPasswordErr = "User Password is required";
					} else {
						
						$ConfirmPassword = test_input($_POST["ConfirmPassword"]);
						$UserPassword = test_input($_POST["UserPassword"]);
						if(strcasecmp($UserPassword , $ConfirmPassword ) != 0)
						{
							$UserPasswordErr = "Password is not match";
						}
					}
						
					}

					}
					function test_input($data) {
						$data = trim($data);
						$data = stripslashes($data);
						$data = htmlspecialchars($data);
						return $data;
					}	
					$input=dalUserManagement ::InsertNewUser($db, $UserName, $UserPassword,  $FirstName, $LastName, $Address, $Phone, $role);
					

?>
      <div id="title">User Management</div>
      <div class="UserManagement">

       <div class="AddUserManagement">
		<p><span class="error">* required field.</span></p>
         <form accept-charset="UTF-8" role="form" method="POST" action="<?php echo  htmlspecialchars($_SERVER["PHP_SELF"]);?>">
          <fieldset>
            <span><u>Insert full name:</u></span>
            <div class="form-group" id="FirstName">
              <input class="form-control" placeholder="First Name" name="FirstName" type="text"><span class="error">* <?php echo $FirstNameErr;?></span>
            </div>
			 <div class="form-group" id="LastName">
              <input class="form-control" placeholder="Last Name" name="LastName" type="text"><span class="error">* <?php echo $LastNameErr ;?></span>
            </div>

            <span><u>Insert new details:</u></span>
            <div class="form-group">
              <input class="form-control" placeholder="User Name" name="UserName" type="text"><span class="error">* <?php echo $UserNameErr  ;?></span>
            </div>
            <div class="form-group">
              <input class="form-control" placeholder="Password" name="UserPassword" type="password" value=""><span class="error">* <?php echo $UserPasswordErr  ;?></span>
            </div>
            <div class="form-group">
              <input class="form-control" placeholder="Confirm Password" name="ConfirmPassword" type="password" value=""><span class="error">* <?php echo $UserPasswordErr  ;?></span>
            </div>
            <div class="form-group">
              <input class="form-control" placeholder="Phone" name="Phone" type="text" value=""><span class="error">* <?php echo $PhoneErr ;?></span>
            </div>
            <div class="form-group">
              <input class="form-control" placeholder="Address" name="Address" type="text" value=""><span class="error">* <?php echo $AddressErr ;?></span>
            </div>
            <div><u>Select role</u></div>
            <div class="checkbox">
              <label>
                <input name="role" type="radio" value="deliver"> Courier
              </label>

              <label>
                <input name="role" type="radio" value="Shift Manager"> Shift Manager
              </label>
              <label>
                <input name="role" type="radio" value="managment"> Management
              </label>
			  <span class="error">* <?php echo $roleErr ;?></span>
            </div>


            <div class="btnSend">
              <input class="btnSendStyle" name="submit" type="submit" value="send">
			   <input class="btnSendStyle" name="reset" type="reset">
            </div>
          </fieldset>
        </form>

			

      </div>

    </div>
	<?php
	$db->closeConn();
	?>   

    </html>