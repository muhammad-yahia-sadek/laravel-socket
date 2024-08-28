<?php

/**
 * Laravel - A PHP Framework For Web Artisans
 *
 * @package  Laravel
 */

define('LARAVEL_START', microtime(true));

/*
|--------------------------------------------------------------------------
| Turn On The Lights
|--------------------------------------------------------------------------
|
| Here we will load the framework bootstrap file which will load all of the
| necessary components of the framework and turn on the lights for us.
|
*/

require __DIR__.'/../vendor/autoload.php';

/*
|--------------------------------------------------------------------------
| Run The Application
|--------------------------------------------------------------------------
|
| Next we will create an instance of the Laravel application, which we will
| use to handle the incoming request. Then we will send the response back
| to the browser and allow the browser to display the result.
|
*/

$app = require_once __DIR__.'/../bootstrap/app.php';

$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);

$response = $kernel->handle(
    $request = Illuminate\Http\Request::capture()
);

$response->send();

$kernel->terminate($request, $response);

