import 'package:flutter/material.dart';

class CardPost extends StatefulWidget {
  const CardPost({super.key});

  @override
  State<CardPost> createState() => _CardPostState();
}

class _CardPostState extends State<CardPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/avatar.jpg",
                    ),
                  )),
            ),
            const Text(
              "Gia Bảo",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Hiện tại còn dư 4 phòng',
            style: TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('boardinghousedetail');
          },
          child: Row(
            children: [
              Container(
                width: 150,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  "assets/images/anh.jpg",
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 150,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 2.5),
                      child: Text("Phòng cho Thuê"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 2.5),
                      child: Text(
                        "Phòng cho Thuê Hoàng Gia, Quận Ninh Kiều, cần thơ ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 2.5),
                      child: Text(
                        "1.200.000 VND",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
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
                      padding: EdgeInsets.only(left: 10, bottom: 2.5),
                      child: Text("Ninh Kiêu"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
