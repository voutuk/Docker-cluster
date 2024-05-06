<?php
$servername = "192.168.30.11";
$username = "UB1";
$password = "p1ZT3Z8TmeJCgsAG1HyNnwt65rbgzs9sWuYs7fcndH3eSGbP4X";
$dbname = "bloodbank";
$conn = new mysqli($servername, $username, $password, $dbname);
if(!$conn){
 die('Could not Connect MySql:' .mysql_error());
}
?>