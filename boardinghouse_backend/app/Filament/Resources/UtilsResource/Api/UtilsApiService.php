<?php
namespace App\Filament\Resources\UtilsResource\Api;

use Rupadana\ApiService\ApiService;
use App\Filament\Resources\UtilsResource;
use Illuminate\Routing\Router;


class UtilsApiService extends ApiService
{
    protected static string | null $resource = UtilsResource::class;

    public static function allRoutes(Router $router)
    {
        Handlers\CreateHandler::route($router);
        Handlers\UpdateHandler::route($router);
        Handlers\DeleteHandler::route($router);
        Handlers\PaginationHandler::route($router);
        Handlers\DetailHandler::route($router);
    }
}
