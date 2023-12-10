<?php

namespace Database\Factories;

use App\Models\BoardingHouse;
use App\Models\Util;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\BoardingHouseUtil>
 */
class BoardingHouseUtilFactory extends Factory
{
    public function definition(): array
    {
        $boardingHouseIds = BoardingHouse::pluck('id')->toArray();
        $utilIds = Util::pluck('id')->toArray();

        return [
            'boarding_house_id' => $this->faker->randomElement($boardingHouseIds),
            'util_id' => $this->faker->randomElement($utilIds),
        ];
    }
}
