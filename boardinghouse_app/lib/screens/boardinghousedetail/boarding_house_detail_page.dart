import 'package:boardinghouse_app/models/Evaluate.dart';
import 'package:boardinghouse_app/models/util.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BoardingHouseDetailPage extends StatefulWidget {
  const BoardingHouseDetailPage({super.key});

  @override
  State<BoardingHouseDetailPage> createState() =>
      _BoardingHouseDetailPageState();
}

class _BoardingHouseDetailPageState extends State<BoardingHouseDetailPage> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              const ListImage(),
              const InfoDetail(),
              const UtilBoardingHouse(),
              const HostBoardingHouse(),
              const Rating(),
              ReviewListPage(),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------------------------------//
// ------------------------------------------------------------------------------------------//
// ------------------------------------------------------------------------------------------//

List<String> imageList = [
  'assets/images/bh_image_1.jpg',
  'assets/images/bh_image_2.jpg',
  'assets/images/bh_image_3.jpg',
  'assets/images/bh_image_4.jpg',
  // Thêm nhiều hình ảnh khác ở đây
];

class ListImage extends StatefulWidget {
  const ListImage({super.key});

  @override
  State<ListImage> createState() => _ListImageState();
}

class _ListImageState extends State<ListImage> {
  final controller = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 4 / 10,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        controller: controller,
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    imageList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: SmoothPageIndicator(
                    controller: controller, // PageController
                    count: imageList.length,
                    effect: const WormEffect(
                        dotHeight: 7,
                        dotWidth: 7,
                        activeDotColor: Color.fromRGBO(
                            0, 177, 237, 1)), // your preferred effect
                    onDotClicked: (index) {}),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ------------------------------------------------------------------------------------------//
// ------------------------------------------------------------------------------------------//
// ------------------------------------------------------------------------------------------//

class InfoDetail extends StatefulWidget {
  const InfoDetail({super.key});

  @override
  State<InfoDetail> createState() => _InfoDetailState();
}

class _InfoDetailState extends State<InfoDetail> {
  bool _isFavorite = false;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Loại phòng',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                    margin: EdgeInsets.only(top: 5, right: 5),
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                      child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red),
                    )),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "name boarding house",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 177, 237, 1)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Text(
                  'Giá: ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '1.000.000 VND',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 177, 237, 1)),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Đặt cọc',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Text(
                      '5tr',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 177, 237, 1)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Giá điện',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Text(
                      '5tr',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 177, 237, 1)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Giá nước',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Text(
                      '5tr',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 177, 237, 1)),
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Số phòng',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Text(
                      '20',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Sức chứa',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Text(
                      '4',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Giới tính',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Text(
                      'Tất cả',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Diện tích',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Text(
                      '15 m2',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time_outlined),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "0:00 AM",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "  -  ",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "23:59 PM",
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
          const Padding(
            padding: EdgeInsets.all(5),
            child: Text(
                'CHO THUÊ PHÒNG BỜ HỒ BÚN XÁNG (HẺM 51) \n 📍Gần trường ĐHYD, ĐHCT, CĐYT... \n 💵Giá thuê: 3tr5/tháng. Cọc 1 tháng. Hđ 1 năm \n- Điện 5k. Nước 10k \n- Có thang máy \n- Cổng sd khoá thông minh \n- Lộ lớn oto đậu được (hạn chế)'),
          ),
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
                  child: const Text(
                    '40B/49, Trần Hoàng Na, Hưng Lợi, Ninh Kiều, Cần Thơ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(Icons.phone),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'SĐT: 0377808122',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//-------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------//

List<Util> utils = [
  Util(icon: Icons.wifi, name: 'Wifi'),
  Util(icon: Icons.directions_car, name: 'Nhà Xe'),
  Util(icon: Icons.wash, name: 'Máy Giặt'),
  Util(icon: Icons.ac_unit, name: 'Máy Lạnh'),
  Util(icon: Icons.tv, name: 'TV'),
  Util(icon: Icons.kitchen, name: 'Tủ Lạnh'),
  Util(icon: Icons.king_bed, name: 'Giường'),
  Util(icon: Icons.access_time, name: 'Giờ Tự Do'),
  Util(icon: Icons.hotel, name: 'Gác Lửng'),
  Util(icon: Icons.pets, name: 'Thú Cưng'),
  Util(icon: Icons.outdoor_grill, name: 'Ban Công'),
];

class UtilBoardingHouse extends StatefulWidget {
  const UtilBoardingHouse({super.key});

  @override
  State<UtilBoardingHouse> createState() => _UtilBoardingHouseState();
}

class _UtilBoardingHouseState extends State<UtilBoardingHouse> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Số cột
                // childAspectRatio: 5 / 2,
                // crossAxisSpacing: 5,
                // mainAxisSpacing: 5
              ),
              itemCount: utils.length,
              itemBuilder: (BuildContext context, int index) {
                final feature = utils[index];
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      feature.icon,
                      size: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      feature.name,
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
    );
  }
}

//-------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------//

class HostBoardingHouse extends StatelessWidget {
  const HostBoardingHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Container(
        margin: EdgeInsets.symmetric(
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/avatar.jpg",
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Gia Bảo",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('chat');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        'Nhắn tin',
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
    );
  }
}

//-------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------//

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double _rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Center(
            child: Text(
              'Đánh giá',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
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
            onChanged: (value) {
              setState(() {
              });
            },
            maxLines: 1,
            decoration: const InputDecoration(
              hintText: 'Nhập bình luận...',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Đánh giá và bình luận đã được lưu vào cơ sở dữ liệu
              // Chuyển hướng đến trang hiển thị đánh giá
            },
            child: const Text('Lưu đánh giá'),
          ),
        ],
      ),
    );
  }
}

//-------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------//

class ReviewListPage extends StatefulWidget {
  @override
  _ReviewListPageState createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  // Danh sách đánh giá của người dùng (đây là một danh sách giả định)
  List<Evalute> Evalutes = [
    Evalute(username: "Người dùng 1", comment: "Rất tốt, 5 sao!", rating: 5),
    Evalute(
        username: "Người dùng 2",
        comment: "Sản phẩm không tốt lắm, 2 sao",
        rating: 2),
    Evalute(
        username: "Người dùng 3",
        comment: "Sản phẩm ổn đấy, 4 sao!",
        rating: 4),
    Evalute(username: "Người dùng 4", comment: "", rating: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Đánh giá nhà trọ',
            style: TextStyle(fontSize: 18),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: Evalutes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(Evalutes[index].username),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(
                        Evalutes[index].rating,
                        (index) => Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                      ),
                    ),
                    Text(Evalutes[index].comment),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
