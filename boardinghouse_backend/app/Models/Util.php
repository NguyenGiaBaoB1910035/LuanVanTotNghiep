<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Storage;

class Util extends Model
{
    use HasFactory;
    protected $appends = ['url_icon', 'html_image_icon'];
    protected $fillable = [
        'name',
        'icon',
    ];

    public function children(): HasMany
    {
        return $this->hasMany(Util::class, 'parent_id');
    }

    public function parent(): BelongsTo
    {
        return $this->belongsTo(Util::class, 'parent_id');
    }

    public function boardingHouses(): BelongsToMany
    {
        return $this->belongsToMany(BoardingHouse::class, 'boarding_house_util', 'util_id', 'boarding_house_id');
    }

    public function getUrlIconAttribute()
    {
        if (empty($this->icon)) return;
        return url(Storage::url($this->icon));
    }

    public function getHtmlImageIconAttribute()
    {
        if (empty($this->icon)) return;
        $html = '<img src="' . $this->url_icon . '"/>';
        return $html;
    }
}
