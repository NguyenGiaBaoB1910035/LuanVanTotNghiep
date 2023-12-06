// import 'package:boardinghouse_app/apis/constant.dart';
// import 'package:boardinghouse_app/apis/user_api.dart';
// import 'package:boardinghouse_app/models/api_response.dart';
// import 'package:boardinghouse_app/screens/authu/begin_page.dart';
// import 'package:boardinghouse_app/screens/authu/login_page.dart';
// import 'package:boardinghouse_app/screens/bottombar.dart';
// import 'package:flutter/material.dart';

// class Loading extends StatefulWidget {
//   @override
//   _LoadingState createState() => _LoadingState();
// }

// class _LoadingState extends State<Loading> {
//   void _loadUserInfo() async {
//     String token = await getToken();
//     if (token == '') {
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => BeginPage()),
//           (route) => false);
//     } else {
//       int userId = await getUserId();
//       ApiResponse response = await getUserDetail(userId);
//       if (response.error == null) {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => BottomBar()),
//             (route) => false);
//       } else if (response.error == unauthorized) {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => LoginPage()),
//             (route) => false);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('${response.error}'),
//         ));
//       }
//     }
//   }

//   @override
//   void initState() {
//     _loadUserInfo();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       color: Colors.white,
//       child: Center(child: CircularProgressIndicator()),
//     );
//   }
// }
