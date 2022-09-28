<?php

header('Access-Control-Allow-Origin: *');

if(empty($_FILES)){
    
    $response = [
        'success' => false,
        'file'    => null
    ];

    exit(json_encode($response));
}

if(empty($_FILES['audio'])){
    
    $response = [
        'success' => false,
        'file'    => null
    ];

    exit(json_encode($response));
}

$input = $_FILES['audio']['tmp_name'];
$filename = time().'.wav';
$output = "./audios/".$filename;
if(move_uploaded_file($input, $output)){
    $response = [
        'success' => true,
        'file'    => $filename
    ];

    exit(json_encode($response));
}else{
    $response = [
        'success' => false,
        'file'    => null
    ];

    exit(json_encode($response));
}