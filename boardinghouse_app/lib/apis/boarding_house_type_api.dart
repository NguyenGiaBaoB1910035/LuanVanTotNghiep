import 'dart:convert';
import 'dart:math';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/boarding_house_type.dart';
import 'package:http/http.dart' as http;
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/models/api_response.dart';

Future<ApiResponse> getBoardingHouseType() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(apiBoardingHouseType), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    });

    print('responsr from server boardinghousetpyr');
    print(response.body);

    switch (response.statusCode) {
      case 200:
        // Kiểm tra xem dữ liệu từ API có tồn tại không
        if (jsonDecode(response.body)['data'] != null) {
          // Mapping từ danh sách JSON thành danh sách đối tượng BoardingHouseType
          List<BoardingHouseType> boardingHouseTypes =
              (jsonDecode(response.body)['data'] as List)
                  .map((boardinghousetypeJson) =>
                      BoardingHouseType.fromJson(boardinghousetypeJson))
                  .toList();
          // Gán danh sách vào apiResponse.data
          apiResponse.data = boardingHouseTypes;
          print('apiResponse.data');
          print(apiResponse.data);
        } else {
          // Nếu không có dữ liệu, bạn có thể xử lý tùy thuộc vào yêu cầu của bạn
          apiResponse.error = null;
        }

        // apiResponse.data = jsonDecode(response.body)['data']
        //     .map((p) => BoardingHouseType.fromJson(p))
        //     .toList();
        // // we get list of posts, so we need to map each item to post model
        // apiResponse.data as List<dynamic>;
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
