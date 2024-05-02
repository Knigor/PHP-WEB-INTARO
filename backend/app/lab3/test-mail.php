<?php


use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

//Load Composer's autoloader
require '../vendor/autoload.php';

//Create an instance; passing `true` enables exceptions
$mail = new PHPMailer(true);

try {
    //Server settings
    $mail->SMTPDebug = SMTP::DEBUG_SERVER;                      //Enable verbose debug output
    $mail->isSMTP();                                            //Send using SMTP
    $mail->Host       = 'smtp.gmail.com';                     //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
    $mail->Username   = 'knigor1337@gmail.com';                     //SMTP username
    $mail->Password   = 'xjwf zvgj xnpm pfrb';                               //SMTP password
    $mail->SMTPSecure = 'ssl';            //Enable implicit TLS encryption
    $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

    //Recipients
    $mail->setFrom('knigor1337@gmail.com', 'Aboba'); // От кого письмо
    $mail->addAddress('knigor1337@gmail.com');     //Add a recipient




    //Content
    $mail->CharSet = 'UTF-8'; // Установка кодировки UTF-8
    $mail->Encoding = 'base64'; // Установка метода кодирования


    $mail->isHTML(true);                                  //Set email format to HTML
    $mail->Subject = 'У Вас новое письмо от пользователя';
    $mail->Body    = "<b>ФИО:</b> Зубенко Михаил Петрович </br>
                      <b>Телефон:</b> 88005553535 </br>
                      <b>Сообщение:</b> Какое-то описание </br>";
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

    $mail->send();
    echo 'Message has been sent';
} catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}

?>