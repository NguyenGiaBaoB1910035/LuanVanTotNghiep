import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // late GoogleMapController mapController;

  final LatLng _center = const LatLng(10.029971997636826, 105.77060993558173);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  late GoogleMapController _controller;

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: const Color.fromRGBO(0, 177, 237, 1),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Tìm kiếm trên bản đồ",
          style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
        ),
      ),
      body: GoogleMap(
        // mapToolbarEnabled: true,
        // myLocationButtonEnabled: true,
        onMapCreated: onMapCreated,
        initialCameraPosition:
            CameraPosition(target: _center, zoom: 15, tilt: 0, bearing: 0),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        
        // markers: {
        //   const Marker(
        //     markerId: MarkerId('Đại học Cần Thơ'),
        //     position: LatLng(10.029971997636826, 105.77060993558173),
        //     infoWindow: InfoWindow(
        //       title: "'Đại học Cần Thơ",
        //       // snippet: "Capital of New South Wales",
        //     ),
        //   )
        // },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );

    
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
