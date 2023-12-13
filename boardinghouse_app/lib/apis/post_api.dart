import 'dart:convert';
import 'dart:io';
import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:http/http.dart' as http;

import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/models/port.dart';
import 'package:path/path.dart';

Future<ApiResponse> getPosts() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiPost), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['posts']
            .map((p) => Post.fromJson(p))
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

// Create post
Future<ApiResponse> createPost(
  int userId,
  int boardingHouseId,
  String name,
  String content,
  File? imageFile,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    var request = http.MultipartRequest('POST', Uri.parse(apiBoardingHouse))
      ..headers['Authorization'] = 'Bearer $token'
      ..fields.addAll({
        'user_id': userId.toString(),
        'boarding_house_id': boardingHouseId.toString(),
        'name': name,
        'room_number': content,
      });

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
    // developer.log("error: $e");
  }
  return apiResponse;
}

// Future<ApiResponse> createPost(int boardingHouseId, String name, String content) async {
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String token = await getToken();
//     final response = await http.post(
//       Uri.parse(apiPost),
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token'
//       },
//       body: json.encode(
//         {
//           'content': content,
//         },
//       ),
//     );

//     // here if the image is null we just send the body, if not null we send the image too

//     switch (response.statusCode) {
//       case 200:
//         apiResponse.data = jsonDecode(response.body);
//         break;
//       case 422:
//         final errors = jsonDecode(response.body)['errors'];
//         apiResponse.error = errors[errors.keys.elementAt(0)][0];
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       default:
//         print(response.body);
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }

// Edit post
Future<ApiResponse> editPost(int postId, String content) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse('$ApiConstants.apiPost/$postId'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: {
          'content': content
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

// Delete post
Future<ApiResponse> deletePost(int postId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .delete(Uri.parse('$ApiConstants.apiPost/$postId'), headers: {
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
