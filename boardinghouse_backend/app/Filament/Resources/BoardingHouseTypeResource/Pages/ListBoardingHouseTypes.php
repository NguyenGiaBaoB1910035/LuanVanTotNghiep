<?php

namespace App\Filament\Resources\BoardingHouseTypeResource\Pages;

use App\Filament\Resources\BoardingHouseTypeResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListBoardingHouseTypes extends ListRecords
{
    protected static string $resource = BoardingHouseTypeResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
