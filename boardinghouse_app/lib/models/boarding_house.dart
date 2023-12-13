import 'package:boardinghouse_app/models/Evaluate.dart';
import 'package:boardinghouse_app/models/boarding_house_type.dart';

import 'user.dart';
import 'util.dart';

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
  List<dynamic>? urlImages;
  int? userid;
  int? boardingHouseTypeId;

  BoardingHouseType? boardingHouseType;
  User? user;
  List<Utils>? utils;
  List<Evaluate>? evaluates;

  BoardingHouse({
    this.id,
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
    this.urlImages,
    this.status,
    this.userid,
    this.boardingHouseTypeId,
    this.boardingHouseType,
    this.user,
    this.utils,
    this.evaluates,
  });

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
      // openTime: json['open_time'],
      // closeTime: json['close_time'],
      description: json['description'],
      address: json['address'],
      urlIamge: json['url_featured_image'],
      urlImages: json['url_images'],
      // favourite: json['favourite'],
      status: json['status'],
      userid: json['user_id'],
      boardingHouseTypeId: json['boarding_house_type_id'],
      boardingHouseType: BoardingHouseType(
          id: json['boarding_house_type']['id'],
          name: json['boarding_house_type']['name']),
      user: User(
        id: json['user']['id'],
        userName: json['user']['user_name'],
        urlAvatar: json['user']['url_avatar'],
      ),
      utils:
          List<Utils>.from(json['utils'].map((util) => Utils.fromJson(util))),
      evaluates: List<Evaluate>.from(
        json['evaluates'].map((evaluate) => Evaluate.fromJson(evaluate)),
      ),
    );
  }
}
