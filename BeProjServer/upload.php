<?php
/*
if(!is_dir("recordings")){
	$res = mkdir("recordings",0777); 
}
*/
// pull the raw binary data from the POST array


$fp = fopen("php://input", "r");
$wav_file = stream_get_contents($fp);

$filename = 'audio_recording.wav';
// write the data out to the file
$fp = fopen('emotions_test/testClip/'.$filename, 'wb');
fwrite($fp, $wav_file);

chmod("/uploads/audio_recording.wav",0755);
fclose($fp);



exec( 'start1.exe');
$myfile = fopen("filename.txt", "r") or die("Unable to open file!");
echo fread($myfile,filesize("filename.txt"));
fclose($myfile);


?>
