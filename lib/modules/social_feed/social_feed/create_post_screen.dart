// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/modules/home_module/home_cubit/home_cubit.dart';
// import 'package:opigno_app/modules/home_module/state.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/aditional_screen/badge_picker.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/aditional_screen/certificate_picker.dart';
// import 'package:opigno_app/utils/fonts.dart';
// import 'package:opigno_app/widgets/app_button.dart';
// import 'package:opigno_app/widgets/message_text_field.dart';
// import 'package:opigno_app/widgets/rotating_progress_indicator.dart';

// class MessageScreen extends StatefulWidget {
//   const MessageScreen({super.key});

//   @override
//   State<MessageScreen> createState() => _MessageScreenState();
// }

// class _MessageScreenState extends State<MessageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final textEditingController = TextEditingController();

//     return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
//       if (state.isLoading) {
//         return const Center(
//             child: RotatingProgressIndicator(
//                 color: ColorConstants.tapColor, size: 40));
//       }
//       var newText = textEditingController.text;
//       final itemPicture = state.userData?.pictureSrc ?? "";
//       final userName = state.userData?.firstName ?? "";
//       final userSename = state.userData?.lastName ?? "";
//       var modifiedUrl = itemPicture.replaceFirst(
//         'mob',
//         'develop:\$wissC0nnectI@mob',
//       );
//       return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             title: const Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   'Create a post',
//                   style: TextStyle(
//                       color: ColorConstants.mainText,
//                       fontFamily: FontFamily.montserratBold,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16),
//                 ),
//               ],
//             ),
//             actions: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.add,
//                   color: ColorConstants.mainText,
//                 ),
//                 onPressed: () {
//                   _showBottomSheet(context);
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: SizedBox(
//                   width: 110,
//                   height: 35,
//                   child: AppButton(
//                     "Post",
//                     onTap: () {
//                       context
//                           .read<HomeCubit>()
//                           .createPost(textEditingController.text, 1);
//                     },
//                     color: textEditingController.text.isNotEmpty
//                         ? ColorConstants.buttonColor
//                         : ColorConstants.buttonDeclineColor,
//                     textColor: textEditingController.text.isNotEmpty
//                         ? ColorConstants.mainText
//                         : ColorConstants.mainGray,
//                   ),
//                 ),
//               ),
//             ],
//             elevation: 0,
//             backgroundColor: Colors.white,
//             leading: Padding(
//               padding: const EdgeInsets.only(left: 10.0),
//               child: IconButton(
//                   color: Colors.black,
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: SvgPicture.asset('assets/svg/angle-small-left.svg')),
//             ),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       if (itemPicture.isNotEmpty)
//                         Center(
//                           child: CircleAvatar(
//                               radius: 20,
//                               backgroundColor: ColorConstants.containerColor,
//                               backgroundImage: CachedNetworkImageProvider(
//                                 modifiedUrl,
//                               )),
//                         ),
//                       if (itemPicture.isEmpty)
//                         const Center(
//                           child: CircleAvatar(
//                             radius: 18,
//                             backgroundColor: ColorConstants.containerColor,
//                             backgroundImage:
//                                 AssetImage('assets/png/profile-smoll.png'),
//                           ),
//                         ),
//                       const SizedBox(width: 10),
//                       Text(
//                         '$userName $userSename',
//                         style: const TextStyle(
//                             color: ColorConstants.mainText,
//                             fontFamily: FontFamily.montserratBold,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 13),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     child: MessageTextField(
//                       controller: textEditingController,
//                       texts: textEditingController.text,
//                       onChanged: (newText) {
//                         print('Text changed: ${textEditingController.text}');
//                         setState(() {});
//                       },
//                     ),
//                   ),
//                   if (state.images != null)
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(left: 8.0, top: 10, bottom: 4),
//                       child: Row(
//                         children: [
//                           state.images.length != 0
//                               ? Text(
//                                   "${state.images.length ?? 0} /10 pictures",
//                                   style: const TextStyle(
//                                     color: ColorConstants.mainGray,
//                                     fontSize: 12,
//                                   ),
//                                 )
//                               : Container(),
//                         ],
//                       ),
//                     ),
//                   if (state.images != null && state.images != [])
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 18),
//                       child: SizedBox(
//                         height: (state.images.length > 1)
//                             ? (state.images.length > 2)
//                                 ? (state.images.length > 3)
//                                     ? 100
//                                     : 120
//                                 : 180
//                             : 220,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: state.images.length,
//                           itemBuilder: (context, index) {
//                             return GestureDetector(
//                               onTap: () {
//                                 // Show image preview or other actions
//                               },
//                               child: Stack(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(
//                                         state.images.length > 1 ? 2 : 1.0),
//                                     child: Container(
//                                       width: (state.images.length > 1)
//                                           ? (state.images.length > 2)
//                                               ? (state.images.length > 3)
//                                                   ? 100
//                                                   : 120
//                                               : 180
//                                           : 370,
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(12.0),
//                                         image: DecorationImage(
//                                           image: FileImage(
//                                             File(state.images[index].path),
//                                           ),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 8,
//                                     right: 8,
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         context
//                                             .read<HomeCubit>()
//                                             .removeImage(index);
//                                       },
//                                       child: Container(
//                                         decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: Colors.white,
//                                         ),
//                                         child: const Icon(Icons.close),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   if (state.files != null)
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: Row(
//                         children: [
//                           state.files.length != 0
//                               ? Text(
//                                   "${state.files.length ?? 0} /10 documents",
//                                   style: const TextStyle(
//                                     color: ColorConstants.mainGray,
//                                     fontSize: 12,
//                                   ),
//                                 )
//                               : Container(),
//                         ],
//                       ),
//                     ),
//                   if (state.files != null)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4),
//                       child: SizedBox(
//                         height: 90.0 * state.files.length,
//                         child: ListView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           itemCount: state.files.length,
//                           itemBuilder: (context, index) {
//                             return Stack(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12.0),
//                                       color: Colors.grey[200],
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           if (state.files[index].path
//                                                   .split('.')
//                                                   .last ==
//                                               'doc')
//                                             SvgPicture.asset(
//                                                 'assets/svg/003-doc.svg'),

//                                           if (state.files[index].path
//                                                   .split('.')
//                                                   .last ==
//                                               'pdf')
//                                             SvgPicture.asset(
//                                                 'assets/svg/004-pdf.svg'),
//                                           if (state.files[index].path
//                                                   .split('.')
//                                                   .last ==
//                                               'xls')
//                                             SvgPicture.asset(
//                                                 'assets/svg/002-xls.svg'),
//                                           if (state.files[index].path
//                                                   .split('.')
//                                                   .last ==
//                                               'txt')
//                                             SvgPicture.asset(
//                                                 'assets/svg/005-txt.svg'),
//                                           // ),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   '${state.files[index].path.split('/').last.split('.').first}',
//                                                   style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   '${state.files[index].path.split('.').last}',
//                                                   style: const TextStyle(
//                                                     color:
//                                                         ColorConstants.mainGray,
//                                                     fontSize: 16,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 12,
//                                   right: 12,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       context
//                                           .read<HomeCubit>()
//                                           .removeFile(index);
//                                     },
//                                     child: Container(
//                                       decoration: const BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.white,
//                                       ),
//                                       child: const Icon(Icons.close),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   if (state.certIndex != null)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4),
//                       child: SizedBox(
//                         height: 90.0 * state.certIndex!.toDouble(),
//                         child: ListView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           itemCount: 1,
//                           itemBuilder: (context, index) {
//                             return Stack(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12.0),
//                                       color: Colors.grey[200],
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(5.0),
//                                               child: (state
//                                                           .certificateIndex
//                                                           ?.items![int.parse(
//                                                               state.certIndex
//                                                                   .toString())]
//                                                           .learningPath
//                                                           ?.image !=
//                                                       null)
//                                                   ? Container(
//                                                       width: 40,
//                                                       height: 40,
//                                                       decoration: BoxDecoration(
//                                                         image: DecorationImage(
//                                                             image: CachedNetworkImageProvider(state
//                                                                 .certificateIndex!
//                                                                 .items![int
//                                                                     .parse(state
//                                                                         .certIndex
//                                                                         .toString())]
//                                                                 .learningPath!
//                                                                 .image!
//                                                                 .src
//                                                                 .toString()
//                                                                 .replaceFirst(
//                                                                     'mob',
//                                                                     'develop:\$wissC0nnectI@mob'))),
//                                                       ))
//                                                   : SvgPicture.asset(
//                                                       'assets/svg/badge-check.svg'),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   state
//                                                       .certificateIndex!
//                                                       .items![int.parse(state
//                                                           .certIndex
//                                                           .toString())]
//                                                       .learningPath!
//                                                       .label
//                                                       .toString(),
//                                                   style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                                 const Text(
//                                                   "earned on [date]",
//                                                   style: TextStyle(
//                                                     color: ColorConstants
//                                                         .borderColor,
//                                                     fontSize: 13,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   state
//                                                       .certificateIndex!
//                                                       .items![int.parse(state
//                                                           .certIndex
//                                                           .toString())]
//                                                       .entityType
//                                                       .toString(),
//                                                   style: const TextStyle(
//                                                     color: ColorConstants
//                                                         .buttonColor,
//                                                     fontSize: 13,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 12,
//                                   right: 12,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       context.read<HomeCubit>().addBadge(null);
//                                     },
//                                     child: Container(
//                                       decoration: const BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.white,
//                                       ),
//                                       child: const Icon(Icons.close),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   if (state.badgeIndex != null)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4),
//                       child: SizedBox(
//                         height: 90.0 * state.badgeIndex!.toDouble(),
//                         child: ListView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           itemCount: 1,
//                           itemBuilder: (context, index) {
//                             return Stack(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12.0),
//                                       color: Colors.grey[200],
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10)),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(5.0),
//                                               child: (state
//                                                           .badgeItem
//                                                           ?.items?[int.parse(
//                                                               state.badgeIndex
//                                                                   .toString())]
//                                                           .image !=
//                                                       null)
//                                                   ? Container(
//                                                       width: 40,
//                                                       height: 40,
//                                                       decoration: BoxDecoration(
//                                                         image: DecorationImage(
//                                                             image: CachedNetworkImageProvider(state
//                                                                 .badgeItem!
//                                                                 .items![int.parse(state
//                                                                     .badgeIndex
//                                                                     .toString())]
//                                                                 .image!
//                                                                 .src
//                                                                 .toString()
//                                                                 .replaceFirst(
//                                                                     'mob',
//                                                                     'develop:\$wissC0nnectI@mob'))),
//                                                       ))
//                                                   : SvgPicture.asset(
//                                                       'assets/svg/badge-check.svg'),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   state
//                                                       .badgeItem!
//                                                       .items![int.parse(state
//                                                           .badgeIndex
//                                                           .toString())]
//                                                       .name
//                                                       .toString(),
//                                                   style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                                 const Text(
//                                                   "earned on [date]",
//                                                   style: TextStyle(
//                                                     color: ColorConstants
//                                                         .borderColor,
//                                                     fontSize: 13,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   state
//                                                       .badgeItem!
//                                                       .items![int.parse(state
//                                                           .badgeIndex
//                                                           .toString())]
//                                                       .entityType
//                                                       .toString(),
//                                                   style: const TextStyle(
//                                                     color: ColorConstants
//                                                         .buttonColor,
//                                                     fontSize: 13,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 12,
//                                   right: 12,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       context.read<HomeCubit>().addBadge(null);
//                                     },
//                                     child: Container(
//                                       decoration: const BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.white,
//                                       ),
//                                       child: const Icon(Icons.close),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ));
//     });
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
//                     'assets/svg/picture_bur.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text('Picture'),
//                   onTap: () {
//                     context.read<HomeCubit>().pickImages();
//                   },
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/files.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text('Document'),
//                   onTap: () {
//                     context.read<HomeCubit>().pickFiles();
//                   },
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/book-alt.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text('Training'),
//                   onTap: () {
//                     // Add your action for Option 2 here
//                   },
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/diploma.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text('Certificate'),
//                   onTap: () async {
//                     await context.read<HomeCubit>().getCertificate();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const CertificatePicker(),
//                       ),
//                     );
//                     // Add your action for Option 3 here
//                   },
//                 ),
//                 ListTile(
//                   leading: SvgPicture.asset(
//                     'assets/svg/badge.svg',
//                     width: 20,
//                     height: 20,
//                   ),
//                   title: const Text('Badge'),
//                   onTap: () async {
//                     await context.read<HomeCubit>().getBadge();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const BadgePicker(),
//                       ),
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
// }
