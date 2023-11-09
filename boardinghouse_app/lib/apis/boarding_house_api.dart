import 'dart:convert';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class BoardingHouseApi {
  Future<List<BoardingHouse>?> getBoardingHouses() async {
    try {
      var url = Uri.parse(ApiConstants.apiBoardingHouse);
      var response = await http.get(url);

      // In ra nội dung phản hồi từ máy chủ dưới dạng chuỗi
      print("Response from server: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> boardinghouseData = jsonData['data'];
        List<BoardingHouse> boardinghouses =
            boardinghouseData.map((boardinghouseJson) => BoardingHouse.fromJson(boardinghouseJson)).toList();

        return boardinghouses;
      } else {
        // Xử lý khi phản hồi không thành công
        log("Failed to fetch data: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Xử lý khi có lỗi
      log("Error fetching data: $e");
      return null;
    }
  }
}