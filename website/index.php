 <?php

// Very simple PHP site just to prove that the load is balanced across all Apache pods.
// Also checking if MySQL database connection is established successfully and we can extract data from it.

    require_once "connection.php";
    try {
        $conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        echo "<h2>Connected to DB!</h2><br><br>";
        $stmt = $conn->prepare('SELECT * FROM products');
        $stmt->execute();
        echo "<p>Response from pod: ".$_ENV['HOSTNAME']."</p><br><br>";
        if($stmt->rowCount() > 0) {
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                echo "id: ".$row['id']."   ";
                echo "name: ".$row['name']."   ";
                echo "price: ".$row['price']."   ";
                echo "<br>";
                echo "description: ".$row['description']."   ";
                echo "<br><br>";
            }
        }
    }
    catch(PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
    }
?>

