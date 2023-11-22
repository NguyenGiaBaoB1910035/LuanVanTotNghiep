<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\MorphMany;
use Spatie\MediaLibrary\HasMedia;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Spatie\MediaLibrary\InteractsWithMedia;
use Awcodes\Curator\Models\Media;

class BoardingHouse extends Model implements HasMedia
{
    use HasFactory;
    use InteractsWithMedia;

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

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function evaluates(): HasMany
    {
        return $this->hasMany(Evaluate::class, 'boarding_house_id');
    }

    public function utils(): BelongsToMany
    {
        return $this->belongsToMany(Util::class, 'utils_boardings', 'boarding_house_id', 'util_id')->withTimestamps();
    }

    public function pictures(): BelongsToMany
    {
        return $this
            ->belongsToMany(Media::class, 'boarding_house_images', 'boarding_house_id', 'media_id')
            ->withPivot('order')
            ->orderBy('order');
    }


    public function featured_image(): BelongsTo
    {
        return $this->belongsTo(Media::class, 'featured_image_id', 'id');
    }
}
