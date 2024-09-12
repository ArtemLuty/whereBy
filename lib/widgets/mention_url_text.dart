// import 'package:flutter/material.dart';
// import 'package:flutter_parsed_text/flutter_parsed_text.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:whereby_app/constants/colors.dart';

// class MentionAndUrlText extends StatelessWidget {
//   final String text;

//   MentionAndUrlText({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return ParsedText(
//       text: text,
//       style: Theme.of(context).textTheme.bodyMedium,
//       alignment: TextAlign.start,
//       // style: TextStyle(color: Colors.black),
//       parse: <MatchText>[
//         MatchText(
//           type: ParsedType.CUSTOM,
//           pattern: r'@(\w+)',
//           style: const TextStyle(color: ColorConstants.tapColor),
//           onTap: (url) {
//             print('Mention tapped: $url');
//           },
//         ),
//         MatchText(
//           type: ParsedType.URL,
//           pattern: r'(?:(https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
//           style: const TextStyle(
//               color: ColorConstants.buttonColor,
//               decoration: TextDecoration.underline),
//           onTap: (url) async {
//             print('URL tapped: $url');
//             String urlString = url.toString();
//             if (!urlString.startsWith('http://') &&
//                 !urlString.startsWith('https://')) {
//               urlString = 'https://$urlString';
//             }

//             if (await canLaunch(urlString)) {
//               await launch(urlString);
//             } else {
//               throw 'Could not launch $urlString';
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
