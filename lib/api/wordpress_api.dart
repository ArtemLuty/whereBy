// import 'package:whereby_app/data_servise/data_model/card.dart';
// import 'package:whereby_app/data_servise/data_model/content.dart';
// import 'package:wordpress_api/wordpress_api.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void connectWpAPI() async {
//   final api = WordPressAPI('https://wetalk.co');

//   final headers = {
//     'Authorization':
//         'Basic ${base64Encode(utf8.encode('api:UQP0rBvY2IzQOzXqahcn19kz'))}',
//   };

//   // Fetch cards
//   final cardsResponse = await http.get(
//     Uri.parse('https://wetalk.co/wp-json/wetalk/v1/cards'),
//     headers: headers,
//   );
//   final List<dynamic> jsonList = jsonDecode(cardsResponse.body);
//   final List<UserCard> cards =
//       jsonList.map((json) => UserCard.fromJson(json)).toList();

//   if (cardsResponse.statusCode == 200) {
//     // Print parsed data
//     for (var card in cards) {
//       print('ID: ${card.id}');
//       print('Level: ${card.level}');
//       print('Name: ${card.name}');
//       print('Type: ${card.type}');
//       print('Content: ${card.content}');
//       print('Content:');
//       print('  Text: ${card.content.text}');
//       print('  Image 1: ${card.content.image1}');
//       print('  Image 2: ${card.content.image2}');
//       print('  Voiceover: ${card.content.voiceover}');
//       print('  Description: ${card.content.description}');
//       print('  Image: ${card.content.image}');
//       print('  Phrase: ${card.content.phrase}');
//       print('  Example: ${card.content.example}');
//       print('  Question: ${card.content.question}');
//       print('  Explanation: ${card.content.explanation}');
//       print('  Task: ${card.content.task}');
//       print('  Theme: ${card.content.theme}');
//       print('  Sentences: ${card.content.sentences?.join(', ')}');
//       print('  Words: ${card.content.words?.join(', ')}');
//       print('---');
//     }
//   } else {
//     print(
//         'Failed to load cards: ${cardsResponse.statusCode}, ${cardsResponse.reasonPhrase}');
//   }

//   // Fetch users
//   final usersResponse = await http.get(
//     Uri.parse('https://wetalk.co/wp-json/get/users?ids=13083'),
//     headers: headers,
//   );
//   if (usersResponse.statusCode == 200) {
//     print('Users: ${usersResponse.body}');
//   } else {
//     print('Failed to load users: ${usersResponse.reasonPhrase}');
//   }
// }
