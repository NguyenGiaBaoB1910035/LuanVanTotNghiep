<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Storage;

class Post extends Model
{
    use HasFactory;
    protected $appends = ['url_featured_image', 'author'];

    protected $fillable = [
        'user_id',
        'user_name',
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

    public function getAuthor()
    {
        return $this->boardingHouse->user();
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

    public function getUrlFeaturedImageAttribute()
    {
        if (empty($this->featured_image) || !$this->featured_image) return;

        return url(Storage::url($this->featured_image));
    }
    public function getAuthorAttribute()
    {
        return $this->getAuthor->name;
    }
}
