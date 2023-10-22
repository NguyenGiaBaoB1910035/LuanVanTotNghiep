import 'package:boardinghouse_app/components/card_post.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Bảng tin",
            style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     // height: 50,

            //     color: Colors.white,
            //     child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(20),
            //             child: InkWell(
            //               onTap: () {},
            //               child: const Text(
            //                 'Bạn đang nghĩ gì? ',
            //                 style: TextStyle(fontSize: 20),
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(right: 20),
            //             child: ElevatedButton(
            //                 // style: ButtonStyle(),
            //                 onPressed: () {},
            //                 child: const Row(
            //                   children: [
            //                     Icon(Icons.add_home_outlined),
            //                     SizedBox(
            //                       width: 5,
            //                     ),
            //                     Text('Đăng phòng')
            //                   ],
            //                 )),
            //           )
            //         ]),
            //   ),
            // ),
//----------------------------------------------------------------------------------//
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(8),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CardPost(),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
