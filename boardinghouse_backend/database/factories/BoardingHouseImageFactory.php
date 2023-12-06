<?php

namespace Database\Factories;

use App\Models\BoardingHouseImage;
use Illuminate\Database\Eloquent\Factories\Factory;

class BoardingHouseImageFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'media_id' => function () {
                return \App\Models\Media::factory()->create()->id;
            },
            'boarding_house_id' => function () {
                return \App\Models\BoardingHouse::factory()->create()->id;
            },
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }
}
