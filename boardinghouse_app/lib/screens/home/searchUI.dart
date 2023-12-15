import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchUI extends StatefulWidget {
  //  SearchUI({super.key});

  @override
  State<SearchUI> createState() => _SearchUIState();
}

class _SearchUIState extends State<SearchUI> {
  final String searchQuery = "Nhà trọ";

  void launchMap() async {
    // Tạo đường dẫn Google Maps với tìm kiếm nhà trọ xung quanh
    String mapUrl =
        'https://www.google.com/maps/search/?api=1&query=$searchQuery';

    // Kiểm tra xem có thể mở liên kết không
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Không thể mở Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          margin: const EdgeInsets.only(
            top: 250,
          ),
          height: 150,
          width: MediaQuery.of(context).size.width,
          // color: Colors.white,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('searchbox');
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Color(0xF5F5F5F5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        )),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.search),
                        ),
                        Text(
                          "Tìm theo tên đường, địa điểm",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                    // TextFormField(
                    // decoration: const InputDecoration(
                    //   icon: Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 20),
                    //     child: Icon(Icons.search),
                    //   ),
                    //   hintText: "Tìm theo tên đường, địa điểm",
                    //   border: InputBorder.none,
                    //   ),
                    // )
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      // _showMaterialDialog();
                      Navigator.of(context).pushNamed('demo');
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: const Icon(
                            Icons.lightbulb_outline,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Tìm theo \n yêu cầu",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pushNamed('mapplace');
                      launchMap();
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 87, 244, 3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: const Icon(
                            Icons.pin_drop,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Tìm gần nơi \n học và làm",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('postquickly');
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 36, 84),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: const Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Đăng tin \n nhanh",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
