import 'package:flutter/material.dart';

class CardBoardingHousePost extends StatefulWidget {
  const CardBoardingHousePost({super.key});

  @override
  State<CardBoardingHousePost> createState() => _CardBoardingHousePostState();
}

class _CardBoardingHousePostState extends State<CardBoardingHousePost> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(children: [
          Row(
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
                width: MediaQuery.of(context).size.width - 190,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('createpost');
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black26)),
                  height: 35,
                  width: MediaQuery.of(context).size.width * 1 / 2 - 20,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.post_add,
                        color: Colors.blue,
                      ),
                      Text(
                        'Đăng bài',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width * 1 / 4 - 8,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black26)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                        Text(
                          'Sửa',
                          style: TextStyle(color: Colors.green),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width * 1 / 4 - 8,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black26)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        Text(
                          'Xóa',
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
