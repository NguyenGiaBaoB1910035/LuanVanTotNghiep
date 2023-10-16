<?php

namespace App\Filament\Pages\Auth;

use Filament\Forms\Components\{
    TextInput,
    DatePicker,
    Card,
    Grid,
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
                        TextInput::make('user_name')
                            ->required()
                            ->maxLength(255),
                        $this->getNameFormComponent(),
                        $this->getEmailFormComponent(),
                        TextInput::make('phone')->required(),
                        DatePicker::make('birthday')->required(),
                        TextInput::make('gender')->required(),
                        TextInput::make('address')->required(),
                        $this->getPasswordFormComponent(),
                        $this->getPasswordConfirmationFormComponent(),
                    ])
            ])->columns(12);
    }
}
