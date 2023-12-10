<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Storage;
use Illuminate\Http\UploadedFile;

class BoardingHouse extends Model
{
    use HasFactory;

    protected $appends = ['url_featured_image', 'utils', 'images'];
    protected $fillable = [
        'type',
        'name',
        'slug',
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
        'boarding_house_type_id',
    ];

    public function boarding_house_type(): BelongsTo
    {
        return $this->belongsTo(BoardingHouseType::class, 'boarding_house_type_id');
    }

    public function utils()
    {
        return $this->belongsToMany(Util::class, 'boarding_house_util');
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function evaluates(): HasMany
    {
        return $this->hasMany(Evaluate::class, 'boarding_house_id');
    }

    public function storeFile(UploadedFile $file, string $folder)
    {
        $path = $file->storePublicly($folder, ['disk' => 'public']);

        $this->images()->create([
            'path' => $path,
        ]);
    }


    public function images(): HasMany
    {
        return $this->hasMany(BoardingHouseImage::class, 'boarding_house_id');
    }

    public function getUrlFeaturedImageAttribute(): ?string
    {
        return $this->featured_image ? url(Storage::url($this->featured_image)) : null;
    }

    public function getUtilsAttribute()
    {
        return $this->utils()->get();
    }

    public function getImagesAttribute()
    {
        return $this->images()->pluck('path')->toArray();
    }
}
