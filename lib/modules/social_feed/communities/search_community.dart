// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/utils/fonts.dart';

// class SearchCommunity extends StatelessWidget {
//   const SearchCommunity({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               'Search a community',
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
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: SizedBox(
//           height: 40,
//           child: TextField(
//             textAlignVertical: TextAlignVertical.bottom,
//             decoration: InputDecoration(
//               prefixIcon: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Padding(
//                       padding: const EdgeInsets.only(right: 12.0),
//                       child: SvgPicture.asset('assets/svg/search.svg')),
//                 ],
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.white),
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.white),
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//               filled: true,
//               fillColor: ColorConstants.containerColor,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(40.0),
//               ),
//               hintText: 'Search a community',
//             ),
//             onChanged: (text) {},
//           ),
//         ),
//       ),
//     );
//   }
// }
