<?php
namespace App\Filament\Resources\UserResource\Api\Handlers;

use App\Models\FavouriteBoardingHouse;
use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use App\Filament\Resources\UserResource;

class FavouriteHandler extends Handlers {
    public static string | null $uri = '/favourite';
    public static string | null $resource = UserResource::class;

    public static function getMethod()
    {
        return Handlers::POST;
    }

    public static function getModel()
    {
        return FavouriteBoardingHouse::class;
    }

    public function handler(Request $request)
    {
        $request->validate([
            'user_id' => 'required|integer',
            'boarding_house_id' => 'required|integer',
        ]);
        
        $userId = $request->input('user_id');
        $boardingHouseId = $request->input('boarding_house_id');

        // Check if the boarding house is already a favorite
        $favorite = FavouriteBoardingHouse::where('user_id', $userId)
            ->where('boarding_house_id', $boardingHouseId)
            ->first();

        if ($favorite) {
            // Toggle the existing favorite record status
            $favorite->update(['status' => !$favorite->status]);
            return static::sendSuccessResponse($favorite, "Successfully toggled favorite status.");
        }

        // Create a new favorite record
        $newFavorite = new FavouriteBoardingHouse([
            'user_id' => $userId,
            'boarding_house_id' => $boardingHouseId,
            'status' => true,
        ]);

        $newFavorite->save();

        return static::sendSuccessResponse($newFavorite, "Successfully marked as favorite.");
    }
}
