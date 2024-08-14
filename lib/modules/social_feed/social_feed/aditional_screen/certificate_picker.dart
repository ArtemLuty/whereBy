// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/modules/home_module/home_cubit/home_cubit.dart';
// import 'package:opigno_app/modules/home_module/state.dart';
// import 'package:opigno_app/utils/fonts.dart';
// import 'package:opigno_app/widgets/rotating_progress_indicator.dart';

// class CertificatePicker extends StatelessWidget {
//   const CertificatePicker({super.key});

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
//         return Scaffold(
//           appBar: AppBar(
//             title: const Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   'Select certeficate',
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
//                 itemCount: state.certificateIndex!.items?.length.toInt(),
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: InkWell(
//                       onTap: () {
//                         context.read<HomeCubit>().addCertificate(index);
//                         Navigator.of(context).pop();
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: const Color.fromARGB(255, 238, 238, 241),
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
//                                     child: (state
//                                                 .certificateIndex
//                                                 ?.items![index]
//                                                 .learningPath
//                                                 ?.image !=
//                                             null)
//                                         ? Container(
//                                             width: 40,
//                                             height: 40,
//                                             decoration: BoxDecoration(
//                                               image: DecorationImage(
//                                                   image: CachedNetworkImageProvider(
//                                                       state
//                                                           .certificateIndex!
//                                                           .items![index]
//                                                           .learningPath!
//                                                           .image!
//                                                           .src
//                                                           .toString()
//                                                           .replaceFirst('mob',
//                                                               'develop:\$wissC0nnectI@mob'))),
//                                             ))
//                                         : SvgPicture.asset(
//                                             'assets/svg/diploma.svg',
//                                             width: 40,
//                                           ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       state.certificateIndex!.items![index]
//                                           .learningPath!.label
//                                           .toString(),
//                                       style: const TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                         state.certificateIndex!.items![index]
//                                             .entityType
//                                             .toString(),
//                                         style: const TextStyle(
//                                           color: ColorConstants.buttonColor,
//                                           fontSize: 13,
//                                         )),
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
