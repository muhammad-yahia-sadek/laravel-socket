<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Define your API routes here
Route::get('/example', function (Request $request) {
    return response()->json(['message' => 'Hello, world!']);
});

