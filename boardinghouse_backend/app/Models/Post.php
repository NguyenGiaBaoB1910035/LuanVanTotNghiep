<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Post extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'name',
        'featured_image',
        'content',
        'boarding_house_id',
        'date_created',
        'date_updated',
        'status',
        'view',
    ];

    protected $dates = ['date_created', 'date_updated'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function boardingHouse(): BelongsTo
    {
        return $this->belongsTo(BoardingHouse::class, 'boarding_house_id')->where('status', true);
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
