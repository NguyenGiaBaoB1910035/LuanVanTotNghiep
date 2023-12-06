<?php

namespace Database\Factories;

use App\Models\BoardingHouse;
use App\Models\Util;
use App\Models\UtilBoarding;
use Illuminate\Database\Eloquent\Factories\Factory;

class UtilBoardingHouseFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'util_id' => Util::inRandomOrder()->pluck('id')->first(),
            'boarding_house_id' => BoardingHouse::inRandomOrder()->pluck('id')->first(),
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }
}
