<?php

namespace Database\Factories;

use App\Models\BoardingHouse;
use App\Models\BoardingHouseType;
use App\Models\Media;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\DB;

class BoardingHouseFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        // Get a random Media record
        $imagePath = storage_path('app/public');
        return [
            'name' => $this->faker->word,
            'featured_image' => $this->faker->image($imagePath, 640, 480, null, false),
            'room_number' => $this->faker->randomNumber(2),
            'acreage' => $this->faker->randomFloat(2, 50, 200),
            'capacity' => $this->faker->randomNumber(2),
            'price' => $this->faker->randomNumber(4),
            'deposit_price' => $this->faker->randomNumber(3),
            'electric_price' => $this->faker->randomNumber(2),
            'water_price' => $this->faker->randomNumber(2),
            'open_time' => $this->faker->time(),
            'close_time' => $this->faker->time(),
            'description' => $this->faker->paragraph,
            'address' => $this->faker->address,
            'favourite' => '0',
            'status' => 'pending',
            'published_at' => $this->faker->date(),
            'user_id' => User::inRandomOrder()->pluck('id')->first(),
            'boarding_house_type_id' => BoardingHouseType::inRandomOrder()->pluck('id')->first(),
        ];
    }
}
