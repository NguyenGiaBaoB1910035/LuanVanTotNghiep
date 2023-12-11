<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Enums\UserRole;
use App\Models\BoardingHouse;
use App\Models\BoardingHouseImage;
use App\Models\BoardingHouseType;
use App\Models\Media;
use App\Models\User;
use App\Models\Util;
use App\Models\UtilBoardingHouse;
use Database\Factories\CuratorMediaFactory;
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
        $utils = [
            [
                'name' => 'Wifi',
                'icon' => 'Wifi.png',
            ],
            [
                'name' => 'Nhà xe',
                'icon' => 'Nha-xe.png',
            ],
            [
                'name' => 'Thú cưng',
                'icon' => 'Thu-cung.png',
            ],
            [
                'name' => 'Giờ tự do',
                'icon' => 'Gio-tu-do.png',
            ],
            [
                'name' => 'Điều hòa',
                'icon' => 'Dieu-hoa.png',
            ],
            [
                'name' => 'TV',
                'icon' => 'TV.png',
            ],
            [
                'name' => 'Tủ lạnh',
                'icon' => 'Tu-lanh.png',
            ],
            [
                'name' => 'Giường',
                'icon' => 'Giuong.png',
            ],
            [
                'name' => 'Gác lửng',
                'icon' => 'Gac-lung.',
            ],
            [
                'name' => 'Ban công',
                'icon' => 'Ban-cong.png',
            ],
            [
                'name' => 'Máy giặt',
                'icon' => 'May-giat.png',
            ],
        ];
        // Tạo symbolic link nếu chưa tồn tại
        $storageLink = public_path('storage');

        if (!File::exists($storageLink)) {
            $this->command->info('Creating storage link...');
            // Tạo symbolic link
            Artisan::call('storage:link');
            $this->command->info('Created storage link');
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
                'user_name' => 'admin123',
                'email' => 'admin@gmail.com',
                'phone' => '0379375157',
                'password' => Hash::make('admin123'),
                'name' => 'Admin',
                'role' => UserRole::Admin
            ],
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
            [
                'user_name' => 'nbao202',
                'email' => 'nbao202@gmail.com',
                'phone' => '0377808172',
                'password' => Hash::make('123456789'),
                'name' => 'Gia Bao',
                'role' => UserRole::Customer
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

        Util::insert($utils);

        User::factory(50)->create();

        BoardingHouse::factory(10)->create();
        UtilBoardingHouse::factory(15)->create();
    }
}
