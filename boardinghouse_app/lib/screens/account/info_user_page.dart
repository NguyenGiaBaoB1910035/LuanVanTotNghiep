import 'package:boardinghouse_app/api/user_api.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

class InfoUserPage extends StatefulWidget {
  const InfoUserPage({super.key});

  @override
  State<InfoUserPage> createState() => _InfoUserPageState();
}

class _InfoUserPageState extends State<InfoUserPage> {
  // Future? _user;
  // @override
  // void initState() {
  //   super.initState();
  //   _user = UserApi().getAllUser();
  // }

  UserApi users = UserApi();

  // var jsonList;

  // @override
  // void initState() {
  //   super.initState();
  //   getUser();
  // }

  // void getUser() async {
  //   try {
  //     var response = await Dio().get("http://10.10.38.179:8000/api/users");
  //     print(response);
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         jsonList = response.data["data"] as List;
  //       });
  //     }
  //     //
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('show user'),
      ),
      //       body: SingleChildScrollView(
      //         child: ListView.builder(
      //             shrinkWrap: true,
      //             itemCount: 2,
      //             itemBuilder: (context, index) {
      //               return Card(
      //                 child: Column(children: [
      //                   Text('ebu'),
      //                   Text("iebi"),
      //                   Text("iebi"),
      //                   Text("iebi"),
      //                 ]),
      //               );
      //             }),
      //       ));
      // }

      body: Container(
          child: FutureBuilder<List>(
              future: UserApi().getAllUser(),
              builder: (context, snapshot) {
                print(
                    "//--------------------------------------------------//\n");

                print(snapshot);

                print(
                    "//--------------------------------------------------//\n");
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(children: [
                            Text("name"),
                            Text("phone"),
                            Text("email"),
                            Text("password"),
                          ]),
                        );
                      });
                } else {
                  return Center(
                    child: Text('kcos gif'),
                  );
                }
              })),
    );
  }
}


// var getUserInfo = await dio.get('https://localhost:8000/users/me',
//     options: Options(
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${response.data["token"]} ',
//       },
//     ));

// print(getUserInfo);