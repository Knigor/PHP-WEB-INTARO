<?php

    // Вывести из папки images только файлы с раширением .jpg

    $dir = __DIR__ . '/images';
 
    $files = array();
    foreach(glob($dir . '/*.jpg') as $file) {
        $files[] = basename($file);	
    } 
     
    print_r($files);



?>