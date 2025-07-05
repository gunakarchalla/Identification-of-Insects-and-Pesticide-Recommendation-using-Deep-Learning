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

$sql = "SELECT * FROM Insects";
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
