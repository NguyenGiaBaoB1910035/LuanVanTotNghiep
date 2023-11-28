<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;

class Util extends Model implements HasMedia
{
    use HasFactory;
    use InteractsWithMedia;
    protected $appends = ['url_icon'];
    protected $fillable = [
        'name',
        'icon',
    ];

    public function boarding_houses(): BelongsToMany
    {
        return $this->belongsToMany(BoardingHouse::class, 'utils_boardings', 'boarding_house_id', 'util_id');
    }

    public function getUrlIconAttribute()
    {
        if (empty($this->icon)) return;
        return Storage::url($this->icon);
    }
}
