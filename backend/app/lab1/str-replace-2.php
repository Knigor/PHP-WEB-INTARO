<?php

$before = "http://asozd.duma.gov.ru/main.nsf/(Spravka)?OpenAgent&RN=31990-6&2";

$newURL = "https://sozd.duma.gov.ru/bill/";  


preg_match("/\d+-\d/",$before,$matches);

$result = $newURL . implode("",$matches);

echo $result, "\n";



?>