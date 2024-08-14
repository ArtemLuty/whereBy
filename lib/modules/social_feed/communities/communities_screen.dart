// import 'package:flutter/material.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/modules/social_feed/communities/create_community/create_community.dart';
// import 'package:opigno_app/modules/social_feed/communities/pending_communities_card%20copy.dart';
// import 'package:opigno_app/modules/social_feed/communities/search_community.dart';
// import 'package:opigno_app/modules/social_feed/communities/aditional_screen/your_communities_card.dart';

// class CommunitiesScreen extends StatelessWidget {
//   const CommunitiesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const SearchCommunity(),
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
//                   child: Container(
//                     width: 180,
//                     height: 35,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       color: ColorConstants.containerColor,
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Search a Community',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w800, fontSize: 12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const CreateCommunity(),
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.only(right: 10.0, top: 5, bottom: 5),
//                   child: Container(
//                     width: 180,
//                     height: 35,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       color: ColorConstants.containerColor,
//                     ),
//                     padding: const EdgeInsets.all(2),
//                     child: const Center(
//                       child: Text(
//                         'Create a Community',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w800, fontSize: 12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Text(
//               'Pending invitations',
//               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
//             ),
//           ),
//           const PendingCommunities(),
//           const Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Text(
//               'Your communities',
//               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
//             ),
//           ),
//           const YourCommunities(),
//         ],
//       ),
//     );
//   }
// }
