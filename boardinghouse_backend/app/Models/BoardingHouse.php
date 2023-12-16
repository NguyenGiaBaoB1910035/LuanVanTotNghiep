<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Storage;

class BoardingHouse extends Model
{
    use HasFactory;

    protected $appends = ['url_featured_image', 'url_images', 'utils', 'boarding_house_type', 'user', 'evaluates', 'user_email', 'user_phone'];
    protected $fillable = [
        'type',
        'name',
        'images',
        'featured_image',
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
        'published_at',
        'boarding_house_type_id'
    ];

    protected $casts = ['images' => 'array'];

    public function boarding_house_type(): BelongsTo
    {
        return $this->belongsTo(BoardingHouseType::class, 'boarding_house_type_id');
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }


    public function evaluates(): HasMany
    {
        return $this->hasMany(Evaluate::class, 'boarding_house_id');
    }

    public function posts(): HasMany
    {
        return $this->hasMany(Post::class, 'boarding_house_id');
    }

    public function utils(): BelongsToMany
    {
        return $this->belongsToMany(Util::class, 'util_boarding_houses', 'boarding_house_id', 'util_id')->withTimestamps();
    }
    public function favourites(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'favourite_boarding_houses', 'boarding_house_id', 'user_id')->withTimestamps();
    }

    public function getUrlFeaturedImageAttribute()
    {
        if (empty($this->featured_image) || !$this->featured_image) return;

        return url(Storage::url($this->featured_image));
    }

    public function getUtilsAttribute()
    {
        return $this->utils()->get();
    }

    public function getBoardingHouseTypeAttribute()
    {
        return BoardingHouseType::findOrFail($this->boarding_house_type_id);
    }

    public function getUserAttribute()
    {
        return User::findOrFail($this->user_id);
    }

    public function getEvaluatesAttribute()
    {
        return $this->evaluates()->get();
    }

    public function getUrlImagesAttribute()
    {
        if (empty($this->images)) return;
        $urlImages = [];

        foreach ($this->images as $image) {
            $urlImages[] = url(Storage::url($image));
        }

        return $urlImages;
    }

    public function getUserEmailAttribute()
    {
        return $this->user->email;
    }
    public function getUserPhoneAttribute()
    {
        return $this->user->phone;
    }
}
