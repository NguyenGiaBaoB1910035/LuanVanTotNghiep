<?php

namespace App\Filament\Resources\BoardingHouseResource\RelationManagers;

use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Yepsua\Filament\Forms\Components\Rating;

class EvaluateRelationManager extends RelationManager
{
    protected static string $relationship = 'evaluate';

    public function form(Form $form): Form
    {
        return $form
            ->columns(1)
            ->schema([

                Forms\Components\Select::make('user_id')
                    ->relationship('users', 'name')
                    ->searchable()
                    ->required(),

                    Rating::make('rating')
                    ->size(5),

                Forms\Components\MarkdownEditor::make('content')
                    ->required()
                    ->label('Content'),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('title')
            ->columns([
                Tables\Columns\TextColumn::make('title'),
            ])
            ->filters([
                //
            ])
            ->headerActions([
                Tables\Actions\CreateAction::make(),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->emptyStateActions([
                Tables\Actions\CreateAction::make(),
            ]);
    }
}
