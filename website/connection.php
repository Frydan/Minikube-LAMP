<?php

// Data was extracted from Secret file to environmental variables,
// now we extract in to PHP for establishing database connections.

	$host = $_ENV["MYSQL_SERVICE_SERVICE_HOST"];
	$user = $_ENV["MYSQL_USER"];
	$pass = $_ENV["MYSQL_PASSWORD"];
	$db = $_ENV["MYSQL_DATABASE"];
?>
