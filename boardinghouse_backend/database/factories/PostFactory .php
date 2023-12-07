<?php

namespace Database\Factories;

use App\Models\Post;
use Illuminate\Database\Eloquent\Factories\Factory;

class PostFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'user_id' => User::inRandomOrder()->pluck('id')->first(),
            'name' => $this->faker->sentence,
            'content' => $this->faker->paragraph,
            'boarding_house_id' => BoardingHouse::inRandomOrder()->pluck('id')->first(), 
            'date_created' => $this->faker->date,
            'date_updated' => $this->faker->date,
            'view' => $this->faker->numberBetween(0, 100),
        ];
    }
}
