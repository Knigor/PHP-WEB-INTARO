<?php
function isPalindrome($string) {
    // Удаление пробелов и приведение к нижнему регистру для корректного сравнения
    $string = strtolower(str_replace(' ', '', $string));


    // получаем реверс строки
    
    $reversed = strrev($string);

    echo $string . "\n";
    echo $reversed . "\n";



    // Сравнение оригинальной строки с перевернутой
    return $string == $reversed;
}

// Пример использования
$inputString = null;
if (isPalindrome($inputString)) {
    echo "Является палиндромом" . "\n";
} else {
    echo "Не является палиндромом" . "\n";
}
?>