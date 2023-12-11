<?php
namespace App\Filament\Resources\EvaluateResource\Api;

use Rupadana\ApiService\ApiService;
use App\Filament\Resources\EvaluateResource;
use Illuminate\Routing\Router;


class EvaluateApiService extends ApiService
{
    protected static string | null $resource = EvaluateResource::class;

    public static function allRoutes(Router $router)
    {
        Handlers\CreateHandler::route($router);
        Handlers\UpdateHandler::route($router);
        Handlers\DeleteHandler::route($router);
        Handlers\PaginationHandler::route($router);
        Handlers\DetailHandler::route($router);
    }
}
