<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class BoardingHouseType extends Model
{
    use HasFactory;

    protected $fillable = [
        'type',
        'name',
        'slug',
        'description',
        'is_visible',
        'position',
        'sort'
    ];
    protected $casts = [
        'is_visible' => 'boolean',
    ];

    public function boarding_houses(): HasMany
    {
        return $this->hasMany(BoardingHouse::class, 'boarding_house_type_id');
    }
}
