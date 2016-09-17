<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of MasterPage
 *
 * @author gaby
 */
class LoginPannel extends MasterPage{
    public $title,$titlePannel;
    function getHeader(){
        $_html = <<<HTML
     <!DOCTYPE html>
<html>
<head>
	<title>$this->title</title>
	<style type="text/css">
    body{
         position: absolute; 
         width: 99%;
         height: 99%;
         
    }
		#container{
            height: 80%;
          margin-top: 50px; 
          margin-bottom: 50px; 
        background-image: url(img/background.jpg);
        border-style: solid;
        border-color:  none;
        border-width: 1px;
        }
        #title{
            color:gray;
            font-weight:bold;
            font-size: 30px;
            text-align: center;
        }

.colorgraph {
    width: 400px;
  height: 5px;
  border-top: 0;
  background: #5cb85c;
  border-radius: 5px;
  text-align: center;
  
}
input[type=text] {
    color: gray;
    width: 400px;
    height: 40px;
    text-align: left;
    -webkit-border-radius: 3px;
-moz-border-radius: 3px;
border-radius: 3px;
}
input[type=password] {
    color: gray;
    width: 400px;
    height: 40px;
    text-align: left;
     -webkit-border-radius: 3px;
-moz-border-radius: 3px;
border-radius: 3px;
}
input[type=submit] {
    background-color: #5cb85c;
    color: white;
    width: 400px;
    height: 40px;
    font-size: 18px;
    text-align: center;

}
.form-group{
text-align: center;
}
.btnlogin{
text-align: center;

}
.checkbox{
   margin-left: 448px;
}
fieldset{
    border: none;
}
	</style>
	<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script type="text/javascript"></script>
</head>
<body>           
HTML;
        return $_html;
    }
    function getBody(){
        $_html = <<<HTML
                <div id="container">
       <br><br><br>
       <div id="title">$this->titlePannel</div>
        <hr class="colorgraph">

            <div class="panel-body">
                    <form accept-charset="UTF-8" role="form" method="post" action="index.php?page=checking">
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
HTML;
        return $_html;
    }
     function getFooter(){
        $_html = <<<HTML
                </html>
HTML;
        return $_html;
    }
}
