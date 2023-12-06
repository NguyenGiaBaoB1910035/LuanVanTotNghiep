<?php
namespace App\Filament\Resources\BoardingHouseTypeResource\Api;

use Rupadana\ApiService\ApiService;
use App\Filament\Resources\BoardingHouseTypeResource;
use Illuminate\Routing\Router;


class BoardingHouseTypeApiService extends ApiService
{
    protected static string | null $resource = BoardingHouseTypeResource::class;

    public static function allRoutes(Router $router)
    {
        Handlers\CreateHandler::route($router);
        Handlers\UpdateHandler::route($router);
        Handlers\DeleteHandler::route($router);
        Handlers\PaginationHandler::route($router);
        Handlers\DetailHandler::route($router);
    }
}
