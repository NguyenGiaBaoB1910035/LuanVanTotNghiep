import 'package:boardinghouse_app/apis/boarding_house_api.dart';
import 'package:boardinghouse_app/apis/boarding_house_type_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/apis/util_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:boardinghouse_app/models/boarding_house_type.dart';
import 'package:boardinghouse_app/screens/boardinghouse/boarding_house_detail_page.dart';
import 'package:boardinghouse_app/screens/components/card_boarding_house_detail.dart';
import 'package:boardinghouse_app/models/util.dart';
import 'package:boardinghouse_app/screens/search/search_results_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  @override
  State<DemoPage> createState() => _DemoPageState();
}

bool selectData = false;
bool selectUtil = false;

class _DemoPageState extends State<DemoPage> with TickerProviderStateMixin {
  List<dynamic> _boardingHouseList = [];
  String address = "";
  String selectedRoom = '';
  List<Utils> selectedUtils = [];
  int capacity = 1;

  void _searchBoardingHouse() async {
    try {
      String? capacityValue = capacity != 0 ? null : capacity.toString();

      ApiResponse response = await searchBoardingHouse(
        address,
        selectedRoom,
        capacityValue,
        priceRange.start.toStringAsFixed(0),
        priceRange.end.toStringAsFixed(0),
        selectedUtils.map((util) => util.name!).toList(),
      );

      if (response.error == null) {
        setState(() {
          _boardingHouseList = response.data as List<dynamic>;
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _txtAddressController = TextEditingController();

  List<dynamic> _utilsList = [];

  //get Uitls
  void getListUtil() async {
    try {
      ApiResponse response = await getUtil();
      if (response.error == null) {
        setState(() {
          _utilsList = response.data as List<dynamic>;
        });
      } else if (response.error == unauthorized) {
        logout().then((value) => {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
        print("response.error getListUtil ${response.error}");
      }
    } catch (e) {
      print('Error in getListUtil: $e');
    }
  }

  List<dynamic> _typeList = [];

  //get boardingHouseType
  void getNameBoardingHouseType() async {
    try {
      ApiResponse response = await getBoardingHouseType();
      if (response.error == null) {
        setState(() {
          _typeList = response.data as List<dynamic>;
        });
      } else if (response.error == unauthorized) {
        logout().then((value) => {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
        print("response.error getNameBoardingHouseType ${response.error}");
      }
    } catch (e) {
      print('Error in getNameBoardingHouseType: $e');
    }
  }

  TabController? _tabController;
  RangeValues priceRange = RangeValues(0.0, 1000000.0);
  double priceIncrement = 1000000;

  @override
  void initState() {
    super.initState();
    getNameBoardingHouseType();
    getListUtil();
    _tabController = TabController(length: 6, vsync: this, initialIndex: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Tìm kiếm theo yêu cầu",
            style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1))),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.black54, fontSize: 20),
              )),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          // selectData
          //     ? selectedOptionsContainer()
          //     : Container(
          //         child: null,
          //       ),
          // selectUtil
          //     ? selectedOptionsUtil()
          //     : Container(
          //         child: null,
          //       ),
          Container(
            color: Colors.white,
            height: selectData && selectUtil
                ? MediaQuery.of(context).size.height * 9 / 10
                : MediaQuery.of(context).size.height * 4 / 5,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Form(
                  key: formKey,
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xF5F5F5F5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                      child: TextFormField(
                        controller: _txtAddressController,
                        decoration: const InputDecoration(
                          icon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(
                              Icons.search,
                              color: Color.fromRGBO(0, 177, 237, 1),
                            ),
                          ),
                          hintText: "Tìm theo tên đường, địa điểm",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            address = (value);
                          });
                        },
                      )),
                ),
              ),

              //-----------------------------------------------------------------------------------//
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(children: [
                  Container(
                    height: 150,
                    child: ListView.builder(
                        itemCount: _typeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          BoardingHouseType type = _typeList[index];
                          return buildRoomOption('${type.name}');
                        }),
                  )
                ]),
              ),

              //-----------------------------------------------------------------------------------//
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      RangeSlider(
                        values: priceRange,
                        min: 0.0,
                        max: 15000000.0,
                        divisions: 15, // (15000000 - 1000000) / 1000000 + 1
                        labels: RangeLabels(
                          priceRange.start.toStringAsFixed(0) + ' VND',
                          priceRange.end.toStringAsFixed(0) + ' VND',
                        ),
                        onChanged: (RangeValues newRange) {
                          setState(() {
                            priceRange = newRange;
                          });
                        },
                      ),
                      Text(
                        'Khoảng giá: ${priceRange.start.toStringAsFixed(0)} VND - ${priceRange.end.toStringAsFixed(0)} VND',
                        style: const TextStyle(fontSize: 18),
                      ),

                      //-----------------------------------------------------------------------------------//
                      // Padding(
                      //   padding: const EdgeInsets.all(30),
                      //   child: ElevatedButton(
                      //       onPressed: () {
                      //         setState(() {
                      //           selectData = true;
                      //           selectprice = true;
                      //         });
                      //         _tabController?.animateTo(5);
                      //         print(
                      //             '${priceRange.start.toStringAsFixed(0)} VND - ${priceRange.end.toStringAsFixed(0)} VND');
                      //         _searchBoardingHouse();
                      //       },
                      //       child: Container(
                      //         decoration: const BoxDecoration(
                      //             color: Colors.blue,
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(10))),
                      //         child: const Center(
                      //           child: Text(
                      //             'Áp dụng',
                      //             style: TextStyle(
                      //                 color: Colors.white, fontSize: 20),
                      //           ),
                      //         ),
                      //       )),
                      // )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Số người / phòng',
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      IconButton(
                          icon: const Icon(
                            CupertinoIcons.minus,
                            size: 18,
                          ),
                          // color: Colors.white,
                          onPressed: () {
                            capacity <= 1
                                ? null
                                : setState(() {
                                    capacity = capacity - 1;
                                  });
                          }),
                      Text('${capacity}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          )),
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.plus,
                          size: 18,
                        ),
                        // color: Colors.white,
                        onPressed: () {
                          setState(() {
                            capacity = capacity + 1;
                          });
                        },
                      ),
                    ]),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1 / 5,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Số cột
                                  childAspectRatio: 1 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing:
                                      10 // Tỉ lệ chiều cao theo chiều rộng
                                  ),
                          itemCount: _utilsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            Utils feature = _utilsList[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  feature.isSelected = !feature.isSelected;
                                  if (feature.isSelected) {
                                    selectedUtils.add(feature);
                                  } else {
                                    selectedUtils.remove(feature);
                                  }
                                });
                              },
                              child: Card(
                                color: feature.isSelected
                                    ? Colors.green
                                    : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${feature.imageUrl}'),
                                              fit: BoxFit.cover),
                                          // color: Colors.amber
                                        ),
                                      ),
                                      // Icon(
                                      //   feature.icon,
                                      //   color: feature.isSelected
                                      //       ? Colors.white
                                      //       : Colors.grey,
                                      //   // Kích thước của icon
                                      // ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${feature.name}',
                                        style: TextStyle(
                                          // Kích thước của văn bản
                                          color: feature.isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectprice = true;
                            selecttype = true;
                            selectnumber = true;
                            selectData = true;
                            selectaddress = true;
                            selectUtil = true;
                          });
                          // _tabController?.animateTo(5);
                          for (Utils util in selectedUtils) {
                            print("Util đã chọn: ${util.name}");
                          }
                          // _searchBoardingHouse();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SearchResultsPage(
                                type: selectedRoom,
                                address: address,
                                capacity: capacity.toString(),
                                price_start:
                                    priceRange.start.toStringAsFixed(0),
                                typprice_end: priceRange.end.toStringAsFixed(0),
                                utils: selectedUtils
                                    .map((util) => util.name!)
                                    .toList(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                            child: Text(
                              'Áp dụng',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        )),
                  )
                ],
              ),
              // defaultPage(),
            ]),
          )
        ]),
      ),
    );
  }

//--------------------------------------default page---------------------------------------//

  // Widget defaultPage() {
  //   return SingleChildScrollView(
  //     child: Padding(
  //         padding: const EdgeInsets.all(20),
  //         child: GridView.builder(
  //           physics: const NeverScrollableScrollPhysics(),
  //           // mainAxisSpacing: 20,
  //           // crossAxisSpacing: 20,
  //           shrinkWrap: true,
  //           // crossAxisCount: 2,
  //           // childAspectRatio: (1 / 1.4),
  //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 2, // Số cột
  //               childAspectRatio: 1 / 1.4,
  //               crossAxisSpacing: 20,
  //               mainAxisSpacing: 20 // Tỉ lệ chiều cao theo chiều rộng
  //               ),
  //           // scrollDirection: Axis.vertical,
  //           itemCount: _boardingHouseList.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             BoardingHouse boardingHouse = _boardingHouseList[index];
  //             return InkWell(
  //               onTap: () {
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (_) => BoardingHouseDetailPage(
  //                               boardingHouseId: boardingHouse.id!,
  //                             )));
  //               },
  //               child: Container(
  //                   decoration: BoxDecoration(
  //                       border: Border.all(width: 1),
  //                       borderRadius: BorderRadius.circular(10)),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         margin: const EdgeInsets.only(bottom: 2.5),
  //                         width: MediaQuery.of(context).size.width,
  //                         height: 100,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(10),
  //                           image: DecorationImage(
  //                             image: Image.network(
  //                               '${boardingHouse.urlIamge}',
  //                             ).image,
  //                             fit: BoxFit.fitWidth,
  //                           ),
  //                         ),
  //                         // child: Container(
  //                         //     margin: EdgeInsets.only(top: 5, right: 5),
  //                         //     alignment: Alignment.topRight,
  //                         //     child: InkWell(
  //                         //       onTap: () {
  //                         //         setState(() {
  //                         //           isFavorite = !isFavorite;
  //                         //         });
  //                         //       },
  //                         //       child: Icon(
  //                         //           isFavorite ? Icons.favorite : Icons.favorite_border,
  //                         //           color: Colors.red),
  //                         //     )),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(
  //                             horizontal: 10, vertical: 2.5),
  //                         child: Text(
  //                           "${boardingHouse.boardingHouseType!.name}",
  //                           style: TextStyle(fontSize: 16),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(
  //                             horizontal: 10, vertical: 2.5),
  //                         child: Text(
  //                           "${boardingHouse.name}",
  //                           overflow: TextOverflow.ellipsis,
  //                           maxLines: 2,
  //                           style: const TextStyle(
  //                               fontSize: 16, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(
  //                             horizontal: 10, vertical: 2.5),
  //                         child: Text(
  //                           "${boardingHouse.price}",
  //                           style: const TextStyle(
  //                               fontSize: 16,
  //                               color: Colors.blue,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(
  //                             horizontal: 10, vertical: 2.5),
  //                         child: Text(
  //                           "${boardingHouse.address}",
  //                           overflow: TextOverflow.ellipsis,
  //                           maxLines: 2,
  //                           style: const TextStyle(fontSize: 16),
  //                         ),
  //                       )
  //                     ],
  //                   )),
  //             );
  //           },
  //         )),
  //   );
  // }

  Widget buildRoomOption(String roomName) {
    return Row(
      children: <Widget>[
        Radio(
          value: roomName,
          groupValue: selectedRoom,
          onChanged: (value) {
            setState(() {
              selectedRoom = value.toString();
            });
          },
        ),
        Text(roomName),
      ],
    );
  }

//----------------------------------=========---------------------------------//
  bool selectaddress = false;
  bool selecttype = false;
  bool selectprice = false;
  bool selectnumber = false;

  Widget selectedOptionsContainer() {
    return Container(
      alignment: Alignment.centerLeft,
      // width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1 / 18,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                'Yêu cầu:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              child: Row(
                children: [
                  selectaddress
                      ? Stack(children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200),
                            child: selectedRoom != null
                                ? Text('$address',
                                    style: TextStyle(fontSize: 15))
                                : Text(''),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectaddress = false;
                                });
                                if (!selecttype &&
                                    !selectprice &&
                                    !selectnumber &&
                                    !selectaddress) {
                                  setState(() {
                                    selectData = false;
                                  });
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Colors.grey, // Màu nền của nút hình tròn
                                ),
                                padding: const EdgeInsets.all(
                                    5), // Điều chỉnh kích thước của nút hình tròn
                                child: const Text(
                                  "x",
                                  style: TextStyle(
                                    color: Colors.white, // Màu chữ "x"
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ])
                      : Container(
                          child: null,
                        ),
                  const SizedBox(
                    width: 5,
                  ),
                  selecttype
                      ? Stack(children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200),
                            child: selectedRoom != null
                                ? Text('$selectedRoom',
                                    style: TextStyle(fontSize: 15))
                                : Text(''),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selecttype = false;
                                });
                                if (!selecttype &&
                                    !selectprice &&
                                    !selectnumber &&
                                    !selectaddress) {
                                  setState(() {
                                    selectData = false;
                                  });
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Colors.grey, // Màu nền của nút hình tròn
                                ),
                                padding: const EdgeInsets.all(
                                    5), // Điều chỉnh kích thước của nút hình tròn
                                child: const Text(
                                  "x",
                                  style: TextStyle(
                                    color: Colors.white, // Màu chữ "x"
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ])
                      : Container(
                          child: null,
                        ),
                  const SizedBox(
                    width: 5,
                  ),
                  selectnumber
                      ? Stack(children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200),
                            child: (capacity != null)
                                ? Text('$capacity',
                                    style: const TextStyle(fontSize: 15))
                                : Text(''),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectnumber = false;
                                });
                                if (!selecttype &&
                                    !selectprice &&
                                    !selectnumber &&
                                    !selectaddress) {
                                  setState(() {
                                    selectData = false;
                                  });
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Colors.grey, // Màu nền của nút hình tròn
                                ),
                                padding: const EdgeInsets.all(
                                    5), // Điều chỉnh kích thước của nút hình tròn
                                child: const Text(
                                  "x",
                                  style: TextStyle(
                                    color: Colors.white, // Màu chữ "x"
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ])
                      : Container(
                          child: null,
                        ),
                  const SizedBox(
                    width: 5,
                  ),
                  selectprice
                      ? Stack(children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200),
                            child: Text(
                              '${priceRange.start.toStringAsFixed(0)} VND - ${priceRange.end.toStringAsFixed(0)} VND',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectprice = false;
                                });
                                if (!selecttype &&
                                    !selectprice &&
                                    !selectnumber &&
                                    !selectaddress) {
                                  setState(() {
                                    selectData = false;
                                  });
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Colors.grey, // Màu nền của nút hình tròn
                                ),
                                padding: const EdgeInsets.all(
                                    5), // Điều chỉnh kích thước của nút hình tròn
                                child: const Text(
                                  "x",
                                  style: TextStyle(
                                    color: Colors.white, // Màu chữ "x"
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ])
                      : Container(
                          child: null,
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget selectedOptionsUtil() {
    return Container(
      alignment: Alignment.centerLeft,
      // width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1 / 18,
      // color: Colors.white,
      padding: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                'Tiện ích:  ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 5),
            // Hiển thị các tiện ích đã chọn
            if (selectedUtils.isNotEmpty)
              Row(
                children: selectedUtils
                    .map(
                      (util) => Stack(children: [
                        Container(
                            margin: EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200),
                            child: Text(util.name!,
                                style: const TextStyle(fontSize: 15))),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedUtils.remove(util);
                                util.isSelected = false;
                              });

                              if (selectedUtils.length == 0) {
                                selectUtil = false;
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey, // Màu nền của nút hình tròn
                              ),
                              padding: const EdgeInsets.all(
                                  5), // Điều chỉnh kích thước của nút hình tròn
                              child: const Text(
                                "x",
                                style: TextStyle(
                                  color: Colors.white, // Màu chữ "x"
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
