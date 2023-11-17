import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceSearchScreen extends StatefulWidget {
  @override
  _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final String apiKey =
      'AIzaSyBNEUDMuDUf5GH6dbcqsRdeg2NYG4yRWA8'; // Thay thế bằng khóa API của bạn
  TextEditingController _searchController = TextEditingController();
  late GoogleMapController _mapController;
  Set<Marker> _markers = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm Kiếm Địa Điểm'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Nhập địa điểm',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchPlace();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                });
              },
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0),
                zoom: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchPlace() async {
    final String input = _searchController.text;
    final String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$input&key=$apiKey';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);

      if (json.containsKey('results') && json['results'].isNotEmpty) {
        var place = json['results'][0];
        var location = place['geometry']['location'];

        double lat = location['lat'];
        double lng = location['lng'];

        setState(() {
          _markers.clear();
          _markers.add(
            Marker(
              markerId: MarkerId(place['place_id']),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: place['name']),
            ),
          );

          _mapController.animateCamera(
            CameraUpdate.newLatLng(LatLng(lat, lng)),
          );
        });
      } else {
        print('Không tìm thấy địa điểm');
      }
    } else {
      print('Lỗi khi tải dữ liệu. Mã trạng thái: ${response.statusCode}');
    }
  }
}
