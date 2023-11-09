class UtilBoardingHouse {
  int? id;
  int? utilId;
  int? boardingHouseId;

  UtilBoardingHouse({
    this.id,
    this.utilId,
    this.boardingHouseId,
  });

  factory UtilBoardingHouse.fromJson(Map<String, dynamic> json) {
    return UtilBoardingHouse(
      id: json['id'],
      utilId: json['util_id'],
      boardingHouseId: json['boarding_house_id'],
    );
  }
}
