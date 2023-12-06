<?php

namespace Database\Factories;

use App\Models\Media;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Storage;

class MediaFactory extends Factory
{
    protected $model = Media::class;

    public function definition()
    {
        $imagePath = storage_path('app/public/media');
        $file = $this->faker->image($imagePath, 640, 480, null, false);
        return [
            'disk' => 'public',
            'directory' => 'media',
            'visibility' => 'public',
            'name' => $this->faker->word,
            'path' => 'media/' . $file,
            'width' => 640,
            'height' => 480,
            'size' => null,
            'type' => 'image',
            'ext' => 'jpg', // or 'png', depending on the format of your images
            'alt' => $this->faker->sentence,
            'title' => $this->faker->sentence,
            'description' => $this->faker->paragraph,
            'caption' => $this->faker->sentence,
            'exif' => json_encode(['key' => 'value']), // Replace with actual EXIF information if available
            'curations' => json_encode(['key' => 'value']), // Replace with actual curation data if available
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }
}
