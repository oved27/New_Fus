<?php
error_reporting(E_ALL & ~E_NOTICE);
session_start();
$name=$_POST['UserName'];
$password=$_POST['UserPassword'];
require_once "../class/config.php";   
  $db->openConn();
if($_POST["sessionId"]==session_id())
{
  $res=dalLogin::checkUserAndPassword($db,$name,$password);
    
    if(count($res))
    {
        $_SESSION["UserName"]=$res[0]->UserName;
        $_SESSION["Password"]=$res[0]->Password;
        header('Location:HomeManager.php');
       //$db->printf($_SESSION);
       

    }
    else
    {
        header('Location:error.php');
        exit();
    }
}
if($_REQUEST["destroy"]==session_id())
{
    session_destroy();
}
?>
<html>
<head>
    <meta charset="utf-8">
    <title>Login</title>
    <LINK href="../style/Login.css" rel="stylesheet" type="text/css">
       <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
       <script type="text/javascript"></script>
   </head>
   <body>  
      <div id="container">
         <br><br><br>
         <div id="title">Login</div>
         <hr class="colorgraph">

         <div class="panel-body">
            <form accept-charset="UTF-8" role="form" method="post" action="login.php?opt=yes">
             <input type="hidden" name="sessionId" value="<?php echo session_id();?>">
                <fieldset>
                    <div class="form-group">
                        <input class="form-control" placeholder="User Name" name="UserName" type="text">
                    </div>
                    <div class="form-group">
                        <input class="form-control" placeholder="Password" name="UserPassword" type="password" value="">
                    </div>
                    <div class="checkbox">
                        <label>
                            <input name="remember" type="checkbox" value="Remember Me"> Remember Me
                        </label>
                    </div>
                    <div class="btnlogin">
                        <input class="btn btn-lg btn-success btn-block" type="submit" value="Login">
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</body>  
</html>  
<?php
$db->closeConn();
?>        