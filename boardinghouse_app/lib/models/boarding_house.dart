import 'package:boardinghouse_app/models/boarding_house_image.dart';
import 'package:boardinghouse_app/models/boarding_house_type.dart';
import 'user.dart';

class BoardingHouse {
  int? id;
  String? name;
  String? slug;
  String? type;
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
  String? favourite;
  String? status;
  int? userid;
  User? user;

  BoardingHouse({
    this.id,
    this.name,
    this.slug,
    this.type,
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
    this.favourite,
    this.status,
    this.userid,
    this.user
  });

  factory BoardingHouse.fromJson(Map<String, dynamic> json) {
    return BoardingHouse(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      type: json['type'],
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
      favourite: json['favourite'],
      status: json['status'],
      userid: json['user_id'],
      user: User.fromJson(json["user"]),
    );
  }
}
