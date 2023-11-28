<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\BoardingHouse;

class BoardingHouseController extends Controller
{
    public function scopeName($query, $request)
    {
        if ($request->has('address')) {
            $query->where('address', 'LIKE', '%' . $request->name . '%');
        }

        return $query;
    }

    public function scopeStatus($query, $request)
    {
        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        return $query;
    }

    public function scopeBirthday($query, $request)
    {
        if ($request->has('birthday')) {
            $query->whereDate('birthday', $request->birthday);
        }

        return $query;
    }
}
