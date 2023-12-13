import 'package:boardinghouse_app/apis/boarding_house_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:flutter/material.dart';

class BoardingHouseProvider with ChangeNotifier {
  List<BoardingHouse> _boardigHouseList = [];

  //get BoardingHouse
  void getListBoardingHouse() async {
    ApiResponse response = await getBoardingHouses();
    if (response.error == null) {
      _boardigHouseList = response.data as List<BoardingHouse>;
    }

    notifyListeners();
  }

  BoardingHouse? findById(String id) {
    try {
      return _boardigHouseList.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }
}
