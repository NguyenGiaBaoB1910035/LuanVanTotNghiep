<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class BoardingHouse extends Model
{
    use HasFactory;
    protected $fillable = [
        'type',
        'name',
        'slug',
        'room_number',
        'acreage',
        'capacity',
        'price',
        'deposit_price',
        'electric_price',
        'water_price',
        'open_time',
        'close_time',
        'description',
        'address',
        'favourite',
        'status',
        'user_id',
        'boarding_house_type_id'
    ];

    public function boarding_house_type(): BelongsTo
    {
        return $this->belongsTo(BoardingHouseType::class, 'boarding_house_type_id');
    }
}
