import 'package:flutter/material.dart';

import '../authu/begin_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Tài khoản",
              style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
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
                    const Text(
                      "Gia Bảo",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Xem thông tin cá nhân",
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.navigate_next,
                              )
                            ],
                          )),
                    ),
                    const Divider(
                      color: Colors.black45,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Xác minh tài khoản",
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.navigate_next,
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              // -----------------------------------------//
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Thông tin về SEBOA",
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.navigate_next,
                              )
                            ],
                          )),
                    ),
                    const Divider(
                      color: Colors.black45,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Điều Khoản dịch vụ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.navigate_next,
                              )
                            ],
                          )),
                    ),
                    const Divider(
                      color: Colors.black45,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Chính sách bảo mật",
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.navigate_next,
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              //--------------------------------------//
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Liên hệ với SEBOA",
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.navigate_next,
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text("Đăng xuất"), Icon(Icons.logout)],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
