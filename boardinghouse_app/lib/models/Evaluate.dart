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
  int? userId;
  // int? boardingHouseId;

  int? rating;
  String? content;
  User? user;
  // BoardingHouse? boardingHouse;

  Evaluate({
    this.id,
    this.rating,
    this.content,
    this.userId,
    // this.boardingHouseId,

    this.user,
  });

  factory Evaluate.fromJson(Map<String, dynamic> json) {
    return Evaluate(
      id: json['id'],
      rating: json['ratings'],
      content: json['content'],
      userId: json['user_id'],
      // boardingHouseId: json['boarding_house_id']
      user: User(
        id: json['user']['id'],
        userName: json['user']['user_name'],
        urlAvatar: json['user']['url_avatar'],
      ),
    );
  }
}
