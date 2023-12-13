import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math';
import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:http/http.dart' as http;
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:path/path.dart';

//get all boardinghouse
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

//get BoardingHousesDetail
Future<ApiResponse> getBoardingHousesDetail(int boardingHouseId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse('$apiBoardingHouse/$boardingHouseId'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    });

    print("responsr from server getBoardingHouses");
    print(response.body);

    switch (response.statusCode) {
      case 200:
        // Assuming 'data' directly contains the single boarding house
        BoardingHouse boardingHouse =
            BoardingHouse.fromJson(jsonDecode(response.body)['data']);
        // Assign the single boarding house to apiResponse.data
        apiResponse.data = boardingHouse;
        print('apiResponse.data:');
        print(apiResponse.data);
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

//create boarding house
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
  String description,
  File? imageFile,
  List<File>? imageFiles,
  List<int>? utilityIds,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    var request = http.MultipartRequest('POST', Uri.parse(apiBoardingHouse))
      ..headers['Authorization'] = 'Bearer $token'
      ..fields.addAll({
        'user_id': userId.toString(),
        'boarding_house_type_id': type.toString(),
        'name': name,
        'room_number': roomNumber,
        'acreage': acreage,
        'capacity': capacity,
        'price': price,
        'deposit_price': depositPrice,
        'electric_price': electricPrice,
        'water_price': waterPrice,
        'description': description,
        'address': address,
        'utils': utilityIds!.join(','),
      });

    // if (utilityIds != null && utilityIds.isNotEmpty) {
    //   request.fields['id'] = utilityIds.map((id) => id.toString()).join(',');
    // }

    if (imageFile != null) {
      String fileExtension = extension(imageFile.path);
      if (fileExtension.toLowerCase() == '.png' ||
          fileExtension.toLowerCase() == '.jpg') {
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile('featured_image', stream, length,
            filename: basename(imageFile.path));
        request.files.add(multipartFile);
      } else {
        // Handle the case where the file extension is not allowed.
        apiResponse.error =
            "Invalid file type. Please choose a PNG or JPG image.";
        return apiResponse;
      }
    }
    // Add multiple image files
    if (imageFiles != null) {
      for (int i = 0; i < imageFiles.length; i++) {
        File imageFile = imageFiles[i];
        String fileExtension = extension(imageFile.path);
        if (fileExtension.toLowerCase() == '.png' ||
            fileExtension.toLowerCase() == '.jpg') {
          var stream = http.ByteStream(imageFile.openRead());
          var length = await imageFile.length();
          var multipartFile = http.MultipartFile('images[]', stream, length,
              filename: 'image$i$fileExtension');
          request.files.add(multipartFile);
        } else {
          // Handle the case where the file extension is not allowed.
          apiResponse.error =
              "Invalid file type. Please choose PNG or JPG images.";
          return apiResponse;
        }
      }
    }

    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(responseData);
        break;
      case 422:
        final errors = jsonDecode(responseData)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        print(apiResponse.error);
        break;
      default:
        print(responseData);
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
    print(e);
    developer.log("error: $e");
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
