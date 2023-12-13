import 'package:boardinghouse_app/screens/components/card_post.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
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
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: 50,

                color: Colors.white,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  // Container(
                  //     margin: EdgeInsets.all(5),
                  //     width: 250,
                  //     decoration: const BoxDecoration(
                  //         color: Color(0xF5F5F5F5),
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(15),
                  //         )),
                  //     child: TextFormField(
                  //       decoration: const InputDecoration(
                  //         icon: Padding(
                  //           padding: EdgeInsets.only(left: 20),
                  //           child: Icon(
                  //             Icons.search,
                  //             color: Color.fromRGBO(0, 177, 237, 1),
                  //           ),
                  //         ),
                  //         hintText: "Tìm bài đăng",
                  //         border: InputBorder.none,
                  //       ),
                  //     )),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      // style: ButtonStyle(),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.post_add,
                            color: Colors.white,
                          ),
                          Text(
                            'Đăng bài',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
//----------------------------------------------------------------------------------//
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(8),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
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
                              Center(
                                child: Text(
                                  "Title",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Hiện tại còn dư 4 phòng',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  height: 150,
                                  child: Image.asset(
                                    "assets/images/anh.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) =>
                                    //             BoardingHouseDetailPage(
                                    //               boardingHouseId:
                                    //                   boardingHouse.id!,
                                    //             )));
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
                                  )
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       width: 150,
                                  //       height: 90,
                                  //       decoration: BoxDecoration(
                                  //         color: Colors.blue,
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //       child: Image.asset(
                                  //         "assets/images/anh.jpg",
                                  //         fit: BoxFit.fitHeight,
                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       width: MediaQuery.of(context).size.width -
                                  //           150,
                                  //       child: const Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Padding(
                                  //             padding: EdgeInsets.only(
                                  //                 left: 10, bottom: 2.5),
                                  //             child: Text("Phòng cho Thuê"),
                                  //           ),
                                  //           Padding(
                                  //             padding: EdgeInsets.only(
                                  //                 left: 10, bottom: 2.5),
                                  //             child: Text(
                                  //               "Phòng cho Thuê Hoàng Gia, Quận Ninh Kiều, cần thơ ",
                                  //               overflow: TextOverflow.ellipsis,
                                  //               maxLines: 2,
                                  //               softWrap: false,
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.bold),
                                  //             ),
                                  //           ),
                                  //           Padding(
                                  //             padding: EdgeInsets.only(
                                  //                 left: 10, bottom: 2.5),
                                  //             child: Text(
                                  //               "1.200.000 VND",
                                  //               style: TextStyle(
                                  //                   color: Colors.blue,
                                  //                   fontWeight: FontWeight.bold),
                                  //             ),
                                  //           ),
                                  //           // const Padding(
                                  //           //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                                  //           //   child: Text(
                                  //           //     "40B/49, Trần Hoàng Na, Hưng Lợi",
                                  //           //     overflow: TextOverflow.ellipsis,
                                  //           //   ),
                                  //           // ),
                                  //           Padding(
                                  //             padding: EdgeInsets.only(
                                  //                 left: 10, bottom: 2.5),
                                  //             child: Text("Ninh Kiêu"),
                                  //           )
                                  //         ],
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  ),
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
