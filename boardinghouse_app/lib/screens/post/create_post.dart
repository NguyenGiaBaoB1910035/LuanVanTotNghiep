import 'dart:io';
import 'package:boardinghouse_app/apis/boarding_house_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/post_api.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  final int boardingHouseId;

  const CreatePost({required this.boardingHouseId, Key? key}) : super(key: key);
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  BoardingHouse? _boardingHouse;
  // bool loading = false;

  void getBoardingHouse() async {
    int boardingHouseId = widget.boardingHouseId;
    ApiResponse response = await getBoardingHousesDetail(boardingHouseId);

    if (response.error == null) {
      setState(() {
        _boardingHouse = response.data as BoardingHouse;
        // loading = true;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      print("loiiooioioio");
    }
  }

  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  String content = '';
  String title = '';
  DateTime dateCreated = DateTime.now();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _txtTitleController = TextEditingController();
  final TextEditingController _txtContentController = TextEditingController();

  void _createPost() async {
    int _userId = await getUserId();

    ApiResponse response = await createPost(
      _userId,
      widget.boardingHouseId,
      _txtTitleController.text,
      _txtContentController.text,
      _imageFile,
      dateCreated
    );

    if (response.error == null) {
      Navigator.of(context).pop();
    } else if (response.error == unauthorized) {
      logout().then((value) => {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        // _loading = !_loading;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Đăng tin",
          style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: _txtTitleController,
                    // maxLines: 6,
                    style: const TextStyle(fontSize: 20),
                    // textDirection: ,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tên tin',
                      // labelText: 'Nội dung cho nhà trọ của bạn?'
                    ),
                    onChanged: (value) {
                      setState(() {
                        content = (value);
                      });
                    },
                  ),
                ),
                Divider(
                  color: Colors.black45,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _txtContentController,
                    maxLines: 5,
                    style: TextStyle(fontSize: 20),
                    // textDirection: ,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nội dung cho nhà trọ của bạn?',
                      // labelText: 'Nội dung cho nhà trọ của bạn?'
                    ),
                    onChanged: (value) {
                      setState(() {
                        content = (value);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        image: DecorationImage(
                            image: FileImage(_imageFile ?? File('')),
                            fit: BoxFit.cover),
                      ),
                    ),
                    onTap: () {
                      getImage();
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(5),
                //   child: Row(
                //     children: [
                //       Container(
                //         width: 150,
                //         height: 90,
                //         decoration: BoxDecoration(
                //           color: Colors.blue,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child:
                //             // Image.network(
                //             // "${_boardingHouse!.urlIamge}",
                //             // fit: BoxFit.cover,
                //             // )
                //             Image.asset(
                //           "assets/images/anh.jpg",
                //           fit: BoxFit.fitHeight,
                //         ),
                //       ),
                //       Container(
                //         alignment: Alignment.topLeft,
                //         width: MediaQuery.of(context).size.width - 160,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Padding(
                //               padding:
                //                   const EdgeInsets.only(left: 10, bottom: 2.5),
                //               child: Text(
                //                   "${_boardingHouse!.boardingHouseType!.name}"),
                //             ),
                //             Padding(
                //               padding:
                //                   const EdgeInsets.only(left: 10, bottom: 2.5),
                //               child: Text(
                //                 "${_boardingHouse!.name}",
                //                 overflow: TextOverflow.ellipsis,
                //                 maxLines: 2,
                //                 softWrap: false,
                //                 style: TextStyle(fontWeight: FontWeight.bold),
                //               ),
                //             ),
                //             Padding(
                //               padding: EdgeInsets.only(left: 10, bottom: 2.5),
                //               child: Text(
                //                 "${_boardingHouse!.price}",
                //                 style: const TextStyle(
                //                     color: Colors.blue,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ),
                //             Padding(
                //               padding: EdgeInsets.only(left: 10, bottom: 2.5),
                //               child: Text(
                //                 "${_boardingHouse!.address}",
                //                 overflow: TextOverflow.ellipsis,
                //                 maxLines: 2,
                //                 softWrap: false,
                //               ),
                //             )
                //       ],
                //     ),
                //   )
                // ],
                // ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: ElevatedButton(
                      onPressed: () {
                        _createPost();
                      },
                      child: Container(
                        // decoration: const BoxDecoration(
                        //     color: Colors.blue,
                        //     borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: const Center(
                          child: Text(
                            'Đăng tin',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
