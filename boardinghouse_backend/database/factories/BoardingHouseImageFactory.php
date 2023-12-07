<?php

namespace Database\Factories;

use App\Models\BoardingHouse;
use App\Models\BoardingHouseImage;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Storage;

class BoardingHouseImageFactory extends Factory
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
            'path' => $this->faker->image($imagePath, 640, 480, null, false),
            'boarding_house_id' => BoardingHouse::inRandomOrder()->pluck('id')->first(),
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }
}
