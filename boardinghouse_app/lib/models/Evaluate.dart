// import 'package:flutter/material.dart';

class Evalute {
  final String username;
  final String? boardinghouse;
  final String comment;
  final int rating;

  Evalute({required this.username, this.boardinghouse, required this.comment, required this.rating});
}

class Evaluate {
  int? id;
  double? rating;
  String? comment;
  int? userId;
  int? boardingHouseId;

  Evaluate({
    this.id,
    this.rating,
    this.comment,
    this.userId,
    this.boardingHouseId,
  });

  factory Evaluate.fromJson(Map<String, dynamic> json) {
    return Evaluate(
      id: json['id'],
      rating: json['rating']?.toDouble(),
      comment: json['comment'],
      userId: json['user_id'],
      boardingHouseId: json['boarding_house_id'],
    );
  }
}

