<?php

namespace Database\Factories;

use App\Models\User;
use App\Enums\UserRole;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

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
            'user_name' => $this->faker->userName,
            'email' => $this->faker->unique()->safeEmail,
            'phone' => $this->faker->unique()->phoneNumber,
            'password' => Hash::make('123456'),
            'avatar' => 'avatar-default.jpg',
            'role' => UserRole::Customer,
            'name' => $this->faker->name,
            'gender' => $this->faker->randomElement(['Male', 'Female']),
            'address' => $this->faker->address,
            'birthday' => $this->faker->date,
            'email_verified_at' => now(),
            'remember_token' => Str::random(10), 
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }
}
