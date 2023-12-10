<?php

namespace Database\Factories;

use App\Models\Util;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Storage;

class UtilFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $imagePath = storage_path('app/public');

        return [
            'name' => $this->faker->word,
            // 'icon' => $this->faker->image($imagePath, 640, 480, null, false),
            'icon' => 'null',
            'parent_id' => null,
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }
}
