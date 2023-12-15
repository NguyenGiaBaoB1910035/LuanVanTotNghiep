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
                'icon' => 'Gac-lung.png',
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

        $sourcePath = public_path('images/avatar-default.jpg');
        $destinationPath = storage_path('app/public/avatar-default.jpg');


        if (File::exists($sourcePath)) {
            File::copy($sourcePath, $destinationPath);
        } else {
            $this->command->info('Tệp tin avatar-default.jpg không tồn tại trong public.');
        }

        // Image Utils
        $sourceDirectory = public_path('images/utils');
        if (File::exists($sourceDirectory)) {
            $iconFiles = File::files($sourceDirectory);

            foreach ($iconFiles as $iconFile) {
                $filename = pathinfo($iconFile, PATHINFO_FILENAME);
                $destinationPath = storage_path("app/public/{$filename}.{$iconFile->getExtension()}");
                File::copy($iconFile, $destinationPath);
            }
            $this->command->info('Copied icon files to storage/app/public/');
        } else {
            $this->command->info('Thư mục images/utils/ không tồn tại.');
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

       /* BoardingHouseType::insert([
            [
                'name' => 'Nhà trọ Hoàng Gia',
                'featured_image' => 'nhatro1-1.jpg',
                'images' => [
                    'nhatro1-1.jpg',
                    'nhatro1-2.jpg',
                    'nhatro1-3.jpg',
                    'nhatro1-5.jpg',
                ],
                'room_number' => '20',
                'acreage' => '3',
                'capacity' => '20',
                'price' => '1200000',
                'deposit_price' => '1200000',
                'electric_price' => '10000',
                'water_price' => '6000',
                'description' => 'CHO THUÊ PHÒNG KHU GIẢNG VIÊN ĐẠI HỌC CẦN THƠ ( hẻm 51, bờ hồ Bún Xáng....)\n📍kế bên trường ĐHYD, ĐHCT...\n💵: Giá 4tr6/tháng. Cọc 2 tháng. Hdong 1 năm\n- Lộ lớn đậu oto vivu/n- Nội thất đẹp mới như hình\n☎️: 07.9596.2728 Uyên',
                'address' => '211 Huỳnh Cương, P An Cư, Q Ninh Kiều, TP Cần Thơ',
                'status' => 'pending',
                'user_id' => '1',
                'boarding_house_type_id' => '1'
                

            ]
        ]);
*/
        Util::insert($utils);

        User::factory(50)->create();

        BoardingHouse::factory(10)->create();
        UtilBoardingHouse::factory(15)->create();
    }
}
