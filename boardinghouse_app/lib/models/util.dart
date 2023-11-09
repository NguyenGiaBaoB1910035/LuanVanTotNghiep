import 'package:flutter/material.dart';

class Util {
  final String? id;
  final IconData icon;
  final String name;
  bool isSelected;

  Util({this.id, required this.icon, required this.name, this.isSelected = false});
}

// class Util {
//   int? id;
//   String? name;

//   Util({
//     this.id,
//     this.name,
//   });

//   factory Util.fromJson(Map<String, dynamic> json) {
//     return Util(
//       id: json['id'],
//       name: json['name'],
//     );
//   }
// }

