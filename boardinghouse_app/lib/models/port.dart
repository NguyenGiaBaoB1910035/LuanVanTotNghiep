class Post {
  int? id;
  int? userId;
  String? name;
  String? content;
  int? boardingHouseId;
  DateTime? dateCreated;
  DateTime? dateUpdated;
  int? view;

  Post({
    this.id,
    this.userId,
    this.name,
    this.content,
    this.boardingHouseId,
    this.dateCreated,
    this.dateUpdated,
    this.view,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      content: json['content'],
      boardingHouseId: json['boarding_house_id'],
      dateCreated: json['date_created'] != null ? DateTime.parse(json['date_created']) : null,
      dateUpdated: json['date_updated'] != null ? DateTime.parse(json['date_updated']) : null,
      view: json['view'],
    );
  }
}


// import 'package:boardinghouse_app/models/boarding_house.dart';
// import 'package:boardinghouse_app/models/user.dart';

// class Post {
//   final String? id;
//   final List<User> user;
//   final List<BoardingHouse> boardinghouse;
//   final String content;
//   final int view;
//   Post(
//       {this.id,
//       required this.user,
//       required this.boardinghouse,
//       required this.content,
//       required this.view});
// }
