import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MapAPI {
  final String key = 'AIzaSyBNEUDMuDUf5GH6dbcqsRdeg2NYG4yRWA8';

  Future<String?> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var json = convert.jsonDecode(response.body);

        if (json.containsKey('candidates') && json['candidates'].isNotEmpty) {
          var placeId = json['candidates'][0]['place_id'] as String;
          print('tìm thấy địa điểm');
          print(placeId);
          return placeId;
        } else {
          print('Không tìm thấy địa điểm');
          return null; // hoặc ném một exception, tùy thuộc vào yêu cầu cụ thể
        }
      } else {
        print('Lỗi khi tải dữ liệu. Mã trạng thái: ${response.statusCode}');
        return null; // hoặc ném một exception, tùy thuộc vào yêu cầu cụ thể
      }
    } catch (e) {
      print('Lỗi: $e');
      return null; // hoặc ném một exception, tùy thuộc vào yêu cầu cụ thể
    }
  }

  // Future<String> getPlaceId(String input) async {
  //   final String url =
  //       'http://maps.googleapis.com/maps/api/place/findplacefromtext/jons?input=$input&inputtype=textquery&key=$key';

  //   var response = await http.get(Uri.parse(url));

  //   var json = convert.jsonDecode(response.body);

  //   var placeId = json['candidates'][0]['place_id'] as String;

  //   print(placeId);

  //   return placeId;
  // }
}

class NetworkUtiliti {
  final String key = 'AIzaSyBNEUDMuDUf5GH6dbcqsRdeg2NYG4yRWA8';

  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final Response = await http.get(uri, headers: headers);
      if (Response.statusCode == 200) {
        return Response.body;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
