<?php

namespace App\Filament\Resources\UtilsResource\Pages;

use App\Filament\Resources\UtilsResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListUtils extends ListRecords
{
    protected static string $resource = UtilsResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
