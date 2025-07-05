<?php
$servername = "localhost";
$username = "id16452820_bryclay";
$password = "NITbryclay@123";
$dbname = "id16452820_pesticides";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

if(isset($_POST['insect']))
{
    $insect=$_POST['insect'];
}
if(isset($_POST['crop']))
{
    $crop=$_POST['crop'];
}

$sql = "SELECT * FROM Pesticides WHERE `Pesticide id` IN (SELECT C.`Pesticide id` FROM Compatible AS C INNER JOIN Kills AS K on C.`Pesticide id`=K.`Pesticide id` WHERE C.`Crop id`=(SELECT `Crop id` FROM Crops WHERE `Crop name`='$crop') AND K.`Insect id`=(SELECT `Insect id` FROM Insects WHERE `Insect name`='$insect'))";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
  $rows = array();
while($r = mysqli_fetch_assoc($result)) {
    $rows[] = $r;
}
echo json_encode($rows);
} else {
  echo "0 results";
}

mysqli_close($conn);
?>
