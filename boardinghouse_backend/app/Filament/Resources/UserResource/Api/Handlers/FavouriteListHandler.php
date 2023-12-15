<?php

namespace App\Filament\Resources\UserResource\Api\Handlers;

use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use App\Filament\Resources\UserResource;
use App\Models\User;

class FavouriteListHandler extends Handlers
{
    public static string | null $uri = '/get-favourites-list';
    public static string | null $resource = UserResource::class;

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
        $request->validate([
            'user_id' => 'required|integer',
        ]);

        $user = User::find($request->user_id);

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Assuming the relationship method is named 'favourite_boarding_houses'
        $favouriteBoardingHouses = $user->favourite_boarding_houses()
            ->with('boarding_house_type', 'user', 'evaluates', 'utils')
            ->get();

        return static::sendSuccessResponse($user->favourite_boarding_houses()->get(), "List of favourite boarding houses of " . $user->name . "(" . $user->user_name . ")");
    }
}
