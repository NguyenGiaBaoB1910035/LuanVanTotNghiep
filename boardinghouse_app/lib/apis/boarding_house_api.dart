import 'dart:convert';
// import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:boardinghouse_app/models/api_response.dart';

//get boardinghouse
Future<ApiResponse> getBoardingHouses() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiBoardingHouse), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['boadingHouses']
            .map((p) => BoardingHouse.fromJson(p))
            .toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> createBoardingHouse(
    int userId,
    String type,
    String name,
    String address,
    String roomNumber,
    String acreage,
    String capacity,
    String price,
    String depositPrice,
    String electricPrice,
    String waterPrice,
    String openTime,
    String closeTime,
    String description,
    String image) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse(apiBoardingHouse),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: json.encode(
        {
          'user_id': userId,
          'type': type,
          'name': name,
          'featured_image_id': image,
          'room_number': roomNumber,
          'acreage': acreage,
          'capacity': capacity,
          'price': price,
          'deposit_price': depositPrice,
          'electric_price': electricPrice,
          'water_price': waterPrice,
          'open_time': openTime,
          'close_time': closeTime,
          'description': description,
          'address': address,
        },
      ),
    );
    // here if the image is null we just send the body, if not null we send the image too
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        print(response.body);
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Edit boardinghouse
Future<ApiResponse> editBoardingHouse(
    int boardingHouseId,
    String type,
    String name,
    String address,
    String roomNumber,
    String acreage,
    String capacity,
    String price,
    String depositPrice,
    String electricPrice,
    String waterPrice,
    String openTime,
    String closeTime,
    String image) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(
      Uri.parse('$ApiConstants.apiBoardingHouse/$boardingHouseId'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: json.encode(
        {
          'type': type,
          'name': name,
          // 'slug',
          'featured_image_id': image,
          'room_number': roomNumber,
          'acreage': acreage,
          'capacity': capacity,
          'price': price,
          'deposit_price': depositPrice,
          'electric_price': electricPrice,
          'water_price': waterPrice,
          'open_time': openTime,
          'close_time': closeTime,
          'description': depositPrice,
          'address': address,
          // 'user_id': userId,
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// Delete boardinghouse
Future<ApiResponse> deleteBoardingHouse(int boardingHouseId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(
        Uri.parse('$ApiConstants.apiBoardingHouse/$boardingHouseId'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//get all boardinghouse
// Future<List<BoardingHouse>?> getBoardingHouseTypes() async {
//   try {
//     var url = Uri.parse(ApiConstants.apiBoardingHouse);
//     var response = await http.get(url);

//     // In ra nội dung phản hồi từ máy chủ dưới dạng chuỗi
//     print("Response from server: ${response.body}");

//     if (response.statusCode == 200) {
//       Map<String, dynamic> jsonData = json.decode(response.body);
//       List<dynamic> boardinghouseData = jsonData['data'];
//       List<BoardingHouse> boardinghouses = boardinghouseData
//           .map((boardinghouseJson) => BoardingHouse.fromJson(boardinghouseJson))
//           .toList();

//       return boardinghouses;
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
