import 'package:flutter/material.dart';

class TrendsUI extends StatelessWidget {
  const TrendsUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Xu hướng tìm kiếm",
            style: TextStyle(fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black45,
                    image: DecorationImage(
                      image: AssetImage("assets/images/NK1.jpg"),
                    ),
                  ),
                  child: const Text(
                    "Ninh Kiều",
                    style: TextStyle(
                        backgroundColor: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black45,
                    image: DecorationImage(
                      image: AssetImage("assets/images/CR1.jpg"),
                    ),
                  ),
                  child: const Text(
                    "Cái Răng",
                    style: TextStyle(
                        backgroundColor: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black45,
                    image: DecorationImage(
                      image: AssetImage("assets/images/BT1.jpg"),
                    ),
                  ),
                  child: const Text(
                    "Bình Thủy",
                    style: TextStyle(
                        backgroundColor: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black45,
                    image: DecorationImage(
                      image: AssetImage("assets/images/OM1.jpg"),
                    ),
                  ),
                  child: const Text(
                    "Ô Môn",
                    style: TextStyle(
                        backgroundColor: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black45,
                    image: DecorationImage(
                      image: AssetImage("assets/images/TN.jpg"),
                    ),
                  ),
                  child: const Text(
                    "Thốt Nốt",
                    style: TextStyle(
                        backgroundColor: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black45,
                    image: DecorationImage(
                      image: AssetImage("assets/images/PD.jpg"),
                    ),
                  ),
                  child: const Text(
                    "Phong Điền",
                    style: TextStyle(
                        backgroundColor: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
