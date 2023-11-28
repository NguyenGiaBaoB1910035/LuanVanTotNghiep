import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:boardinghouse_app/models/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateBoardingHousePage extends StatefulWidget {
  const CreateBoardingHousePage({Key? key}) : super(key: key);

  @override
  _CreateBoardingHousePageState createState() =>
      _CreateBoardingHousePageState();
}

class _CreateBoardingHousePageState extends State<CreateBoardingHousePage> {
  int _currentStep = 0;
  final _boardinghousekey = GlobalKey<FormState>();
  List<Step> stepList() => [
        Step(
          state: _currentStep <= 0 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 0,
          title: const Text('địa chỉ'),
          content: addressForm(),
        ),
        Step(
          state: _currentStep <= 1 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 1,
          title: const Text('Thông tin'),
          content: const InforForm(),
        ),
        Step(
          state: _currentStep <= 2 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 2,
          title: const Text('Tiện ích'),
          content: const UtilForm(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: const Color.fromRGBO(0, 177, 237, 1),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('main');
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Tạo nhà trọ",
          style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
        ),
      ),
      body: Form(
        key: _boardinghousekey,
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          steps: stepList(),
          onStepContinue: () {
            if (_currentStep < (stepList().length - 1)) {
              setState(() {
                _currentStep += 1;
              });
            } else {
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
          onStepTapped: (int index) {
            setState(() {
              _currentStep = index;
            });
          },
          controlsBuilder:
              (BuildContext context, ControlsDetails? controlsDetails) {
            final isLastStep = _currentStep == stepList().length - 1;
            return Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controlsDetails?.onStepContinue,
                    child: (isLastStep)
                        ? const Text('Hoàn thành')
                        : const Text('Tiếp tục'),
                  ),
                ),
                const SizedBox(width: 10),
                if (_currentStep > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controlsDetails?.onStepCancel,
                      child: const Text('Trở lại'),
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//

class addressForm extends StatefulWidget {
  @override
  _addressFormState createState() => _addressFormState();
}

class _addressFormState extends State<addressForm> {
// String selectedDistrict = 'Quận Ninh Kiều';
// String selectedWard = '';
  TextEditingController addressController = TextEditingController();
// late Future<List<District>?> _districtListFuture;
// late Future<List<Ward>?> _wardListFuture;
// late District district;

// @override
// void initState() {
//   super.initState();
//   // _userListFuture = UserApi().getUsers();
//   _districtListFuture = AddressApi().fetchDistrict();
//   _wardListFuture = AddressApi().fetchWard(district.id);
// }

// List<String> districtList = [
//   'Quận Ninh Kiều',
//   'Quận Cái Răng',
//   'Quận Thốt Nốt',
//   'Quận Bình Thủy'
// ];
// Map<String, List<String>> wards = {
//   'Quận Ninh Kiều': ['Phường A', 'Phường B'],
//   'Quận Cái Răng': ['Phường X', 'Phường Y'],
//   'Quận Thốt Nốt': ['Phường M', 'Phường N'],
//   'Quận Bình Thủy': ['Phường P', 'Phường Q'],
// };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
//       DropdownButtonFormField(
//         onChanged: (String? newValue) {
//           setState(() {
//             selectedDistrict = newValue!;
//           });
//         },
//         items: districtList.map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value.isNotEmpty ? value : null,
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 20),
//             ),
//           );
//         }).toList(),
//         decoration: const InputDecoration(
//           hintText: 'Chọn Quận/Huyện',
//           labelText: 'Chọn Quận/Huyện',
//           border: OutlineInputBorder(),
//         ),
//       ),
//       const SizedBox(height: 16),
//       DropdownButtonFormField<String>(
//         onChanged: (String? newValue) {
//           setState(() {
//             selectedWard = newValue!;
//           });
//         },
//         items: wards[selectedDistrict]!
//             .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value.isNotEmpty ? value : null,
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 20),
//             ),
//           );
//         }).toList(),
//         value: selectedWard.isNotEmpty ? selectedWard : null,
//         decoration: const InputDecoration(
//           hintText: 'Chọn Phường/Xã',
//           labelText: 'Chọn Phường/Xã',
//           border: OutlineInputBorder(),
//         ),
//       ),
          const SizedBox(height: 16),
          TextFormField(
            controller: addressController,
            decoration: const InputDecoration(
              labelText: 'Địa Chỉ',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
//

//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//

class InforForm extends StatefulWidget {
  const InforForm({super.key});

  @override
  State<InforForm> createState() => _InforFormState();
}

class _InforFormState extends State<InforForm> {
  String selectedRoom = 'Phòng cho thuê';
  int quantity = 1;
  int capacity = 1;
  String selectedGender = 'Tất cả';
  double area = 0.0;
  double cost = 0.0;
  double deposit = 0.0;
  double electricityPrice = 0.0;
  double waterPrice = 0.0;
  TimeOfDay openTime = TimeOfDay.now();
  TimeOfDay closeTime = TimeOfDay.now();
  String description = '';

  // double maxPrice = 1000000.0;

  // void handleSubmit() {
  //   // Xử lý dữ liệu ở đây
  //   print('Phòng: $selectedRoom');
  //   print('Số lượng: $quantity');
  //   print('Sức chứa: $capacity');
  //   print('Giới tính: $selectedGender');
  //   print('Diện tích: $area');
  //   print('Chi phí: $cost');
  //   print('Đặt cọc: $deposit');
  //   print('Giá điện: $electricityPrice');
  //   print('Giá nước: $waterPrice');
  //   print('Giờ mở cửa: $openTime');
  //   print('Giờ đóng cửa: $closeTime');
  //   print('Mô tả: $description');
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Loại phòng:'),
            Column(
              children: <Widget>[
                buildRoomOption('Phòng cho thuê'),
                buildRoomOption('Ký túc xá'),
                buildRoomOption('Nhà nguyên căn'),
                // buildRoomOption('Căn hộ'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Tên nhà trọ"),
            TextFormField(
              // decoration: InputDecoration(labelText: 'Sức chứa'),
              // keyboardType: TextInputTyp.,
              onChanged: (value) {
                setState(() {
                  capacity = int.parse(value);
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Số lượng phòng"),
            TextFormField(
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
            const Text('Giới tính'),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildGenderOption('Tất cả'),
                buildGenderOption('Nam'),
                buildGenderOption('Nữ'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Diện tích'),
            TextFormField(
              // decoration: InputDecoration(labelText: 'Diện tích'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  area = double.parse(value);
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Giá phòng'),
            TextFormField(
              // decoration: InputDecoration(labelText: 'Chi phí'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  cost = double.parse(value);
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Đặt cọc'),
            TextFormField(
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
            ListTile(
              title: const Text('Giờ mở cửa'),
              trailing: Text(openTime.format(context)),
              onTap: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: openTime,
                );
                if (selectedTime != null) {
                  setState(() {
                    openTime = selectedTime;
                  });
                }
              },
            ),
            ListTile(
              title: const Text('Giờ đóng cửa'),
              trailing: Text(closeTime.format(context)),
              onTap: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: closeTime,
                );
                if (selectedTime != null) {
                  setState(() {
                    closeTime = selectedTime;
                  });
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Mô tả'),
            TextFormField(
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

  Widget buildGenderOption(String gender) {
    return Row(
      children: <Widget>[
        Radio(
          value: gender,
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value.toString();
            });
          },
        ),
        Text(gender),
      ],
    );
  }
}

//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
class UtilForm extends StatefulWidget {
  const UtilForm({super.key});

  @override
  State<UtilForm> createState() => _UtilFormState();
}

List<Util> utils = [
  Util(icon: Icons.wifi, name: 'Wifi'),
  Util(icon: Icons.directions_car, name: 'Nhà Xe'),
  Util(icon: Icons.wash, name: 'Máy Giặt'),
  Util(icon: Icons.ac_unit, name: 'Máy Lạnh'),
  Util(icon: Icons.tv, name: 'TV'),
  Util(icon: Icons.kitchen, name: 'Tủ Lạnh'),
  Util(icon: Icons.king_bed, name: 'Giường'),
  Util(icon: Icons.access_time, name: 'Giờ Tự Do'),
  Util(icon: Icons.hotel, name: 'Gác Lửng'),
  Util(icon: Icons.pets, name: 'Thú Cưng'),
  Util(icon: Icons.outdoor_grill, name: 'Ban Công'),
];

class _UtilFormState extends State<UtilForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const UploadImage(),
          SizedBox(
            height: 20,
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
            itemCount: utils.length,
            itemBuilder: (BuildContext context, int index) {
              final feature = utils[index];
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
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          feature.icon,
                          color:
                              feature.isSelected ? Colors.white : Colors.grey,
                          // Kích thước của icon
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          feature.name,
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
    );
  }
}

//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------//

final ImagePicker imagePicker = ImagePicker();
List<XFile> imageFileList = [];

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(border: Border.all(width: 1)),
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
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
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
                                        color: Colors.white, // Màu chữ "x"
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
                      child: Text(' Chọn ảnh'),
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
                  "upload image",
                  // style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
