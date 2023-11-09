class User {
  int? id;
  String? userName;
  String? email;
  String? phone;
  String? avatar;
  String? role;
  String? name;
  String? gender;
  String? address;
  DateTime? birthday;

  User({
    this.id,
    this.userName,
    this.email,
    this.phone,
    this.avatar,
    this.role,
    this.name,
    this.gender,
    this.address,
    this.birthday,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['user_name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      role: json['role'],
      name: json['name'],
      gender: json['gender'],
      address: json['address'],
      birthday:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
    );
  }
}
