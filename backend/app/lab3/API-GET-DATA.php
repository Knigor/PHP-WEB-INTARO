<?php


header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: http://localhost:5173');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Credentials: true');

try {
    
    $connectPDO = new PDO("pgsql:host=postgres-db;dbname=intaro-2024","user","user");

    // Выполним запрос для выборки данных из таблицы
    $stmt = $connectPDO->query("SELECT * FROM lab3_php");

    // Инициализация массива для хранения данных
    $data = [];

    // Сбор данных из запроса
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $data[] = $row;
    }

    // Преобразование массива в JSON
    $jsonData = json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);

    echo $jsonData;

} catch (PDOException $e) {
    echo $e->getMessage();
}

?>