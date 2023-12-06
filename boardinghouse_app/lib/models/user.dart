// class User {
//   int? id;
//   String? userName;
//   String? email;
//   String? phone;
//   String? avatar;
//   String? role;
//   String? name;
//   String? gender;
//   String? address;
//   String? token;

//   User(
//       {this.id,
//       this.userName,
//       this.email,
//       this.phone,
//       this.avatar,
//       this.role,
//       this.name,
//       this.gender,
//       this.address,
//       this.token});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//         id: json['id'],
//         userName: json['user_name'],
//         email: json['email'],
//         phone: json['phone'],
//         avatar: json['avatar'],
//         role: json['role'],
//         name: json['name'],
//         gender: json['gender'],
//         address: json['address'],
//         token: json['token']);
//   }
// }

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
  // DateTime? birthday;
  String? token;

  User(
      {this.id,
      this.userName,
      this.email,
      this.phone,
      this.avatar,
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
        role: json['user']['role'],
        name: json['user']['name'],
        gender: json['user']['gender'],
        address: json['user']['address'],
        token: json['token']);
  }
}

// class User {
//   int? id;
//   String? userName;
//   String? email;
//   String? phone;
//   String? avatar;
//   String? role;
//   String? name;
//   String? gender;
//   String? address;
//   // DateTime? birthday;
//   String? token;

//   User(
//       {this.id,
//       this.userName,
//       this.email,
//       this.phone,
//       this.avatar,
//       this.role,
//       this.name,
//       this.gender,
//       this.address,
//       // this.birthday,
//       this.token});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//         id: json['data']['id'],
//         userName: json['data']['user_name'],
//         email: json['data']['email'],
//         phone: json['data']['phone'],
//         avatar: json['data']['avatar'],
//         role: json['data']['role'],
//         name: json['data']['name'],
//         gender: json['data']['gender'],
//         address: json['data']['address'],
//         token: json['token']);
//   }
// }
