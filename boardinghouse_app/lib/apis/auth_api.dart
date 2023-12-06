// import 'dart:convert';
// import 'dart:io';

// import 'package:boardinghouse_app/apis/constant.dart';
// import 'package:boardinghouse_app/models/user.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';


//   Future<String> authLogin(String login, String password) async {
//     try {
//       var url = Uri.parse(ApiConstants.apiLogin);

//       var response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: json.encode(
//           {
//             'login': login,
//             'password': password,
//           },
//         ),
//       );

//       print("Response from server: ${response.body}");

//       if (response.statusCode == 201) {
//         final responseJson = json.decode(response.body);
//         String token =
//             responseJson['token']; // Điều chỉnh tùy theo cấu trúc của API

//         // Lưu token vào SharedPreferences
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setString('token', token);

//         return token;
//       } else {
//         // Xử lý lỗi nếu cần thiết
//         throw Exception('AthuApi: Failed to authenticate');
//       }
//     } catch (error) {
//       print("login_api failed: $error");
//       rethrow;
//     }
//   }

//   Future<String> authRegister(
//       String username, String email, String phone, String password) async {
//     try {
//       var url = Uri.parse(ApiConstants.apiRegister);

//       var response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: json.encode(
//           {
//             'user_name': username,
//             'email': email,
//             'phone': phone,
//             'password': password,
//           },
//         ),
//       );

//       print("Response from server: ${response.body}");

//       if (response.statusCode == 201) {
//         final responseJson = json.decode(response.body);
//         String status = responseJson['status'];

//         return status;
//       } else {
//         // Xử lý lỗi nếu cần thiết
//         throw Exception('AthuApi: Failed to authenticate');
//       }
//     } catch (error) {
//       print(error);
//       rethrow;
//     }
//   }

//   Future<User> getUserProfile() async {
//     try {
//       String token = await getToken();
//       print(token);
//       var url = Uri.parse(ApiConstants.apiUserProfile);

//       var response = await http.get(
//         url,
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token"
//         },
//       );

//       print("Response from server: ${response.body}");

//       if (response.statusCode == 200) {
//         final user = User.fromJson(json.decode(response.body));
//         return user;
//       } else {
//         // Xử lý lỗi nếu cần thiết
//         throw Exception('AuthApi: Failed to get user profile');
//       }
//     } catch (error) {
//       print(error);
//       rethrow;
//     }
//   }

//   Future<String> getToken() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     return pref.getString('token') ?? '';
//   }

// // get user id
//   Future<int> getUserId() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     return pref.getInt('userId') ?? 0;
//   }

// // logout
//   Future<bool> logout() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     return await pref.remove('token');
//   }

//   // Get base64 encoded image
//   String? getStringImage(File? file) {
//     if (file == null) return null;
//     return base64Encode(file.readAsBytesSync());
//   }

