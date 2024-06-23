<?php

// функция для валидации строки

function validateString($input) {
    // Регулярное выражение для извлечения частей строки
    preg_match('/^(<.*>)\s+(\S+)\s+(\d+)\s+(\d+)$/', $input, $matches);

    if (count($matches) !== 5) {
        return "FAIL"; // Если не удалось извлечь все части, возвращаем FAIL
    }

    // Извлекаем строку, тип, n и m
    $inputString = $matches[1];
    $type = $matches[2];
    $n = (int)$matches[3];
    $m = (int)$matches[4];

    // Удаляем угловые скобки
    $cleanedString = trim($inputString, '<>');

    // Проверка длины строки
    $length = strlen($cleanedString);

    if ($length >= $n && $length <= $m) {
        return "OK";
    } else {
        return "FAIL";
    }
}


// функция для валидации чисел

function validateInteger($input) {
    // Регулярное выражение для извлечения частей строки
    preg_match('/^<(-?\d+)>\s+N\s+(-?\d+)\s+(-?\d+)$/', $input, $matches);

    if (count($matches) !== 4) {
        return "FAIL"; // Если не удалось извлечь все части, возвращаем FAIL
    }

    // Извлекаем целое число, n и m
    $a = (int)$matches[1];
    $n = (int)$matches[2];
    $m = (int)$matches[3];

    // Проверка значения числа
    if ($a >= $n && $a <= $m) {
        return "OK";
    } else {
        return "FAIL";
    }
}

// функция для валидации номера телефона


function validatePhoneNumber($input) {
    // Регулярное выражение для извлечения частей строки
    preg_match('/^<(.+)>\s+P$/', $input, $matches);

    if (count($matches) !== 2) {
        return "FAIL"; // Если не удалось извлечь номер телефона, возвращаем FAIL
    }

    // Извлекаем номер телефона
    $phoneNumber = $matches[1];

    

    // Регулярное выражение для проверки формата номера телефона
    $pattern = '/^\+7 \(\d{3}\) \d{3}-\d{2}-\d{2}$/';

    // Проверка формата номера телефона
    if (preg_match($pattern, $phoneNumber)) {
        return "OK";
    } else {
        return "FAIL";
    }
}

// функция для валидации почты

function validateEmail($input) {
    // Регулярное выражение для извлечения частей строки
    preg_match('/^<(.+)> E$/', $input, $matches);

    if (count($matches) !== 2) {
        return "FAIL"; // Если не удалось извлечь email, возвращаем FAIL
    }

    // Извлекаем email
    $email = $matches[1];

    // Регулярное выражение для проверки формата email
    $pattern = '/^[a-zA-Z0-9](?:[a-zA-Z0-9_]{2,29})?[a-zA-Z0-9]@[a-zA-Z]{2,30}\.[a-z]{2,10}$/';

    // Проверка формата email
    if (preg_match($pattern, $email)) {
        return "OK";
    } else {
        return "FAIL";
    }
}


// функция для валидации даты, месяца и времени

function validateDateTime($input) {
    // Регулярное выражение для извлечения частей строки
    preg_match('/^<(.+)> D$/', $input, $matches);

    if (count($matches) !== 2) {
        return "FAIL"; // Если не удалось извлечь дату и время, возвращаем FAIL
    }

    // Извлекаем дату и время
    $dateTime = $matches[1];

    // Регулярное выражение для проверки формата даты и времени
    $pattern = '/^(\d{1,2})\.(\d{1,2})\.(\d{4}) (\d{1,2}):(\d{2})$/';

    if (!preg_match($pattern, $dateTime, $dateParts)) {
        return "FAIL"; // Если формат даты и времени не совпадает, возвращаем FAIL
    }

    // Извлекаем части даты и времени
    $day = (int)$dateParts[1];
    $month = (int)$dateParts[2];
    $year = (int)$dateParts[3];
    $hour = (int)$dateParts[4];
    $minute = (int)$dateParts[5];

    // Проверка корректности даты
    if (!checkdate($month, $day, $year)) {
        return "FAIL"; // Если дата некорректна, возвращаем FAIL
    }

    // Проверка корректности времени
    if ($hour < 0 || $hour > 23 || $minute < 0 || $minute > 59) {
        return "FAIL"; // Если время некорректно, возвращаем FAIL
    }

    return "OK"; // Если все проверки пройдены, возвращаем OK
}


for ($j = 1; $j <= 14; $j++)
{
    
    // проверка на кол-во проверок
    if ($j >= 10){
        
        $answerFile = __DIR__ . "/tests/C/0{$j}.ans";
        $answerarr = file($answerFile);

        // сохраняем значения из файла в массив $arr
        $filename = __DIR__ . "/tests/C/0{$j}.dat";
        $arr = file($filename);

    } else {

        $answerFile = __DIR__ . "/tests/C/00{$j}.ans";
        $answerarr = file($answerFile);

        // сохраняем значения из файла в массив $arr
        $filename = __DIR__ . "/tests/C/00{$j}.dat";
        $arr = file($filename);
        
    }


   // print_r($answerarr);
   // print_r($arr);

   $checkWinner = [];

    // проходимся по массиву и достаем нужную букву
    foreach ($arr as $key => $value) {
        

        // условие для строк 

        if (preg_match_all("/\sS\s/",$value,$matches)){
            
            $string = $matches[0];
           
            array_push($checkWinner,validateString($value));
                       
        }


        // условие для чисел

        if (preg_match_all("/\sN\s/",$value,$matches)){
            
            $string = $matches[0];
           
         //   echo $value . "\n";
            
            
            array_push($checkWinner,validateInteger($value));
        }
        

        // условия для телефона

        if (preg_match_all("/\sP\s/",$value,$matches)){
            
            $string = $matches[0];
           
          //  echo $value . "\n";
            
            
            array_push($checkWinner,validatePhoneNumber($value));
        }

        // условие для почты 

        if (preg_match_all("/\sE\s/",$value,$matches)){
            
            $string = $matches[0];
           
        //    echo $value . "\n";
            
            
            array_push($checkWinner,validateEmail($value));
        }

        // условие для даты, мясяца и времени

        if (preg_match_all("/\sD\s/",$value,$matches)){
            
            $string = $matches[0];
           
        //    echo $value . "\n";
            
            
            array_push($checkWinner,validateDateTime($value));
        }
    }


    $answerarr = array_map('trim', $answerarr);
  //  print_r($answerarr);
  //  print_r($checkWinner);

    if ($answerarr == $checkWinner){
        echo "$j Тест успешно пройден\n";
    } else {
        echo "$j Тест не пройден\n";
    }
}


?>