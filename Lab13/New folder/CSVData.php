<link rel="stylesheet" href="css.css" />
<?php
// --------------
// -- Programmer:  [Jessica Alexander]
// -- Course:      ITSE-1306 (Intro to PHP)
// -- Instructor:  Cesar "Coach" Marrero
// -- Assignment:  [Chap 11]
// -- Description: [Lab 12]
// I got assistence from several websites i think one was https://www.chegg.com/homework-help/questions-and-answers/php-week-create-php-script-parse-csv-data-file-display-contents-html-document-sometimes-da-q36174208?trackid=QxTMiAa
// ---------------

$namesfromFile=fopen("People.csv","r");

while (!feof($namesfromFile) ) {
    $names[] = fgetcsv($namesfromFile, 1024);
}
fclose($namesfromFile);
?>

<table border=25>
<tr>
<th>Last Name</th>
<th>First Name</th>
<th>Salary</th>
</tr>
<?php

foreach($names as $name)
{
?>
<tr>
<td><?php echo $name[0]?></td> 
<td><?php echo $name[1]?></td> 
<td><?php echo $name[2]?></td> 
</tr>
<?php } ?>
</table>