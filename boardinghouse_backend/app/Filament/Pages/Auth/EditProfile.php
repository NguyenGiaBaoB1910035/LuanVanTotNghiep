<?php

namespace App\Filament\Pages\Auth;

use Filament\Forms\Components\{
    TextInput,
    DatePicker,
    Card,
    Grid,
    Select,
    FileUpload
};
use Filament\Forms\Form;
use Filament\Pages\Auth\EditProfile as BaseEditProfile;

class EditProfile extends BaseEditProfile
{

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Grid::make()
                    ->schema([
                        FileUpload::make('avatar')
                            ->image()
                            ->imageEditor(),
                        TextInput::make('user_name')
                            ->required()
                            ->maxLength(255),
                        $this->getNameFormComponent(),
                        $this->getEmailFormComponent(),
                        TextInput::make('phone')->required(),
                        DatePicker::make('birthday'),
                        Select::make('gender')
                            ->options([
                                'Male' => 'Nam',
                                'Female' => 'Nữ',
                            ]),
                        Grid::make()
                            ->schema([
                                TextInput::make('address'),
                                $this->getPasswordFormComponent(),
                                $this->getPasswordConfirmationFormComponent(),
                            ])->columns(1),
                    ])
            ])->columns(12);
    }
}
