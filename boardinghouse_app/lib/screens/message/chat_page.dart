import 'package:boardinghouse_app/models/message.dart';
import 'package:boardinghouse_app/models/user.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {
      // required this.user,
      super.key});
  // final User user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // _chatBubble(Message message, bool isMe, bool isSameUser) {
  //   if (isMe) {
  //     return Column(
  //       children: <Widget>[
  //         Container(
  //           alignment: Alignment.topRight,
  //           child: Container(
  //             constraints: BoxConstraints(
  //                 maxWidth: MediaQuery.of(context).size.width * 0.8),
  //             padding: EdgeInsets.all(10),
  //             margin: EdgeInsets.symmetric(vertical: 10),
  //             decoration: BoxDecoration(
  //                 color: Colors.lightBlue,
  //                 borderRadius: BorderRadius.circular(15),
  //                 boxShadow: [
  //                   BoxShadow(
  //                       color: Colors.grey.withOpacity(0.5),
  //                       spreadRadius: 2,
  //                       blurRadius: 5)
  //                 ]),
  //             child: Text(
  //               message.text,
  //             ),
  //           ),
  //         ),
  //         !isSameUser
  //             ? Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   Text(
  //                     '12:30pm',
  //                     style: TextStyle(fontSize: 12, color: Colors.black54),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Container(
  //                     padding: EdgeInsets.all(2),
  //                     decoration: BoxDecoration(
  //                         shape: BoxShape.circle,
  //                         boxShadow: [
  //                           BoxShadow(
  //                               color: Colors.grey.withOpacity(0.5),
  //                               spreadRadius: 2,
  //                               blurRadius: 5)
  //                         ]),
  //                     child: CircleAvatar(
  //                       radius: 12,
  //                       backgroundImage: AssetImage("assets/images/avatar.jpg"),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             : Container(
  //                 child: null,
  //               )
  //       ],
  //     );
  //   } else {
  //     return Column(
  //       children: <Widget>[
  //         Container(
  //           alignment: Alignment.topLeft,
  //           child: Container(
  //             constraints: BoxConstraints(
  //                 maxWidth: MediaQuery.of(context).size.width * 0.8),
  //             padding: EdgeInsets.all(10),
  //             margin: EdgeInsets.symmetric(vertical: 10),
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(15),
  //                 boxShadow: [
  //                   BoxShadow(
  //                       color: Colors.grey.withOpacity(0.5),
  //                       spreadRadius: 2,
  //                       blurRadius: 5)
  //                 ]),
  //             child: Text(message.text),
  //           ),
  //         ),
  //         !isSameUser
  //             ? Row(
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.all(2),
  //                     decoration: BoxDecoration(
  //                         shape: BoxShape.circle,
  //                         boxShadow: [
  //                           BoxShadow(
  //                               color: Colors.grey.withOpacity(0.5),
  //                               spreadRadius: 2,
  //                               blurRadius: 5)
  //                         ]),
  //                     child: CircleAvatar(
  //                       radius: 12,
  //                       backgroundImage: AssetImage("assets/images/avatar.jpg"),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Text(
  //                     '12:30pm',
  //                     style: TextStyle(fontSize: 12, color: Colors.black54),
  //                   )
  //                 ],
  //               )
  //             : Container(
  //                 child: null,
  //               )
  //       ],
  //     );
  //   }
  // }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // String prevUserId = '';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: const Color.fromRGBO(0, 177, 237, 1),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                  // widget.user.avatar
                  'assets/images/avatar.jpg'),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              // widget.user.username,
              'Gia Bao',
              style: const TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
            ),
          ],
        ),
      ),
      // body: Column(
      //   children: <Widget>[
      //     Expanded(
      //       child: ListView.builder(
      //         reverse: true,
      //         padding: const EdgeInsets.all(20),
      //         itemCount: messages.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           final Message message = messages[index];
      //           final bool isMe = message.sender.id == currentUser.id;
      //           final bool isSameUser = prevUserId == message.sender.id;
      //           prevUserId = message.sender.id;
      //           return _chatBubble(message, isMe, isSameUser);
      //         },
      //       ),
      //     ),
      //     _sendMessageArea(),
      //   ],
      // ),
      body: Column(children: [
        Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5)
                    ]),
                child: Text("uegueighiehigiehgiehigjb jvuwuvbf jwbfbw vfvw"),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5)
                  ]),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage("assets/images/avatar.jpg"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '12:30pm',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                )
              ],
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5)
                    ]),
                child: Text(
                  "rnuseubsubeh iebisei kenk",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '12:30pm',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5)
                  ]),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage("assets/images/avatar.jpg"),
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
      bottomNavigationBar: _sendMessageArea(),
    );
  }
}
