<?php

namespace App\Filament\Resources\EvaluateResource\Pages;

use App\Filament\Resources\EvaluateResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditEvaluate extends EditRecord
{
    protected static string $resource = EvaluateResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
