// import 'package:boardinghouse_app/apis/user_api.dart';
// import 'package:boardinghouse_app/models/user.dart';
// import 'package:flutter/material.dart';

// class InfoUserPage extends StatefulWidget {
//   const InfoUserPage({Key? key});

//   @override
//   State<InfoUserPage> createState() => _InfoUserPageState();
// }

// class _InfoUserPageState extends State<InfoUserPage> {
//   late Future<List<User>?> _userListFuture;

//   @override
//   void initState() {
//     super.initState();
//     _userListFuture = UserApi().getUsers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Show Users'),
//       ),
//       body: Container(
//         child: FutureBuilder<List<User>?>(
//           future: _userListFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             } else if (snapshot.hasData && snapshot.data != null) {
//               List<User> users = snapshot.data!;
//               return ListView.builder(
//                 itemCount: users.length,
//                 itemBuilder: (context, index) {
//                   User user = users[index];
//                   return Card(
//                     child: Column(
//                       children: [
//                         Text("Name: ${user.name}"),
//                         Text("Phone: ${user.phone}"),
//                         Text("Email: ${user.email}"),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return Center(
//                 child: Text('No data available'),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
