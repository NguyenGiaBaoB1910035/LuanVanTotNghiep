import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:boardinghouse_app/models/user.dart';

class Post {
  String? id;
  User? user;
  BoardingHouse? boardingHouse;
  String? content;
  DateTime? dateCreated;
  DateTime? dateUpdated;
  int? view;

  Post({
    this.id,
    this.user,
    this.boardingHouse,
    this.content,
    this.dateCreated,
    this.dateUpdated,
    this.view,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
       id: json['id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      boardingHouse: json['boardingHouse'] != null
          ? BoardingHouse.fromJson(json['boardingHouse'])
          : null,
      content: json['content'],
      dateCreated: json['date_created'] != null
          ? DateTime.parse(json['date_created'])
          : null,
      dateUpdated: json['date_updated'] != null
          ? DateTime.parse(json['date_updated'])
          : null,
      view: json['view'],
    );
  }
}


