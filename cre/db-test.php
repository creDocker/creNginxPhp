<?php
 require("/cre/www/db-config.php");
?>
<!DOCTYPE html>
<html>
  <head>
    <title>DB Test</title>
  </head>
  <body>
    <h2>Database Test</p>
     <?php printDbResults(); ?>
  </body>
</html>

<?php

 function printDbResults()
 {
   echo "<style>";
   echo "table {border-collapse: collapse;}";
   echo "table, th, td {border: 1px solid black; padding: 10px;}";
   echo "</style>";

   echo "<table>";
   echo "<tr><th>Type</th><th>Table</th><th>PDO</th><th>Classic</th></tr>";
   foreach(inqDbConnections() as $db=>$c)
   {
    echo "<tr><td>".$c['type']."</td><td>".$c['dbname']."</td>";
    $pdoTest = testPDO($c['pdo'], $c['user'], $c['password']);
    echo "<td>".($pdoTest ? "ok" : "fail")."</td>";
    $classicTest = false;
    switch($c['type']) {
     case "mysql":
       $classicTest = testMySqlDb($c['dbname'], $c['user'], $c['password'], $c['host'], $c['port']);
       break;
     case "pgsql":
       $classicTest = testPostgresDb($c['dbname'], $c['user'], $c['password'], $c['host'], $c['port']);
       break;
     case "sqlite":
       $classicTest = testSqliteDb($c['dbname'], $c['user'], $c['password'], $c['host'], $c['port']);
       break;
    } 
    echo "<td>".($classicTest ? "ok" : "fail")."</td>";
    echo "</tr>";
   }
   echo "</table>";
 }

 function testPostgresDb($dbname, $user, $password, $host, $port='5432')
  {
     $connectString = 'host='.$host.' port='.$port.' dbname='.$dbname.' user='.$user.' password='.$password;
     return pg_connect($connectString);
  }

 function testMySqlDb($dbname, $user, $password, $host, $port='3306')
  {
     $connectString = ''.$host.':'.$port.';dbname='.$dbname;
     return mysqli_connect($connectString, $user, $password);
  }

 function testSqliteDb($dbname, $user, $password, $host, $port='3306')
  {
     $connectString = '/cre/www/sqlite/'.$dbname.'.db';
     // PDO does not work with encryption - so we don't test it classical either
     // return new SQLite3($connectString, SQLITE3_OPEN_READWRITE | SQLITE3_OPEN_CREATE, $password);
     return new SQLite3($connectString);
  }

  function testPDO($connect, $user, $password)
  {
     try {
       $connection = new PDO($connect, $user, $password);  
       $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
       return true;
     }
     catch(PDOException $e)
     {
       return false;
     }
     return false;
  }

?>
