import 'dart:io';

import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/user.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  bool loading = true;

  void getUser() async {
    ApiResponse response = await getUserDetail();
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
    // _loadUserProfile();
    getUser();
  }
  // late User _user;
  // File? _imageFile;
  // final _picker = ImagePicker();

  // @override
  // void initState() {
  //   super.initState();
  //   _loadUserProfile();
  // }

  // Future getImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  // Future<void> _loadUserProfile() async {
  //   try {
  //     User user = await AuthApi().getUserProfile();
  //     setState(() {
  //       _user = user;
  //     });
  //   } catch (error) {
  //     print('Failed to load user profile: $error');
  //   }
  // }

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
                image: _user!.avatar != null
                    ? DecorationImage(
                        image: NetworkImage('${_user!.avatar}'),
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
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            '${_user?.userName}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            leading: Icon(
              Icons.email,
              size: 35,
            ),
            title: Text(
              '${_user?.email}',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            leading: Icon(
              Icons.phone,
              size: 35,
            ),
            title: Text(
              '${_user?.phone}',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            leading: Icon(
              Icons.person,
              size: 35,
            ),
            title: _user?.name != null
                ? Text(
                    '${_user?.name}',
                    style: TextStyle(fontSize: 20),
                  )
                : Text(
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
                    style: TextStyle(fontSize: 20),
                  )
                : Text(
                    '...',
                    style: TextStyle(fontSize: 20),
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            leading: Icon(
              Icons.place,
              size: 35,
            ),
            title: _user?.address != null
                ? Text(
                    '${_user?.address}',
                    style: TextStyle(fontSize: 20),
                  )
                : Text(
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
