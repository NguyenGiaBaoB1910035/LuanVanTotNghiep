// import 'package:boardinghouse_app/models/message.dart';
// import 'package:boardinghouse_app/models/user.dart';
import 'package:boardinghouse_app/screens/account/account_page.dart';
// import 'package:boardinghouse_app/screens/account/info_user_page.dart';
import 'package:boardinghouse_app/screens/authu/begin_page.dart';
import 'package:boardinghouse_app/screens/authu/login_page.dart';
import 'package:boardinghouse_app/screens/authu/register_page.dart';
import 'package:boardinghouse_app/screens/boardinghousedetail/boarding_house_detail_page.dart';
import 'package:boardinghouse_app/screens/bottombar.dart';
import 'package:boardinghouse_app/screens/favouritepage.dart';
import 'package:boardinghouse_app/screens/message/chat_page.dart';
import 'package:boardinghouse_app/screens/search/map_page.dart';
import 'package:boardinghouse_app/screens/home/homepage.dart';
// import 'package:boardinghouse_app/screens/message/chat_page.dart';
import 'package:boardinghouse_app/screens/message/messagepage.dart';
import 'package:boardinghouse_app/screens/outstandingpage.dart';
import 'package:boardinghouse_app/screens/post/post_page.dart';
import 'package:boardinghouse_app/screens/search/search_request_page.dart';
import 'package:boardinghouse_app/screens/suggestpage.dart';
import 'package:boardinghouse_app/screens/post/create_boarding_house.dart';
import 'package:boardinghouse_app/screens/post/post_quickly_page.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SEBOA',
      theme: ThemeData(
          // primarySwatch: Colors.blue,
          ),
      // home: const BeginPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const BeginPage(),
        'login': (context) => const LoginPage(),
        'register': (context) => const RegisterPage(),
        //-------//
        'main': (context) => const BottomBar(),
        'home': (context) => const HomePage(),
        'outstanding': (context) => const OutstandingPage(),
        'suggest': (context) => const SuggestPage(),
        'search': (context) => SearchPage(),
        'map': (context) => const MapPage(),
        //------//
        'post': (context) => const PostPage(),
        // 'users':(context) => InfoUserPage(),
        //------//
        'message': (context) => const MessagePage(),
        'chat':(context) => const  ChatPage(),

        //-----//
        'account': (context) => const AccountPage(),
        'favourite': (context) => const FavouritePage(),
        //-----//
        'postquickly': (context) => const PostQuicklyPage(),
        'createBH': (context) => const CreateBoardingHousePage(),
        //-----//
        'boardinghousedetail': (context) => const BoardingHouseDetailPage(),

        //-----//
        // 'test':(context) => MyHomePage(title: 'chat bubble example')
      },
    );
  }
}
