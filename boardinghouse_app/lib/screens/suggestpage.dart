// import 'package:boardinghouse_app/screens/bottombar.dart';
import 'package:boardinghouse_app/apis/boarding_house_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:flutter/material.dart';

// import '../components/card_boarding_house_detail.dart';

class SuggestPage extends StatefulWidget {
  const SuggestPage({super.key});

  @override
  State<SuggestPage> createState() => _SuggestPageState();
}

class _SuggestPageState extends State<SuggestPage> {
  List<dynamic> _boardigHouseList = [];

  //get BoardingHouse
  void getListBoardingHouse() async {
    try {
      ApiResponse response = await getBoardingHouses();
      if (response.error == null) {
        setState(() {
          _boardigHouseList = response.data as List<dynamic>;
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
            color: Color.fromRGBO(0, 177, 237, 1),
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushNamed('main');
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Phòng gợi ý",
            style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
          )),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Số cột
                  childAspectRatio: 1 / 1.4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20 // Tỉ lệ chiều cao theo chiều rộng
                  ),
              itemCount: _boardigHouseList.length,
              itemBuilder: (BuildContext context, int index) {
                BoardingHouse boardingHouse = _boardigHouseList[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('boardinghousedetail');
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 2.5),
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image:
                                    NetworkImage('${boardingHouse.urlIamge}'),
                                // AssetImage("assets/images/anh.jpg"),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            // child: Container(
                            //     margin: EdgeInsets.only(top: 5, right: 5),
                            //     alignment: Alignment.topRight,
                            //     child: InkWell(
                            //       onTap: () {
                            //         setState(() {
                            //           isFavorite = !isFavorite;
                            //         });
                            //       },
                            //       child: Icon(
                            //           isFavorite ? Icons.favorite : Icons.favorite_border,
                            //           color: Colors.red),
                            //     )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2.5),
                            child: Text(
                              "${boardingHouse.type}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2.5),
                            child: Text(
                              "${boardingHouse.name}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2.5),
                            child: Text(
                              "${boardingHouse.price}",
                              style: const TextStyle(
                                  fontSize: 16,
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2.5),
                            child: Text(
                              "${boardingHouse.address}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      )),
                );
              },
            )),
      ),
    );
  }
}
