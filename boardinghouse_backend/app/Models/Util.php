<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;

class Util extends Model
{
    use HasFactory;
    protected $appends = ['url_icon'];
    protected $fillable = [
        'name',
        'icon',
    ];

    public function boarding_houses(): BelongsToMany
    {
        return $this->belongsToMany(BoardingHouse::class, 'util_boarding_houses', 'boarding_house_id', 'util_id');
    }

    public function getUrlIconAttribute()
    {
        if (empty($this->icon)) return;
        return url(Storage::url($this->icon));
    }
}
