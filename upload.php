<?php
    $uploadDirectory = '/var/www/html/uploads/';
    $uploadFile = $uploadDirectory . $_FILES['file']['name'];
    move_uploaded_file($_FILES['file']['tmp_name'], $uploadFile);
?>
