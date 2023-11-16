<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Enums\UserRole;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('user_name')->unique();
            $table->string('email')->unique();
            $table->string('phone')->unique();
            $table->string('password');
            $table->string('avatar')->default('avatar-default.jpg');
            $table->string('role')->default(UserRole::Customer);
            $table->string('name')->nullable();
            $table->string('gender')->nullable();
            $table->string('address')->nullable();
            $table->date('birthday')->nullable();
            $table->timestamp('email_verified_at')->nullable();
            $table->rememberToken()->nullable();
            $table->softDeletes();
            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP'));
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('posts');
        Schema::dropIfExists('evaluates');
        Schema::dropIfExists('boarding_house_types');
        Schema::dropIfExists('boarding_houses');
        Schema::dropIfExists('users');
        Schema::dropIfExists('media');
    }
};
