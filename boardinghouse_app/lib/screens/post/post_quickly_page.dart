import 'package:boardinghouse_app/apis/boarding_house_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:boardinghouse_app/screens/components/card_boarding_house_post.dart';
import 'package:flutter/material.dart';

class PostQuicklyPage extends StatefulWidget {
  const PostQuicklyPage({super.key});

  @override
  State<PostQuicklyPage> createState() => _PostQuicklyPageState();
}

class _PostQuicklyPageState extends State<PostQuicklyPage> {
  List<dynamic> _boardigHouseList = [];
  bool _loading = true;
  //get BoardingHouse
  void getListBoardingHouse() async {
    try {
      int userId = await getUserId();
      ApiResponse response = await getBoardingHousesUserId(userId);
      if (response.error == null) {
        setState(() {
          _boardigHouseList = response.data as List<dynamic>;
          // _loading = _loading ? !_loading : _loading;
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

  @override
  void initState() {
    super.initState();
    getListBoardingHouse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            color: const Color.fromRGBO(0, 177, 237, 1),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushNamed('main');
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Đăng tin nhanh",
            style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
          )),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('createBHP');
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tạo nhà trọ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(0, 177, 237, 1),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.add_circle_outline,
                    color: Color.fromRGBO(0, 177, 237, 1),
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text("Danh sách nhà trọ của bạn"),
          ),
          ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: _boardigHouseList.length,
              itemBuilder: (BuildContext context, int index) {
                BoardingHouse boardingHouse = _boardigHouseList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(children: [
                        Row(
                          children: [
                            Container(
                                width: 150,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  "${boardingHouse.urlIamge}",
                                  fit: BoxFit.fitHeight,
                                )
                                // Image.asset(
                                //   "assets/images/anh.jpg",
                                //   fit: BoxFit.fitHeight,
                                // ),
                                ),
                            Container(
                              width: MediaQuery.of(context).size.width - 190,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                       const  EdgeInsets.only(left: 10, bottom: 2.5),
                                    child: Text('${boardingHouse.boardingHouseType!.name}'),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 2.5),
                                    child: Text(
                                      "${boardingHouse.name}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: false,
                                      style: const  TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 2.5),
                                    child: Text(
                                      "${boardingHouse.price}",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // const Padding(
                                  //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                                  //   child: Text(
                                  //     "40B/49, Trần Hoàng Na, Hưng Lợi",
                                  //     overflow: TextOverflow.ellipsis,
                                  //   ),
                                  // ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 2.5),
                                    child: Text("${boardingHouse.address}"),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('createpost');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.black26)),
                                height: 35,
                                width:
                                    MediaQuery.of(context).size.width * 1 / 2 -
                                        20,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.post_add,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      'Đăng bài',
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          4 -
                                      8,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black26)),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        'Sửa',
                                        style: TextStyle(color: Colors.green),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          4 -
                                      8,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black26)),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        'Xóa',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ]),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
