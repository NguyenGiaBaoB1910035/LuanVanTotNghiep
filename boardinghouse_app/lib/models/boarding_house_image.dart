class BoardingHouseImage {
  String? id;
  String? imageUrl;

  BoardingHouseImage({
    this.id,
    this.imageUrl,
  });

  factory BoardingHouseImage.fromJson(Map<String, dynamic> json) {
    return BoardingHouseImage(
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
    };
  }
}

