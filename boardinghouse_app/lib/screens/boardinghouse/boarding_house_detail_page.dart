import 'package:boardinghouse_app/apis/boarding_house_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/evaluate_api.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BoardingHouseDetailPage extends StatefulWidget {
  final int boardingHouseId;

  const BoardingHouseDetailPage({required this.boardingHouseId, Key? key})
      : super(key: key);

  // const BoardingHouseDetailPage({super.key});
  @override
  State<BoardingHouseDetailPage> createState() =>
      _BoardingHouseDetailPageState();
}

class _BoardingHouseDetailPageState extends State<BoardingHouseDetailPage> {
  final controller = PageController(viewportFraction: 0.9);
  BoardingHouse? _boardingHouse;
  bool loading = false;
  bool _isFavorite = false;
  // SampleItem? selectedMenu;
  int userId = 0;

  void getBoardingHouse() async {
    userId = await getUserId();
    int boardingHouseId = widget.boardingHouseId;
    ApiResponse response = await getBoardingHousesDetail(boardingHouseId);
    print('profile:');
    if (response.error == null) {
      setState(() {
        _boardingHouse = response.data as BoardingHouse;
        loading = true;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      print("loiiooioioio");
    }
  }

  bool _loading = false;
  double _rating = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _txtContentController = TextEditingController();

  void _createEvaluate() async {
    int usedId = await getUserId();
    ApiResponse response = await createEvalutes(
        usedId, widget.boardingHouseId, _rating, _txtContentController.text);

    if (response.error == null) {
      _txtContentController.clear();
      getBoardingHouse();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (context) => Login()),
            //     (route) => false)
          });
    } else {
      setState(() {
        _loading = true;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _deleteEvaluate(int commentId) async {
    ApiResponse response = await deleteComment(commentId);

    if (response.error == null) {
      getBoardingHouse();
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

  void _favourites(int? boardingHouseId) async {
    int userId = await getUserId();
    ApiResponse response = await favourites(userId, boardingHouseId!);
    if (response.error == null) {
      print("yêu thích");
      // Navigator.of(context).pop();
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
  void initState() {
    super.initState();
    getBoardingHouse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          color: Color.fromRGBO(0, 177, 237, 1),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Chi tiết nhà trọ",
          style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 4 / 10,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: controller,
                        // shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _boardingHouse!.urlImages!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final _image = _boardingHouse!.urlImages![index];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.network(
                                      "${_image}",
                                      fit: BoxFit.cover,
                                    )
                                    // Image.asset(
                                    //   imageList[index],
                                    //   fit: BoxFit.cover,
                                    // ),
                                    ),
                              ),
                              Container(
                                child: SmoothPageIndicator(
                                    controller: controller, // PageController
                                    count: _boardingHouse!.urlImages!.length,
                                    effect: const WormEffect(
                                        dotHeight: 7,
                                        dotWidth: 7,
                                        activeDotColor: Color.fromRGBO(0, 177,
                                            237, 1)), // your preferred effect
                                    onDotClicked: (index) {}),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    //-------------------------------------------------------------//
                    //------------------------------------------------------------//
                    //------------------------------------------------------------//
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${_boardingHouse?.boardingHouseType?.name}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 5, right: 5),
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () {
                                        _favourites(_boardingHouse!.id);
                                        setState(() {
                                          _isFavorite = !_isFavorite;
                                        });
                                      },
                                      child: Icon(
                                          _isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "${_boardingHouse!.name}",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 177, 237, 1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Text(
                                  'Giá: ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${_boardingHouse!.price}',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(0, 177, 237, 1)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Đặt cọc',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      '${_boardingHouse!.depositPrice}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(0, 177, 237, 1)),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Giá điện',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      '${_boardingHouse!.electricPrice}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(0, 177, 237, 1)),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Giá nước',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      '${_boardingHouse!.waterPrice}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(0, 177, 237, 1)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              height: 1,
                              color: Colors.black54,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Số phòng',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      '${_boardingHouse!.roomNumber}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Sức chứa',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      '${_boardingHouse!.capacity}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Diện tích',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      '${_boardingHouse!.acreage} m2',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              height: 1,
                              color: Colors.black54,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.access_time_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${_boardingHouse!.openTime}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "  -  ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "${_boardingHouse!.closeTime}",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: Text(
                              'Mô tả',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                '${_boardingHouse!.price}',
                              )),
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: Text(
                              'Địa chỉ',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                const Icon(Icons.pin_drop),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: Text(
                                    '${_boardingHouse!.address}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: false,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'SĐT: ${_boardingHouse!.user!.phone}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //---------------------------------------------------------------------------------------------//
                    //---------------------------------------------------------------------------------------------//
                    //---------------------------------------------------------------------------------------------//
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Tiện ích',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, // Số cột
                                // childAspectRatio: 5 / 2,
                                // crossAxisSpacing: 5,
                                // mainAxisSpacing: 5
                              ),
                              itemCount: _boardingHouse!.utils!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final feature = _boardingHouse!.utils![index];
                                return Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
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
                                    //   size: 20,
                                    // ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${feature.name}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //---------------------------------------------------------------------------------------------//
                    //---------------------------------------------------------------------------------------------//
                    //---------------------------------------------------------------------------------------------//
                    Container(
                      color: Colors.black12,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "${_boardingHouse!.user!.urlAvatar}")
                                            //  AssetImage(
                                            //   "assets/images/avatar.jpg",
                                            // ),
                                            )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${_boardingHouse!.user!.userName}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('chat');
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color.fromRGBO(0, 177, 237, 1)),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.chat,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Liên hệ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //---------------------------------------------------------------------------------------------//
                    //---------------------------------------------------------------------------------------------//
                    //---------------------------------------------------------------------------------------------//
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Center(
                              child: Text(
                                'Đánh giá',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Đánh giá của bạn:',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: _rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemSize: 30,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  _rating = rating;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Bình luận:',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextField(
                              controller: _txtContentController,
                              onChanged: (value) {
                                setState(() {});
                              },
                              maxLines: 1,
                              decoration: const InputDecoration(
                                hintText: 'Nhập bình luận...',
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                _createEvaluate();

                                // Đánh giá và bình luận đã được lưu vào cơ sở dữ liệu
                                // Chuyển hướng đến trang hiển thị đánh giá
                              },
                              child: const Text('Lưu đánh giá'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //---------------------------------------------------------------------------------------------//
                    //---------------------------------------------------------------------------------------------//
                    //---------------------------------------------------------------------------------------------//
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Đánh giá nhà trọ',
                            style: TextStyle(fontSize: 18),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _boardingHouse!.evaluates!.length,
                            itemBuilder: (context, index) {
                              final evaluate =
                                  _boardingHouse!.evaluates![index];
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${evaluate.user!.userName}'),
                                    evaluate.userId == userId
                                        ? PopupMenuButton(
                                            child: const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.more_vert,
                                                  color: Colors.black,
                                                )),
                                            itemBuilder: (context) => [
                                              const PopupMenuItem(
                                                  child: Text('Sửa'),
                                                  value: 'edit'),
                                              const PopupMenuItem(
                                                  child: Text('Xóa'),
                                                  value: 'delete')
                                            ],
                                            onSelected: (val) {
                                              if (val == 'edit') {
                                                // Navigator.of(context).push(
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             evaForm(
                                                //               title: 'Edit eva',
                                                //               eva: eva,
                                                //             )));
                                              } else {
                                                _deleteEvaluate(
                                                    evaluate.id! ?? 0);
                                              }
                                            },
                                          )
                                        : Container(
                                            child: null,
                                          )
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: List.generate(
                                        evaluate.rating!,
                                        (index) => const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    Text('${evaluate.content}'),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
