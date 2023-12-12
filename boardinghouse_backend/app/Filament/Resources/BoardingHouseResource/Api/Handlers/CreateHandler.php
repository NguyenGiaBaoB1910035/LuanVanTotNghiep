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
        $model = new (static::getModel());

        $model->fill($request->except('featured_image'));

        // Kiểm tra xem có file ảnh được gửi lên không
        if ($request->hasFile('featured_image')) {
            // Lưu file vào storage và lấy đường dẫn
            $imagePath = $request->file('featured_image')->store('featured_images', 'public');

            // Gán đường dẫn file ảnh vào trường featured_image của model
            $model->featured_image = $imagePath;
        }

        $model->save();

        return static::sendSuccessResponse($model, "Successfully Create Resource");
    }
}
