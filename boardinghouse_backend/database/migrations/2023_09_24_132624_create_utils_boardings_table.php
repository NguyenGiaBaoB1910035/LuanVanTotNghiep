<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('utils_boardings', function (Blueprint $table) {
            $table->primary(['util_id', 'boarding_house_id']);
            $table->foreignId('util_id')->nullable();
            $table->foreignId('boarding_house_id')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('utils_boardings');
    }
};
