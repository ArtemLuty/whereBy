// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/modules/home_module/home_cubit/home_cubit.dart';
// import 'package:opigno_app/modules/home_module/state.dart';
// import 'package:opigno_app/utils/fonts.dart';

// class BadgePicker extends StatelessWidget {
//   const BadgePicker({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         if (state.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         return Scaffold(
//           appBar: AppBar(
//             title: const Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   'Select badge',
//                   style: TextStyle(
//                       color: ColorConstants.mainText,
//                       fontFamily: FontFamily.montserratBold,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16),
//                 ),
//               ],
//             ),
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
//           body: SizedBox(
//             child: ListView.builder(
//                 itemCount: state.badgeItem!.items?.length.toInt(),
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: InkWell(
//                       onTap: () {
//                         context.read<HomeCubit>().addBadge(index);
//                         Navigator.of(context).pop();
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: ColorConstants.buttonDeclineColor,
//                         ),
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child:
//                                         (state.badgeItem?.items?[index].image !=
//                                                 null)
//                                             ? Container(
//                                                 width: 40,
//                                                 height: 40,
//                                                 decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                       image: CachedNetworkImageProvider(
//                                                           state
//                                                               .badgeItem!
//                                                               .items![index]
//                                                               .image!
//                                                               .src
//                                                               .toString()
//                                                               .replaceFirst(
//                                                                   'mob',
//                                                                   'develop:\$wissC0nnectI@mob'))),
//                                                 ))
//                                             : SvgPicture.asset(
//                                                 'assets/svg/badge-check.svg'),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       state.badgeItem!.items![index].name
//                                           .toString(),
//                                       style: const TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       state.badgeItem!.items![index].entityType
//                                           .toString(),
//                                       style: const TextStyle(
//                                         color: ColorConstants.buttonColor,
//                                         fontSize: 13,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const Spacer(),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           ),
//         );
//       },
//     );
//   }
// }
