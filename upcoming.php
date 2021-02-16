<?php

$connect = mysqli_connect("Localhost","root","","music_db",);

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$concert = "SELECT Concert.Name, DATE_FORMAT(Start_Date, '%D of %M %Y'), DATE_FORMAT(End_Date, '%D of %M %Y'), Venue, City, Country # Selects the concert name, dates, venue name, and location
            FROM Concert JOIN Venue ON Concert.Venue = Venue.Name # Selects the rows where there is an overlap
            WHERE Start_Date > DATE(Now()) ORDER BY Start_Date DESC LIMIT 3;"; # Only chooses top 3 results where the date is after today's date

$result = mysqli_query($connect, $concert);

if (!$result) {echo "Error with query:". mysqli_error($connect);}

echo '<table>
  <tr>
    <th>Concert</th>
    <th>Location</th>
    <th>When?</th>
  </tr>';

while($row = mysqli_fetch_assoc($result))
{
  echo "<tr><td>" . $row["Name"];
  echo "</td><td>" . $row["Venue"] . ", " . $row["City"] . ", " . $row["Country"];
  echo "</td><td>" . $row["DATE_FORMAT(Start_Date, '%D of %M %Y')"] . " to " . $row["DATE_FORMAT(End_Date, '%D of %M %Y')"];
  echo "</td><tr>";
}

echo "</table>";

mysqli_free_result($result); mysqli_close($connect);

?>
