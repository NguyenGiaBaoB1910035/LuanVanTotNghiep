import 'dart:convert';
import 'dart:io';
import 'package:boardinghouse_app/apis/boarding_house_api.dart';
import 'package:boardinghouse_app/apis/boarding_house_type_api.dart';
import 'package:boardinghouse_app/apis/constant.dart';
import 'package:boardinghouse_app/apis/user_api.dart';
import 'package:boardinghouse_app/apis/util_api.dart';
import 'package:boardinghouse_app/models/api_response.dart';
import 'package:boardinghouse_app/models/boarding_house.dart';
import 'package:boardinghouse_app/models/boarding_house_type.dart';
import 'package:http/http.dart' as http;
import 'package:boardinghouse_app/models/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';

class CreateBoardingHousePage extends StatefulWidget {
  const CreateBoardingHousePage({Key? key}) : super(key: key);

  @override
  _CreateBoardingHousePageState createState() =>
      _CreateBoardingHousePageState();
}

class _CreateBoardingHousePageState extends State<CreateBoardingHousePage> {
  // BoardingHouse? _boardingHouse;
  String selectedRoom = 'Phòng cho thuê';
  String name = '';
  String address = '';
  int quantity = 1;
  int capacity = 1;
  double acrea = 0.0;
  double price = 0.0;
  double deposit = 0.0;
  double electricityPrice = 0.0;
  double waterPrice = 0.0;
  String description = '';
  // DateTime openTime = DateTime.now();
  // DateTime closeTime = DateTime.now();
  // DateTime publishedAt = DateTime.now();

  bool _loading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int _typeId = 1;
  final TextEditingController _txtNameController = TextEditingController();
  final TextEditingController _txtAddressController = TextEditingController();
  final TextEditingController _txtQuantityController = TextEditingController();
  final TextEditingController _txtCapacityController = TextEditingController();
  final TextEditingController _txtAcraeController = TextEditingController();
  final TextEditingController _txtPriceController = TextEditingController();
  final TextEditingController _txtDepositController = TextEditingController();
  final TextEditingController _txtElectriController = TextEditingController();
  final TextEditingController _txtWaterController = TextEditingController();
  final TextEditingController _txtDescriptionController =
      TextEditingController();

  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  List<String> imagePathList = [];
  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {});
  }

  void deleteImage(int index) {
    setState(() {
      if (index >= 0 && index < imageFileList.length) {
        imageFileList.removeAt(index);
      }
    });
  }

  List<dynamic> _typeList = [];

  //get boardingHouseType
  void getNameBoardingHouseType() async {
    try {
      ApiResponse response = await getBoardingHouseType();
      if (response.error == null) {
        setState(() {
          _typeList = response.data as List<dynamic>;
        });
      } else if (response.error == unauthorized) {
        logout().then((value) => {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
        print("response.error getNameBoardingHouseType ${response.error}");
      }
    } catch (e) {
      print('Error in getNameBoardingHouseType: $e');
    }
  }

  void _createBoardingHouse() async {
    print("có chạy cái này nha");
    int _userId = await getUserId();
    // String? _image = getStringImage(_imageFile);

    List<File> additionalImageFiles = [];

    // Convert additional XFile images to File objects
    for (XFile imageFile in imageFileList) {
      additionalImageFiles.add(File(imageFile.path));
    }

    List<int> selectedUtilsIds = [];
    for (Utils utility in _utilsList) {
      if (utility.isSelected) {
        selectedUtilsIds.add(utility.id!);
      }
    }

    ApiResponse response = await createBoardingHouse(
      _userId,
      _typeId,
      _txtNameController.text,
      _txtAddressController.text,
      _txtQuantityController.text,
      _txtCapacityController.text,
      _txtAcraeController.text,
      _txtPriceController.text,
      _txtDepositController.text,
      _txtElectriController.text,
      _txtWaterController.text,
      _txtDescriptionController.text,
      _imageFile,
      additionalImageFiles,
      selectedUtilsIds,
    );

    if (response.error == null) {
      Navigator.of(context).pop();
    } else if (response.error == unauthorized) {
      logout().then((value) => {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  List<dynamic> _utilsList = [];
  // List<Utils> _utilsList = [];

  //get Uitls
  void getListUtil() async {
    try {
      ApiResponse response = await getUtil();
      if (response.error == null) {
        setState(() {
          _utilsList = response.data as List<dynamic>;
        });
      } else if (response.error == unauthorized) {
        logout().then((value) => {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
        print("response.error getListUtil ${response.error}");
      }
    } catch (e) {
      print('Error in getListUtil: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getNameBoardingHouseType();
    getListUtil();
  }

  int _currentStep = 0;
  List<Step> stepList() => [
        Step(
          state: _currentStep <= 0 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 0,
          title: const Text('Thông tin'),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          image: DecorationImage(
                              image: FileImage(_imageFile ?? File('')),
                              fit: BoxFit.cover),
                        ),
                      ),
                      onTap: () {
                        getImage();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Loại phòng:'),
                    Container(
                      height: 150,
                      child: ListView.builder(
                          itemCount: _typeList.length,
                          itemBuilder: (BuildContext context, int index) {
                            BoardingHouseType type = _typeList[index];
                            return buildRoomOption('${type.name}');
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Tên nhà trọ"),
                    TextFormField(
                      controller: _txtNameController,
                      // decoration: InputDecoration(labelText: 'Sức chứa'),
                      // keyboardType: TextInputTyp.,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Địa chỉ"),
                    TextFormField(
                      controller: _txtAddressController,
                      // decoration: InputDecoration(labelText: 'Sức chứa'),
                      // keyboardType: TextInputTyp.,
                      onChanged: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Số lượng phòng"),
                    TextFormField(
                      controller: _txtQuantityController,
                      // decoration: InputDecoration(labelText: 'Số lượng'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          quantity = int.parse(value);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("sức chứa"),
                    TextFormField(
                      controller: _txtCapacityController,
                      // decoration: InputDecoration(labelText: 'Sức chứa'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          capacity = int.parse(value);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Diện tích'),
                    TextFormField(
                      controller: _txtAcraeController,
                      // decoration: InputDecoration(labelText: 'Diện tích'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          acrea = double.parse(value);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Giá phòng'),
                    TextFormField(
                      controller: _txtPriceController,
                      // decoration: InputDecoration(labelText: 'Chi phí'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          price = double.parse(value);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Đặt cọc'),
                    TextFormField(
                      controller: _txtDepositController,
                      // decoration: InputDecoration(labelText: 'Đặt cọc'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          deposit = double.parse(value);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Giá điện'),
                    TextFormField(
                      controller: _txtElectriController,
                      // decoration: InputDecoration(labelText: 'Giá điện'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          electricityPrice = double.parse(value);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Giá nước'),
                    TextFormField(
                      controller: _txtWaterController,
                      // decoration: InputDecoration(labelText: 'Giá nước'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          waterPrice = double.parse(value);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // ListTile(
                    //   title: const Text('Giờ mở cửa'),
                    //   trailing: Text(_formatTime(openTime)),
                    //   onTap: () async {
                    //     final selectedTime = await showTimePicker(
                    //       context: context,
                    //       initialTime: TimeOfDay.fromDateTime(openTime),
                    //     );
                    //     if (selectedTime != null) {
                    //       setState(() {
                    //         openTime = _combineDateAndTime(
                    //           openTime,
                    //           selectedTime,
                    //         );
                    //       });
                    //     }
                    //   },
                    // ),
                    // ListTile(
                    //   title: const Text('Giờ đóng cửa'),
                    //   trailing: Text(_formatTime(closeTime)),
                    //   onTap: () async {
                    //     final selectedTime = await showTimePicker(
                    //       context: context,
                    //       initialTime: TimeOfDay.fromDateTime(closeTime),
                    //     );
                    //     if (selectedTime != null) {
                    //       setState(() {
                    //         closeTime = _combineDateAndTime(
                    //           closeTime,
                    //           selectedTime,
                    //         );
                    //       });
                    //     }
                    //   },
                    // ),
                    // ListTile(
                    //   title: const Text('Giờ mở cửa'),
                    //   trailing: Text(openTime.format(context)),
                    //   onTap: () async {
                    //     final selectedTime = await showTimePicker(
                    //       context: context,
                    //       initialTime: openTime,
                    //     );
                    //     if (selectedTime != null) {
                    //       setState(() {
                    //         openTime = selectedTime;

                    //       });
                    //     }
                    //   },
                    // ),
                    // ListTile(
                    //   title: const Text('Giờ đóng cửa'),
                    //   trailing: Text(closeTime.format(context)),
                    //   onTap: () async {
                    //     final selectedTime = await showTimePicker(
                    //       context: context,
                    //       initialTime: closeTime,
                    //     );
                    //     if (selectedTime != null) {
                    //       setState(() {
                    //         closeTime = selectedTime;

                    //       });
                    //     }
                    //   },
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Mô tả'),
                    TextFormField(
                      controller: _txtDescriptionController,
                      // decoration: InputDecoration(labelText: 'Mô tả'),
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
          state: _currentStep <= 1 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 1,
          title: const Text('Tiện ích'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // ------------------------------------------------------------------------------------------//
                // ------------------------------------------------------------------------------------------//
                // ------------------------------------------------------------------------------------------//
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("Chọn thêm ảnh và video về nhà trọ của bạn!"),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: imageFileList.length != 0
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: GridView.builder(
                                    itemCount: imageFileList!.length,
                                    itemBuilder: (context, index) {
                                      // return Image.file(
                                      //   File(imageFileList[index].path),
                                      //   fit: BoxFit.cover,
                                      // );
                                      return Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: Image.file(
                                              File(imageFileList[index].path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                deleteImage(index);
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors
                                                      .grey, // Màu nền của nút hình tròn
                                                ),
                                                padding: const EdgeInsets.all(
                                                    5), // Điều chỉnh kích thước của nút hình tròn
                                                child: const Text(
                                                  "x",
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // Màu chữ "x"
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10),
                                  ),
                                )
                              : const Center(
                                  child: Text('Chọn ảnh và video'),
                                )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            textStyle: TextStyle(fontSize: 15)),
                        onPressed: () {
                          selectImages();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 22,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Tải lên",
                              // style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                // const UploadImage(),
                const SizedBox(
                  height: 20,
                ),
                // ------------------------------------------------------------------------------------------//
                // ------------------------------------------------------------------------------------------//
                // ------------------------------------------------------------------------------------------//
                const Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Chọn các tiện ích nhà trọ bạn cung cấp!"),
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Số cột
                      childAspectRatio: 5 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20 // Tỉ lệ chiều cao theo chiều rộng
                      ),
                  itemCount: _utilsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Utils feature = _utilsList[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          feature.isSelected = !feature.isSelected;
                        });
                      },
                      child: Card(
                        color: feature.isSelected ? Colors.green : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          NetworkImage('${feature.imageUrl}'),
                                      fit: BoxFit.cover),
                                  // color: Colors.amber
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${feature.name}',
                                style: TextStyle(
                                  // Kích thước của văn bản
                                  color: feature.isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Step(
          state: _currentStep <= 2 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 2,
          title: const Text('Kết quả'),
          content: const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Nhà trọ của bạn đã được tạo, \n vui lòng chờ Quản trị viên liên hệ xác nhận trước khi đưa lên ứng dụng để đảm bảo tính chính xác",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   color: const Color.fromRGBO(0, 177, 237, 1),
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.of(context).pushNamed('postquickly');
        //   },
        // ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Tạo nhà trọ",
          style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ))
        ],
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        steps: stepList(),
        onStepContinue: () {
          if (_currentStep < (stepList().length - 1)) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            // Chức năng khi hoàn thành tất cả các bước
            print('Submited');
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        // onStepTapped: (int index) {
        //   setState(() {
        //     _currentStep = index;
        //   });
        // },
        controlsBuilder:
            (BuildContext context, ControlsDetails? controlsDetails) {
          final isLastStep = _currentStep == stepList().length - 1;

          return Row(
            children: [
              if (_currentStep > 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý nút Trở lại của từng stepper
                      if (_currentStep == 0) {
                        // Thực hiện chức năng cho stepper thứ nhất khi nhấn nút Trở lại
                      } else if (_currentStep == 1) {
                        // Thực hiện chức năng cho stepper thứ hai khi nhấn nút Trở lại
                      } else if (_currentStep == 2) {
                        // Thực hiện chức năng cho stepper thứ ba khi nhấn nút Trở lại
                      }

                      // Di chuyển đến bước trước đó
                      if (_currentStep > 0) {
                        setState(() {
                          _currentStep -= 1;
                        });
                      }
                    },
                    child: const Text('Trở lại'),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: _currentStep != 0
                      ? const EdgeInsets.only(left: 10)
                      : const EdgeInsets.only(left: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý nút Tiếp tục của stepper thứ nhất
                      if (_currentStep == 0) {
                        print("lưu nhà trọ");

                        // Thực hiện chức năng cho stepper thứ nhất
                      } else if (_currentStep == 1) {
                        print("ảnh và tiện ích");

                        // Thực hiện chức năng cho stepper thứ hai
                      } else if (_currentStep == 2) {
                        print("hoàn thành");

                        // Thực hiện chức năng cho stepper thứ ba
                      }

                      // Di chuyển đến bước tiếp theo
                      if (_currentStep < (stepList().length - 1)) {
                        setState(() {
                          _currentStep += 1;
                        });
                      } else {
                        _createBoardingHouse();
                        Navigator.of(context).pushNamed("postquickly");
                        // Chức năng khi hoàn thành tất cả các bước
                        print('Submited');
                      }
                    },
                    child: (isLastStep)
                        ? const Text('Hoàn thành')
                        : const Text('Tiếp tục'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildRoomOption(String roomName) {
    return Row(
      children: <Widget>[
        Radio(
          value: roomName,
          groupValue: selectedRoom,
          onChanged: (value) {
            setState(() {
              selectedRoom = value.toString();
            });
          },
        ),
        Text(roomName),
      ],
    );
  }
}
