<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Evaluate extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'boarding_house_id',
        'ratings',
        'comment'
    ];

    public function boarding_house(): BelongsTo
    {
        return $this->belongsTo(BoardingHouse::class, 'boarding_house_id');
    }
}
