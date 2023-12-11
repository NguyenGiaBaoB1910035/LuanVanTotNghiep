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
        'content'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function boardingHouse(): BelongsTo
    {
        return $this->belongsTo(BoardingHouse::class, 'boarding_house_id')
            ->where('status', true);
    }


    public function getUserAttribute()
    {
        return User::findOrFail($this->user_id);
    }

    public function getBoardingHouseAttribute()
    {
        $boardingHouse = BoardingHouse::findOrFail($this->boarding_house_id);

        if ($boardingHouse->status) {
            return $boardingHouse;
        }

        return null;
    }
}
