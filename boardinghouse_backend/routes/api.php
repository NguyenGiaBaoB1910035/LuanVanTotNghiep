<?php

use App\Filament\Resources\UserResource\Api\UserApiService;
use App\Filament\Resources\BoardingHouseResource\Api\BoardingHouseApiService;
use App\Filament\Resources\AuthResource\Api\Handlers\AuthHandler;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
UserApiService::routes();
BoardingHouseApiService::routes();
