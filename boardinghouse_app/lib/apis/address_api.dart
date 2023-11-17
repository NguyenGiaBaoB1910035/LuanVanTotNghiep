import 'dart:convert';
import 'dart:math';
import 'dart:developer';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:http/http.dart' as http;

class AddressApi {
  Future<List<District>?> fetchDistrict() async {
    try {
      var url = Uri.parse(ApiAddress.addressUrl);
      var response = await http.get(url);
      print("Response from server: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> districtData = jsonData['data'];

        List<District> districts = districtData
            .map((districtJson) => District.fromJson(districtJson))
            .toList();

        return districts;
      } else {
        // log("Failed to fetch data: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // log("Error fetching data: $e");
      return null;
    }
  }

  Future<List<Ward>?> fetchWard(String districtsId) async {
    try {
      var response = await http
          .get(Uri.parse('https://provinces.open-api.vn/api/p/${districtsId}'));
      print("Response from server: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> wardData = jsonData['data'];

        List<Ward> ward =
            wardData.map((wardJson) => Ward.fromJson(wardJson)).toList();

        return ward;
      } else {
        // throw Exception('Failed to load districts');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class District {
  final String id;
  final String name;

  District({required this.id, required this.name});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['ID'],
      name: json['Title'],
    );
  }
}

class Ward {
  final String id;
  final String name;

  Ward({required this.id, required this.name});

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      id: json['ID'],
      name: json['Title'],
    );
  }
}
