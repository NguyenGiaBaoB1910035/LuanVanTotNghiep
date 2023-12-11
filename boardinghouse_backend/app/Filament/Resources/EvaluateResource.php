<?php

namespace App\Filament\Resources;

use App\Filament\Resources\EvaluateResource\Pages;
use App\Filament\Resources\EvaluateResource\RelationManagers;
use App\Models\Evaluate;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use IbrahimBougaoua\FilamentRatingStar\Actions\RatingStar;
use IbrahimBougaoua\FilamentRatingStar\Columns\RatingStarColumn;

class EvaluateResource extends Resource
{
    protected static ?string $model = Evaluate::class;

    protected static ?string $recordTitleAttribute = 'name';

    protected static ?string $navigationGroup = 'Boarding Houses';

    protected static ?string $navigationLabel = 'Evaluates';

    protected static ?string $navigationIcon = 'heroicon-o-star';

    protected static ?int $navigationSort = 3;

    public static function form(Form $form): Form
    {
        return $form
            ->columns(1)
            ->schema([

                Forms\Components\Select::make('user_id')
                    ->relationship('user', 'name')
                    ->searchable()
                    ->required(),
                Forms\Components\Select::make('boarding_house_id')
                    ->relationship('boardingHouse', 'name')
                    ->searchable()
                    ->required(),

                RatingStar::make('ratings')
                    ->label('Rating')
                    ->required(),

                Forms\Components\MarkdownEditor::make('content')
                    ->required()
                    ->label('Content'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('title')
            ->columns([
                Tables\Columns\TextColumn::make('user.name')
                    ->label('User')
                    ->searchable()
                    ->sortable()
                    ->toggleable(),

                Tables\Columns\TextColumn::make('boarding_house.name')
                    ->label('Boarding House')
                    ->searchable()
                    ->sortable()
                    ->toggleable(),

                RatingStarColumn::make('ratings')
                    ->label('Rating')
                    ->sortable()
                    ->toggleable(),

                Tables\Columns\TextColumn::make('content')
                    ->label('Content')
                    ->searchable()
                    ->toggleable(),
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

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListEvaluates::route('/'),
            'create' => Pages\CreateEvaluate::route('/create'),
            'edit' => Pages\EditEvaluate::route('/{record}/edit'),
        ];
    }
}
