import 'package:flutter/material.dart';

class Util {
  final String? id;
  final IconData icon;
  final String name;
  bool isSelected;

  Util({this.id, required this.icon, required this.name, this.isSelected = false});
}
