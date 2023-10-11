import 'package:flutter/material.dart';

class CardUI extends StatefulWidget {
  const CardUI({super.key});

  @override
  State<CardUI> createState() => _CardUIState();
}

class _CardUIState extends State<CardUI> {
  // bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 2.5),
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/images/anh.jpg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
              // child: Container(
              //     margin: EdgeInsets.only(top: 5, right: 5),
              //     alignment: Alignment.topRight,
              //     child: InkWell(
              //       onTap: () {
              //         setState(() {
              //           isFavorite = !isFavorite;
              //         });
              //       },
              //       child: Icon(
              //           isFavorite ? Icons.favorite : Icons.favorite_border,
              //           color: Colors.red),
              //     )),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
              child: Text("Phòng cho Thuê"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
              child: Text(
                "Phòng cho Thuê Hoàng Gia, Quận Ninh Kiều, cần thơ ",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
              child: Text(
                "1.200.000 VND",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
            //   child: Text(
            //     "40B/49, Trần Hoàng Na, Hưng Lợi",
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
              child: Text("Ninh Kiêu"),
            )
          ],
        ));
  }
}
