import 'package:flutter/material.dart';

class PostQuicklyPage extends StatelessWidget {
  const PostQuicklyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            color: const Color.fromRGBO(0, 177, 237, 1),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushNamed('main');
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Đăng tin nhanh",
            style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
          )),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('createBH');
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Tạo nhà trọ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(0, 177, 237, 1),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.add_circle_outline,
                    color: Color.fromRGBO(0, 177, 237, 1),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
