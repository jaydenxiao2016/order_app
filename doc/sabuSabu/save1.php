<?php
    //ini_set('display_errors','1');
     
     // Get the data from the client.  
     $myText = file_get_contents('php://input');
     echo $myText;
     // Burasi calismiyor
     $myFile=substr($myText,0,strpos($myText,","));
	 $myFile="\\" . $myFile;
	 
	echo $myFile;
	
     echo "<p>Writing data to " . getcwd() . $myFile;
     $f = fopen($myFile, 'w') or die("can't open file");
     fwrite($f, $myText);
     fclose($f);
    //this code will save the returned value as a string in a file.
    // ja wie mache ich es hier:



?>