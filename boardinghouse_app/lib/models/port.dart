import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:boardinghouse_app/models/user.dart';

class Post {
  int? id;
  int? userId;
  int? boardingHouseId;
  // User? user;
  // BoardingHouse? boardingHouse;
  String? name;
  String? content;
  String? image;
  DateTime? dateCreated;
  DateTime? dateUpdated;
  int? view;

  Post({
    this.id,
    this.userId,
    this.boardingHouseId,
    // this.user,
    // this.boardingHouse,
    this.name,
    this.content,
    this.image,
    this.dateCreated,
    this.dateUpdated,
    this.view,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      boardingHouseId: json['boarding_house_id'],
      // user: User(
      //   id: json['user']['id'],
      //   userName: json['user']['user_name'],
      //   avatar: json['user']['avatar'],
      // ),
      // boardingHouse: BoardingHouse(
      //     id: json['boardingHouse']['id'],
      //     name: json['boardingHouse']['name'],
      //     image: json['boardingHouse']['featured_image_id'], //???
      //     type: json['boardingHouse']['type'],
      //     price: json['boardingHouse']['price'] //???
      //     ),
      name: json['name'],
      content: json['content'],
      image: json['url_featured_image'],
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
