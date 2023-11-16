<?php

namespace App\Filament\Resources\BoardingHouseTypeResource\Pages;

use App\Filament\Resources\BoardingHouseTypeResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditBoardingHouseType extends EditRecord
{
    protected static string $resource = BoardingHouseTypeResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
