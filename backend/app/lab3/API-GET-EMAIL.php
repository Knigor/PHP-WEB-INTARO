<?php

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: http://localhost:5173');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Credentials: true');

try {
    $connectPDO = new PDO("pgsql:host=postgres-db;dbname=intaro-2024","user","user");
    $connectPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Устанавливаем временную зону на UTC для PDO
    $connectPDO->exec("SET TIME ZONE 'UTC'");

    // Проверяем, были ли получены данные через POST запрос
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        
        // Получаем данные из POST запроса
        $fio = $_POST['fio'] ?? '';
        $email = $_POST['email'] ?? '';
        $phone = $_POST['phone'] ?? '';
        $text_message = $_POST['text_message'] ?? '';


        // Здесь берем текущую дату и выравниваем под МСК

        $currentTimestamp = date('Y-m-d H:i:s', strtotime('+3 hours'));


            $stmtInsert = $connectPDO->prepare("
                INSERT INTO lab3_php (fio, email, phone, text_message, data_send) 
                VALUES (:fio, :email, :phone, :text_message, :data_send)
            ");

            $stmtInsert->bindParam(':fio', $fio);
            $stmtInsert->bindParam(':email', $email);
            $stmtInsert->bindParam(':phone', $phone);
            $stmtInsert->bindParam(':text_message', $text_message);

            $stmtInsert->execute();

            echo json_encode(['success' => 'Данные успешно добавлены']);

    } else {
        echo json_encode(['error' => 'Метод запроса должен быть POST']);
    }

} catch (PDOException $e) {
    echo json_encode(['error' => 'Ошибка подключения к базе данных: ' . $e->getMessage()]);
}


?>
