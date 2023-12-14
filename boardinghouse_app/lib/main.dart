import 'package:boardinghouse_app/screens/account/account_page.dart';
import 'package:boardinghouse_app/screens/account/edit_profile_user.dart';
import 'package:boardinghouse_app/screens/account/profile_user.dart';
import 'package:boardinghouse_app/screens/authu/begin_page.dart';
import 'package:boardinghouse_app/screens/authu/login_page.dart';
import 'package:boardinghouse_app/screens/authu/register_page.dart';
import 'package:boardinghouse_app/screens/boardinghouse/create_boarding_house_page.dart';
import 'package:boardinghouse_app/screens/bottombar.dart';
import 'package:boardinghouse_app/screens/favouritepage.dart';
import 'package:boardinghouse_app/screens/loading.dart';
import 'package:boardinghouse_app/screens/post/create_post.dart';
import 'package:boardinghouse_app/screens/search/PlaceSearchScreen.dart';
import 'package:boardinghouse_app/screens/search/demo.dart';
import 'package:boardinghouse_app/screens/search/map_page.dart';
import 'package:boardinghouse_app/screens/home/homepage.dart';
import 'package:boardinghouse_app/screens/outstandingpage.dart';
import 'package:boardinghouse_app/screens/post/post_page.dart';
import 'package:boardinghouse_app/screens/search/search_box_page.dart';
import 'package:boardinghouse_app/screens/search/search_request_page.dart';
import 'package:boardinghouse_app/screens/suggestpage.dart';
// import 'package:boardinghouse_app/screens/boardinghouse/create_boarding_house.dart';
import 'package:boardinghouse_app/screens/post/post_quickly_page.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SEBOA',
      theme: ThemeData(),
      // home: const BeginPage(),
      initialRoute: '/',
      routes: {
        // 'loading': (context) => Loading(),
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
        // 'createpost': (context) => const CreatePost(),
        // 'users': (context) => InfoUserPage(),
        //-----//
        'account': (context) => const AccountPage(),
        'profile': (context) => const ProfilePage(),
        'edit_profile': (context) => const EditProfilePage(),
        'favourite': (context) => const FavouritePage(),
        //-----//
        'postquickly': (context) => const PostQuicklyPage(),
        // 'createBH': (context) => const CreateBoardingHouse(),
        'createBHP': (context) => const CreateBoardingHousePage(),

        'mapplace': (context) => PlaceSearchScreen(),

        'demo': (context) => DemoPage(),
        'searchbox': (context) => SearchBoxPage()
      },
    );
  }
}
