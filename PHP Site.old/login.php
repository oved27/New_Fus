<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

error_reporting(E_ALL & ~E_NOTICE);

require_once 'client/MasterPage.php';
require_once 'client/LoginPannel.php';
require_once 'businessLogical/Checking.php';
//https://localhost/fusproject/index.php?page=checking
$obj = $_GET["page"];

switch ($obj) {
    case "error":
        echo "TEST<br/>";
        //echo "<a href='https://localhost/fusproject/index.php?page=login'>login</a>";
        echo "<a href='https://localhost/fusproject/index.php'>INDEX</a>";
        break;
    
    
    case "checking":
        $objChecking = new Checking();
       $objChecking->checkingLogin($_POST["UserName"],$_POST["UserPassword"]);
        
        break;

    default:
        $obj = new LoginPannel();
        $obj->title = "F.U.S";
        $obj->titlePannel = "כניסה למערכת";
        echo $obj->getHeader();
        echo $obj->getBody();
        echo $obj->getFooter();


        break;
}