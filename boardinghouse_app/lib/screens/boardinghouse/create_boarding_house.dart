// import 'dart:convert';
// import 'dart:io';
// import 'package:boardinghouse_app/apis/boarding_house_api.dart';
// import 'package:boardinghouse_app/apis/boarding_house_type_api.dart';
// import 'package:boardinghouse_app/apis/constant.dart';
// import 'package:boardinghouse_app/apis/user_api.dart';
// import 'package:boardinghouse_app/apis/util_api.dart';
// import 'package:boardinghouse_app/models/api_response.dart';
// import 'package:boardinghouse_app/models/boarding_house.dart';
// import 'package:boardinghouse_app/models/boarding_house_type.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:boardinghouse_app/models/util.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class CreateBoardingHouse extends StatefulWidget {
//   const CreateBoardingHouse({Key? key}) : super(key: key);

//   @override
//   _CreateBoardingHouseState createState() =>
//       _CreateBoardingHouseState();
// }

// class _CreateBoardingHouseState extends State<CreateBoardingHouse> {
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   getNameBoardingHouseType();
//   // }
//   int _currentStep = 0;
//   final _boardinghousekey = GlobalKey<FormState>();
//   List<Step> stepList() => [
//         Step(
//           state: _currentStep <= 0 ? StepState.editing : StepState.complete,
//           isActive: _currentStep >= 0,
//           title: const Text('Thông tin'),
//           content: const InforForm(),
//         ),
//         Step(
//           state: _currentStep <= 1 ? StepState.editing : StepState.complete,
//           isActive: _currentStep >= 1,
//           title: const Text('Tiện ích'),
//           content: const UtilForm(),
//         ),
//         Step(
//           state: _currentStep <= 2 ? StepState.editing : StepState.complete,
//           isActive: _currentStep >= 2,
//           title: const Text('Kết quả'),
//           content: const Center(
//             child: Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Text(
//                 "Nhà trọ của bạn đã được tạo, \n vui lòng chờ Quản trị viên liên hệ xác nhận trước khi đưa lên ứng dụng để đảm bảo tính chính xác",
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ),
//       ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           color: const Color.fromRGBO(0, 177, 237, 1),
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pushNamed('main');
//           },
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "Tạo nhà trọ",
//           style: TextStyle(color: Color.fromRGBO(0, 177, 237, 1)),
//         ),
//       ),
//       body: Form(
//         key: _boardinghousekey,
//         child: Stepper(
//           type: StepperType.horizontal,
//           currentStep: _currentStep,
//           steps: stepList(),
//           onStepContinue: () {
//             if (_currentStep < (stepList().length - 1)) {
//               setState(() {
//                 _currentStep += 1;
//               });
//             } else {
//               print('Submited');
//             }
//           },
//           onStepCancel: () {
//             if (_currentStep > 0) {
//               setState(() {
//                 _currentStep -= 1;
//               });
//             }
//           },
//           onStepTapped: (int index) {
//             setState(() {
//               _currentStep = index;
//             });
//           },
//           controlsBuilder:
//               (BuildContext context, ControlsDetails? controlsDetails) {
//             final isLastStep = _currentStep == stepList().length - 1;
//             return Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: controlsDetails?.onStepContinue,
//                     child: (isLastStep)
//                         ? const Text('Hoàn thành')
//                         : const Text('Tiếp tục'),
//                   ),
//                 ),
//                 if (_currentStep > 0)
//                   // const SizedBox(width: 10),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: ElevatedButton(
//                         onPressed: controlsDetails?.onStepCancel,
//                         child: const Text('Trở lại'),
//                       ),
//                     ),
//                   )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//

// class InforForm extends StatefulWidget {
//   const InforForm({super.key});

//   @override
//   State<InforForm> createState() => _InforFormState();
// }

// class _InforFormState extends State<InforForm> {
//   BoardingHouse? _boardingHouse;
//   // bool loading = true;

//   String selectedRoom = 'Phòng cho thuê';
//   String name = '';
//   String address = '';
//   int quantity = 1;
//   int capacity = 1;
//   // String selectedGender = 'Tất cả';
//   double acrea = 0.0;
//   double price = 0.0;
//   double deposit = 0.0;
//   double electricityPrice = 0.0;
//   double waterPrice = 0.0;
//   TimeOfDay openTime = TimeOfDay.now();
//   TimeOfDay closeTime = TimeOfDay.now();
//   String description = '';

//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TextEditingController _txtTypeController = TextEditingController();
//   final TextEditingController _txtNameController = TextEditingController();
//   final TextEditingController _txtAddressController = TextEditingController();
//   final TextEditingController _txtQuantityController = TextEditingController();
//   final TextEditingController _txtCapacityController = TextEditingController();
//   final TextEditingController _txtAcraeController = TextEditingController();
//   final TextEditingController _txtPriceController = TextEditingController();
//   final TextEditingController _txtDepositController = TextEditingController();
//   final TextEditingController _txtElectriController = TextEditingController();
//   final TextEditingController _txtWaterController = TextEditingController();
//   final TextEditingController _txtOpenTimeController = TextEditingController();
//   final TextEditingController _txtCloseTimeController = TextEditingController();
//   final TextEditingController _txtDescriptionController =
//       TextEditingController();

//   File? _imageFile;
//   final _picker = ImagePicker();

//   Future getImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   void _createBoardingHouse() async {
//     int userId = await getUserId();
//     String? image = _imageFile == null ? null : getStringImage(_imageFile);
//     ApiResponse response = await createBoardingHouse(
//         userId,
//         _txtTypeController.text,
//         _txtNameController.text,
//         _txtAddressController.text,
//         _txtQuantityController.text,
//         _txtCapacityController.text,
//         _txtAcraeController.text,
//         _txtPriceController.text,
//         _txtDepositController.text,
//         _txtElectriController.text,
//         _txtWaterController.text,
//         _txtOpenTimeController.text,
//         _txtCloseTimeController.text,
//         _txtDescriptionController.text,
//         image!);

//     if (response.error == null) {
//       Navigator.of(context).pop();
//     } else if (response.error == unauthorized) {
//       logout().then((value) => {
//             // Navigator.of(context).pushAndRemoveUntil(
//             //     MaterialPageRoute(builder: (context) => Login()),
//             //     (route) => false)
//           });
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('${response.error}')));
//       setState(() {
//         // _loading = !_loading;
//       });
//     }
//   }

//   List<dynamic> _typeList = [];
//   void getNameBoardingHouseType() async {
//     try {
//       ApiResponse response = await getBoardingHouseType();
//       if (response.error == null) {
//         setState(() {
//           _typeList = response.data as List<dynamic>;
//         });
//       } else if (response.error == unauthorized) {
//         logout().then((value) => {});
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('${response.error}')));
//         print(response.error);
//       }
//     } catch (e) {
//       print('Error in getNameBoardingHouseType: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getNameBoardingHouseType();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               GestureDetector(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 180,
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 1),
//                     image: DecorationImage(
//                         image: FileImage(_imageFile ?? File('')),
//                         fit: BoxFit.cover),
//                   ),
//                 ),
//                 onTap: () {
//                   getImage();
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text('Loại phòng:'),

//               Container(
//                 height: 150,
//                 child: ListView.builder(
//                     itemCount: _typeList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       BoardingHouseType type = _typeList[index];
//                       return buildRoomOption('${type.name}');
//                     }),
//               ),

//               // Column(
//               //   children: <Widget>[
//               //     buildRoomOption('Phòng cho thuê'),
//               //     buildRoomOption('Ký túc xá'),
//               //     buildRoomOption('Nhà nguyên căn'),
//               //     // buildRoomOption('Căn hộ'),
//               //   ],
//               // ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text("Tên nhà trọ"),
//               TextFormField(
//                 controller: _txtNameController,
//                 // decoration: InputDecoration(labelText: 'Sức chứa'),
//                 // keyboardType: TextInputTyp.,
//                 onChanged: (value) {
//                   setState(() {
//                     name = value;
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text("Địa chỉ"),
//               TextFormField(
//                 controller: _txtAddressController,
//                 // decoration: InputDecoration(labelText: 'Sức chứa'),
//                 // keyboardType: TextInputTyp.,
//                 onChanged: (value) {
//                   setState(() {
//                     address = value;
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text("Số lượng phòng"),
//               TextFormField(
//                 // decoration: InputDecoration(labelText: 'Số lượng'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     quantity = int.parse(value);
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text("sức chứa"),
//               TextFormField(
//                 // decoration: InputDecoration(labelText: 'Sức chứa'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     capacity = int.parse(value);
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text('Diện tích'),
//               TextFormField(
//                 // decoration: InputDecoration(labelText: 'Diện tích'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     acrea = double.parse(value);
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text('Giá phòng'),
//               TextFormField(
//                 // decoration: InputDecoration(labelText: 'Chi phí'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     price = double.parse(value);
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text('Đặt cọc'),
//               TextFormField(
//                 // decoration: InputDecoration(labelText: 'Đặt cọc'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     deposit = double.parse(value);
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text('Giá điện'),
//               TextFormField(
//                 // decoration: InputDecoration(labelText: 'Giá điện'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     electricityPrice = double.parse(value);
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text('Giá nước'),
//               TextFormField(
//                 // decoration: InputDecoration(labelText: 'Giá nước'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   setState(() {
//                     waterPrice = double.parse(value);
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               ListTile(
//                 title: const Text('Giờ mở cửa'),
//                 trailing: Text(openTime.format(context)),
//                 onTap: () async {
//                   final selectedTime = await showTimePicker(
//                     context: context,
//                     initialTime: openTime,
//                   );
//                   if (selectedTime != null) {
//                     setState(() {
//                       openTime = selectedTime;
//                     });
//                   }
//                 },
//               ),
//               ListTile(
//                 title: const Text('Giờ đóng cửa'),
//                 trailing: Text(closeTime.format(context)),
//                 onTap: () async {
//                   final selectedTime = await showTimePicker(
//                     context: context,
//                     initialTime: closeTime,
//                   );
//                   if (selectedTime != null) {
//                     setState(() {
//                       closeTime = selectedTime;
//                     });
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text('Mô tả'),
//               TextFormField(
//                 // decoration: InputDecoration(labelText: 'Mô tả'),
//                 onChanged: (value) {
//                   setState(() {
//                     description = value;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildRoomOption(String roomName) {
//     return Row(
//       children: <Widget>[
//         Radio(
//           value: roomName,
//           groupValue: selectedRoom,
//           onChanged: (value) {
//             setState(() {
//               selectedRoom = value.toString();
//             });
//           },
//         ),
//         Text(roomName),
//       ],
//     );
//   }
// }

// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//
// class UtilForm extends StatefulWidget {
//   const UtilForm({super.key});

//   @override
//   State<UtilForm> createState() => _UtilFormState();
// }

// // List<Util> utils = [
// //   Util(icon: Icons.wifi, name: 'Wifi'),
// //   Util(icon: Icons.directions_car, name: 'Nhà Xe'),
// //   Util(icon: Icons.wash, name: 'Máy Giặt'),
// //   Util(icon: Icons.ac_unit, name: 'Máy Lạnh'),
// //   Util(icon: Icons.tv, name: 'TV'),
// //   Util(icon: Icons.kitchen, name: 'Tủ Lạnh'),
// //   Util(icon: Icons.king_bed, name: 'Giường'),
// //   Util(icon: Icons.access_time, name: 'Giờ Tự Do'),
// //   Util(icon: Icons.hotel, name: 'Gác Lửng'),
// //   Util(icon: Icons.pets, name: 'Thú Cưng'),
// //   Util(icon: Icons.outdoor_grill, name: 'Ban Công'),
// // ];

// class _UtilFormState extends State<UtilForm> {
//   List<dynamic> _utilsList = [];
//   void getListUtil() async {
//     try {
//       ApiResponse response = await getUtil();
//       if (response.error == null) {
//         setState(() {
//           _utilsList = response.data as List<dynamic>;
//         });
//       } else if (response.error == unauthorized) {
//         logout().then((value) => {});
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('${response.error}')));
//       }
//     } catch (e) {
//       print('Error in getNameBoardingHouseType: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getListUtil();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           const UploadImage(),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text("Chọn các tiện ích nhà trọ bạn cung cấp!"),
//           ),
//           GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // Số cột
//                 childAspectRatio: 5 / 2,
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 20 // Tỉ lệ chiều cao theo chiều rộng
//                 ),
//             itemCount: _utilsList.length,
//             itemBuilder: (BuildContext context, int index) {
//               Utils feature = _utilsList[index];
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     feature.isSelected = !feature.isSelected;
//                   });
//                 },
//                 child: Card(
//                   color: feature.isSelected ? Colors.green : Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 10,
//                           height: 10,
//                           decoration: BoxDecoration(
//                               // borderRadius: BorderRadius.circular(60),
//                               image: DecorationImage(
//                                   image: NetworkImage('${feature.imageUrl}'),
//                                   fit: BoxFit.cover)),
//                         ),
//                         // Icon(
//                         //   feature.icon,
//                         //   color:
//                         //       feature.isSelected ? Colors.white : Colors.grey,
//                         //   // Kích thước của icon
//                         // ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           '${feature.name}',
//                           style: TextStyle(
//                             // Kích thước của văn bản
//                             color: feature.isSelected
//                                 ? Colors.white
//                                 : Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//
// //--------------------------------------------------------------------------------------------------------------//

// final ImagePicker imagePicker = ImagePicker();
// List<XFile> imageFileList = [];

// class UploadImage extends StatefulWidget {
//   const UploadImage({super.key});

//   @override
//   State<UploadImage> createState() => _UploadImageState();
// }

// class _UploadImageState extends State<UploadImage> {
//   void selectImages() async {
//     final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
//     if (selectedImages!.isNotEmpty) {
//       imageFileList!.addAll(selectedImages);
//     }
//     setState(() {});
//   }

//   void deleteImage(int index) {
//     setState(() {
//       if (index >= 0 && index < imageFileList.length) {
//         imageFileList.removeAt(index);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(10),
//           child: Text("Chọn thêm ảnh và video về nhà trọ của bạn!"),
//         ),
//         // const SizedBox(
//         //   height: 10,
//         // ),
//         Padding(
//           padding: const EdgeInsets.all(10),
//           child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 150,
//               decoration: BoxDecoration(border: Border.all(width: 1)),
//               child: imageFileList.length != 0
//                   ? Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: GridView.builder(
//                         itemCount: imageFileList!.length,
//                         itemBuilder: (context, index) {
//                           // return Image.file(
//                           //   File(imageFileList[index].path),
//                           //   fit: BoxFit.cover,
//                           // );
//                           return Stack(
//                             children: [
//                               Container(
//                                 width: MediaQuery.of(context).size.width,
//                                 height: MediaQuery.of(context).size.height,
//                                 child: Image.file(
//                                   File(imageFileList[index].path),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 0,
//                                 right: 0,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     deleteImage(index);
//                                   },
//                                   child: Container(
//                                     decoration: const BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Colors
//                                           .grey, // Màu nền của nút hình tròn
//                                     ),
//                                     padding: const EdgeInsets.all(
//                                         5), // Điều chỉnh kích thước của nút hình tròn
//                                     child: const Text(
//                                       "x",
//                                       style: TextStyle(
//                                         color: Colors.white, // Màu chữ "x"
//                                         fontSize: 10,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 4,
//                                 mainAxisSpacing: 10,
//                                 crossAxisSpacing: 10),
//                       ),
//                     )
//                   : const Center(
//                       child: Text('Chọn ảnh và video'),
//                     )),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 50),
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 minimumSize: Size.fromHeight(40),
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//                 textStyle: TextStyle(fontSize: 15)),
//             onPressed: () {
//               selectImages();
//             },
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.image_outlined,
//                   size: 22,
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Text(
//                   "Tải lên",
//                   // style: TextStyle(fontSize: 15),
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
