<?php

namespace App\Filament\Resources\EvaluateResource\Pages;

use App\Filament\Resources\EvaluateResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListEvaluates extends ListRecords
{
    protected static string $resource = EvaluateResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
