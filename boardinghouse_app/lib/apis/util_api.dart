import 'dart:convert';
import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/util.dart';
import 'package:http/http.dart' as http;
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/models/api_response.dart';

Future<ApiResponse> getUtil() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiUtil), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    });

    print('responsr from server getUtil');
    print(response.body);

    switch (response.statusCode) {
      case 200:
        if (jsonDecode(response.body)['data'] != null) {
          // Mapping từ danh sách JSON thành danh sách đối tượng BoardingHouseType
          List<Utils> utils = (jsonDecode(response.body)['data'] as List)
              .map((utilsJson) => Utils.fromJson(utilsJson))
              .toList();
          // Gán danh sách vào apiResponse.data
          apiResponse.data = utils;
          print('apiResponse.data');
          print(apiResponse.data);
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
