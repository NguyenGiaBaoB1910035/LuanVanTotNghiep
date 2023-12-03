import 'dart:convert';

import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/Evaluate.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:http/http.dart' as http;

// Get post comments
Future<ApiResponse> getComments(int boardingHouseId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$ApiConstants.apiBoardingHouse/$boardingHouseId/evalutes'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

    switch (response.statusCode) {
      case 200:
        // map each comments to comment model
        apiResponse.data = jsonDecode(response.body)['evalutes']
            .map((p) => Evaluate.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
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

// Create comment
Future<ApiResponse> createComment(
    int boardingHouseId, int rating, String? comment) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse('$ApiConstants.apiBoardingHouse/$boardingHouseId/comments'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: comment == null
            ? json.encode(
                {
                  'rating': rating,
                },
              )
            : json.encode({
                'rating': rating,
                'comment': comment,
              }));

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
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

// Delete comment
Future<ApiResponse> deleteComment(int commentId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('$ApiConstants.apiEvaluate/$commentId'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
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

// Edit comment
// Future<ApiResponse> editComment(int commentId, String comment) async {
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String token = await getToken();
//     final response = await http.put(Uri.parse('$commentsURL/$commentId'),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token'
//         },
//         body: {
//           'comment': comment
//         });

//     switch (response.statusCode) {
//       case 200:
//         apiResponse.data = jsonDecode(response.body)['message'];
//         break;
//       case 403:
//         apiResponse.error = jsonDecode(response.body)['message'];
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
