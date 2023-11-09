class BoardingHouseImage {
  int? id;
  String? name;
  int? boardingHouseId;

  BoardingHouseImage({
    this.id,
    this.name,
    this.boardingHouseId,
  });

  factory BoardingHouseImage.fromJson(Map<String, dynamic> json) {
    return BoardingHouseImage(
      id: json['id'],
      name: json['name'],
      boardingHouseId: json['boarding_house_id'],
    );
  }
}
