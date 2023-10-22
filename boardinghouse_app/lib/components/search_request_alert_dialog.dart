// import 'package:flutter/material.dart';

// class SearchRequestAlertDialog extends StatefulWidget {
//   const SearchRequestAlertDialog({super.key});

//   @override
//   State<SearchRequestAlertDialog> createState() => _SearchRequestAlertDialogState();
// }

// class _SearchRequestAlertDialogState extends State<SearchRequestAlertDialog> {

//   TextEditingController _textFieldController = TextEditingController();  
//   @override
//   Widget build(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Tìm kiếm nhà trọ'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               DropdownButton<String>(
//                 value: selectedLocation,
//                 onChanged: (String newValue) {
//                   setState(() {
//                     selectedLocation = newValue;
//                   });
//                 },
//                 items: locations.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               DropdownButton<String>(
//                 value: selectedRoomType,
//                 onChanged: (String newValue) {
//                   setState(() {
//                     selectedRoomType = newValue;
//                   });
//                 },
//                 items: roomTypes.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               Slider(
//                 value: maxPrice,
//                 onChanged: (double newValue) {
//                   setState(() {
//                     maxPrice = newValue;
//                   });
//                 },
//                 min: 0.0,
//                 max: 10000000.0,
//                 divisions: 100,
//                 label: '${maxPrice.toStringAsFixed(0)} VND',
//               ),
//               Text('Giá tối đa: ${maxPrice.toStringAsFixed(0)} VND'),
//             ],
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 // Thực hiện tìm kiếm với các thông tin đã chọn
//                 print('Đã chọn: Khu vực: $selectedLocation, Loại phòng: $selectedRoomType, Giá tối đa: $maxPrice VND');
//                 Navigator.of(context).pop();
//               },
//               child: Text('Tìm kiếm'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Hủy'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }