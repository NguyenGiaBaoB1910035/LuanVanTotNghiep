import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:boardinghouse_app/models/user.dart';
import 'package:flutter/material.dart';

class Post {
  final String? id;
  final List<User> user;
  final List<BoardingHouse> boardinghouse;
  final String content;
  final int view;
  Post(
      {this.id,
      required this.user,
      required this.boardinghouse,
      required this.content,
      required this.view});
}
