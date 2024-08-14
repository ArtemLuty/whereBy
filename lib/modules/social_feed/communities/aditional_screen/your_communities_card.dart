// import 'package:flutter/material.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/modules/social_feed/communities/aditional_screen/your_community_posts.dart';

// class YourCommunities extends StatelessWidget {
//   const YourCommunities({super.key});
//   final itemCount = 8;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 300,
//       child: ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const YourPostsScreen(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     color: ColorConstants.containerColor,
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   child: const Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Row(
//                         children: [
//                           Center(
//                             child: CircleAvatar(
//                               radius: 14,
//                               backgroundColor: ColorConstants.containerColor,
//                               backgroundImage:
//                                   AssetImage('assets/png/comunities.png'),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Community name',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w800, fontSize: 12),
//                               ),
//                             ],
//                           ),
//                           Spacer(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
