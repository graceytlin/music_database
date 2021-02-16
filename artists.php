<?php

$connect = mysqli_connect("Localhost","root","","music_db",);

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$artist = "SELECT Stage_Name, Forename, Surname, DATE_FORMAT(DOB, '%d/%m/%Y'), Origin # Selects the Artists' stage name, forename and surname, date of birth, and origin
            FROM Person JOIN Artist ON Person.ID = Artist.Stage_Name # Selects the rows where there is an overlap
            ORDER BY RAND() LIMIT 1;"; # Chooses one artist randomly

$result = mysqli_query($connect, $artist);

if (!$result) {echo "Error with query:". mysqli_error($connect);}

echo '<table>
  <tr>
    <th>Alias</th>
    <th>Full name</th>
    <th>Date of birth</th>
    <th>Origin</th>
  </tr>';

while($row = mysqli_fetch_assoc($result))
{
  echo "<tr><td>" . $row["Stage_Name"];
  echo "</td><td>" . $row["Forename"] . " " . $row["Surname"];
  echo "</td><td>" . $row["DATE_FORMAT(DOB, '%d/%m/%Y')"];
  echo "</td><td>" . $row["Origin"];
  echo "</td><tr>";
}

echo "</table>";

mysqli_free_result($result); mysqli_close($connect);

?>
