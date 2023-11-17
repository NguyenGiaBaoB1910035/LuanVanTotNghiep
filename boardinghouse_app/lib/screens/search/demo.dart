// import 'package:flutter/material.dart';

// const kGoogleApiKey = "Api_key";

// GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

// class demo extends StatefulWidget {
//   @override
//   demoState createState() => new demoState();
// }

// class demoState extends State<demo> {
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         child: RaisedButton(
//           onPressed: () async {
//             // show input autocomplete with selected mode
//             // then get the Prediction selected
//             Prediction p = await PlacesAutocomplete.show(
//                 context: context, apiKey: kGoogleApiKey);
//             displayPrediction(p);
//           },
//           child: Text('Find address'),

//         )
//       )
//     );
//   }

//   Future<Null> displayPrediction(Prediction p) async {
//     if (p != null) {
//       PlacesDetailsResponse detail =
//       await _places.getDetailsByPlaceId(p.placeId);

//       var placeId = p.placeId;
//       double lat = detail.result.geometry.location.lat;
//       double lng = detail.result.geometry.location.lng;

//       var address = await Geocoder.local.findAddressesFromQuery(p.description);

//       print(lat);
//       print(lng);
//     }
//   }
// }