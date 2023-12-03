import 'dart:convert';
import 'dart:math';
import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:http/http.dart' as http;

import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/models/port.dart';

class PostApi {
  Future<List<Post>?> getAllPost() async {
    try {
      var url = Uri.parse(ApiConstants.apiBoardingHouse);
      var response = await http.get(url);

      // In ra nội dung phản hồi từ máy chủ dưới dạng chuỗi
      print("Response from server: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> postData = jsonData['data'];
        List<Post> posts =
            postData.map((postJson) => Post.fromJson(postJson)).toList();

        return posts;
      } else {
        throw Exception('PostApi: Failed to getPost');

        // Xử lý khi phản hồi không thành công
        // log("Failed to fetch data: ${response.statusCode}");
        // return null;
      }
    } catch (e) {
      print(e);
      rethrow;
      // Xử lý khi có lỗi
      // log("Error fetching data: $e");
      // return null;
    }
  }

  Future<String> createPost(
      String content, int userId, int boardingHouseId) async {
    try {
      String token = await AuthApi().getToken();
      // int userId = await AuthApi().getUserId();
      var url = Uri.parse(ApiConstants.apiRegister);

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: json.encode(
          {
            'user_id': userId,
            'content': content,
            'boarding_house_id': boardingHouseId
          },
        ),
      );

      print("Response from server: ${response.body}");

      if (response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        String status = responseJson['status'];

        return status;
      } else {
        // Xử lý lỗi nếu cần thiết
        throw Exception('PostAPi: Failed to createPost');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
