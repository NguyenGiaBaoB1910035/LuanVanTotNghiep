// import 'package:boardinghouse_app/apis/auth_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/user.dart';
import 'package:boardinghouse_app/screens/authu/login_page.dart';
// import 'package:boardinghouse_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? _user;
  bool loading = true;

  void getUser() async {
    try {
      int userId = await getUserId();
      print('userId');
      print(userId);
      ApiResponse response = await getUserDetail(userId);

      if (response.error == null) {
        setState(() {
          _user = response.data as User;
          loading = false;
        });
      } else if (response.error == unauthorized) {
        logout().then((value) => {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false)
            });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    } catch (e) {
      print('Error in getUser: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    // getUserTest();
  }

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
                margin: const EdgeInsets.only(top: 10, bottom: 5),
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
                        child: _user?.urlAvatar != null
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage('${_user?.urlAvatar}'),
                              )
                            : const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/avatar.jpg"),
                              ),
                      ),
                    ),
                    Text(
                      '${_user?.userName}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).pushNamed('users');
                        Navigator.of(context).pushNamed('profile');
                      },
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
                                "Nhà trọ của tôi",
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

              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
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
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                  ],
                ),
              ),
              //--------------------------------------//
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
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
                    logout().then(
                        (value) => {Navigator.of(context).pushNamed('/')});
                    // AuthProvider().logout();
                    // Navigator.of(context).pushNamed('/');
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
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
