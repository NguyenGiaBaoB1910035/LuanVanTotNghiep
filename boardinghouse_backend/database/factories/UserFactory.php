<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\User>
 */
class UserFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'user_name' => $this->faker->unique()->name,
            'email' => $this->faker->unique()->email,
            'phone' => $this->faker->unique()->phoneNumber,
            'name' => $this->faker->name,
            'password' => Hash::make('123456'), // password
            'remember_token' => Str::random(10),
        ];
    }

}
