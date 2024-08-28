<?php
$host = '127.0.0.1';
$port = 8080;
set_time_limit(0);
$socket = socket_create(AF_INET, SOCK_STREAM, 0);
socket_bind($socket, $host, $port);
socket_listen($socket);

echo "Server started at $host:$port...\n";

while (true) {
    $client = socket_accept($socket);
    $input = socket_read($client, 1024);
    $output = "Received: " . trim($input);
    socket_write($client, $output, strlen($output));
    socket_close($client);
}

socket_close($socket);
?>

