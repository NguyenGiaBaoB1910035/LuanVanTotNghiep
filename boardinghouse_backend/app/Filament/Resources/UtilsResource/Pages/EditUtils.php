<?php

namespace App\Filament\Resources\UtilsResource\Pages;

use App\Filament\Resources\UtilsResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditUtils extends EditRecord
{
    protected static string $resource = UtilsResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
