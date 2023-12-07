import 'dart:io';

import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/user.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User? _user;
  bool loading = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _imageFile;
  final _picker = ImagePicker();
  TextEditingController txtNameController = TextEditingController();
  TextEditingController txtGenderController = TextEditingController();
  TextEditingController txtAddressController = TextEditingController();

  // Future getImage() async {
  //   final pickedFile = await _picker.getImage(source: ImageSource.gallery);
  //   if (pickedFile != null){
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //     });
  //   }
  // }
  Future getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // get user detail
  void getUser() async {
    int userId = await getUserId();
    ApiResponse response = await getUserDetail(userId);
    print('edit profile:');
    if (response.error == null) {
      setState(() {
        _user = response.data as User;
        loading = false;
        txtNameController.text = _user!.name ?? '';
        txtGenderController.text = _user!.gender ?? '';
        txtAddressController.text = _user!.address ?? '';
        // txtBirthdayController.text = _user!. ?? '';
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  //update profile
  void updateProfile() async {
    int userId = await getUserId();
    ApiResponse response = await updateUser(
        userId,
        txtNameController.text,
        txtGenderController.text,
        txtAddressController.text,
        // txtBirthdayController.text,
        getStringImage(_imageFile));
    setState(() {
      loading = false;
    });
    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.data}')));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            // Navigator.of(context).pushAndRemoveUntil(MateriagealPRoute(builder: (context)=>Login()), (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Center(
              child: GestureDetector(
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  image: _imageFile == null
                      ? _user!.urlAvatar != null
                          ? DecorationImage(
                              image: NetworkImage('${_user!.urlAvatar}'),
                              fit: BoxFit.cover)
                          : null
                      : DecorationImage(
                          image: FileImage(
                              _imageFile ?? File('assets/images/avatar.jpg')),
                          // image: AssetImage("assets/images/avatar.jpg"),
                          fit: BoxFit.cover),
                  color: Colors.amber),
            ),
            onTap: () {
              getImage();
            },
          )),
          SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "họ và tên",
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                  controller: txtNameController,
                  validator: (val) => val!.isEmpty ? 'Invalid Name' : null,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "giới tính",
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                  controller: txtGenderController,
                  validator: (val) => val!.isEmpty ? 'Invalid gender' : null,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "địa chỉ",
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black))),
                  controller: txtAddressController,
                  validator: (val) => val!.isEmpty ? 'Invalid address' : null,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

          TextButton(
              child: Text(
                "Lưu",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.blue),
                  padding: MaterialStateProperty.resolveWith(
                      (states) => EdgeInsets.symmetric(vertical: 10))),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                }
                updateProfile();
                Navigator.of(context).pushNamed('profile');
              })
          // SizedBox(
          //   height: 20,
          // ),
          // Center(
          //   child: Text(
          //     '${_user?.userName}',
          //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.email,
          //       size: 35,
          //     ),
          //     title: Text(
          //       '${_user?.email}',
          //       style: TextStyle(fontSize: 20),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.phone,
          //       size: 35,
          //     ),
          //     title: Text(
          //       '${_user?.phone}',
          //       style: TextStyle(fontSize: 20),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.person,
          //       size: 35,
          //     ),
          //     title: _user?.name != null
          //         ? Text(
          //             '${_user?.name}',
          //             style: TextStyle(fontSize: 20),
          //           )
          //         : Text(
          //             '...',
          //             style: TextStyle(fontSize: 20),
          //           ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //   child: ListTile(
          //     leading: const Icon(
          //       Icons.transgender,
          //       size: 35,
          //     ),
          //     title: _user?.gender != null
          //         ? Text(
          //             '${_user?.gender}',
          //             style: TextStyle(fontSize: 20),
          //           )
          //         : Text(
          //             '...',
          //             style: TextStyle(fontSize: 20),
          //           ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.place,
          //       size: 35,
          //     ),
          //     title: _user?.address != null
          //         ? Text(
          //             '${_user?.address}',
          //             style: TextStyle(fontSize: 20),
          //           )
          //         : Text(
          //             '...',
          //             style: TextStyle(fontSize: 20),
          //           ),
          //   ),
          // ),
        ]),
      ),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit, color: Color.fromRGBO(0, 177, 237, 1)),
      onPressed: () {
        // Navigator.of(context).pushNamed(

        // );
      },
    );
  }

//   Widget InputDecoration  kInputDecoration(String label) {
//   return InputDecoration(
  // labelText: label,
  // contentPadding: EdgeInsets.all(10),
  // border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black))
//     );
// }
}
