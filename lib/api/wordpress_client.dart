import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:whereby_app/data_servise/data_model/card.dart';
import 'package:whereby_app/data_servise/repository/secure_storage.dart';

// final SecureStorageManager secureManager;

final String basicAuth =
    'Basic ${base64Encode(utf8.encode('api:UQP0rBvY2IzQOzXqahcn19kz'))}';

// Define headers
final headers = {
  'Authorization': basicAuth,
};

Future<List<UserCard>> fetchCards(cardId) async {
  final String basicAuth =
      'Basic ${base64Encode(utf8.encode('api:UQP0rBvY2IzQOzXqahcn19kz'))}';
  final headers = {'Authorization': basicAuth};

  final response = await http.get(
    Uri.parse('https://wetalk.co/wp-json/wetalk/v1/cards?ids=$cardId'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    print("${response.body}");
    return jsonResponse.map((cardJson) => UserCard.fromJson(cardJson)).toList();
  } else {
    throw Exception(
        'Failed to load cards: ${response.statusCode}, ${response.reasonPhrase}');
  }
}

Future<void> fetchUsers() async {
  // final userId = secureManager.getUserId();
  final response = await http.get(
    Uri.parse('https://test.wtalk.space/wp-json/get/users?id=13083'),
    headers: headers,
  );
  if (response.statusCode == 200) {
    print('UsersWP: ${response.body}');
  } else {
    print(
        'Failed to load usersWP: ${response.statusCode}, ${response.reasonPhrase}');
  }
}

void connectWpClients() async {
  // Base64 encoding for Basic Authentication
  final String basicAuth =
      'Basic ${base64Encode(utf8.encode('api:UQP0rBvY2IzQOzXqahcn19kz'))}';

  // Define headers
  final headers = {
    'Authorization': basicAuth,
  };

  // Function to fetch cards
  // Future<void> fetchCards() async {
  //   final response = await http.get(
  //     Uri.parse('https://wetalk.co/wp-json/wetalk/v1/cards'),
  //     headers: headers,
  //   );
  //   if (response.statusCode == 200) {
  //     print('Cards: ${response.body}');
  //   } else {
  //     print(
  //         'Failed to load cards: ${response.statusCode}, ${response.reasonPhrase}');
  //   }
  // }

  // Function to fetch users
  // Future<void> fetchUsers() async {
  //   // final userId = secureManager.getUserId();
  //   final response = await http.get(
  //     Uri.parse('https://test.wtalk.space/wp-json/get/users?id=13083'),
  //     headers: headers,
  //   );
  //   if (response.statusCode == 200) {
  //     print('UsersWP: ${response.body}');
  //   } else {
  //     print(
  //         'Failed to load usersWP: ${response.statusCode}, ${response.reasonPhrase}');
  //   }
  // }

  // await fetchCards();
  await fetchUsers();
}
