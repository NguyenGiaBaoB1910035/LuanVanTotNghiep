import 'dart:convert';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class UserApi {
  Future<List<User>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.apiUser);
      var response = await http.get(url);

      // In ra nội dung phản hồi từ máy chủ dưới dạng chuỗi
      print("Response from server: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> userData = jsonData['data'];
        List<User> users =
            userData.map((userJson) => User.fromJson(userJson)).toList();

        return users;
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

  // Future<User> getUserProfile( int userId) async {
  //   try {
  //     var url = Uri.parse(ApiConstants.apiUserProfile);
  //     var response = await http.get(url);

  //     // In ra nội dung phản hồi từ máy chủ dưới dạng chuỗi
  //     print("Response from server: ${response.body}");

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonData = json.decode(response.body);
  //       List<dynamic> userData = jsonData['data'];
  //       List<User> users =
  //           userData.map((userJson) => User.fromJson(userJson)).toList();

  //       return users;
  //     } else {
  //       // Xử lý khi phản hồi không thành công
  //       log("Failed to fetch data: ${response.statusCode}");
  //       return null;
  //     }
  //   } catch (e) {
  //     // Xử lý khi có lỗi
  //     log("Error fetching data: $e");
  //     return null;
  //   }
  // }
}
