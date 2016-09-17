<?php
error_reporting(E_ALL & ~E_NOTICE);
require_once "db.php";
require_once 'blHomePage.php';
require_once 'dalHomePage.php';
require_once 'blReports.php';
require_once 'dalReports.php';
require_once 'blHistory.php';
require_once 'dalHistory.php';
require_once 'blDeliveryManagment.php';
require_once 'dalDeliveryManagment.php';
require_once 'dalLogin.php';
require_once 'libraryHtml.php';
require_once 'dalLibrary.php';

$db = new db("localhost", "fus", "root", "");
?>