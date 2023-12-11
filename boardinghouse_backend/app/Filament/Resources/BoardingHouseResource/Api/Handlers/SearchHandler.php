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
        return static::$resource::getModel();
    }

    public function handler(Request $request)
    {
        try {
            $query = static::getModel();

            // Search by name
            if ($request->has('name')) {
                $query->where('name', 'like', '%' . $request->input('name') . '%');
            }

            // Search by author's name
            if ($request->has('author_name')) {
                $query->whereHas('user', function ($subQuery) use ($request) {
                    $subQuery->where('name', 'like', '%' . $request->input('author_name') . '%');
                });
            }

            // Search by utils
            if ($request->has('utils')) {
                $query->whereHas('utils', function ($subQuery) use ($request) {
                    $subQuery->whereIn('name', $request->input('utils'));
                });
            }

            // Search by address
            if ($request->has('address')) {
                $query->where('address', 'like', '%' . $request->input('address') . '%');
            }

            // Search by type
            if ($request->has('type')) {
                $query->whereHas('boarding_house_type', function ($subQuery) use ($request) {
                    $subQuery->where('name', 'like', '%' . $request->input('type') . '%');
                });
            }

            // Search by capacity
            if ($request->has('capacity')) {
                $query->where('capacity', '=', $request->input('capacity'));
            }

            // Search by openTime, closeTime
            if ($request->has('openTime') && $request->has('closeTime')) {
                $query->whereBetween('open_time', [$request->input('openTime'), $request->input('closeTime')])
                    ->whereBetween('close_time', [$request->input('openTime'), $request->input('closeTime')]);
            }

            // Search by price
            if ($request->has('price_start') && $request->has('price_end')) {
                $query->where('price', '>=', $request->input('price_start'))
                    ->where('price', '<=', $request->input('price_end'));
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
