<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;

use App\Enums\UserRole;
use Filament\Models\Contracts\HasAvatar;
use Filament\Models\Contracts\HasName;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;
use Filament\Models\Contracts\FilamentUser;
use Filament\Panel;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements FilamentUser, HasAvatar, HasName, JWTSubject, MustVerifyEmail
{
    use HasApiTokens, HasFactory, Notifiable, SoftDeletes;

    protected $appends = ['url_avatar'];

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'user_name',
        'email',
        'phone',
        'password',
        'avatar',
        'role',
        'name',
        'gender',
        'address',
        'birthday',
        'email_verified_at'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    /**
     * Get the identifier that will be stored in the subject claim of the JWT.
     *
     * @return mixed
     */
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }

    public function getFilamentAvatarUrl(): ?string
    {
        return asset('storage/' . $this->avatar);
    }

    public function canAccessPanel(Panel $panel): bool
    {
        if ($panel->getId() === 'admin') {
            return $this->role == UserRole::Admin || $this->role == UserRole::SubAdmin;
        }

        return true;
    }

    public function getFilamentName(): string
    {
        return "{$this->name}";
    }

    public function boarding_houses(): HasMany
    {
        return $this->hasMany(BoardingHouse::class, 'user_id');
    }

    public function favourite_boarding_houses(): BelongsToMany
    {
        return $this->belongsToMany(BoardingHouse::class, 'favourite_boarding_houses', 'user_id', 'boarding_house_id')
            ->withPivot('status')
            ->wherePivot('status', 1)
            ->withTimestamps();
    }

    public function getUrlAvatarAttribute()
    {
        if ($this->avatar) {
            return asset('storage/' . $this->avatar);
        }

        return asset('storage/' . 'avatar-default.jpg');
    }
}
