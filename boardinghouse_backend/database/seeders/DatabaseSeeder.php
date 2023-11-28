<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Enums\UserRole;
use App\Models\BoardingHouseType;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\File;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Tạo symbolic link nếu chưa tồn tại
        $storageLink = public_path('storage');

        if (!File::exists($storageLink)) {
            $this->command->info('Creating storage link...');
            // Tạo symbolic link
            Artisan::call('storage:link');
        }

        // Nếu tệp tin chưa được public
        $sourcePath = public_path('images/avatar-default.jpg');
        $destinationPath = storage_path('app/public/avatar-default.jpg');


        // Kiểm tra xem tệp tin đã tồn tại trong public hay không
        if (File::exists($sourcePath)) {
            // Di chuyển tệp tin từ public đến storage
            File::copy($sourcePath, $destinationPath);

            // Seed dữ liệu vào database
            // Ví dụ: factory(App\User::class, 10)->create();
        } else {
            // Xử lý khi tệp tin không tồn tại trong public
            $this->command->info('Tệp tin avatar-default.jpg không tồn tại trong public.');
        }

        User::insert([
            [
                'user_name' => 'phamle21',
                'email' => 'phamle21@gmail.com',
                'phone' => '091649826',
                'password' => Hash::make('phamle21'),
                'name' => 'Phạm Lê',
                'role' => UserRole::Admin
            ],
            [
                'user_name' => 'giabao111',
                'email' => 'nbao7757@gmail.com',
                'phone' => '0377808122',
                'password' => Hash::make('123456789'),
                'name' => 'Gia Bao',
                'role' => UserRole::Admin
            ],
        ]);

        BoardingHouseType::insert([
            [
                'name' => 'Phòng cho thuê',
                'slug' => 'phong-cho-thue',
            ],
            [
                'name' => 'Nhà nguyên căn',
                'slug' => 'nha-nguyen-can',
            ],
            [
                'name' => 'Ký túc xá',
                'slug' => 'ky-tuc-xa',
            ],
        ]);

        User::factory(50)->create();
    }
}
