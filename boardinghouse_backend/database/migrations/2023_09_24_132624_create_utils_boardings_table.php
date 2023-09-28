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
            $table->id();
            $table->unsignedBigInteger('util_id');
            $table->unsignedBigInteger('boarding_house_id');
            $table->timestamps();

            $table->foreign('util_id')
            ->references('id')->on('utils')
            ->onDelete('cascade')
            ->onUpdate('cascade');

            $table->foreign('boarding_house_id')
            ->references('id')->on('boarding_house')
            ->onDelete('cascade')
            ->onUpdate('cascade');

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
