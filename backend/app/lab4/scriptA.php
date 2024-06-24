<?php

for ($j = 1; $j <= 4; $j++) {

    $answerFile = __DIR__ . "/tests/A/00{$j}.ans";
    $answerarr = file($answerFile);

    // сохраняем значения из файла в массив $arr
    $filename = __DIR__ . "/tests/A/00{$j}.dat";
    $input = file($filename);

  //  print_r($input);
  //  print_r($answerarr);

    $banners = [];

    // Обработка входных данных
    foreach ($input as $line) {
        $line = trim($line); // Удаляем пробелы и символы новой строки
        // Разделение строки по первому пробелу
        $parts = preg_split('/\s+/', $line, 2);
        if (count($parts) === 2) {
            list($id, $time) = $parts;
            if (!isset($banners[$id])) {
                $banners[$id] = [
                    'count' => 0,
                    'last_time' => '',
                ];
            }
            $banners[$id]['count']++;
            if (strtotime($time) > strtotime($banners[$id]['last_time'])) {
                $banners[$id]['last_time'] = $time;
            }
        }
    }

    // Подготовка выходных данных
    $output = [];
    foreach ($banners as $id => $data) {
        $output[] = "{$data['count']} $id {$data['last_time']}";
    }

    // Вывод результатов

    $answerarr = array_map('trim', $answerarr);


  //  print_r($answerarr);
  //  print_r($output);

    if ($answerarr == $output){
        echo "$j Тест успешно пройден\n";
    } else {
        echo "$j Тест не пройден\n";
    }


}
?>
