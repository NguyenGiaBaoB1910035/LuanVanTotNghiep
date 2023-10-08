<?php

namespace App\Filament\Resources;

use App\Filament\Resources\UserResource\Pages;
use App\Filament\Resources\UserResource\RelationManagers;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\{
    Builder,
    SoftDeletingScope
};
use Illuminate\Validation\Rules\Password;
use Filament\Support\Enums\FontWeight;
use Filament\Forms\Components\{
    FileUpload,
    TextInput,
    Card,
    Grid,
    DateTimePicker,
    Toggle
};
use Filament\Tables\Columns\{
    TextColumn,
    ImageColumn,
    Layout\Stack,
    Layout\Split,
    Layout\Panel,
};

class UserResource extends Resource
{
    protected static ?string $model = User::class;

    protected static ?string $navigationIcon = 'heroicon-o-user-group';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Card::make()
                    ->schema([
                        FileUpload::make('avatar'),
                        Card::make()
                            ->schema([
                                TextInput::make('user_name')->required(),
                                TextInput::make('name')->required(),
                                TextInput::make('email')->email()->required(),
                                TextInput::make('phone')->required(),
                                TextInput::make('password')
                                    ->password()
                                    ->required()
                                    ->hiddenOn('edit')
                                    ->visibleOn('create')
                                    ->maxLength(255)
                                    ->rule(Password::default()),
                            ]),

                    ])
            ])->columns(12);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->contentGrid([
                'md' => 2,
                'xl' => 3,
            ])
            ->columns([
                Stack::make([
                    ImageColumn::make('avatar')->circular(),
                    TextColumn::make('name')
                        ->weight(FontWeight::Bold)
                        ->searchable()
                        ->sortable(),
                    TextColumn::make('role')
                        ->searchable()
                        ->sortable(),
                ]),
                Panel::make([
                    Split::make([
                        Stack::make([
                            TextColumn::make('phone')
                                ->icon('heroicon-m-phone')
                                ->searchable(),
                            TextColumn::make('email')
                                ->icon('heroicon-m-envelope')
                                ->searchable(),
                        ]),
                    ])->from('md'),
                ])->collapsed(true)
            ])
            ->filters([
                Tables\Filters\TrashedFilter::make(),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
                Tables\Actions\RestoreAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                    Tables\Actions\ForceDeleteBulkAction::make(),
                    Tables\Actions\RestoreBulkAction::make(),
                ]),
            ])
            ->emptyStateActions([
                Tables\Actions\CreateAction::make(),
            ])
            ->query(function (User $query) {
                return $query->where('id', '<>', auth()->user()->id);
            });
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
            'index' => Pages\ListUsers::route('/'),
            'create' => Pages\CreateUser::route('/create'),
            'edit' => Pages\EditUser::route('/{record}/edit'),
        ];
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->withoutGlobalScopes([
                SoftDeletingScope::class,
            ]);
    }
}
