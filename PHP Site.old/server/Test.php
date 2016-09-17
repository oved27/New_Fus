<?php

$host = "localhost";
$user = "root";
$password = "";
$database = "fus";
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

try {
    $mysqli = new mysqli($host, $user, $password, $database);

    //echo $mysqli->client_info . "</br>";
    //echo $mysqli->client_version . "</br>";
    //echo $mysqli->server_info . "</br>";

    $query = "SELECT * FROM `users`";
    $objResult = $mysqli->query($query);
    //echo $objResult->num_rows;

    if ($objResult = $mysqli->query($query)) {
        while ($row = $objResult->fetch_object()) {
            echo $row->UserName . " " . $row->Password . "</br>";
        }
       $objResult->close(); 
    }
    $mysqli->close();
} catch (Exception $exc) {
    echo $exc->getMessage();
}
