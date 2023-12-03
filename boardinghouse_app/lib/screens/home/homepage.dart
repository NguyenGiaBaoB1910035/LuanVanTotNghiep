import 'package:boardinghouse_app/screens/home/outstandingUI.dart';
import 'package:boardinghouse_app/screens/home/searchUI.dart';
import 'package:boardinghouse_app/screens/home/suggestUI.dart';
import 'package:boardinghouse_app/screens/home/trendsUI.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          color: Color(0xF5F5F5F5),
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage("assets/images/home3.jpg"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(children: [
          SearchUI(),
          TrendsUI(),
          // OutstandingUI(),
          SuggestUI()
        ]),
      ),
    );
  }
}
