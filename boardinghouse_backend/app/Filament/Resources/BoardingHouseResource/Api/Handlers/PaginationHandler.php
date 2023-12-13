<?php

namespace App\Filament\Resources\BoardingHouseResource\Api\Handlers;

use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use Spatie\QueryBuilder\QueryBuilder;
use App\Filament\Resources\BoardingHouseResource;
use Illuminate\Support\Facades\Storage;

class PaginationHandler extends Handlers
{
    public static string | null $uri = '/';
    public static string | null $resource = BoardingHouseResource::class;


    public function handler()
    {
        $model = static::getModel();

        $query = QueryBuilder::for($model)
            ->allowedFields($model::$allowedFields ?? [])
            ->allowedSorts($model::$allowedSorts ?? [])
            ->allowedFilters($model::$allowedFilters ?? []);

        // Check if 'user_id' is present in the request
        if ($userId = request()->query('user_id')) {
            // Add a filter to only include boarding_houses for the specified user
            $query->where('user_id', $userId);
        }

        $query = $query->paginate(request()->query('per_page'))
            ->appends(request()->query());

        return static::getApiTransformer()::collection($query);
    }
}
