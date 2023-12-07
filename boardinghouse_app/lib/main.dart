import 'package:boardinghouse_app/providers/auth_provider.dart';
import 'package:boardinghouse_app/screens/account/account_page.dart';
import 'package:boardinghouse_app/screens/account/edit_profile_user.dart';
// import 'package:boardinghouse_app/screens/account/info_user_page.dart';
import 'package:boardinghouse_app/screens/account/profile_user.dart';
import 'package:boardinghouse_app/screens/authu/begin_page.dart';
import 'package:boardinghouse_app/screens/authu/login_page.dart';
import 'package:boardinghouse_app/screens/authu/register_page.dart';
import 'package:boardinghouse_app/screens/boardinghouse/boarding_house_detail_page.dart';
import 'package:boardinghouse_app/screens/boardinghouse/create_boarding_house_page.dart';
import 'package:boardinghouse_app/screens/bottombar.dart';
import 'package:boardinghouse_app/screens/favouritepage.dart';
import 'package:boardinghouse_app/screens/loading.dart';
import 'package:boardinghouse_app/screens/post/create_post.dart';
import 'package:boardinghouse_app/screens/search/PlaceSearchScreen.dart';
import 'package:boardinghouse_app/screens/search/map_page.dart';
import 'package:boardinghouse_app/screens/home/homepage.dart';
import 'package:boardinghouse_app/screens/outstandingpage.dart';
import 'package:boardinghouse_app/screens/post/post_page.dart';
import 'package:boardinghouse_app/screens/search/search_request_page.dart';
import 'package:boardinghouse_app/screens/suggestpage.dart';
import 'package:boardinghouse_app/screens/boardinghouse/create_boarding_house.dart';
import 'package:boardinghouse_app/screens/post/post_quickly_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        //     providers: [
        //       ChangeNotifierProvider(create: (context) => AuthProvider()),
        //     ],
        //     child: Consumer<AuthProvider>(builder: (ctx, authManager, child) {
        //       return
        MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SEBOA',
      theme: ThemeData(
          // primarySwatch: Colors.blue,
          ),
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
        'createpost': (context) => const CreatePost(),
        // 'users': (context) => InfoUserPage(),
        //-----//
        'account': (context) => const AccountPage(),
        'profile': (context) => const ProfilePage(),
        'edit_profile': (context) => const EditProfilePage(),
        'favourite': (context) => const FavouritePage(),
        //-----//
        'postquickly': (context) => const PostQuicklyPage(),
        'createBH': (context) => const CreateBoardingHouse(),
        'createBHP': (context) => const CreateBoardingHousePage(),

        //-----//
        'boardinghousedetail': (context) => const BoardingHouseDetailPage(),
        //-----//
        'mapplace': (context) => PlaceSearchScreen(),
      },

      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const BeginPage(),
      //   'login': (context) => const LoginPage(),
      //   'register': (context) => const RegisterPage(),
      //   //-------//
      //   'main': (context) {
      //     if (isLoggedIn()) {
      //       return const BottomBar();
      //     } else {
      //       // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập.
      //       return const LoginPage();
      //     }
      //   },
      //   'home': (context) => const HomePage(),
      //   'outstanding': (context) {
      //     if (isLoggedIn()) {
      //       return const OutstandingPage();
      //     } else {
      //       // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập.
      //       return const LoginPage();
      //     }
      //   },
      //   'suggest': (context) {
      //     if (isLoggedIn()) {
      //       return const SuggestPage();
      //     } else {
      //       // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập.
      //       return const LoginPage();
      //     }
      //   },
      //   'search': (context) {
      //     if (isLoggedIn()) {
      //       return SearchPage();
      //     } else {
      //       // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập.
      //       return const LoginPage();
      //     }
      //   },
      //   'map': (context) {
      //     if (isLoggedIn()) {
      //       return const MapPage();
      //     } else {
      //       // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập.
      //       return const LoginPage();
      //     }
      //   },
      //   //------//
      //   'post': (context) {
      //     if (isLoggedIn()) {
      //       return const PostPage();
      //     } else {
      //       // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập.
      //       return const LoginPage();
      //     }
      //   },
      //   'createpost': (context) {
      //     if (isLoggedIn()) {
      //       return const CreatePost();
      //     } else {
      //       // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập.
      //       return const LoginPage();
      //     }
      //   },
      //   'users': (context) {
      //     if (isLoggedIn()) {
      //       return InfoUserPage();
      //     } else {
      //       // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập.
      //       return const LoginPage();
      //     }
      //   },
      // }
    );
  }
  // ));
}
// }
