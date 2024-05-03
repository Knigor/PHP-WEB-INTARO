<?php

    // счетчик для для вывода данных

    for ($j = 1; $j <= 8; $j++)
    {
        
        $answerFile = __DIR__ . "/tests/A/00{$j}.ans";
        $answerarr = file($answerFile);
        
    
        // сохраняем значения из файла в массив $arr
        $filename = __DIR__ . "/tests/A/00{$j}.dat";
        $arr = file($filename);
       
    
        // получаем кол-во ставок, проходимся по массиву, записываем данные в переменную
    
        $count = [];
    
        foreach ($arr as $key => $value) {
            if (preg_match('/[а-яА-Яa-zA-Z]/u', $value)) { // ругулярка, чтобы исключить строки где есть буквы
                
            } else {
                array_push($count, $value);
            }
            
        }
    
        // записываем в переменные, ниже мы считаем сколько ставок и сколько игр
    
        $countBet = $count[0];
        $countGame = $count[1];
    
    
       // print_r($arr);
    
        // проходимся массивом по ставкам, сохраняем в новый массив
    
        $arrBet = [];
    
        for ($i=1; $i <= $countBet; $i++) { 
            array_push($arrBet, $arr[$i]);
            
        }
    
    
       // print_r($arrBet);
        
       // print_r($arr);
    
        // проходимся по массиву, достаем кол-во ставок и сохраняем в новый массив
    
        $arrGame = [];
    
        for ($i =  ($countBet + 2); $i < count($arr); $i++) { 
            array_push($arrGame, $arr[$i]);
            
        }
        
       // print_r($arrBet);
       // print_r($arrGame);
    
        // находим последние буквы из двух массивов и сравниваем их, затем считаем выигрыш
    
        $winner = 0;
    
        foreach ($arrBet as $value1) {
            // Разбиваем строку по пробелам
            $parts1 = explode(' ', $value1);
            $numberBet = $parts1[0]; // Получаем первое число
            $letterBet = end($parts1); // Получаем последний элемент (буква)
        
            $matchFound = false; // Флаг для обозначения совпадения
        
            foreach ($arrGame as $value2) {
                // Разбиваем строку по пробелам
                $parts2 = explode(' ', $value2);
                $numberGame = $parts2[0]; // Получаем первое число
                $letterGame = end($parts2); // Получаем последний элемент (буква)
        
                // Сравниваем буквы и первые числа
                if ($letterBet === $letterGame && $numberBet === $numberGame) {
                  //  echo $value1;
                    if (preg_match_all('/\b\d+\b(?=[^\d]*$)/m', $value1, $matches)) {
                        // $matches[0] содержит массив всех найденных чисел
                        foreach ($matches[0] as $number) { 
                             
                          //  echo $number . "\n";
    
                          //  echo $value2;
    
                            $parts = explode(' ',$value2);
                            $lastChar = end($parts);
    
                            $trimChar = trim($lastChar);        
    
                            
    
                            switch ($trimChar) {
                                case 'L':
                                    $winner += ($number * $parts[1]) - $number;
                                    break;
                                case 'R':
                                    $winner += ($number * $parts[2]) - $number;
                                    break;                    
                                case 'D':
                                    $winner += ($number * $parts[3]) - $number;
                                    break;                    
                            }
                             
                             
    
                        }
                        
                    }
    
    
                    $matchFound = true; // Устанавливаем флаг совпадения
                    break; // Прерываем внутренний цикл, так как совпадение найдено
                }
            }
        
            if (!$matchFound) {
                // Если совпадение не найдено
                if (preg_match_all('/\b\d+\b(?=[^\d]*$)/m', $value1, $matches)) {
                    // $matches[0] содержит массив всех найденных чисел
                    foreach ($matches[0] as $number) {
                        $winner -= $number;
                       // echo $number . "\n";
                    }
                }
            }
        }
    
        if ($answerarr[0] == $winner) {
            echo "$j Тест успешно пройден\n";
        } else {
            echo "Тест не пройден\n";
        }
        
    
       // echo $winner,"\n";

    }



?>