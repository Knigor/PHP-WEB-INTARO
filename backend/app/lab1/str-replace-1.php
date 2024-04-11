<?php

    $string = "'2a''aa2'bbb'4'";

    $pattern = "/'(\d+)'/";

    $result = preg_replace_callback($pattern, function($matches) {
        print_r($matches);
        return "'" . pow($matches[1], 2) . "'";
    }, $string);
    
    echo $result,"\n";


?>