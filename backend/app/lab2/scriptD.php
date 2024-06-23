<?php



function dijkstra($graph, $source, $destination) {
    $n = count($graph); // Получаем количество вершин в графе
    $distances = array_fill(0, $n, PHP_INT_MAX); // Создаем массив для хранения расстояний до каждой вершины, изначально заполненный максимальными значениями
    $visited = array_fill(0, $n, false); // Массив для отслеживания посещенных вершин, изначально все вершины не посещены
    
    $distances[$source] = 0; // Устанавливаем расстояние до начальной вершины $source равным 0
    
    // Выполняем алгоритм Дейкстры
    for ($count = 0; $count < $n - 1; $count++) {
        $minDist = PHP_INT_MAX; // Изначально минимальное расстояние устанавливаем как максимально возможное
        $minIndex = -1; // Индекс минимальной вершины
        
        // Находим вершину с минимальным расстоянием, которую еще не посетили
        for ($i = 0; $i < $n; $i++) {
            if (!$visited[$i] && $distances[$i] <= $minDist) {
                $minDist = $distances[$i];
                $minIndex = $i;
            }
        }
        
        $visited[$minIndex] = true; // Помечаем вершину $minIndex как посещенную
        
        // Обновляем расстояния до смежных вершин через $minIndex
        for ($i = 0; $i < $n; $i++) {
            if (!$visited[$i] && $graph[$minIndex][$i] && $distances[$minIndex] != PHP_INT_MAX && $distances[$minIndex] + $graph[$minIndex][$i] < $distances[$i]) {
                $distances[$i] = $distances[$minIndex] + $graph[$minIndex][$i];
            }
        }
    }
    
    // Возвращаем расстояние до вершины $destination или -1, если путь не найден
    return ($distances[$destination] == PHP_INT_MAX) ? -1 : $distances[$destination];
}



// Функция для обработки запросов
function processQueries($graph, $queries) {
    $results = []; // Массив для хранения результатов запросов
    
    foreach ($queries as $query) {
        $source = $query[0]; // Исходная вершина
        $destination = $query[1]; // Целевая вершина
        $action = $query[2]; // Действие (? для запроса расстояния, число для изменения веса ребра или удаления)
        
        if ($action == "?") {
            // Выполняем запрос расстояния с помощью алгоритма Дейкстры
            $results[] = dijkstra($graph, $source, $destination);
        } elseif ($action == -1) {
            // Удаляем ребро между $source и $destination (или устанавливаем вес ребра в 0)
            $graph[$source][$destination] = 0;
            $graph[$destination][$source] = 0;
        } else {
            // Устанавливаем вес ребра между $source и $destination равным $action
            $graph[$source][$destination] = $action;
            $graph[$destination][$source] = $action;
        }
    }
    
    // Возвращаем массив с результатами запросов
    return $results;
}




function run_test($test_name) {
    // Определение полного пути до файлов данных и ожидаемых результатов
    $test_dir = __DIR__ . "/tests/$test_name";
    $stdin = fopen("$test_dir.dat", 'r'); // Открываем файл с входными данными для чтения
    $expected_result_file = "$test_dir.ans"; // Файл с ожидаемыми результатами
    
    // Чтение файла с ожидаемым результатом
    $expected_results = file($expected_result_file, FILE_IGNORE_NEW_LINES);

    // Чтение входных данных
    list($n, $m) = array_map('intval', explode(' ', trim(fgets($stdin))));
    $graph = array_fill(0, $n, array_fill(0, $n, 0));

    // Заполнение графа весами ребер из файла
    for ($i = 0; $i < $m; $i++) {
        list($ai, $bi, $wi) = array_map('intval', explode(' ', trim(fgets($stdin))));
        $graph[$ai][$bi] = $wi;
        $graph[$bi][$ai] = $wi;
    }

    // Чтение количества запросов
    $k = intval(trim(fgets($stdin)));
    $queries = [];
    
    // Чтение запросов из файла
    for ($i = 0; $i < $k; $i++) {
        $queries[] = array_map('trim', explode(' ', fgets($stdin)));
    }

    fclose($stdin); // Закрываем файл с входными данными

    // Обработка запросов и проверка результатов
    $results = processQueries($graph, $queries);
    $passed = true;
    
    // Проверяем результаты и выводим сообщение о прохождении или неудаче теста
    foreach ($results as $index => $result) {
        if ($result != $expected_results[$index]) {
            $passed = false;
            echo "Test $test_name failed! Query index: $index, Expected: {$expected_results[$index]}, Actual: $result\n";
        }
    }

    if ($passed) {
        $rest = substr($test_name, -1); // Получаем последний символ из имени теста
        echo "$rest тест успешно пройден \n";
    }
}

// Запуск тестов для всех тестовых случаев от D/001 до D/009
for ($i = 1; $i <= 9; $i++) {
    $test_name = sprintf("D/%03d", $i); // Формируем имя теста в формате D/001, D/002, ..., D/009
    run_test($test_name); // Запускаем функцию для выполнения теста
}


// Запуск тестов для всех тестовых случаев от D/001 до D/009
for ($i = 1; $i <= 9; $i++) {
    $test_name = sprintf("D/%03d", $i);
    run_test($test_name);
}

?>
