// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/social_feed_post_card.dart';
// import 'package:opigno_app/utils/fonts.dart';

// class YourPostsScreen extends StatelessWidget {
//   const YourPostsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               'Your communities feed',
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
//           SocialFeedPostCard(index: 0),
//         ],
//       ),
//     );
//   }
// }
