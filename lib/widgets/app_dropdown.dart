import 'package:flutter/material.dart';
import 'package:whereby_app/utils/fonts.dart';

import '../constants/colors.dart';

class PostDropdown extends StatefulWidget {
  final double height;
  final String hintText;
  final List<String> items;
  String selectedValue;

  PostDropdown({
    Key? key,
    required this.height,
    required this.hintText,
    required this.items,
    required this.selectedValue, // Add this line
  }) : super(key: key);

  @override
  _PostDropdownState createState() => _PostDropdownState();
}

class _PostDropdownState extends State<PostDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: DropdownButtonFormField<String>(
        value: widget.selectedValue,
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            widget.selectedValue = newValue!;
          });
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorConstants.borderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorConstants.borderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 12,
            fontFamily: FontFamily.poppins,
            color: ColorConstants.mainText,
          ),
        ),
      ),
    );
  }
}

// class PostDropdown extends StatefulWidget {
//   final double height;
//   final String hintText;
//   final List<String> items;
//   String? selectedValue; // Use a nullable String

//   PostDropdown({
//     Key? key,
//     required this.height,
//     required this.hintText,
//     required this.items,
//   }) : super(key: key);

//   @override
//   _PostDropdownState createState() => _PostDropdownState();
// }

// class _PostDropdownState extends State<PostDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       child: DropdownButtonFormField<String>(
//         value: widget.selectedValue,
//         hint: Text(
//           widget.hintText,
//           style: TextStyle(color: ColorConstants.mainText),
//         ), // Set the hint text here
//         items: widget.items.map((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Container(
//                 color: Colors.white,
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(value),
//               ),
//             ),
//           );
//         }).toList(),
//         onChanged: (String? newValue) {
//           setState(() {
//             widget.selectedValue = newValue;
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
//         ),
//       ),
//     );
//   }
// }
