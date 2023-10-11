import 'package:flutter/material.dart';

class BoardingHouse {
  final String id; // Room ID
  final String roomType; // Room Type
  final String address; // Address
  final String roomNumber; // Number of Rooms
  final String capacity; // Capacity
  final String gender; // Gender Requirement
  final String area; // Area
  final String roomPrice; // Room Price
  final String deposit; // Deposit
  final String electricityPrice; // Electricity Price
  final String waterPrice; // Water Price
  final TimeOfDay openingTime; // Opening Time
  final TimeOfDay closingTime; // Closing Time
  final String description; // Description
  final String favorite = '0'; // Favorite

  BoardingHouse({
    required this.id,
    required this.roomType,
    required this.address,
    required this.roomNumber,
    required this.capacity,
    required this.gender,
    required this.area,
    required this.roomPrice,
    required this.deposit,
    required this.electricityPrice,
    required this.waterPrice,
    required this.openingTime,
    required this.closingTime,
    required this.description,
    required favorite,
  });
}
