<?php declare(strict_types=1);

namespace App\Enums;

use BenSampo\Enum\Enum;


final class BoardingHouseType extends Enum
{
    const BoardingRoom = 'boarding_room'; // default
    const Dormitory = 'dormitory';
    const WholeHouse = 'whole_house';
    const Apartment = 'apartment';
}
