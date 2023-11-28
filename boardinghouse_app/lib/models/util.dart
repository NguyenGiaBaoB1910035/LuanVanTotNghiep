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
  String? id;
  String? name;
  String? imageUrl; // Add a property for the image URL

  Utils({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory Utils.fromJson(Map<String, dynamic> json) {
    return Utils(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'], // Update to the actual key for the image URL
    );
  }
}
