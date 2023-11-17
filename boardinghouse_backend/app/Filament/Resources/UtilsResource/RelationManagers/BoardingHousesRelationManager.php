<?php

namespace App\Filament\Resources\UtilsResource\RelationManagers;

use App\Filament\Resources\BoardingHouseResource;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class BoardingHousesRelationManager extends RelationManager
{
    protected static string $relationship = 'boarding_houses';

    protected static ?string $recordTitleAttribute = 'name';


    public function form(Form $form): Form
    {
        return BoardingHouseResource::form($form);
    }

    public function table(Table $table): Table
    {
        return BoardingHouseResource::table($table)
            ->headerActions([
                Tables\Actions\CreateAction::make(),
            ])
            ->actions([
                Tables\Actions\DeleteAction::make(),
            ])
            ->groupedBulkActions([
                Tables\Actions\DeleteBulkAction::make(),
            ]);
    }
}
