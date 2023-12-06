import 'dart:convert';
import 'dart:io';
import 'auth_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<ApiResponse> login(String login, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(ApiConstants.apiLogin),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          'login': login,
          'password': password,
        },
      ),
    );

    print("Response from server: ${response.body}");
    switch (response.statusCode) {
      case 201:
        apiResponse.data = User.fromJson(jsonDecode(response.body));

        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
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

// Register
Future<ApiResponse> register(
    String username, String email, String phone, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(ApiConstants.apiRegister),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          'user_name': username,
          'email': email,
          'phone': phone,
          'password': password,
        },
      ),
    );

    switch (response.statusCode) {
      case 201:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
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

// get User
Future<ApiResponse> getUserDetail(int userId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('$apiUser/$userId'),
        // final response = await http.get(Uri.parse(ApiConstants.apiUserProfile),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        });
    // print("Response from server: ${response.body}");

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(json.decode(response.body));
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

// // get User
// Future<ApiResponse> getUserDetail() async {
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String token = await getToken();
//     // final response = await http.get(
//     //   Uri.parse('$ApiConstants.apiUser/$userId'),
//     final response = await http.get(Uri.parse(ApiConstants.apiUserProfile),
//         headers: {
//           "Content-Type": "application/json",
//           'Authorization': 'Bearer $token'
//         });
//     // print("Response from server: ${response.body}");

//     switch (response.statusCode) {
//       case 200:
//         apiResponse.data = User.fromJson(json.decode(response.body));
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
//     print(e);
//   }
//   return apiResponse;
// }

// Update user
Future<ApiResponse> updateUser(
    String name, String gender, String address, String? image) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse(ApiConstants.apiUpdateUser),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: image == null
            ? json.encode({
                'name': name,
                'gender': gender,
                'address': address,
                // 'birthday': birthday
              })
            : json.encode({
                'name': name,
                'gender': gender,
                'address': address,
                // 'birthday': birthday,
                'image': image
              }));

    // user can update his/her name or name and image

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
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

// get token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

// get user id
Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}

// logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}

// Get base64 encoded image
String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}
