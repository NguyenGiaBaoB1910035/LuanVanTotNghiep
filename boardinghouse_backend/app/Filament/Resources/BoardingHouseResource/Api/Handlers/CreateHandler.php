<?php

namespace App\Filament\Resources\BoardingHouseResource\Api\Handlers;

use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use App\Filament\Resources\BoardingHouseResource;
use Illuminate\Support\Facades\Storage;

class CreateHandler extends Handlers
{
    public static string | null $uri = '/';
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
            $model = new (static::getModel());

            // Validate the incoming request data (you can use validation rules)

            $model->fill($request->except('featured_image'));

            // Check if the request has the 'featured_image' file
            if ($request->hasFile('featured_image')) {
                // Validate the file (size, mime type, etc.) before storing it
                $request->validate([
                    'featured_image' => 'image|mimes:jpeg,png,jpg,gif,webp', // Adjust max size as needed
                ]);

                // Store the file in the 'public' disk under the 'featured_images' directory
                $imagePath = $request->file('featured_image')->store('featured_images', 'public');

                // Assign the file path to the 'featured_image' attribute of the model
                $model->featured_image = $imagePath;
            }

            // Check if the request has multiple images
            if ($request->hasFile('images')) {
                $imagePaths = [];

                foreach ($request->file('images') as $image) {
                    // Validate and store each image
                    $image->validate([
                        'image' => 'image|mimes:jpeg,png,jpg,gif,webp', // Adjust max size as needed
                    ]);

                    $imagePath = $image->store('images', 'public');
                    $imagePaths[] = $imagePath;
                }

                $model->images = $imagePaths;
            }

            $model->save();

            // Return a JSON response indicating success
            return response()->json([
                'message' => 'Successfully Create Resource',
                'data' => $model,
            ], 200);
        } catch (\Exception $e) {
            // Handle exceptions appropriately (e.g., log, return error response)
            return response()->json([
                'message' => 'Error creating resource',
                'error' => $e->getMessage(),
            ], 500); // Set a default HTTP status code (e.g., 500 for internal server error)
        }
    }
}
