import 'package:boardinghouse_app/apis/boarding_house_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:boardinghouse_app/screens/boardinghouse/boarding_house_detail_page.dart';
import 'package:boardinghouse_app/screens/components/card_boarding_house_detail.dart';
// import 'package:boardinghouse_app/screens/home/suggestpage.dart';
import 'package:flutter/material.dart';

class SuggestUI extends StatefulWidget {
  const SuggestUI({super.key});

  @override
  State<SuggestUI> createState() => _SuggestUIState();
}

class _SuggestUIState extends State<SuggestUI> {
  List<dynamic> _boardigHouseList = [];
  bool _loading = true;

  //get BoardingHouse
  void getListBoardingHouse() async {
    try {
      ApiResponse response = await getBoardingHouses();
      if (response.error == null) {
        setState(() {
          _boardigHouseList = response.data as List<dynamic>;
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

  @override
  void initState() {
    super.initState();
    getListBoardingHouse();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Phòng gợi ý",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Số cột
                      childAspectRatio: 1 / 1.4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20 // Tỉ lệ chiều cao theo chiều rộng
                      ),
                  // itemCount: _boardigHouseList.length > 10
                  //     ? 10
                  //     : _boardigHouseList.length,
                  itemCount: _boardigHouseList
                              .where((boardingHouse) =>
                                  boardingHouse.status != "0")
                              .length >
                          10
                      ? 10
                      : _boardigHouseList
                          .where((boardingHouse) => boardingHouse.status != "0")
                          .length,
                  itemBuilder: (BuildContext context, int index) {
                    List<BoardingHouse> filteredList = _boardigHouseList
                        .where((boardingHouse) => boardingHouse.status != "0")
                        .cast<
                            BoardingHouse>() // Explicitly cast to List<BoardingHouse>
                        .toList();

                    BoardingHouse boardingHouse = filteredList[_boardigHouseList
                            .where(
                                (boardingHouse) => boardingHouse.status != "0")
                            .length -
                        1 -
                        index];

                    // BoardingHouse boardingHouse =
                    //     _boardigHouseList[_boardigHouseList.length - 1 - index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BoardingHouseDetailPage(
                                      boardingHouseId: boardingHouse.id!,
                                    )));
                        // Navigator.of(context).pushNamed('boardinghousedetail');
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
                                    image: Image.network(
                                      '${boardingHouse.urlIamge}',
                                    ).image,
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
                                  "${boardingHouse.boardingHouseType!.name}",
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                  }),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Divider(
                  color: Colors.black54,
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('suggest');
                    },
                    child: const Text(
                      "Xem tất cả",
                      style: TextStyle(fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
