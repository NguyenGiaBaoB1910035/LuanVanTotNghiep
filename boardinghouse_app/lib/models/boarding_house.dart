import 'package:boardinghouse_app/models/boarding_house_type.dart';

import 'user.dart';

class BoardingHouse {
  int? id;
  String? name;
  String? image; //???
  String? type; //???
  String? roomNumber;
  String? acreage;
  String? capacity;
  String? price;
  String? depositPrice;
  String? electricPrice;
  String? waterPrice;
  String? openTime;
  String? closeTime;
  String? description;
  String? address;
  // String? favourite;
  String? status;
  String? urlIamge;

  int? userid;
  int? boardingHouseTypeId;
  User? user;
  BoardingHouseType? boardingHouseType;

  BoardingHouse(
      {this.id,
      this.name,
      this.image, //???
      this.type, //??
      this.roomNumber,
      this.acreage,
      this.capacity,
      this.price,
      this.depositPrice,
      this.electricPrice,
      this.waterPrice,
      this.openTime,
      this.closeTime,
      this.description,
      this.address,
      // this.favourite,
      this.urlIamge,
      this.status,
      this.userid,
      this.boardingHouseTypeId,
      this.user,
      this.boardingHouseType});

  factory BoardingHouse.fromJson(Map<String, dynamic> json) {
    return BoardingHouse(
      id: json['id'],
      name: json['name'],
      image: json['featured_image_id'], //???
      type: json['type'], //???
      roomNumber: json['room_number'],
      acreage: json['acreage'],
      capacity: json['capacity'],
      price: json['price'],
      depositPrice: json['deposit_price'],
      electricPrice: json['electric_price'],
      waterPrice: json['water_price'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
      description: json['description'],
      address: json['address'],
      urlIamge: json['url_featured_image'],
      // favourite: json['favourite'],
      status: json['status'],
      userid: json['user_id'],
      boardingHouseTypeId: json['boarding_house_type_id'],
      user: User(
        id: json['user']['id'],
        userName: json['user']['user_name'],
        avatar: json['user']['avatar'],
      ),
      boardingHouseType: BoardingHouseType(id: json['id'], name: json['name']),
    );
  }
}
