// import 'package:boardinghouse_app/models/page_views.dart';
// import 'package:boardinghouse_app/screens/authu/login_page.dart';
// import 'package:boardinghouse_app/screens/authu/register_page.dart';
// import '../bottombar.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final logoImages = [
  "assets/logos/logobegin1.png",
  "assets/logos/logobegin2.png",
  "assets/logos/logobegin3.png",
];

final text1 = ["Ứng dụng uy tín", "Tìm kiếm nhanh chóng", "Đăng tin dễ dàng"];

final text2 = [
  "Kiểm duyệt chính xác \n an toàn - nhanh chóng - tiện lợi ",
  "Tìm kiếm dựa trên các \n yêu cầu của khách hàng",
  "Đưa căn trọ của bạn \n đến mọi người nhanh chóng"
];

// final List<PageViews> _pageViews = [
//   PageViews(
//     logoImage: "assets/logos/logobegin1.png",
//     text1: "Ứng dụng uy tín",
//     text2: "Kiểm duyệt chính xác \n an toàn - nhanh chóng - tiện lợi ",
//   ),
//   PageViews(
//     logoImage: "assets/logos/logobegin2.png",
//     text1: "Tìm kiếm nhanh chóng",
//     text2: "Tìm kiếm dựa trên các \n yêu cầu của khách hàng",
//   ),
//   PageViews(
//       logoImage: "assets/logos/logobegin3.png",
//       text1: "Đăng tin dễ dàng",
//       text2: "Đưa căn trọ của bạn \n đến mọi người nhanh chóng"),
// ];

class BeginPage extends StatelessWidget {
  const BeginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //  int _currentIndex = 0;
    final controller = PageController(keepPage: true);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 2 / 3,
              width: double.infinity,
              // color: Colors.black26,
              margin: const EdgeInsets.only(
                  top: 100, left: 20, right: 20, bottom: 50),
              child: PageView.builder(
                  controller: controller,
                  itemCount: logoImages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          // margin: const EdgeInsets.only(top: 100),
                          child: Image.asset(
                            logoImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: SmoothPageIndicator(
                              controller: controller, // PageController
                              count: 3,
                              effect: const WormEffect(
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  activeDotColor: Color.fromRGBO(
                                      0, 177, 237, 1)), // your preferred effect
                              onDotClicked: (index) {}),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                              child: Text(
                            text1[index],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                        ),
                        Center(
                            child: Text(
                          text2[index],
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // TextButton(onPressed: (){}, child: Text("Đăng nhập"), style: ButtonStyle(),),
                      //   TextButton(onPressed: (){}, child: Text("Đăng ký"))

                      InkWell(
                        onTap: () {
                          print("mở Trang đăng nhập");
                          Navigator.of(context).pushNamed('login');
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromRGBO(0, 177, 237, 1)),
                          child: const Center(
                            child: Text("Đăng nhập",
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('register');
                          print("mở Trang đăng kí");
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(0, 177, 237, 1),
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: const Center(
                            child: Text("Đăng ký",
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(0, 177, 237, 1),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      print("mở Trang chủ");
                      Navigator.of(context).pushNamed('main');
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Center(
                        child: Text("Trải nghiệm không cần đăng nhập",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 177, 237, 1))),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
