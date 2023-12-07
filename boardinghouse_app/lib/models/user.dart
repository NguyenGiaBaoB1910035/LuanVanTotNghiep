class User {
  int? id;
  String? userName;
  String? email;
  String? phone;
  String? avatar;
  String? urlAvatar;
  String? role;
  String? name;
  String? gender;
  String? address;
  // DateTime? birthday;
  String? token;

  User(
      {this.id,
      this.userName,
      this.email,
      this.phone,
      this.avatar,
      this.urlAvatar,
      this.role,
      this.name,
      this.gender,
      this.address,
      // this.birthday,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        userName: json['user']['user_name'],
        email: json['user']['email'],
        phone: json['user']['phone'],
        avatar: json['user']['avatar'],
        urlAvatar: json['user']['url_avatar'],
        role: json['user']['role'],
        name: json['user']['name'],
        gender: json['user']['gender'],
        address: json['user']['address'],
        token: json['token']);
  }
}
