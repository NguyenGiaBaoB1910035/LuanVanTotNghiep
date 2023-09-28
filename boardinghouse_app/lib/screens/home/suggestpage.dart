import 'package:boardinghouse_app/screens/bottombar.dart';
import 'package:flutter/material.dart';

import 'CardUI.dart';

class SuggestPage extends StatelessWidget {
  const SuggestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            color: Color.fromRGBO(0, 177, 237, 1),
            icon: Icon(Icons.arrow_back),
            onPressed: () {
               Navigator.of(context).pushNamed('main');
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Phòng gợi ý",
            style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: (1 / 1.5),
            // scrollDirection: Axis.vertical,
            children: List.generate(10, (index) {
              return CardUI();
            }),
          ),
        ),
      ),
    );
  }
}
