<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoardingHouseImage extends Model
{
    use HasFactory;

    protected $fillable = [
        'media_id',
        'boarding_house_id',
    ];

    /**
     * Mối quan hệ thuộc về với model Media.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function media()
    {
        return $this->belongsTo(Media::class);
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
