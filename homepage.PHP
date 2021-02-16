<!DOCTYPE html>
<html>

<?php require 'menu.php'; ?>

	<h2 id="about">About</h2>

	<p style="margin:auto; width: 60%; text-align: center; font-style: italic;">"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</p>

	<h2 id="upcoming">Upcoming Events</h2>

	<p><?php require 'upcoming.php';?></p>

	<h2 id="artists">Featured Artist</h2>

	<p><?php require 'artists.php';?></p>

	<h2 id="previous">Previous Events</h2>

	<p><?php require 'previous.php';?></p>

	<p id="Search:Artist">
		<form action="search_artist.php" method="get" style="text-align: center;">
		<input type="search" name="artist" value="Artists containing..." class="font"><br>
		<input type="submit" value="Search" class="font">
	</form>
	</p>

</body>

<footer>
	<marquee>This is a test website created for Web and Database Systems (<strong>COM1025</strong>)</marquee>
</footer>

</html>
