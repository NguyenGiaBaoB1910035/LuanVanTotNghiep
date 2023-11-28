// import 'package:boardinghouse_app/models/message.dart';
// import 'package:boardinghouse_app/screens/message/chat_page.dart';
// import 'package:flutter/material.dart';

// class MessagePage extends StatefulWidget {
//   const MessagePage({super.key});

//   @override
//   State<MessagePage> createState() => _MessagePageState();
// }

// class _MessagePageState extends State<MessagePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "Nhắn tin",
//           style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
//         ),
//         // actions: [
//         //   IconButton(
//         //       onPressed: () {},
//         //       icon: Icon(Icons.search_outlined,
//         //           color: Color.fromRGBO(0, 177, 237, 1))),
//         // ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//                 margin:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 decoration: const BoxDecoration(
//                     color: Color(0xF5F5F5F5),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(15),
//                     )),
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     icon: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Icon(Icons.search),
//                     ),
//                     hintText: "Tìm Kiếm",
//                     border: InputBorder.none,
//                   ),
//                 )),
//             ListView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: 8,
//                 itemBuilder: ((context, index) {
//                   // final Message chat = chats[index];
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => ChatPage()
//                               // ChatPage(user: chat.sender)
//                               ));
//                     },
//                     child: Row(
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Container(
//                             padding: const EdgeInsets.all(2),
//                             decoration: BoxDecoration(
//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(40)),
//                                 border: Border.all(
//                                     width: 2,
//                                     color:
//                                         const Color.fromRGBO(0, 177, 237, 1)),
//                                 // shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 2,
//                                       blurRadius: 3)
//                                 ]),
//                             child: CircleAvatar(
//                                 radius: 30,
//                                 backgroundImage:
//                                     AssetImage('assets/images/avatar.jpg'
//                                         // chat.sender.avatar
//                                         )),
//                           ),
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.65,
//                           padding: const EdgeInsets.only(left: 10),
//                           child: Column(
//                             children: [
//                               Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       'Gia Bao',
//                                       // chat.sender.username,
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(
//                                       // chat.time,
//                                       '12:00 PM',
//                                       style: const TextStyle(
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w300,
//                                           color: Colors.black54),
//                                     ),
//                                   ]),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(
//                                     'eihifhw ừhwu',
//                                     // chat.text,
//                                     style: const TextStyle(
//                                         fontSize: 13, color: Colors.black54),
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 2,
//                                   )),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 }))
//           ],
//         ),
//       ),
//     );
//   }
// }
