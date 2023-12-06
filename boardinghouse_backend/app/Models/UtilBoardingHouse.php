<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UtilBoardingHouse extends Model
{
    use HasFactory;

    protected $fillable = [
        'util_id',
        'boarding_house_id',
    ];

    /**
     * Mối quan hệ thuộc về với model Util.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function util()
    {
        return $this->belongsTo(Util::class);
    }

    /**
     * Mối quan hệ thuộc về với model BoardingHouse.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function boardingHouse()
    {
        return $this->belongsTo(BoardingHouse::class);
    }
}
