import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:boardinghouse_app/models/user.dart';

class Post {
  int? id;
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
      user: User(
        id: json['user']['id'],
        userName: json['user']['user_name'],
        avatar: json['user']['avatar'],
      ),
      boardingHouse: BoardingHouse(
          id: json['boardingHouse']['id'],
          name: json['boardingHouse']['name'],
          image: json['boardingHouse']['featured_image_id'], //???
          type: json['boardingHouse']['type'],
          price: json['boardingHouse']['price'] //???
          ),
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
