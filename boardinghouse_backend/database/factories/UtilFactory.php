<?php

namespace Database\Factories;

use App\Models\Util;
use Illuminate\Database\Eloquent\Factories\Factory;

class UtilFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => $this->faker->word,
            'icon' => $this->faker->word, // Cần điều chỉnh tùy thuộc vào cách bạn lưu trữ icon
            'parent_id' => null, // Update this based on your requirements
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }
}
