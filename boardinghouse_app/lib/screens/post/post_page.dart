import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/post_api.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/port.dart';
import 'package:boardinghouse_app/screens/boardinghouse/boarding_house_detail_page.dart';
import 'package:boardinghouse_app/screens/components/card_post.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<dynamic> _postList = [];
  bool _loading = true;
  int userId = 0;

  //get BoardingHouse
  void _getPosts() async {
    try {
      userId = await getUserId();
      ApiResponse response = await getPosts();
      if (response.error == null) {
        setState(() {
          _postList = response.data as List<dynamic>;
          _loading = _loading ? !_loading : _loading;
        });
      } else if (response.error == unauthorized) {
        logout().then((value) => {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
        print("response.error getListBoardingHouse ${response.error}");
      }
    } catch (e) {
      print('Error in getListBoardingHouse: $e');
    }
  }

  void _deleteEvaluate(int postId) async {
    ApiResponse response = await deletePost(postId);

    if (response.error == null) {
      _getPosts();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (context) => Login()),
            //     (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    super.initState();
    _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Bảng tin",
          style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('postquickly');
              },
              icon: Icon(
                Icons.add_circle,
                color: Color.fromRGBO(0, 177, 237, 1),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     // height: 50,

            //     color: Colors.white,
            //     child:
            //         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //       // Container(
            //       //     margin: EdgeInsets.all(5),
            //       //     width: 250,
            //       //     decoration: const BoxDecoration(
            //       //         color: Color(0xF5F5F5F5),
            //       //         borderRadius: BorderRadius.all(
            //       //           Radius.circular(15),
            //       //         )),
            //       //     child: TextFormField(
            //       //       decoration: const InputDecoration(
            //       //         icon: Padding(
            //       //           padding: EdgeInsets.only(left: 20),
            //       //           child: Icon(
            //       //             Icons.search,
            //       //             color: Color.fromRGBO(0, 177, 237, 1),
            //       //           ),
            //       //         ),
            //       //         hintText: "Tìm bài đăng",
            //       //         border: InputBorder.none,
            //       //       ),
            //       //     )),
            //       Padding(
            //         padding: const EdgeInsets.only(right: 20),
            //         child: ElevatedButton(
            //           // style: ButtonStyle(),
            //           onPressed: () {},
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Icon(
            //                 Icons.post_add,
            //                 color: Colors.white,
            //               ),
            //               Text(
            //                 'Đăng tin',
            //                 style: TextStyle(color: Colors.white),
            //               )
            //             ],
            //           ),
            //         ),
            //       )
            //     ]),
            //   ),
            // ),
//----------------------------------------------------------------------------------//
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(8),
                  // itemCount: _postList.length,
                  itemCount: _postList
                      .where((boardingHouse) => boardingHouse.status != "0")
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    // Post post = _postList[index];
                    List<Post> filteredList = _postList
                        .where((boardingHouse) => boardingHouse.status != "0")
                        .cast<Post>() // Explicitly cast to List<BoardingHouse>
                        .toList();

                    Post post = filteredList[_postList
                            .where(
                                (boardingHouse) => boardingHouse.status != "0")
                            .length -
                        1 -
                        index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.all(10),
                              //       child: Container(
                              //           width: 40,
                              //           height: 40,
                              //           decoration: const BoxDecoration(
                              //               color: Colors.blue,
                              //               borderRadius: BorderRadius.all(
                              //                   Radius.circular(50))),
                              //           child: const CircleAvatar(
                              //             backgroundImage: AssetImage(
                              //               "assets/images/avatar.jpg",
                              //             ),
                              //           )),
                              //     ),
                              //     const Text(
                              //       "Gia Bảo",
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.w600,
                              //           fontSize: 20),
                              //     )
                              //   ],
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Container(
                                      child: Text(
                                        "${post.name}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  post.userId == userId
                                      ? PopupMenuButton(
                                          child: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.more_vert,
                                                color: Colors.black,
                                              )),
                                          itemBuilder: (context) => [
                                            // const PopupMenuItem(
                                            //     child: Text('Sửa'),
                                            //     value: 'edit'),
                                            const PopupMenuItem(
                                                child: Text('Xóa'),
                                                value: 'delete')
                                          ],
                                          onSelected: (val) {
                                            if (val == 'delete') {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             PostForm(
                                              //               title: 'Edit Post',
                                              //               post: post,
                                              //             )));

                                              _deleteEvaluate(post.id!);
                                            }
                                          },
                                        )
                                      : Container(
                                          child: null,
                                        )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '${post.content}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              post.image == null
                                  ? Container()
                                  : Center(
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          height: 180,
                                          child: Image.network(
                                            "${post!.image}",
                                            fit: BoxFit.cover,
                                          )
                                          // Image.asset(
                                          //   "assets/images/anh.jpg",
                                          //   fit: BoxFit.cover,
                                          // ),
                                          ),
                                    ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                BoardingHouseDetailPage(
                                                  boardingHouseId:
                                                      post.boardingHouseId!,
                                                )));
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "tới nhà trọ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Color.fromRGBO(0, 177, 237, 1)),
                                      ),
                                      Icon(
                                        Icons.send_sharp,
                                        size: 15,
                                        color: Color.fromRGBO(0, 177, 237, 1),
                                      )
                                    ],
                                  )),
                            ]),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
