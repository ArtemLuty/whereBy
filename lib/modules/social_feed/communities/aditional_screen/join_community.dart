// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/utils/fonts.dart';
// import 'package:opigno_app/widgets/app_button.dart';

// class JoinCommunityScreen extends StatelessWidget {
//   const JoinCommunityScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               '[Name] community',
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
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 color: ColorConstants.containerColor,
//               ),
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 children: [
//                   Container(
//                       height: 127,
//                       width: 400,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.0),
//                         color: ColorConstants.tapAditionColor,
//                       ),
//                       child: Image.asset(
//                         'assets/png/container-back-image.png',
//                         fit: BoxFit.fill,
//                       )),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Community name',
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                       const SizedBox(width: 10),
//                       InkWell(
//                           onTap: () {
//                             // _showBottomSheet(context);
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SizedBox(
//                               height: 25,
//                               child: SvgPicture.asset(
//                                 'assets/svg/angle-small-left (1).svg',
//                               ),
//                             ),
//                           )),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.all(0.0),
//                         child: Text(
//                           '222',
//                           style: TextStyle(
//                               color: ColorConstants.mainText,
//                               fontFamily: FontFamily.montserratBold,
//                               fontWeight: FontWeight.w800),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(0.0),
//                         child: Text(
//                           'members',
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                       ),
//                       // const Spacer(),
//                       InkWell(
//                         onTap: () {},
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SvgPicture.asset('assets/svg/lock.svg'),
//                         ),
//                       ),
//                       const Text(
//                         "Restricted",
//                         style: TextStyle(color: ColorConstants.mainGray),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: SizedBox(
//               height: 35,
//               child: AppButton(
//                 'Join',
//                 onTap: () {},
//                 color: ColorConstants.containerColor,
//                 textColor: ColorConstants.mainText,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
