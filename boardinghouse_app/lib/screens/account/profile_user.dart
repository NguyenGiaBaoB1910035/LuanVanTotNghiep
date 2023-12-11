import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/user.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  bool loading = true;

  void getUser() async {
    int userId = await getUserId();
    ApiResponse response = await getUserDetail(userId);
    print('profile:');
    if (response.error == null) {
      setState(() {
        _user = response.data as User;
        loading = false;
        // txtNameController.text = user!.name ?? '';
      });
    } else if (response.error == unauthorized) {
      logout()
          .then((value) => {Navigator.of(context).pushNamed('edit_profile')});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          color: const Color.fromRGBO(0, 177, 237, 1),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          buildAddButton(context),
        ],
      ),
      body: Column(children: [
        Center(
            child: GestureDetector(
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                image: _user!.urlAvatar != null
                    ? DecorationImage(
                        image: NetworkImage('${_user!.urlAvatar}'),
                        fit: BoxFit.cover)
                    : const DecorationImage(
                        // image: FileImage(_imageFile ?? File('')),
                        image: AssetImage("assets/images/avatar.jpg"),
                        fit: BoxFit.cover),
                color: Colors.amber),
          ),
          onTap: () {
            // getImage();
          },
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            '${_user?.userName}',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            leading: const Icon(
              Icons.email,
              size: 35,
            ),
            title: Text(
              '${_user?.email}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            leading: const Icon(
              Icons.phone,
              size: 35,
            ),
            title: Text(
              '${_user?.phone}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            leading: const Icon(
              Icons.person,
              size: 35,
            ),
            title: _user?.name != null
                ? Text(
                    '${_user?.name}',
                    style: const TextStyle(fontSize: 20),
                  )
                : const Text(
                    '...',
                    style: TextStyle(fontSize: 20),
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            leading: const Icon(
              Icons.transgender,
              size: 35,
            ),
            title: _user?.gender != null
                ? Text(
                    '${_user?.gender}',
                    style: const TextStyle(fontSize: 20),
                  )
                : const Text(
                    '...',
                    style: TextStyle(fontSize: 20),
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            leading: const Icon(
              Icons.place,
              size: 35,
            ),
            title: _user?.address != null
                ? Text(
                    '${_user?.address}',
                    style: const TextStyle(fontSize: 20),
                  )
                : const Text(
                    '...',
                    style: TextStyle(fontSize: 20),
                  ),
          ),
        ),
      ]),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit, color: Color.fromRGBO(0, 177, 237, 1)),
      onPressed: () {
        Navigator.of(context).pushNamed('edit_profile');
      },
    );
  }
}
