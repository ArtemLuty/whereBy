// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/modules/social_feed/communities/aditional_screen/join_community.dart';
// import 'package:opigno_app/widgets/app_button.dart';
// import 'package:opigno_app/widgets/message_text_field.dart';

// class CommunitiesCard extends StatefulWidget {
//   const CommunitiesCard({super.key});

//   @override
//   State<CommunitiesCard> createState() => _CommunitiesCardState();
// }

// class _CommunitiesCardState extends State<CommunitiesCard> {
//   final TextEditingController textEditingController = TextEditingController();
//   var likes = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           color: ColorConstants.containerColor,
//         ),
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const JoinCommunityScreen(),
//                   ),
//                 );
//               },
//               child: const Row(
//                 children: [
//                   Center(
//                     child: CircleAvatar(
//                       radius: 14,
//                       backgroundColor: ColorConstants.containerColor,
//                       backgroundImage: AssetImage('assets/png/comunities.png'),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Community name',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w800, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SizedBox(
//                   width: 125,
//                   height: 25,
//                   child: AppButton(
//                     "Accept",
//                     onTap: () {},
//                     color: ColorConstants.buttonColor,
//                     textColor: ColorConstants.mainText,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 SizedBox(
//                   width: 125,
//                   height: 25,
//                   child: AppButton(
//                     "Decline",
//                     onTap: () {},
//                     color: ColorConstants.buttonDeclineColor,
//                     textColor: ColorConstants.mainText,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _showBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       elevation: 10,
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           decoration: const BoxDecoration(
//             color: Colors.white, // Background color of the bottom sheet
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10.0), // Adjust the radius as needed
//               topRight: Radius.circular(10.0), // Adjust the radius as needed
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: ColorConstants
//                             .mainGray, // Background color of the bottom sheet
//                         borderRadius: BorderRadius.circular(30)),
//                     height: 4.0,
//                     width: 45.0,
//                     // color: Colors.grey, // Grey line at the top
//                   ),
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/thumbtack.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text('Pin the post to the top'),
//                   onTap: () {
//                     // Add your action for Option 1 here
//                   },
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/union-5.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text('Remove connection with [username]'),
//                   onTap: () {
//                     // Add your action for Option 2 here
//                   },
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/eye-crossed.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text('Hide the post'),
//                   onTap: () {
//                     // Add your action for Option 3 here
//                   },
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/trash.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text('Delete the post'),
//                   onTap: () {
//                     // Add your action for Option 4 here
//                   },
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   final itemCount = 8;

//   void _showCommentSheet(BuildContext context) {
//     showModalBottomSheet(
//       elevation: 10,
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           decoration: const BoxDecoration(
//             color: Colors.white, // Background color of the bottom sheet
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10.0), // Adjust the radius as needed
//               topRight: Radius.circular(10.0), // Adjust the radius as needed
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: ColorConstants
//                             .mainGray, // Background color of the bottom sheet
//                         borderRadius: BorderRadius.circular(30)),
//                     height: 4.0,
//                     width: 45.0,
//                     // color: Colors.grey, // Grey line at the top
//                   ),
//                 ),
//                 //
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: SizedBox(
//                     height: 250,
//                     child: ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         itemCount: itemCount,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Row(
//                                 children: [
//                                   const Center(
//                                     child: CircleAvatar(
//                                       radius: 14,
//                                       backgroundColor:
//                                           ColorConstants.containerColor,
//                                       backgroundImage: AssetImage(
//                                           'assets/png/profile-smoll.png'),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   const Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Username',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w800,
//                                             fontSize: 12),
//                                       ),
//                                       Text(
//                                         'dd.mm.yyyy',
//                                         style: TextStyle(fontSize: 10),
//                                       )
//                                     ],
//                                   ),
//                                   const Spacer(),
//                                   InkWell(
//                                       onTap: () {
//                                         _showBottomSheet(context);
//                                       },
//                                       child: SvgPicture.asset(
//                                           'assets/svg/menu-dots.svg')),
//                                 ],
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 8.0),
//                                 child: Text(
//                                     'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod @username tempor invidunt ut labore et dolore magna.'),
//                               ),
//                               Row(
//                                 children: [
//                                   SvgPicture.asset(
//                                     'assets/svg/big-like.svg',
//                                     height: 10,
//                                   ),
//                                   const Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       'Like',
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                   ),
//                                   const Spacer(),
//                                   Padding(
//                                     padding: const EdgeInsets.all(4.0),
//                                     child: SvgPicture.asset(
//                                         'assets/svg/thumbs-up.svg'),
//                                   ),
//                                   const Text(
//                                     "12",
//                                     style: TextStyle(fontSize: 10),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           );
//                         }),
//                   ),
//                 ),
//                 const Spacer(),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 20.0),
//                   child: MessageTextField(controller: textEditingController),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
