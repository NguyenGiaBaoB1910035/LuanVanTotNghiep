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
        Schema::create('boarding_house_images', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('media_id');
            $table->unsignedBigInteger('boarding_house_id');
            $table->timestamps();

            $table->foreign('media_id')
                ->references('id')->on('media')
                ->onDelete('cascade')
                ->onUpdate('cascade');

            $table->foreign('boarding_house_id')
                ->references('id')->on('boarding_houses')
                ->onDelete('cascade')
                ->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('boarding_house_images');
    }
};
