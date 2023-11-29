<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Enums\BoardingHouseType;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('boarding_houses', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('slug')->nullable();
            $table->bigInteger('featured_image_id')->nullable();
            $table->String('room_number'); // loai phong
            $table->string('acreage')->nullable(); // diện tích
            $table->string('capacity'); // sức chứa
            $table->string('price'); //giá phòng
            $table->string('deposit_price'); //giá cọc
            $table->string('electric_price'); //giá điện
            $table->string('water_price'); //giá nước
            $table->time('open_time');
            $table->time('close_time');
            $table->longText('description');
            $table->text('address');
            $table->string('favourite')->default('0');
            $table->string('status')->default('pendding');
            $table->date('published_at')->nullable();

            $table->unsignedBigInteger('user_id');

            $table->foreign('user_id')
                ->references('id')->on('users')
                ->onDelete('cascade')
                ->onUpdate('cascade');

            $table->foreignId('boarding_house_type_id')->nullable()->constrained()->nullOnDelete();

            $table->timestamp('created_at')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('updated_at')->default(DB::raw('CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP'));
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('boarding_houses');
    }
};
