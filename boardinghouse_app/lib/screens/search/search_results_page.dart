import 'package:boardinghouse_app/apis/boarding_house_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:boardinghouse_app/screens/boardinghouse/boarding_house_detail_page.dart';
import 'package:flutter/material.dart';
// import '../components/card_boarding_house_detail.dart';

class SearchResultsPage extends StatefulWidget {
  // const SearchResultsPage({super.key});

  final String? type;
  final String? address;
  final String? capacity;
  final String? price_start;
  final String? typprice_end;
  final List<String>? utils;

  const SearchResultsPage(
      {this.type,
      this.address,
      this.capacity,
      this.price_start,
      this.typprice_end,
      this.utils,
      Key? key})
      : super(key: key);

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  List<dynamic> _boardigHouseList = [];
  bool _loading = true;

  //get BoardingHouse
  void _searchBoardingHouse() async {
    try {
      // String? capacityValue = capacity != 0 ? null : capacity.toString();

      ApiResponse response = await searchBoardingHouse(
          widget.address,
          widget.type,
          widget.capacity,
          widget.price_start,
          widget.typprice_end,
          widget.utils);

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
    _searchBoardingHouse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            color: Color.fromRGBO(0, 177, 237, 1),
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Kết quả tìm kiếm",
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
              itemCount: _boardigHouseList
                  .where((boardingHouse) => boardingHouse.status != "0")
                  .length,
              itemBuilder: (BuildContext context, int index) {
                List<BoardingHouse> filteredList = _boardigHouseList
                    .where((boardingHouse) => boardingHouse.status != "0")
                    .cast<
                        BoardingHouse>() // Explicitly cast to List<BoardingHouse>
                    .toList();
                BoardingHouse boardingHouse = filteredList[index];
                // BoardingHouse boardingHouse = _boardigHouseList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BoardingHouseDetailPage(
                                  boardingHouseId: boardingHouse.id!,
                                )));
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
