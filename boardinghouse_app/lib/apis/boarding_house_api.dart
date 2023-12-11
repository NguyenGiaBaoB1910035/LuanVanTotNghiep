import 'dart:convert';
import 'dart:io';
import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:http/http.dart' as http;
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

    print("responsr from server getBoardingHouses");
    print(response.body);

    switch (response.statusCode) {
      case 200:
        if (jsonDecode(response.body)['data'] != null) {
          // Mapping từ danh sách JSON thành danh sách đối tượng BoardingHouseType
          List<BoardingHouse> boardingHouses =
              (jsonDecode(response.body)['data'] as List)
                  .map((boardinghouseJson) =>
                      BoardingHouse.fromJson(boardinghouseJson))
                  .toList();
          // Gán danh sách vào apiResponse.data
          apiResponse.data = boardingHouses;
          print('apiResponse.data');
          print(apiResponse.data);
        } else {
          apiResponse.error = null;
        }

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
    print(e);
  }
  return apiResponse;
}

Future<ApiResponse> createBoardingHouse(
    int userId,
    int type,
    String name,
    String address,
    String roomNumber,
    String acreage,
    String capacity,
    String price,
    String depositPrice,
    String electricPrice,
    String waterPrice,
    DateTime openTime,
    DateTime closeTime,
    DateTime publishedAt,
    // String openTime,
    // String closeTime,
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
          'boarding_house_type_id': type,
          'name': name,
          'featured_image': image,
          'room_number': roomNumber,
          'acreage': acreage,
          'capacity': capacity,
          'price': price,
          'deposit_price': depositPrice,
          'electric_price': electricPrice,
          'water_price': waterPrice,
          'open_time': openTime,
          'close_time': closeTime,
          'published_at': publishedAt,
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
        print(apiResponse.error);
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

Future<ApiResponse> uploadImagesBoardingHouse(
    int boardingHouseId, List<String> imagePaths) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    var uri = Uri.parse('$apiBoardingHouse/upload-pictures/$boardingHouseId');

    var request = http.MultipartRequest('POST', uri);
    request.headers['Content-Type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';

    // Thêm trường dữ liệu vào FormData
    request.fields['boarding_house_id'] = boardingHouseId.toString();

    // Thêm ảnh vào FormData
    for (var imagePath in imagePaths) {
      var file = await http.MultipartFile.fromPath('images', imagePath);
      request.files.add(file);
    }

    var response = await request.send();

    // Đọc response
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    // Xử lý response
    print(responseString);

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(responseString);
        break;
      case 422:
        final errors = jsonDecode(responseString)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        print(responseString);
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print('Error: $e');
    apiResponse.error = serverError;
  }
  return apiResponse;
}
