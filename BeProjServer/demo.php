<?php
exec( 'start1.exe');
$myfile = fopen("filename.txt", "r") or die("Unable to open file!");
echo fread($myfile,filesize("filename.txt"));
fclose($myfile);
?>