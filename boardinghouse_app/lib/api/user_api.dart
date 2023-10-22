import 'dart:convert';

import 'package:dio/dio.dart';

// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// class UserApi {
//   final String _url = 'http:// 10.10.38.179:8000/api/users';
//   getUser() async {
//     http.Response response = await http.get(Uri.parse(_url ));

//     try {
//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         return 'failed';
//       }
//     } catch (e) {
//       print(e);
//       return 'failed';
//     }
//   }
// }

class UserApi {
  final String _url = 'http://10.10.38.179:8000/api/users';
  Future<List> getAllUser() async {
    // var response = await http.get(Uri.parse(_url));
    try {
      var response = await http.get(Uri.parse(_url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
        // return json.decode(utf8.decode(response.bodyBytes));
      } else {
        return Future.error("looi");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

// Dio dio() {
//   Dio dio = new Dio();
//   dio.options.baseUrl = "http://10.10.38.179:8000/api/users";
//   dio.options.headers['accept'] = 'Application/Jon';
//   return dio;
// }

// class UserApi {
//   void getUser() async {
//     try {
//       var response = await Dio().get("http://10.10.38.179:8000/api/users");
//       print(response);
//       if (response.statusCode == 200) {
//         // return jsonDecode(response.body);
//         // return json.decode(utf8.decode(response.bodyBytes));
//       } else {
//         print(response.statusCode);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
