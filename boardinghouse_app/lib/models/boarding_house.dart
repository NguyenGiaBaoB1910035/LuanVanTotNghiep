class BoardingHouse {
  int? id;
  String? type;
  String? name;
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
  int? userId;

  BoardingHouse({
    this.id,
    this.type,
    this.name,
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
    this.userId,
  });

  factory BoardingHouse.fromJson(Map<String, dynamic> json) {
    return BoardingHouse(
      id: json['id'],
      type: json['type'],
      name: json['name'],
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
      userId: json['user_id'],
    );
  }
}
