<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;

// Define your web routes here
Route::get('/', [HomeController::class, 'index']);

