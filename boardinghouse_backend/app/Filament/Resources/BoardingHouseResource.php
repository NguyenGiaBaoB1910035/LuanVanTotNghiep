<?php

namespace App\Filament\Resources;

use App\Filament\Resources\BoardingHouseResource\{
    Pages,
    RelationManagers,
    RelationManagers\EvaluateRelationManager
};
use App\Models\BoardingHouse;
use Filament\Forms;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class BoardingHouseResource extends Resource
{
    protected static ?string $model = BoardingHouse::class;

    protected static ?string $slug = 'boarding-houses';

    protected static ?string $recordTitleAttribute = 'name';

    protected static ?string $navigationGroup = 'Boarding Houses';

    protected static ?string $navigationIcon = 'heroicon-o-bolt';

    protected static ?string $navigationLabel = 'Boarding Houses';

    protected static ?int $navigationSort = 0;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Group::make()
                    ->schema([
                        Forms\Components\Section::make()
                            ->schema([
                                Forms\Components\TextInput::make('name')
                                    ->required()
                                    ->live(onBlur: true)
                                    ->afterStateUpdated(function (string $operation, $state, Forms\Set $set) {
                                        if ($operation !== 'create') {
                                            return;
                                        }
                                        $set('slug', Str::slug($state));
                                    }),
                                Forms\Components\TextInput::make('slug')
                                    ->disabled()
                                    ->dehydrated()
                                    ->required()
                                    ->unique(BoardingHouse::class, 'slug', ignoreRecord: true),

                                Forms\Components\MarkdownEditor::make('description')
                                    ->columnSpan('full')
                                    ->required(),

                                Forms\Components\TextInput::make('room_number')
                                    ->label('Quantity')
                                    ->helperText('Quantity room of boarding house.')
                                    ->numeric()
                                    ->rules(['regex:/^\d{1,6}(\.\d{0,2})?$/'])
                                    ->required(),

                                Forms\Components\TextInput::make('capacity')
                                    ->helperText('Quantity member in room.')
                                    ->numeric()
                                    ->rules(['regex:/^\d{1,6}(\.\d{0,2})?$/'])
                                    ->required(),

                                Forms\Components\TextInput::make('acreage'),

                                Forms\Components\TextInput::make('address')
                                    ->required()
                                    ->columnSpan('full'),
                            ])
                            ->columns(2),

                        Forms\Components\Section::make('Images')
                            ->schema([
                                FileUpload::make('featured_image'),

                                FileUpload::make('images')
                                    ->label('Other Images')
                                    ->preserveFilenames()
                                    ->image()
                                    ->imageEditor()
                                    ->acceptedFileTypes(['image/*'])
                                    ->multiple(),

                            ])
                            ->collapsible(),


                    ])
                    ->columnSpan(['lg' => 2]),

                Forms\Components\Group::make()
                    ->schema([
                        Forms\Components\Section::make('Status')
                            ->schema([
                                Forms\Components\Toggle::make('status')
                                    ->label('Visible')
                                    ->helperText('Approved or not approved.')
                                    ->default(true),

                                Forms\Components\DatePicker::make('published_at')
                                    ->label('Availability')
                                    ->default(now())
                                    ->required(),

                                Forms\Components\Select::make('user_id')
                                    ->label('Author')
                                    ->relationship('user', 'name')
                                    ->searchable()
                                    ->required(),

                                Forms\Components\Select::make('boarding_house_type_id')
                                    ->label('Boarding House Type')
                                    ->relationship('boarding_house_type', 'name')
                                    // ->searchable()
                                    ->required()
                                    ->hiddenOn(EvaluateRelationManager::class),

                                Forms\Components\CheckboxList::make('utils')
                                    ->relationship('utils', 'name')
                                    ->multiple()
                                    ->searchable()
                                    ->columns(2),
                            ]),
                        Forms\Components\Section::make('Time Management')
                            ->schema([
                                Forms\Components\TimePicker::make('open_time')
                                    ->format('H:i')
                                    ->datalist([
                                        '00:00',
                                        '12:00',
                                    ])
                                    ->default('00:00')
                                    ->required(),

                                Forms\Components\TimePicker::make('close_time')->after('open_time')
                                    ->datalist([
                                        '00:00',
                                        '12:00',
                                    ])
                                    ->default('12:00')
                                    ->required(),
                            ])
                            ->columns(2),
                        Forms\Components\Section::make('Pricing')
                            ->schema([
                                Forms\Components\TextInput::make('price')
                                    ->numeric()
                                    ->rules(['regex:/^\d{1,8}(\.\d{0,2})?$/'])
                                    ->required(),

                                Forms\Components\TextInput::make('deposit_price')
                                    ->numeric()
                                    ->rules(['regex:/^\d{1,8}(\.\d{0,2})?$/'])
                                    ->required(),

                                Forms\Components\TextInput::make('electric_price')
                                    ->numeric()
                                    ->rules(['regex:/^\d{1,8}(\.\d{0,2})?$/'])
                                    ->required(),

                                Forms\Components\TextInput::make('water_price')
                                    ->numeric()
                                    ->rules(['regex:/^\d{1,8}(\.\d{0,2})?$/'])
                                    ->required(),
                            ])
                            ->columns(1)
                            ->collapsible(),
                    ])
                    ->columnSpan(['lg' => 1]),

            ])
            ->columns(3);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([

                ImageColumn::make('featured_image'),

                Tables\Columns\TextColumn::make('name')
                    ->label('Name')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('boarding_house_type.name')
                    ->searchable()
                    ->sortable()
                    ->toggleable(),

                Tables\Columns\IconColumn::make('status')
                    ->label('Status')
                    ->boolean()
                    ->sortable()
                    ->toggleable(),

                Tables\Columns\TextColumn::make('price')
                    ->label('Price')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('published_at')
                    ->label('Publish Date')
                    ->date()
                    ->sortable()
                    ->toggleable()
                    ->toggledHiddenByDefault(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('boarding_house_type')
                    ->relationship('boarding_house_type', 'name')
                    ->preload()
                    ->multiple()
                    ->searchable(),

                Tables\Filters\TernaryFilter::make('is_visible')
                    ->label('Visibility')
                    ->boolean()
                    ->trueLabel('Only visible')
                    ->falseLabel('Only hidden')
                    ->native(false),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->groupedBulkActions([
                Tables\Actions\DeleteBulkAction::make()
                    ->action(function () {
                        Notification::make()
                            ->title('Now, now, don\'t be cheeky, leave some records for others to play with!')
                            ->warning()
                            ->send();
                    }),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            RelationManagers\EvaluateRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListBoardingHouses::route('/'),
            'create' => Pages\CreateBoardingHouse::route('/create'),
            'edit' => Pages\EditBoardingHouse::route('/{record}/edit'),
        ];
    }

    public static function getGloballySearchableAttributes(): array
    {
        return ['name', 'boarding_house_type.name'];
    }

    public static function getGlobalSearchResultDetails(Model $record): array
    {
        return [
            'Type' => optional($record->boarding_house_type)->name,
        ];
    }

    public static function getGlobalSearchEloquentQuery(): Builder
    {
        return parent::getGlobalSearchEloquentQuery()->with(['brand', 'images']);
    }
}
