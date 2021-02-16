<!DOCTYPE html>

<?php require 'menu.php' ?>

<?php

$artist = $_GET['artist'];

$connect = mysqli_connect("Localhost","root","","music_db",);

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$similar = "SELECT Stage_Name, Label, Website
            FROM Artist WHERE Stage_Name LIKE '%$artist%';";

$result = mysqli_query($connect, $similar);

if (!$result) {echo "Error with query:". mysqli_error($connect);}

echo '<h2>Search results:</h2>';

if ($result) {
  $rows = mysqli_num_rows($result);

  if ($rows == 0) {
    echo '<p style="text-align: center;">Sorry, no artist under that name could be found! Please check your spelling
            and <a href="homepage.php#Search:Artist" class="link">search again.</a></p>';
    } else {

    echo '<table>
      <tr>
        <th>Alias</th>
        <th>Label</th>
      </tr>';

    while ($row = mysqli_fetch_assoc($result)) {
      echo '<tr><td><a href="https://' . $row["Website"] . '" class="link">' . $row["Stage_Name"] . '</a>';
      echo "</td><td>" . $row["Label"];
      echo "</td><tr>";
    }

    echo "</table>";
  } mysqli_free_result($result);
}


mysqli_close($connect);

?>

</body>
</html>
