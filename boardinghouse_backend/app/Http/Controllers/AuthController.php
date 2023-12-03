<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Validator;

class AuthController extends Controller
{
    public function __construct() {
        $this->middleware('auth:api', ['except' => ['login', 'register']]);
    }

    public function login(Request $request){
        $validator = Validator::make($request->all(), [
            'login' => 'required',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $loginType = filter_var($request->input('login'), FILTER_VALIDATE_EMAIL) ? 'email' : 'phone';

        $credentials = [
            $loginType => $request->input('login'),
            'password' => $request->input('password'),
        ];

        if (! $token = auth()->attempt($credentials)) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->createNewToken($token);
    }

    public function register(Request $request) {
        $validator = Validator::make($request->all(), [
            'user_name' => 'required|string|between:3,100',
            'email' => 'required|string|email|max:100|unique:users',
            'phone' => 'required|string|size:10|unique:users',
            'password' => 'required|string|min:6',
        ]);

        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }

        $user = User::create(array_merge(
                    $validator->validated(),
                    ['password' => bcrypt($request->password)]
                ));

        $token = Auth::login($user);

        return response()->json([
            'status' => 'success',
            'message' => 'User successfully registered',
            'user' => $user,
            'authorisation' => [
                'token' => $token,
                'type' => 'bearer',
            ]
        ], 201);
    }

    public function logout() {
        auth()->logout();

        return response()->json(['message' => 'User successfully signed out']);
    }

    public function refresh() {
        return $this->createNewToken(auth()->refresh());
    }

    protected function createNewToken($token){
        return response()->json([

            'token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth()->factory()->getTTL() * 60,
            'user' => auth()->user()
        ], 201);
    }

    public function userProfile() {
        return response()->json(auth('api')->user());
    }


    public function changePassWord(Request $request) {
        $validator = Validator::make($request->all(), [
            'old_password' => 'required|string|min:6',
            'new_password' => 'required|string|confirmed|min:6',
        ]);

        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }
        $userId = auth()->user()->id;

        $user = User::where('id', $userId)->update(
                    ['password' => bcrypt($request->new_password)]
                );

        return response()->json([
            'message' => 'User successfully changed password',
            'user' => $user,
        ], 201);
    }

     //update proflie
    /*public function update(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_name' => 'required|string',
            'name' => 'required|string',
            'gender' => 'required|string',
            'address' => 'required|string',
            'birthday' => 'required|string',
            'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors()->toJson(), 400);
        }

        $attrs = $validator->validated();
        $userId = auth()->user()->id;

        $dataToUpdate = [
            'user_name' => $attrs['user_name'],
            'name' => $attrs['name'],
            'gender' => $attrs['gender'],
            'address' => $attrs['address'],
            'birthday' => $attrs['birthday'],
        ];

        if ($request->hasFile('image')) {
            $image = $this->saveImage($request->file('image'), 'profiles');
            $dataToUpdate['image'] = $image;
        }

        auth()->user()->update($dataToUpdate);

        return response([
            'message' => 'User updated.',
            'user' => auth()->user(),
        ], 200);
    }*/

    // update user
    public function update(Request $request)
    {
        $attrs = $request->validate([
            'name' => 'required|string',
            'gender' => 'required|string',
            'address' => 'required|string',
        ]);

        $image = $this->saveImage($request->avatar, 'profiles');

        auth()->user()->update([
            'name' => $attrs['name'],
            'gender' => $attrs['gender'],
            'address' => $attrs['address'],
            'avatar' => $image
        ]);

        return response([
            'message' => 'User updated.',
            'user' => auth()->user()
        ], 201);
    }

}
