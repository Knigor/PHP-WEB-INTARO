<?php

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: http://localhost:5173');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Credentials: true');


use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

//Load Composer's autoloader
require '../vendor/autoload.php';

//Create an instance; passing `true` enables exceptions
$mail = new PHPMailer(true);

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


        // Устанавливаем дату для  МСК

        $currentTimestamp = new DateTime("now", new DateTimeZone('Europe/Moscow') );
        $currentTimestampStr = $currentTimestamp->format('Y-m-d H:i:s');

        // Делаем запрос к БД и ищем

        $queryDate = $connectPDO->query("SELECT 
            data_send, interval_data  
            from lab3_php lp
            where email = '$email'
            order by id_form desc
            limit 1");

        $currectDateTime = $queryDate->fetch();
          
        if ($currectDateTime) {

            // Здесь настраиваем логику, проверям интервал между временем и разрешаем добавление 

            // Задаем Часовой пояс

            date_default_timezone_set('Europe/Moscow');
            $date = date('Y-m-d H:i:s');

            // Записвыаем в новые переменные информацию по текущему времени и до какого у нас выставлен кд

            $start = strtotime($date);
            $end = strtotime($currectDateTime[1]);

            // получаем разницу во времени в минутах

            $interval = ($end - $start) / 60;

            // делаем условие

            if ($interval >= 0){

                // Отправлять запрос нельзя, 1.5 часа еще не прошло

                $response = [
                    'interval' => "$interval",
                    'status' => "No"

                ];

                echo json_encode($response);
                

            } else {

                // Сообщение можно отправлять прошло 1.5 часа


                // Отправляем на почту


                            //Server settings
              //  $mail->SMTPDebug = SMTP::DEBUG_SERVER;                      //Enable verbose debug output
                $mail->isSMTP();                                            //Send using SMTP
                $mail->Host       = 'smtp.gmail.com';                     //Set the SMTP server to send through
                $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
                $mail->Username   = 'knigor1337@gmail.com';                     //SMTP username
                $mail->Password   = 'xjwf zvgj xnpm pfrb';                               //SMTP password
                $mail->SMTPSecure = 'ssl';            //Enable implicit TLS encryption
                $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

                //Recipients
                $mail->setFrom('knigor1337@gmail.com', 'Aboba1'); // От кого письмо
                $mail->addAddress('knigor1337@gmail.com');     //Add a recipient




                //Content
                $mail->CharSet = 'UTF-8'; // Установка кодировки UTF-8
                $mail->Encoding = 'base64'; // Установка метода кодирования


                $mail->isHTML(true);                                  //Set email format to HTML
                $mail->Subject = 'У Вас новое письмо от пользователя';
                $mail->Body    = "<b>ФИО:</b> $fio </br>
                                <b>Телефон:</b> $phone </br>
                                <b>Сообщение:</b> $text_message </br>";
                $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

                $mail->send();
               // echo 'Message has been sent';


                // Готовим SQL-запрос для вставки данных
                $stmt = $connectPDO->prepare("INSERT INTO lab3_php (fio, email, phone, text_message, data_send) 
                    VALUES (:fio, :email, :phone, :text_message, :data_send)
                ");

                // Привязываем значения к параметрам в запросе
                $stmt->bindParam(':fio', $fio);
                $stmt->bindParam(':email', $email);
                $stmt->bindParam(':phone', $phone);
                $stmt->bindParam(':text_message', $text_message);
                $stmt->bindParam(':data_send', $currentTimestampStr);

                // Выполняем запрос
                $stmt->execute();

                $response = [
                    'success' => 'Данные успешно добавлены',
                    'status' => 'Yes',
                    'fio' => $fio,
                    'email' => $email,
                    'phone' => $phone,
                    'text_message' => $text_message,
                    'data_send' => $currentTimestampStr
                ];
                
                echo json_encode($response);


            }
            

        } else {

            // Здесь будет делаться запрос на добавление записи если пользователя нету еще в системе

            // Готовим SQL-запрос для вставки данных
            $stmt = $connectPDO->prepare("INSERT INTO lab3_php (fio, email, phone, text_message, data_send) 
                VALUES (:fio, :email, :phone, :text_message, :data_send)
            ");



                         //Server settings
               // $mail->SMTPDebug = SMTP::DEBUG_SERVER;                      //Enable verbose debug output
                $mail->isSMTP();                                            //Send using SMTP
                $mail->Host       = 'smtp.gmail.com';                     //Set the SMTP server to send through
                $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
                $mail->Username   = 'knigor1337@gmail.com';                     //SMTP username
                $mail->Password   = 'xjwf zvgj xnpm pfrb';                               //SMTP password
                $mail->SMTPSecure = 'ssl';            //Enable implicit TLS encryption
                $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

                //Recipients
                $mail->setFrom("$email", 'Aboba'); // От кого письмо
                $mail->addAddress('knigor1337@gmail.com');     // Почта администратора




                //Content
                $mail->CharSet = 'UTF-8'; // Установка кодировки UTF-8
                $mail->Encoding = 'base64'; // Установка метода кодирования


                $mail->isHTML(true);                                  //Set email format to HTML
                $mail->Subject = 'У Вас новое письмо от пользователя';
                $mail->Body    = "<b>ФИО:</b> $fio </br>
                                <b>Телефон:</b> $phone </br>
                                <b>Сообщение:</b> $text_message </br>";
                $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

                $mail->send();
              //  echo 'Message has been sent';




    
            // Привязываем значения к параметрам в запросе
            $stmt->bindParam(':fio', $fio);
            $stmt->bindParam(':email', $email);
            $stmt->bindParam(':phone', $phone);
            $stmt->bindParam(':text_message', $text_message);
            $stmt->bindParam(':data_send', $currentTimestampStr);
    
            // Выполняем запрос
            $stmt->execute();
    
            $response = [
                'success' => 'Данные успешно добавлены',
                'status' => 'Yes',
                'fio' => $fio,
                'email' => $email,
                'phone' => $phone,
                'text_message' => $text_message,
                'data_send' => $currentTimestampStr
            ];
            
            echo json_encode($response);
        }


    } else {
        echo json_encode(['error' => 'Метод запроса должен быть POST']);
    }

} catch (PDOException $e) {
    echo json_encode(['error' => 'Ошибка подключения к базе данных: ' . $e->getMessage()]);
}

?>
