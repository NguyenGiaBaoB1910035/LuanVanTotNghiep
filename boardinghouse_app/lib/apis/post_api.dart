import 'dart:convert';
import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:http/http.dart' as http;

import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/models/port.dart';

Future<ApiResponse> getPosts() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(ApiConstants.apiPost), headers: {
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
Future<ApiResponse> createPost(int boardingHouseId, String content) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse(ApiConstants.apiPost),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: json.encode(
        {
          'content': content,
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
