import 'dart:convert';
import 'package:boardinghouse_app/models/util.dart';
import 'package:http/http.dart' as http;
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/models/api_response.dart';

Future<ApiResponse> getUtil() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    // String token = await getToken();
    final response = await http.get(Uri.parse(ApiConstants.apiUtil), headers: {
      "Content-Type": "application/json",
      // 'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['util']
            .map((p) => Utils.fromJson(p))
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
