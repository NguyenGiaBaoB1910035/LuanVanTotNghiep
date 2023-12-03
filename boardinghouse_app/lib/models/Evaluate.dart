// import 'package:flutter/material.dart';

import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:boardinghouse_app/models/user.dart';

class Evalute {
  final String username;
  final String? boardinghouse;
  final String comment;
  final int rating;

  Evalute(
      {required this.username,
      this.boardinghouse,
      required this.comment,
      required this.rating});
}

class Evaluate {
  int? id;
  int? rating;
  String? comment;
  User? user;
  // BoardingHouse? boardingHouse;

  Evaluate({
    this.id,
    this.rating,
    this.comment,
    this.user,
    // this.boardingHouse,
  });

  factory Evaluate.fromJson(Map<String, dynamic> json) {
    return Evaluate(
      id: json['id'],
      rating: json['rating'],
      comment: json['comment'],
      user: User(id: json['user']['id'], userName: json['user']['user_name']),
    );
  }
}
