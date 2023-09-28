import 'package:flutter/material.dart';

class CreateBoardingHousePage extends StatefulWidget {
  const CreateBoardingHousePage({Key? key}) : super(key: key);

  @override
  _CreateBoardingHousePageState createState() =>
      _CreateBoardingHousePageState();
}

class _CreateBoardingHousePageState extends State<CreateBoardingHousePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late TextEditingController addressController;
  late TextEditingController infoController;
  late TextEditingController amenitiesController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    addressController = TextEditingController();
    infoController = TextEditingController();
    amenitiesController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    addressController.dispose();
    infoController.dispose();
    amenitiesController.dispose();
    super.dispose();
  }

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
        title: Text(
          "Tạo nhà trọ",
          style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(
                Icons.location_on,
                size: 36.0, // Điều chỉnh kích thước biểu tượng tròn
              ),
              text: 'Địa chỉ',
            ),
            Tab(
              icon: Icon(
                Icons.info,
                size: 36.0, // Điều chỉnh kích thước biểu tượng tròn
              ),
              text: 'Thông tin',
            ),
            Tab(
              icon: Icon(
                Icons.shopping_cart,
                size: 36.0, // Điều chỉnh kích thước biểu tượng tròn
              ),
              text: 'Tiện ích',
            ),
          ],
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 4.0, // Điều chỉnh chiều rộng của dòng gạch ngang
              color:
                  Color.fromRGBO(0, 177, 237, 1), // Màu sắc của dòng gạch ngang
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StepPage(
            title: 'Địa chỉ',
            controller: addressController,
            onNext: () {
              if (_tabController.index < 2) {
                _tabController.animateTo(_tabController.index + 1);
              }
            },
          ),
          StepPage(
            title: 'Thông tin',
            controller: infoController,
            onNext: () {
              if (_tabController.index < 2) {
                _tabController.animateTo(_tabController.index + 1);
              }
            },
          ),
          StepPage(
            title: 'Tiện ích',
            controller: amenitiesController,
          ),
        ],
      ),
    );
  }
}

class StepPage extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final VoidCallback? onNext;

  StepPage({
    required this.title,
    required this.controller,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.circle,
            size: 64.0, // Kích thước biểu tượng tròn
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Nhập $title'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: onNext,
            child: Text('Tiếp theo'),
          ),
        ],
      ),
    );
  }
}
