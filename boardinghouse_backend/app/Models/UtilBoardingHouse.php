<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UtilBoardingHouse extends Model
{
    use HasFactory;
    protected $fillable = [
        'util_id',
        'boarding_house_id',
    ];
}
