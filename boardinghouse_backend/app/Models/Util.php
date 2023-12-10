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

    public function boardingHouses()
    {
        return $this->belongsToMany(BoardingHouse::class, 'boarding_house_util');
    }

    public function getUrlIconAttribute()
    {
        if (empty($this->icon)) return;
        return Storage::url($this->icon);
    }
}
