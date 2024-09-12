// import 'package:flutter/material.dart';
// import 'package:whereby_app/constants/colors.dart';
// import 'package:whereby_app/utils/fonts.dart';

// class MessageTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final VoidCallback? onSendPressed;
//   final ValueChanged<String>? onChanged;
//   String? texts;
//   MessageTextField({
//     super.key,
//     this.texts,
//     required this.controller,
//     this.onSendPressed,
//     this.onChanged,
//   });

//   @override
//   State<MessageTextField> createState() => _MessageTextFieldState();
// }

// class _MessageTextFieldState extends State<MessageTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         children: [
//           TextField(
//             style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.normal,
//                 fontFamily: FontFamily.poppins),
//             minLines: 1,
//             controller: widget.controller,
//             maxLines: 5,
//             textAlignVertical: TextAlignVertical.center,
//             onChanged: (text) {
//               // widget.onChanged?.call(text);
//               setState(() {});
//             },
//             decoration: InputDecoration(
//               suffixIcon: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // const Icon(
//                   //   Icons.sentiment_satisfied_alt_sharp,
//                   // ),
//                   const Icon(
//                     Icons.alternate_email_rounded,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                     child: IconButton(
//                         onPressed: widget.onSendPressed,
//                         //  () {

//                         // },
//                         icon: const Icon(
//                           Icons.send,
//                         )),
//                   ),
//                 ],
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.white),
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.white),
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//               filled: true,
//               fillColor: ColorConstants.containerColor,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(40.0),
//               ),
//               hintText: 'Write a message',
//             ),
//             onSubmitted: (text) {
//               setState(() {});
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
