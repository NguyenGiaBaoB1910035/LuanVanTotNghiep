import 'package:boardinghouse_app/components/card_boarding_house_detail.dart';
// import 'package:boardinghouse_app/screens/home/suggestpage.dart';
import 'package:flutter/material.dart';

class SuggestUI extends StatelessWidget {
  const SuggestUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Phòng gợi ý",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: (1 / 1.4),
                // scrollDirection: Axis.vertical,
                children: List.generate(10, (index) {
                  return const CardBoardingHouseDetail();
                }),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Divider(
                  color: Colors.black54,
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('suggest');
                    },
                    child: const Text(
                      "Xem tất cả",
                      style: TextStyle(fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
