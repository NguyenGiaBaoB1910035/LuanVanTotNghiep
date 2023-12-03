class BoardingHouseType {
  int? id;
  String? name;
  // String? featuredImageId;
  // String? slug;
  // String? description;
  // int? position;
  // bool? isVisible;
  // int? sort;

  BoardingHouseType({
    this.id,
    this.name,
    // this.featuredImageId,
    // this.slug,
    // this.description,
    // this.position,
    // this.isVisible,
    // this.sort,
  });

  factory BoardingHouseType.fromJson(Map<String, dynamic> json) {
    return BoardingHouseType(
      id: json['id'],
      name: json['name'],
      // featuredImageId: json['featured_image_id'],
      // slug: json['slug'],
      // description: json['description'],
      // position: json['position'],
      // isVisible: json['is_visible'],
      // sort: json['sort'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'featured_image_id': featuredImageId,
  //     'slug': slug,
  //     'description': description,
  //     'position': position,
  //     'is_visible': isVisible,
  //     'sort': sort,
  //   };
  // }
}

