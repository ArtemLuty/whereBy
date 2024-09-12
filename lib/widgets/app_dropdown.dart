// import 'package:flutter/material.dart';
// import 'package:whereby_app/utils/fonts.dart';

// import '../constants/colors.dart';

// class PostDropdown extends StatefulWidget {
//   final double height;
//   final String hintText;
//   final List<String> items;
//   String selectedValue;

//   PostDropdown({
//     Key? key,
//     required this.height,
//     required this.hintText,
//     required this.items,
//     required this.selectedValue,
//   }) : super(key: key);

//   @override
//   _PostDropdownState createState() => _PostDropdownState();
// }

// class _PostDropdownState extends State<PostDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: widget.height,
//       child: DropdownButtonFormField<String>(
//         value: widget.selectedValue,
//         items: widget.items.map((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//         onChanged: (String? newValue) {
//           setState(() {
//             widget.selectedValue = newValue!;
//           });
//         },
//         decoration: InputDecoration(
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: ColorConstants.borderColor),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: ColorConstants.borderColor),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           fillColor: Colors.white,
//           hintText: widget.hintText,
//           hintStyle: const TextStyle(
//             fontSize: 12,
//             fontFamily: FontFamily.poppins,
//             color: ColorConstants.mainText,
//           ),
//         ),
//       ),
//     );
//   }
// }
