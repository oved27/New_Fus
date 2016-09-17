<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

error_reporting(E_ALL & ~E_NOTICE);

require_once 'client/MasterPage.php';
require_once 'client/HomeManager.php';

$obj = $_GET["page"];

switch ($obj) {
    case "0":
        echo "TEST<br/>";
        //echo "<a href='https://localhost/fusproject/index.php?page=login'>login</a>";
        echo "<a href='https://localhost/fusproject/index.php'>INDEX</a>";
        break;
  
    case "1":
        $obj = new HomeManager();
        $obj->title = "F.U.S";
        echo $obj->getHeader();
        echo $obj->getBody();
        echo $obj->getFooter();
        break;
    
    case "error":
        echo "TEST<br/>";
        //echo "<a href='https://localhost/fusproject/index.php?page=login'>login</a>";
        echo "<a href='https://localhost/fusproject/index.php'>INDEX</a>";
        break; 
}