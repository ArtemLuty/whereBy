// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/post_cubit/post_cubit.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/post_cubit/post_state.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/social_feed_post_card.dart';
// import 'package:opigno_app/utils/fonts.dart';
// import 'package:opigno_app/widgets/rotating_progress_indicator.dart';

// class SocialFeedPost extends StatelessWidget {
//   // ignore: use_key_in_widget_constructors
//   const SocialFeedPost({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PostCubit, PostState>(
//       builder: (context, state) {
//         if (state.isLoading) {
//           return const Center(
//               child: RotatingProgressIndicator(
//             color: ColorConstants.tapColor,
//             size: 40,
//           ));
//         }
//         final int itemCount = state.postsData?.posts?.items?.length ?? 0;
//         final itemCounts = itemCount - 1;
//         return itemCount == 0
//             ? Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     color: ColorConstants.containerColor,
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [],
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.only(bottom: 12.0),
//                         child: Text(
//                           "You don't have social activity yet.",
//                           style: TextStyle(
//                               fontFamily: FontFamily.montserrat,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 14),
//                         ),
//                       ),
//                       const Text(
//                         "Write your first post",
//                         style: TextStyle(
//                             fontFamily: FontFamily.montserrat,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14),
//                       ),
//                       const Text(
//                         "or",
//                         style: TextStyle(
//                             fontFamily: FontFamily.montserrat,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           // context.read<PostCubit>().getPost(postId);
//                           // _showCommentSheet(context);
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.all(0.0),
//                           child: Text("Find connections",
//                               style: TextStyle(
//                                   color: ColorConstants.buttonColor,
//                                   fontFamily: FontFamily.montserrat,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14),
//                               textAlign: TextAlign.center),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             : Expanded(
//                 child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   itemCount: itemCount,
//                   itemBuilder: (context, index) {
//                     return SocialFeedPostCard(index: index);
//                   },
//                 ),
//               );
//       },
//     );
//   }
// }
