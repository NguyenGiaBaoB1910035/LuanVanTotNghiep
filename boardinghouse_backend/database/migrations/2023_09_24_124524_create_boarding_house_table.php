<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Enums\BoardingHouseType;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('boarding_house', function (Blueprint $table) {
            $table->id();
            $table->string('type')->default(BoardingHouseType::BoardingRoom);
            $table->string('price');
            $table->string('acreage');
            $table->string('capacity');
            $table->string('deposit_price');
            $table->string('electric_price');
            $table->string('water_price');
            $table->time('open_time');
            $table->time('close_time');
            $table->longText('description');
            $table->text('address');
            $table->string('favourite')->default('0');
            $table->unsignedBigInteger('user_id');

            $table->foreign('user_id')
                ->references('id')->on('users')
                ->onDelete('cascade')
                ->onUpdate('cascade');

            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP'));
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('boarding_houes');
    }
};
