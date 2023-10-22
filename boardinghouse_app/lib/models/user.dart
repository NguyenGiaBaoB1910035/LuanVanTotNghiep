import 'package:flutter/material.dart';

class User {
  final String id;
  final String user_name;
  final String email;
  final String phone;
  final String password;
  final String avatar;
  final String role;
  final String name;
  final String gender;
  final String address;
  final String birthday;
final String email_verifie_at;

  User({
    required this.id,
    required this.user_name,
    required this.email,
    required this.phone,
    required this.password,
    required this.avatar,
    required this.role,
    required this.name,
    required this.gender,
    required this.address,
    required this.birthday,
    required this.email_verifie_at
  });

  Map<String, dynamic> toJson() {
    return {
       'id' : id,
      ' user_name': user_name,
       'email' : email,
       'phone': phone,
       'password' :password,
       'avatar' :avatar,
       'role' :role,
       'name' :name,
      'gender' :gender,
       'address' :address,
       'birthday' :birthday,
       'email_verifie_at' :email_verifie_at
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
       id:json['id'],
       user_name:json['user_name'],
       email:json['email'],
       phone:json['phone'],
       password:json['password'],
       avatar:json['avatar'],
       role:json['role'],
       name:json['name'],
       gender:json['gender'],
       address:json['address'],
       birthday:json['birthday'],
       email_verifie_at:json['email_verifie_at'],
    );
  }
}

// class User {
//   final String id;
//   final String username;
//   // final String phone;
//   // final String? email;
//   // final String? password;
//   final String avatar;
//   // final String? gender;
//   // final String? address;
//   // final String? birthday;
//   User({
//     required this.id,
//     required this.username,
//     // required this.phone,
//     // required this.email,
//     required this.avatar,
//     // this.gender,
//     // this.address,
//     // this.birthday
//   });
// }

// List<User> users = [
//   User(id: '1', username: 'GiaBao', avatar: 'assets/images/avatar.jpg'),
//   User(id: '2', username: 'GiaBao2', avatar: 'assets/images/avatar.jpg'),
//   User(id: '3', username: 'GiaBao3', avatar: 'assets/images/avatar.jpg'),
//   User(id: '4', username: 'GiaBao4', avatar: 'assets/images/avatar.jpg'),
//   User(id: '5', username: 'GiaBao5', avatar: 'assets/images/avatar.jpg'),
//   User(id: '6', username: 'GiaBao6', avatar: 'assets/images/avatar.jpg'),
// ];

// final User currentUser = User(
//   id: '0',
//   username: 'Nick Fury',
//   avatar: 'assets/images/nick-fury.jpg',
// );
