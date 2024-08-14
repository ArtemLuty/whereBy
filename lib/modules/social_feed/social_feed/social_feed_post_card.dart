// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/post_cubit/post_cubit.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/post_cubit/post_state.dart';
// import 'package:opigno_app/utils/fonts.dart';
// import 'package:opigno_app/widgets/full_screen_image.dart';
// import 'package:opigno_app/widgets/mention_url_text.dart';
// import 'package:opigno_app/widgets/message_text_field.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:opigno_app/widgets/popup_widget.dart';
// import 'package:opigno_app/widgets/rotating_progress_indicator.dart';

// class SocialFeedPostCard extends StatefulWidget {
//   final index;
//   const SocialFeedPostCard({super.key, this.index});

//   @override
//   State<SocialFeedPostCard> createState() => _SocialFeedPostCardState();
// }

// class _SocialFeedPostCardState extends State<SocialFeedPostCard> {
//   bool isFullTextVisible = false;
//   final TextEditingController textEditingController = TextEditingController();
//   var likes = 0;
//   var commentCount = 0;
//   var lastPostId;
//   var postUserId;
//   var postAvtorName;
//   // int? commentId;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PostCubit, PostState>(
//       builder: (context, state) {
//         if (state.isLoading) {
//           return const Scaffold(
//             backgroundColor: Colors.white,
//             body: Center(
//                 child: RotatingProgressIndicator(
//               color: ColorConstants.tapColor,
//               size: 40,
//             )),
//           );
//         }
//         final itemText = state.postsData?.posts?.items![widget.index].text;
//         final postDate = state.postsData?.posts?.items![widget.index].created;
//         final itemName =
//             state.postsData?.posts?.items![widget.index].author?.firstName ??
//                 "";
//         postUserId =
//             state.postsData?.posts?.items?[widget.index].author?.id ?? 0;
//         // commentId =
//         //     state.commentData?.postComments?.items?[widget.index].id ?? 0;
//         postAvtorName =
//             "${state.postsData?.posts?.items![widget.index].author?.firstName} ${state.postsData?.posts?.items![widget.index].author?.lastName}";
//         final itemSername =
//             state.postsData?.posts?.items![widget.index].author?.lastName ?? "";
//         final itemPicture =
//             state.postsData?.posts?.items![widget.index].author?.picture?.src ??
//                 "";
//         final image = state.postsData!.posts!.items![widget.index].picture!
//                 .srcList!.isNotEmpty
//             ? state
//                 .postsData?.posts?.items![widget.index].picture!.srcList?.first
//             : "";
//         var imageChange = image!.isNotEmpty
//             ? image.replaceFirst('mob', 'develop:\$wissC0nnectI@mob')
//             : "";
//         final likesNumber =
//             state.postsData?.posts?.items![widget.index].likesNumber ?? 0;
//         final isLiked =
//             state.postsData?.posts?.items![widget.index].isLiked ?? false;
//         final postId = state.postsData?.posts?.items![widget.index].id ?? 0;
//         lastPostId = postId;
//         var modifiedUrl =
//             itemPicture.replaceFirst('mob', 'develop:\$wissC0nnectI@mob');
//         DateTime parsedDate = DateTime.parse(postDate!);
//         String formattedDate = DateFormat('dd.MM.yyyy').format(parsedDate);
//         commentCount = state
//                 .postsData!.posts!.items![widget.index].commentsNumber!
//                 .toInt() ??
//             0;
//         // commentCount = state.commentData!.postComments!.items!.length.toInt();
//         final srcList =
//             state.postsData?.posts?.items![widget.index].picture?.srcList;

//         final truncatedText = itemText!.length <= 255
//             ? itemText
//             : (isFullTextVisible
//                 ? itemText
//                 : itemText.substring(0, 255) + '...');
//         return Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: ColorConstants.containerColor,
//             ),
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     if (itemPicture.isNotEmpty)
//                       Center(
//                         child: CircleAvatar(
//                             radius: 14,
//                             backgroundColor: ColorConstants.containerColor,
//                             backgroundImage:
//                                 CachedNetworkImageProvider(modifiedUrl)),
//                       ),
//                     if (itemPicture.isEmpty)
//                       const Center(
//                         child: CircleAvatar(
//                           radius: 14,
//                           backgroundColor: ColorConstants.containerColor,
//                           backgroundImage:
//                               AssetImage('assets/png/profile-smoll.png'),
//                         ),
//                       ),
//                     const SizedBox(width: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '$itemName $itemSername',
//                           style: Theme.of(context).textTheme.labelLarge,
//                         ),
//                         Text(
//                           formattedDate,
//                           style: Theme.of(context).textTheme.bodySmall,
//                         )
//                       ],
//                     ),
//                     const Spacer(),
//                     InkWell(
//                         onTap: () {
//                           _showBottomSheet(context);
//                         },
//                         child: SizedBox(
//                           height: 25,
//                           child: SvgPicture.asset(
//                             'assets/svg/menu-dots.svg',
//                           ),
//                         )),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: MentionAndUrlText(
//                     text: truncatedText,
//                   ),
//                   // Text(
//                   //   truncatedText,
//                   //   style: Theme.of(context).textTheme.bodyMedium,
//                   //   textAlign: TextAlign.start,
//                   // ),
//                 ),
//                 if (itemText.toString().length > 255)
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         isFullTextVisible = !isFullTextVisible;
//                       });
//                     },
//                     child: Text(
//                       isFullTextVisible ? 'Read less' : 'Read more',
//                       style: const TextStyle(
//                           color: ColorConstants.buttonColor,
//                           fontFamily: FontFamily.montserrat,
//                           fontSize: 14),
//                     ),
//                   ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 if (srcList != null && srcList.isNotEmpty)
//                   SizedBox(
//                     height: (srcList.length > 1)
//                         ? (srcList.length > 2)
//                             ? 100
//                             : 150
//                         : 220,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: srcList.length,
//                       itemBuilder: (context, index) {
//                         final imageUrl = srcList[index];
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => FullScreenImageGallery(
//                                   imageUrls: srcList,
//                                   initialIndex: index,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Padding(
//                             padding:
//                                 EdgeInsets.all(srcList.length > 1 ? 2 : 0.0),
//                             child: Container(
//                               width: (srcList.length > 1)
//                                   ? (srcList.length > 2)
//                                       ? 100
//                                       : 150
//                                   : 348,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12.0),
//                                 image: DecorationImage(
//                                   image: CachedNetworkImageProvider(imageUrl
//                                       .toString()
//                                       .replaceFirst(
//                                           'mob', 'develop:\$wissC0nnectI@mob')),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 // Container(
//                 //   child: state.postsData?.posts?.items![widget.index]
//                 // ),
//                 Row(
//                   children: [
//                     if (likesNumber > 0)
//                       InkWell(
//                           onTap: () async {
//                             await context.read<PostCubit>().getLike(postId);
//                             _showLikersList(context);
//                           },
//                           child: SvgPicture.asset('assets/svg/thumbs-up.svg')),
//                     if (likesNumber > 0)
//                       InkWell(
//                         onTap: () async {
//                           await context.read<PostCubit>().getLike(postId);
//                           _showLikersList(context);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             '$likesNumber',
//                             style: Theme.of(context).textTheme.bodySmall,
//                           ),
//                         ),
//                       ),
//                     const Spacer(),
//                     if (commentCount > 0)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         child: Text(
//                           "${state.postsData?.posts?.items![widget.index].commentsNumber} Comments",
//                           style: Theme.of(context).textTheme.bodySmall,
//                         ),
//                       )
//                   ],
//                 ),
//                 if (likesNumber > 0 || commentCount > 0)
//                   const Divider(
//                     color: ColorConstants.dividerColor,
//                     thickness: 1,
//                   ),
//                 Row(
//                   children: [
//                     InkWell(
//                         onTap: () {
//                           setState(() {
//                             context.read<PostCubit>().setLikePost(postId);
//                           });
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           child: Container(
//                             child: isLiked
//                                 ? SvgPicture.asset(
//                                     'assets/svg/thumbs-up.svg',
//                                     width: 15,
//                                     height: 15,
//                                   )
//                                 : SvgPicture.asset(
//                                     'assets/svg/big-like.svg',
//                                   ),
//                           ),
//                         )),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           context.read<PostCubit>().setLikePost(postId);
//                         });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           'Like',
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                     InkWell(
//                       onTap: () {
//                         context.read<PostCubit>().getPost(postId);
//                         _showCommentSheet(
//                           context,
//                           // state.commentData?.postComments?.items![widget.index]
//                           //         .id ??
//                           //     0,
//                         );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child:
//                             SvgPicture.asset('assets/svg/comment-middle.svg'),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         context.read<PostCubit>().getPost(postId);
//                         _showCommentSheet(
//                           context,
//                           // state.commentData?.postComments?.items![widget.index]
//                           //         .id ??
//                           //     0,
//                         );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                         child: Text(
//                           "Comment",
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       },
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
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10.0),
//               topRight: Radius.circular(10.0),
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
//                   title: Text('Remove connection with $postAvtorName'),
//                   onTap: () async {
//                     // await context
//                     //     .read<PostCubit>()
//                     //     .removeConnection(postUserId);
//                     // Navigator.pop(context);
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return FileSavedPopup(
//                             text:
//                                 'Do you really want to remove your connection with $postAvtorName',
//                             onOkPressed: () {
//                               context
//                                   .read<PostCubit>()
//                                   .removeConnection(postUserId);
//                               Navigator.pop(context);
//                             },
//                             onCencelPressed: () {
//                               Navigator.pop(context);
//                             });
//                       },
//                     );
//                   },
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/eye-crossed.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text('Hide the post'),
//                   onTap: () async {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return FileSavedPopup(
//                             text: 'Do you really want to hide the post',
//                             onOkPressed: () {
//                               context.read<PostCubit>().hidePost(lastPostId);
//                               Navigator.pop(context);
//                             },
//                             onCencelPressed: () {
//                               Navigator.pop(context);
//                             });
//                       },
//                     );
//                   },
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/trash.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text('Delete the post'),
//                   onTap: () async {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return FileSavedPopup(
//                             text: 'Do you really want to delete the post',
//                             textContent: 'This action is not reversible',
//                             onOkPressed: () {
//                               context.read<PostCubit>().deletePost(lastPostId);
//                               Navigator.pop(context);
//                             },
//                             onCencelPressed: () {
//                               Navigator.pop(context);
//                             });
//                       },
//                     );
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

//   void _showCommentMenuSheet(BuildContext context, commentId) {
//     showModalBottomSheet(
//       elevation: 10,
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10.0),
//               topRight: Radius.circular(10.0),
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
//                   ),
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/trash.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text(
//                     'Delete comment',
//                     style: TextStyle(
//                         fontFamily: FontFamily.montserrat,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   onTap: () {
//                     // await context.read<PostCubit>().deletePost(commentId);
//                     // print("commentID$commentId");
//                     // await context.read<PostCubit>().getPost(lastPostId);
//                     // Navigator.pop(context);
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return FileSavedPopup(
//                             text: 'Do you really want to delete the post',
//                             textContent: 'This action is not reversible',
//                             onOkPressed: () async {
//                               await context
//                                   .read<PostCubit>()
//                                   .deletePost(commentId);
//                               await context
//                                   .read<PostCubit>()
//                                   .getPost(lastPostId);
//                               Navigator.pop(context);
//                             },
//                             onCencelPressed: () {
//                               Navigator.pop(context);
//                             });
//                       },
//                     );
//                   },
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/union-5.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: Text(
//                     'Remove connection with $postAvtorName',
//                     style: const TextStyle(
//                         fontFamily: FontFamily.montserrat,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   onTap: () async {
//                     // await context
//                     //     .read<PostCubit>()
//                     // .removeConnection(postUserId);
//                     // Navigator.pop(context);
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return FileSavedPopup(
//                             text:
//                                 'Do you really want to remove your connection with $postAvtorName',
//                             onOkPressed: () {
//                               context
//                                   .read<PostCubit>()
//                                   .removeConnection(postUserId);
//                               Navigator.pop(context);
//                             },
//                             onCencelPressed: () {
//                               Navigator.pop(context);
//                             });
//                       },
//                     );
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

//   void _showCommentSheet(BuildContext context) {
//     showModalBottomSheet(
//       elevation: 10,
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (BuildContext context) {
//         return BlocBuilder<PostCubit, PostState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Scaffold(
//                 backgroundColor: Colors.white,
//                 body: Center(
//                     child: RotatingProgressIndicator(
//                   color: ColorConstants.tapColor,
//                   size: 40,
//                 )),
//               );
//             }
//             // final commentText = state.commentData?.text ?? "";
//             // final createData = state.commentData?.author.created ?? "";
//             // final commentImage = state.commentData?.author.picture.src ?? "";
//             // var modifiedUrl =
//             //     commentImage.replaceFirst('d9', 'develop:\$wissC0nnectI@d9');

//             return Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white, // Background color of the bottom sheet
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10.0), // Adjust the radius as needed
//                   topRight:
//                       Radius.circular(10.0), // Adjust the radius as needed
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Stack(
//                   children: <Widget>[
//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(vertical: 15.0),
//                     //   child: Container(
//                     //     decoration: BoxDecoration(
//                     //         color: ColorConstants
//                     //             .mainGray, // Background color of the bottom sheet
//                     //         borderRadius: BorderRadius.circular(30)),
//                     //     height: 4.0,
//                     //     width: 45.0,
//                     //     // color: Colors.grey, // Grey line at the top
//                     //   ),
//                     // ),
//                     //
//                     // if (state.commentData?.text != null)
//                     Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 15.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: ColorConstants
//                                     .mainGray, // Background color of the bottom sheet
//                                 borderRadius: BorderRadius.circular(30)),
//                             height: 4.0,
//                             width: 45.0,
//                             // color: Colors.grey, // Grey line at the top
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: SizedBox(
//                             height: 270,
//                             child: ListView.builder(
//                                 scrollDirection: Axis.vertical,
//                                 itemCount: commentCount,
//                                 itemBuilder: (context, index) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           if (state
//                                               .commentData!
//                                               .postComments!
//                                               .items![index]
//                                               .author
//                                               .picture!
//                                               .src
//                                               .isNotEmpty)
//                                             Center(
//                                               child: CircleAvatar(
//                                                   radius: 14,
//                                                   backgroundColor:
//                                                       ColorConstants
//                                                           .containerColor,
//                                                   backgroundImage:
//                                                       CachedNetworkImageProvider(
//                                                           state
//                                                               .commentData!
//                                                               .postComments!
//                                                               .items![index]
//                                                               .author
//                                                               .picture!
//                                                               .src
//                                                               .replaceFirst(
//                                                                   'mob',
//                                                                   'develop:\$wissC0nnectI@mob'))),
//                                             ),
//                                           if (state
//                                               .commentData!
//                                               .postComments!
//                                               .items![index]
//                                               .author
//                                               .picture!
//                                               .src
//                                               .isEmpty)
//                                             const Center(
//                                               child: CircleAvatar(
//                                                 radius: 14,
//                                                 backgroundColor: ColorConstants
//                                                     .containerColor,
//                                                 backgroundImage: AssetImage(
//                                                     'assets/png/profile-smoll.png'),
//                                               ),
//                                             ),
//                                           const SizedBox(width: 10),
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "${state.commentData?.postComments?.items![index].author.firstName} ${state.commentData?.postComments?.items![index].author.lastName}",
//                                                 style: const TextStyle(
//                                                     fontWeight: FontWeight.w800,
//                                                     fontSize: 12),
//                                               ),
//                                               Text(
//                                                 DateFormat('dd.MM.yyyy')
//                                                     .format(DateTime.parse(
//                                                   state
//                                                           .commentData
//                                                           ?.postComments
//                                                           ?.items![index]
//                                                           .author
//                                                           .created ??
//                                                       "",
//                                                 )),
//                                                 style: const TextStyle(
//                                                     fontSize: 10),
//                                               )
//                                             ],
//                                           ),
//                                           const Spacer(),
//                                           InkWell(
//                                               onTap: () {
//                                                 _showCommentMenuSheet(
//                                                     context,
//                                                     state
//                                                             .commentData
//                                                             ?.postComments
//                                                             ?.items![index]
//                                                             .id ??
//                                                         0);
//                                               },
//                                               child: SvgPicture.asset(
//                                                   'assets/svg/menu-dots.svg')),
//                                         ],
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 8.0),
//                                         child: MentionAndUrlText(
//                                           text: state.commentData?.postComments
//                                                   ?.items![index].text ??
//                                               "",
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           InkWell(
//                                             onTap: () async {
//                                               await context
//                                                   .read<PostCubit>()
//                                                   .setLikeComment(
//                                                       lastPostId,
//                                                       state
//                                                           .commentData!
//                                                           .postComments!
//                                                           .items![index]
//                                                           .id);
//                                             },
//                                             child: Container(
//                                               child: state
//                                                       .commentData!
//                                                       .postComments!
//                                                       .items![index]
//                                                       .isLiked
//                                                   ? SvgPicture.asset(
//                                                       'assets/svg/thumbs-up.svg',
//                                                       width: 10,
//                                                       height: 10,
//                                                     )
//                                                   : SvgPicture.asset(
//                                                       'assets/svg/big-like.svg',
//                                                       height: 10,
//                                                     ),
//                                             ),
//                                           ),
//                                           InkWell(
//                                             onTap: () async {
//                                               await context
//                                                   .read<PostCubit>()
//                                                   .setLikeComment(
//                                                       lastPostId,
//                                                       state
//                                                           .commentData!
//                                                           .postComments!
//                                                           .items![index]
//                                                           .id);
//                                             },
//                                             child: const Padding(
//                                               padding: EdgeInsets.all(8.0),
//                                               child: Text(
//                                                 'Like',
//                                                 style: TextStyle(fontSize: 12),
//                                               ),
//                                             ),
//                                           ),
//                                           const Spacer(),
//                                           Padding(
//                                             padding: const EdgeInsets.all(4.0),
//                                             child: SvgPicture.asset(
//                                                 'assets/svg/thumbs-up.svg'),
//                                           ),
//                                           Text(
//                                             state.commentData!.postComments!
//                                                 .items![index].likesNumber
//                                                 .toString(),
//                                             style:
//                                                 const TextStyle(fontSize: 10),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   );
//                                 }),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         const Spacer(),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 20.0),
//                           child: MessageTextField(
//                             controller: textEditingController,
//                             onSendPressed: () async {
//                               await context.read<PostCubit>().commentPost(
//                                   textEditingController.text, lastPostId);
//                               print('Send button pressed!');
//                               textEditingController.text = "";
//                               // await context
//                               //     .read<PostCubit>()
//                               //     .updatePost(lastPostId);
//                               // setState(() {});
//                             },
//                           ),
//                         ),
//                         //  postID
//                         const SizedBox(
//                           height: 30,
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   void _showLikersList(BuildContext context) {
//     showModalBottomSheet(
//       elevation: 10,
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (BuildContext context) {
//         return BlocBuilder<PostCubit, PostState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Scaffold(
//                   backgroundColor: Colors.white,
//                   body: Center(child: CircularProgressIndicator()));
//             }
//             return Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10.0),
//                   topRight: Radius.circular(10.0),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Stack(
//                   children: <Widget>[
//                     Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 15.0),
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   color: ColorConstants.mainGray,
//                                   borderRadius: BorderRadius.circular(30)),
//                               height: 4.0,
//                               width: 45.0),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0),
//                           child: Row(
//                             children: [
//                               Text(
//                                   "${state.likesData!.items?.length} ${"persons liked"}"),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: SizedBox(
//                             height: 350,
//                             child: ListView.builder(
//                                 scrollDirection: Axis.vertical,
//                                 itemCount: state.likesData!.items?.length,
//                                 itemBuilder: (context, index) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 8.0),
//                                         child: Row(
//                                           children: [
//                                             if (state.likesData!.items![index]
//                                                 .user!.picture!.src!.isNotEmpty)
//                                               Center(
//                                                 child: CircleAvatar(
//                                                     radius: 20,
//                                                     backgroundColor:
//                                                         ColorConstants
//                                                             .containerColor,
//                                                     backgroundImage:
//                                                         CachedNetworkImageProvider(
//                                                             state
//                                                                 .likesData!
//                                                                 .items![index]
//                                                                 .user!
//                                                                 .picture!
//                                                                 .src!
//                                                                 .replaceFirst(
//                                                                     'mob',
//                                                                     'develop:\$wissC0nnectI@mob'))),
//                                               ),
//                                             if (state.likesData!.items![index]
//                                                 .user!.picture!.src!.isEmpty)
//                                               const Center(
//                                                 child: CircleAvatar(
//                                                   radius: 14,
//                                                   backgroundColor:
//                                                       ColorConstants
//                                                           .containerColor,
//                                                   backgroundImage: AssetImage(
//                                                       'assets/png/profile-smoll.png'),
//                                                 ),
//                                               ),
//                                             const SizedBox(width: 10),
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   "${state.likesData!.items![index].user!.firstName} ${state.likesData!.items![index].user!.lastName}",
//                                                   style: const TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w800,
//                                                       fontSize: 12),
//                                                 ),
//                                               ],
//                                             ),
//                                             const Spacer(),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
