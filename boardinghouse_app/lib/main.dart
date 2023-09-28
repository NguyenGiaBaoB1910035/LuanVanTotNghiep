import 'package:boardinghouse_app/screens/account/accountpage.dart';
import 'package:boardinghouse_app/screens/authu/begin_page.dart';
import 'package:boardinghouse_app/screens/authu/login_page.dart';
import 'package:boardinghouse_app/screens/authu/register_page.dart';
import 'package:boardinghouse_app/screens/bottombar.dart';
import 'package:boardinghouse_app/screens/home/favouritepage.dart';
import 'package:boardinghouse_app/screens/home/homepage.dart';
import 'package:boardinghouse_app/screens/home/outstandingpage.dart';
import 'package:boardinghouse_app/screens/home/suggestpage.dart';
import 'package:boardinghouse_app/screens/post_quickly/create_boarding_house.dart';
import 'package:boardinghouse_app/screens/post_quickly/post_quickly_page.dart';
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
        'favourite': (context) => const FavouritePage(),
        //------//
        'account': (context) => const AccountPage(),
        //-----//
        'postquickly': (context) => const PostQuicklyPage(),
        'createBH':(context) => const CreateBoardingHousePage()
      },
    );
  }
}
