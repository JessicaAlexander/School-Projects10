<link rel="stylesheet" href="css.css" />
<?php
$host="localhost"; 

$dbuser="alex"; 

$pass="123456"; 

$dbname="newch12"; 

$conn=mysqli_connect($host,$dbuser,$pass,$dbname);

$query="INSERT INTO employee (LastName,FirstName,Salary) VALUES

('Ling', 'Mai','55900'),

('Johnson', 'Jim','56000'),

('Jones', 'Aaron', '46500'),

('Swift', 'Jeffrey', '124000'),

('Xiong', 'Fong', '65000'),

('Zarnecki', 'Sabrina', '55600')";

mysqli_query($conn, $query);

$sql="select * from employee";

$res=mysqli_query($conn,$sql);

if(!$res)

{

die("Query Failed!!!");

}

?>


<table border=1>

<tr>

<th>Last Name</th>

<th>First Name</th>

<th>Salary</th>

</tr>

<?php


while($row=mysqli_fetch_array($res))

{

?>

<tr>

<td><?php echo $row{'LastName'}?></td>

<td><?php echo $row{'FirstName'}?></td>

<td><?php echo $row{'Salary'}?></td>

</tr>

<?php } ?>

</table>

<?php

mysqli_close($conn);

?>