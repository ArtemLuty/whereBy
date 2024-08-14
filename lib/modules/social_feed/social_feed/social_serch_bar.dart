// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/modules/home_module/home_cubit/home_cubit.dart';
// import 'package:opigno_app/modules/home_module/state.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/create_post_screen.dart';
// import 'package:opigno_app/widgets/rotating_progress_indicator.dart';

// class SocialSearchBar extends StatelessWidget {
//   const SocialSearchBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         if (state.isLoading) {
//           return const Center(
//               child: RotatingProgressIndicator(
//             color: ColorConstants.tapColor,
//             size: 40,
//           ));
//         }
//         final itemPicture = state.userData?.pictureSrc ?? "";
//         var modifiedUrl =
//             itemPicture.replaceFirst('mob', 'develop:\$wissC0nnectI@mob');
//         print('modifiedUrl-$modifiedUrl');
//         return Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: ColorConstants.containerColor,
//             ),
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 if (itemPicture.isNotEmpty)
//                   Center(
//                     child: CircleAvatar(
//                         radius: 18,
//                         backgroundColor: ColorConstants.containerColor,
//                         backgroundImage:
//                             CachedNetworkImageProvider(modifiedUrl)),
//                   ),
//                 if (itemPicture.isEmpty)
//                   const Center(
//                     child: CircleAvatar(
//                       radius: 18,
//                       backgroundColor: ColorConstants.containerColor,
//                       backgroundImage:
//                           AssetImage('assets/png/profile-smoll.png'),
//                     ),
//                   ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => MessageScreen(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30.0),
//                         color: Colors.white,
//                       ),
//                       padding: const EdgeInsets.all(12),
//                       height: 40,
//                       child: const Text(
//                         'Write a message',
//                         style: TextStyle(color: ColorConstants.dividerColor),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
