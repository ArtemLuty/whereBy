// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/utils/fonts.dart';
// import 'package:opigno_app/widgets/app_button.dart';
// import 'package:opigno_app/widgets/app_dropdown.dart';
// import 'package:opigno_app/widgets/post_text_field.dart';

// class CreateCommunity extends StatelessWidget {
//   const CreateCommunity({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               'Create a community',
//               style: TextStyle(
//                   color: ColorConstants.mainText,
//                   fontFamily: FontFamily.montserratBold,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16),
//             ),
//           ],
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 10.0),
//           child: IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: SvgPicture.asset('assets/svg/angle-small-left.svg')),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Center(
//                       child: CircleAvatar(
//                         backgroundColor: ColorConstants.buttonDeclineColor,
//                         child: SvgPicture.asset('assets/svg/camera_grey.svg'),
//                       ),
//                     ),
//                     // SizedBox(width: 10),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: SizedBox(
//                         height: 25,
//                         width: 146,
//                         child: AppButton(
//                           'Add a picture',
//                           onTap: () {},
//                           color: ColorConstants.tapColor,
//                           textColor: ColorConstants.mainText,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 const Text('Community name',
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontFamily: FontFamily.montserrat,
//                         color: ColorConstants.mainText)),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10.0),
//                   child: PostTextField(
//                     hintText: "Write a name for the community",
//                     hight: 35,
//                   ),
//                 ),
//                 const Text('Description',
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontFamily: FontFamily.montserrat,
//                         color: ColorConstants.mainText)),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10.0),
//                   child: PostTextField(
//                     hintText: "Describe your community",
//                     hight: 71,
//                   ),
//                 ),
//                 const Text('Visibility',
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontFamily: FontFamily.montserrat,
//                         color: ColorConstants.mainText)),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10.0),
//                   child: PostDropdown(
//                     hintText: "Public",
//                     height: 56,
//                     items: const ['Public', 'Only community', 'Only me'],
//                     selectedValue: "Public",
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: SizedBox(
//               height: 35,
//               child: AppButton(
//                 'Create the community',
//                 onTap: () {},
//                 color: ColorConstants.tapColor,
//                 textColor: ColorConstants.mainText,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }
