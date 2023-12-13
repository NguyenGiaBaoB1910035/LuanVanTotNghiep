import 'dart:io';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _txtTitleController = TextEditingController();
  final TextEditingController _txtContentController = TextEditingController();

  // void _createPost() async {
  //   int _userId = await getUserId();

  //   ApiResponse response = await createPost(
  //     _userId,
  //     boardingHouseId,
  //     _txtTitleController.text,
  //     _txtContentController.text,
  //     _imageFile,
  //   );

  //   if (response.error == null) {
  //     Navigator.of(context).pop();
  //   } else if (response.error == unauthorized) {
  //     logout().then((value) => {});
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('${response.error}')));
  //     setState(() {
  //       // _loading = !_loading;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   color: const Color.fromRGBO(0, 177, 237, 1),
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  // maxLines: 6,
                  style: TextStyle(fontSize: 20),
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
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/images/anh.jpg",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width - 160,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 2.5),
                            child: Text("Phòng cho Thuê"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 2.5),
                            child: Text(
                              "Nhà trọ Hoàng Gia",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 2.5),
                            child: Text(
                              "1.200.000 VND",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 2.5),
                            child: Text(
                              "40B/49, Trần Hoàng Na,Hưng Lợi,  Ninh Kiều, Cần Thơ",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: ElevatedButton(
                    onPressed: () {},
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
    );
  }
}
