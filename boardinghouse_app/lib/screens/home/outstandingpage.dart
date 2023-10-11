// import 'package:boardinghouse_app/screens/bottombar.dart';
import 'package:flutter/material.dart';

import 'CardUI.dart';

class OutstandingPage extends StatelessWidget {
  const OutstandingPage({super.key});

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
            "Phòng nổi bật",
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
            childAspectRatio: (1 / 1.2),
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
