<?php

function expandIPv6($address) {
    // Разбиваем адрес на блоки
    $blocks = explode(':', $address);

    // Ищем индекс пустого блока для вставки нулевых блоков
    $emptyBlockIndex = array_search('', $blocks);

    // Если пустой блок найден, вставляем нулевые блоки до тех пор, пока блоков не будет 8
    while ($emptyBlockIndex !== false && count($blocks) < 8) {
        // Вставляем нулевые блоки
        array_splice($blocks, $emptyBlockIndex, 1, array_fill(0, 8 - count($blocks), '0000'));
        // Ищем следующий пустой блок для вставки нулевых блоков
        $emptyBlockIndex = array_search('', $blocks);
    }

    // Собираем полный адрес
    $fullAddress = implode(':', $blocks);

    return $fullAddress;
}

$j = 1;

$filename = __DIR__ . "/tests/B/00{$j}.dat";
$arr = file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

// Вызов функции для преобразования всех адресов
foreach ($arr as $address) {
    echo expandIPv6($address) . PHP_EOL;
}
?>
