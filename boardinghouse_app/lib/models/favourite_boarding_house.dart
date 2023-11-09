class FavouriteBoardingHouse {
  int? id;
  int? userId;
  int? boardingHouseId;
  String? status;

  FavouriteBoardingHouse({
    this.id,
    this.userId,
    this.boardingHouseId,
    this.status,
  });

  factory FavouriteBoardingHouse.fromJson(Map<String, dynamic> json) {
    return FavouriteBoardingHouse(
      id: json['id'],
      userId: json['user_id'],
      boardingHouseId: json['boarding_house_id'],
      status: json['status'],
    );
  }
}
