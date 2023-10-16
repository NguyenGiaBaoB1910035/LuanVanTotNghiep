<?php
namespace App\Filament\Resources\BoardingHouseResource\Api;

use Rupadana\ApiService\ApiService;
use App\Filament\Resources\BoardingHouseResource;
use Illuminate\Routing\Router;


class BoardingHouseApiService extends ApiService
{
    protected static string | null $resource = BoardingHouseResource::class;

    public static function allRoutes(Router $router)
    {
        Handlers\CreateHandler::route($router);
        Handlers\UpdateHandler::route($router);
        Handlers\DeleteHandler::route($router);
        Handlers\PaginationHandler::route($router);
        Handlers\DetailHandler::route($router);
    }
}
