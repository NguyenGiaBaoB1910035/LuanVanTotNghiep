<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoardingHouseUtil extends Model
{
    use HasFactory;

    protected $table = 'boarding_house_util';

    protected $fillable = [
        'boarding_house_id',
        'util_id',
    ];

    public function boardingHouse()
    {
        return $this->belongsTo(BoardingHouse::class, 'boarding_house_id');
    }

    public function util()
    {
        return $this->belongsTo(Util::class, 'util_id');
    }

    // Hàm để thêm bản ghi mới vào bảng trung gian
    public static function addUtilToBoardingHouse($boardingHouseId, $utilId)
    {
        return self::create([
            'boarding_house_id' => $boardingHouseId,
            'util_id' => $utilId,
        ]);
    }

    // Hàm để xoá một bản ghi khỏi bảng trung gian
    public static function removeUtilFromBoardingHouse($boardingHouseId, $utilId)
    {
        return self::where('boarding_house_id', $boardingHouseId)
            ->where('util_id', $utilId)
            ->delete();
    }

    // Hàm để lấy danh sách các util của một boarding house
    public static function getUtilsForBoardingHouse($boardingHouseId)
    {
        return self::where('boarding_house_id', $boardingHouseId)
            ->with('util')
            ->get();
    }

    // Các hàm khác tùy thuộc vào yêu cầu cụ thể của bạn
}
