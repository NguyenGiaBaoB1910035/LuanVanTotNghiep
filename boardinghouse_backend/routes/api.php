<?php

use App\Filament\Resources\UserResource\Api\UserApiService;
use App\Filament\Resources\BoardingHouseResource\Api\BoardingHouseApiService;
use App\Filament\Resources\AuthResource\Api\Handlers\AuthHandler;
use App\Http\Controllers\UserController;

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

Route::group([
    'middleware' => 'api',
    'namespace' => 'App\Http\Controllers',
    'prefix' => 'auth'

], function ($router) {
    Route::post('/login', 'AuthController@login');
    Route::post('/register','AuthController@register');
    Route::post('/logout', 'AuthController@logout');
    Route::post('/refresh', 'AuthController@refresh');
    Route::get('/user-profile','AuthController@userProfile');
    Route::post('/change-pass', 'AuthController@changePassWord');
    Route::put('/update-profile', 'AuthController@update');
});

