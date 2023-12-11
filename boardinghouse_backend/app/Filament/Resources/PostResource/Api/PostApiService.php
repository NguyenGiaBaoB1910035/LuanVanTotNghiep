<?php
namespace App\Filament\Resources\PostResource\Api;

use Rupadana\ApiService\ApiService;
use App\Filament\Resources\PostResource;
use Illuminate\Routing\Router;


class PostApiService extends ApiService
{
    protected static string | null $resource = PostResource::class;

    public static function allRoutes(Router $router)
    {
        Handlers\CreateHandler::route($router);
        Handlers\UpdateHandler::route($router);
        Handlers\DeleteHandler::route($router);
        Handlers\PaginationHandler::route($router);
        Handlers\DetailHandler::route($router);
    }
}
