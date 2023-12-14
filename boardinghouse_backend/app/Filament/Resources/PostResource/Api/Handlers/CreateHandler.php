<?php

namespace App\Filament\Resources\PostResource\Api\Handlers;

use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use App\Filament\Resources\PostResource;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class CreateHandler extends Handlers
{
    public static string | null $uri = '/';
    public static string | null $resource = PostResource::class;

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

        $model->save();

        return static::sendSuccessResponse($model, "Successfully Create Resource");
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
