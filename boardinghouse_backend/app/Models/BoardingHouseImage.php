<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoardingHouseImage extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'boarding_house_id'
    ];
}
