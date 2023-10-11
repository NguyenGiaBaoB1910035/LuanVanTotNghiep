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
            $table->String('room_number');// loai phong
            $table->string('acreage'); // diện tích
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
