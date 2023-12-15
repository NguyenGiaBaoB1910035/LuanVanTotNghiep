<?php

namespace App\Filament\Resources\BoardingHouseResource\Api\Handlers;

use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use App\Filament\Resources\BoardingHouseResource;

class SearchHandler extends Handlers
{
    public static string | null $uri = '/search';
    public static string | null $resource = BoardingHouseResource::class;

    public static function getMethod()
    {
        return Handlers::POST;
    }

    public static function getModel()
    {
        $modelClass = static::$resource::getModel();
        return new $modelClass;
    }

    public function handler(Request $request)
    {
        try {
            $query = static::getModel()->newQuery();

            // Search by name
            if ($request->filled('name')) {
                $query->where('name', 'like', '%' . trim($request->input('name')) . '%');
            }

            // Search by author's name
            if ($request->filled('author_name')) {
                $query->whereHas('user', function ($subQuery) use ($request) {
                    $subQuery->where('name', 'like', '%' . trim($request->input('author_name')) . '%');
                });
            }

            // Search by utils
            if ($request->filled('utils')) {
                $utils = $request->input('utils');

                // Ensure $utils is an array
                $utils = is_array($utils) ? $utils : [$utils];

                $query->whereHas('utils', function ($subQuery) use ($utils) {
                    $subQuery->whereIn('name', $utils);
                });
            }

            // Search by address
            if ($request->filled('address')) {
                $query->where('address', 'like', '%' . trim($request->input('address')) . '%');
            }

            // Search by type
            if ($request->filled('type')) {
                $query->whereHas('boarding_house_type', function ($subQuery) use ($request) {
                    $subQuery->where('name', 'like', '%' . trim($request->input('type')) . '%');
                });
            }

            // Search by capacity
            if ($request->filled('capacity')) {
                if($request->input('capacity') > 0){
                    $query->where('capacity', '=', $request->input('capacity'));
                }
            }

            // Search by openTime, closeTime
            if ($request->filled('openTime') && $request->filled('closeTime')) {
                $query->whereBetween('open_time', [$request->input('openTime'), $request->input('closeTime')])
                    ->whereBetween('close_time', [$request->input('openTime'), $request->input('closeTime')]);
            }

            // Search by price
            if ($request->filled('price_start') && $request->filled('price_end')) {
                $query->where('price', '>=', (int)$request->input('price_start'))
                    ->where('price', '<=', (int)$request->input('price_end'));
            }

            $results = $query->get();

            return static::sendSuccessResponse($results, "Search Results");
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
                'code' => $e->getCode(),
            ], 500);
        }
    }
}
