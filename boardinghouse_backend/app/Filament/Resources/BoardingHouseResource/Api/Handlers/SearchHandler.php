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
                $name = trim($request->input('name'));
                if ($name !== '') {
                    $query->where('name', 'like', '%' . $name . '%');
                }
            }

            // Search by author's name
            if ($request->filled('author_name')) {
                $authorName = trim($request->input('author_name'));
                if ($authorName !== '') {
                    $query->whereHas('user', function ($subQuery) use ($authorName) {
                        $subQuery->where('name', 'like', '%' . $authorName . '%');
                    });
                }
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
                $address = trim($request->input('address'));
                if ($address !== '') {
                    $query->where('address', 'like', '%' . $address . '%');
                }
            }

            // Search by type
            if ($request->filled('type')) {
                $type = trim($request->input('type'));
                if ($type !== '') {
                    $query->whereHas('boarding_house_type', function ($subQuery) use ($type) {
                        $subQuery->where('name', 'like', '%' . $type . '%');
                    });
                }
            }

            // Search by capacity
            if ($request->filled('capacity')) {
<<<<<<< HEAD
                if($request->input('capacity') > 0){
                    $query->where('capacity', '=', $request->input('capacity'));
=======
                $capacity = $request->input('capacity');
                if ($capacity !== '') {
                    $query->where('capacity', '=', $capacity);
>>>>>>> 884b8f6b1af466e979277283c611b658c370da29
                }
            }

            // Search by openTime, closeTime
            if ($request->filled('openTime') && $request->filled('closeTime')) {
                $openTime = $request->input('openTime');
                $closeTime = $request->input('closeTime');
                if ($openTime !== '' && $closeTime !== '') {
                    $query->whereBetween('open_time', [$openTime, $closeTime])
                        ->whereBetween('close_time', [$openTime, $closeTime]);
                }
            }

            // Search by price
            if ($request->filled('price_start') && $request->filled('price_end')) {
<<<<<<< HEAD
                $query->where('price', '>=', (int)$request->input('price_start'))
                    ->where('price', '<=', (int)$request->input('price_end'));
=======
                $priceStart = $request->input('price_start');
                $priceEnd = $request->input('price_end');
                if ($priceStart !== '' && $priceEnd !== '') {
                    $query->where('price', '>=', $priceStart)
                        ->where('price', '<=', $priceEnd);
                }
>>>>>>> 884b8f6b1af466e979277283c611b658c370da29
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
