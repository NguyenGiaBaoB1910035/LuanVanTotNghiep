import 'package:flutter/material.dart';

class Util {
  final String? id;
  final IconData icon;
  final String name;
  bool isSelected;

  Util(
      {this.id,
      required this.icon,
      required this.name,
      this.isSelected = false});
}

class Utils {
  int? id;
  String? name;
  String? imageUrl;
  bool isSelected;

  Utils({
    this.id,
    this.name,
    this.imageUrl,
    this.isSelected = false,
  });

  factory Utils.fromJson(Map<String, dynamic> json) {
    return Utils(
      id: json['id'],
      name: json['name'],
      imageUrl: json['url_icon'], // Update to the actual key for the image URL
    );
  }
}
