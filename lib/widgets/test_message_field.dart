// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:whereby_app/constants/colors.dart';
// import 'package:whereby_app/utils/fonts.dart';

// class TestMessageTextField extends StatefulWidget {
//   final TextEditingController controller;
//   const TestMessageTextField({
//     super.key,
//     required this.controller,
//   });

//   @override
//   State<TestMessageTextField> createState() => _MessageTextFieldState();
// }

// class _MessageTextFieldState extends State<TestMessageTextField> {
//   final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

//   String? textValidator(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Text is required';
//     } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//       return 'Enter a post text';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         FormBuilder(
//           key: _formKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               FormBuilderTextField(
//                 name: 'email',
//                 decoration: InputDecoration(
//                   labelStyle:
//                       const TextStyle(color: ColorConstants.borderColor),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16),
//                     borderSide: const BorderSide(color: Colors.black, width: 2),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.white),
//                     borderRadius: BorderRadius.circular(25.0),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.white),
//                     borderRadius: BorderRadius.circular(25.0),
//                   ),
//                   filled: true,
//                   fillColor: ColorConstants.containerColor,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40.0),
//                   ),
//                   hintText: 'Write a message',
//                 ),
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 14,
//                   fontFamily: FontFamily.poppins,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 validator: textValidator,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 50,
//         ),
//       ],
//     );
//   }
// }
