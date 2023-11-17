import 'dart:convert';
import 'package:http/http.dart' as http;
import '../apis/constant.dart';
import '../models/place_model/place_model.dart';

class Repo {
  Repo._();
  static Future<PredictionModel?> placeAutoComplete(
      {required String placeInput}) async {
    try {
      Map<String, dynamic> querys = {
        'input': placeInput,
        'key': AppString.google_map_api_key
      };
      final url = Uri.https(
          "maps.googleapis.com", "maps/api/place/autocomplete/json", querys);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print(url);
        print(response.body);
        return PredictionModel.fromJson(jsonDecode(response.body));
      } else {
        // response.body;
        print('Lỗi: ${response.statusCode}');
        return null; // hoặc xử lý lỗi theo cách khác
      }
    } on Exception catch (e) {
      print(e.toString());
    }

    return null;
  }
}
