<?php

namespace App\Filament\Resources\BoardingHouseResource\Api\Handlers;

use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use App\Filament\Resources\BoardingHouseResource;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

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

            $validation_image = 'image|mimes:jpeg,png,jpg,gif,webp';

            // Validate the incoming request data (you can use validation rules)

            $model->fill($request->except('featured_image'));

            // Check if the request has the 'featured_image' file
            if ($request->hasFile('featured_image')) {
                // Validate the file (size, mime type, etc.) before storing it
                $request->validate([
                    'featured_image' => $validation_image, // Adjust max size as needed
                ]);

                // Store the file in the 'public' disk under the 'featured_images' directory
                $imagePath = $this->storeAndConvertToPng($request->file('featured_image'));

                // Assign the file path to the 'featured_image' attribute of the model
                $model->featured_image = $imagePath;
            }

            // Check if the request has multiple images
            if ($request->hasFile('images')) {
                $imagePaths = [];

                $files = is_array($request->file('images')) ? $request->file('images') : [$request->file('images')];

                foreach ($files as $image) {
                    // Validate and store each image
                    $validator = validator(
                        ['image' => $image],
                        ['image' => $validation_image]
                    );

                    if ($validator->fails()) {
                        // Handle validation failure, for example, return a response with error messages
                        return response()->json([
                            'message' => 'Validation failed',
                            'errors' => $validator->errors(),
                        ], 422);
                    }

                    $imagePath = $this->storeAndConvertToPng($image);
                    $imagePaths[] = $imagePath;
                }

                $model->images = $imagePaths;
            }

            // Utils
            if ($request->has('utils')) {
                try {
                    // Retrieve the utility IDs from the request
                    $utilsInput = $request->input('utils');

                    // Decode the JSON string to an array
                    $utilityIds = json_decode($utilsInput);

                    // Save the model first to get the ID
                    $model->save();

                    // Get the ID of the saved model
                    $boardingHouseId = $model->id;

                    // Attach the utilities to the newly created boarding house with the correct boarding_house_id
                    $model->utils()->attach($utilityIds, ['boarding_house_id' => $boardingHouseId]);

                    // ...

                } catch (\Exception $e) {
                    // Handle exceptions appropriately (e.g., log, return error response)
                    return response()->json([
                        'message' => 'Error attaching utilities to the resource',
                        'error' => $e->getMessage(),
                    ], 500);
                }
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

    private function storeAndConvertToPng($file)
    {
        $originalPath = $file->store('boarding_house', 'public');
        $convertedPath = Str::replaceLast($file->getClientOriginalExtension(), 'png', $originalPath);

        // Copy the file to the new path and convert it to PNG
        Storage::disk('public')->copy($originalPath, $convertedPath);

        return $convertedPath;
    }
}
