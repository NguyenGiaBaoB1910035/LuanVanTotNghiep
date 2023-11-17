<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;

class Util extends Model implements HasMedia
{
    use HasFactory;
    use InteractsWithMedia;

    protected $fillable = [
        'name',
        'icon',
        'icon',
    ];

    public function boarding_houses(): BelongsToMany
    {
        return $this->belongsToMany(BoardingHouse::class, 'utils_boardings', 'boarding_house_id', 'util_id');
    }
}
