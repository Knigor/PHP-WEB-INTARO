<?php

function checkRatios($input, $output) {
    $tolerance = 4; // Допустимая погрешность
    $weights = [];
    $shares = [];

    // Извлекаем веса и доли показов
    foreach ($input as $line) {
        list($id, $weight) = explode(" ", trim($line));
        $weights[$id] = (int)$weight;
    }

    foreach ($output as $item) {
        list($id, $share) = explode(" ", trim($item));
        $shares[$id] = (float)$share;
    }

    // Проверяем отношения
    foreach ($weights as $id1 => $weight1) {
        foreach ($weights as $id2 => $weight2) {
            if ($id1 != $id2 && $weight1 != 0 && $weight2 != 0 && isset($shares[$id1]) && isset($shares[$id2]) && $shares[$id2] != 0) {
                $expectedRatio = $weight1 / $weight2;
                $actualRatio = $shares[$id1] / $shares[$id2];

                // Рассчитываем относительную разницу
                $relativeDifference = abs(($actualRatio - $expectedRatio) / $expectedRatio);

                // Проверяем по допустимой относительной погрешности
                if ($relativeDifference > $tolerance) {
                    return false;
                }
            }
        }
    }
    return true;
}



function showBanners($input) {
    $banners = [];
    $totalWeight = 0;

    // Парсим входные данные
    foreach ($input as $line) {
        list($id, $weight) = explode(" ", trim($line));
        $banners[$id] = (int)$weight;
        $totalWeight += $banners[$id];
    }

    // Инициализируем массив для подсчета показов
    $bannerShows = array_fill_keys(array_keys($banners), 0);

    // Генерируем 106 показов с учетом весов
    for ($i = 0; $i < 106; $i++) {
        $rand = mt_rand(1, $totalWeight);
        $currentWeight = 0;

        foreach ($banners as $id => $weight) {
            $currentWeight += $weight;
            if ($rand <= $currentWeight) {
                $bannerShows[$id]++;
                break;
            }
        }
    }

    // Вычисляем доли показов с точностью до шести знаков
    $result = [];
    foreach ($banners as $id => $weight) {
        $share = $bannerShows[$id] / 106;
        $result[] = "$id " . number_format($share, 6, '.', '');
    }

    return $result;
}

// Запуск теста
for ($j = 1; $j <= 6; $j++) {
    $answerFile = __DIR__ . "/tests/C/00{$j}.ans";
    $answerarr = file($answerFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

    // сохраняем значения из файла в массив $arr
    $filename = __DIR__ . "/tests/C/00{$j}.dat";
    $input = file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

    // Вывод результатов
    $output = showBanners($input);

    // print_r($answerarr);
    // print_r($output);

    // Проверка отношений
    $checkPass = checkRatios($input, $output);

    echo "Проверка отношений: " . ($checkPass ? "Пройдена" : "Не пройдена") . "\n";
}

?>
