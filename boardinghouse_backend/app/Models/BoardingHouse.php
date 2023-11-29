<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Awcodes\Curator\Models\Media;
use Illuminate\Support\Facades\Storage;

class BoardingHouse extends Model
{
    use HasFactory;
    protected $appends = ['url_featured_image', 'utils', 'pictures'];
    protected $fillable = [
        'type',
        'name',
        'slug',
        'featured_image_id',
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
            ->belongsToMany(Media::class, 'boarding_house_images', 'boarding_house_id', 'media_id');
    }


    public function featured_image(): BelongsTo
    {
        return $this->belongsTo(Media::class, 'featured_image_id', 'id');
    }

    public function getUrlFeaturedImage()
    {
        return optional($this->featured_image)->path;
    }

    public function getUrlFeaturedImageAttribute()
    {
        if (empty($this->featured_image) || !$this->featured_image) return;

        return url(Storage::url(optional($this->featured_image)->path));
    }

    public function getUtilsAttribute()
    {
        return $this->utils()->get();
    }

    public function getPicturesAttribute()
    {
        return $this->pictures()->get();
    }
}
