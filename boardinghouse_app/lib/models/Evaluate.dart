// import 'package:flutter/material.dart';

import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:boardinghouse_app/models/user.dart';

class Evalute {
  final String username;
  final String? boardinghouse;
  final String comment;
  final int rating;

  Evalute({required this.username, this.boardinghouse, required this.comment, required this.rating});
}

class Evaluate {
  String? id;
  double? rating;
  String? comment;
  User? user;
  BoardingHouse? boardingHouse;

  Evaluate({
    this.id,
    this.rating,
    this.comment,
    this.user,
    this.boardingHouse,
  });

  factory Evaluate.fromJson(Map<String, dynamic> json) {
    return Evaluate(
      id: json['id'],
      rating: json['rating']?.toDouble(),
      comment: json['comment'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      boardingHouse: json['boardingHouse'] != null
          ? BoardingHouse.fromJson(json['boardingHouse'])
          : null,
    );
  }
}

