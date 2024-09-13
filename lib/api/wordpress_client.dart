import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:whereby_app/data_servise/data_model/card.dart';

final String basicAuth =
    'Basic ${base64Encode(utf8.encode('api:UQP0rBvY2IzQOzXqahcn19kz'))}';

final headers = {
  'Authorization': basicAuth,
};

Future<List<UserCard>> fetchCards(cardId) async {
  final String basicAuth =
      'Basic ${base64Encode(utf8.encode('api:UQP0rBvY2IzQOzXqahcn19kz'))}';
  final headers = {'Authorization': basicAuth};

  final response = await http.get(
    Uri.parse('https://test.wetalk.co/wp-json/wetalk/v1/cards?ids=$cardId'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    if (kDebugMode) {
      print("Card is load200${response.body}");
    }
    return jsonResponse.map((cardJson) => UserCard.fromJson(cardJson)).toList();
  } else {
    throw Exception(
        'Failed to load cards: ${response.statusCode}, ${response.reasonPhrase}');
  }
}

Future<void> nextCards(
    String roomId, String cardId, String userToken, String cookie) async {
  Map<String, String> body = {
    'roomId': roomId,
    'cardId': cardId,
  };

  // Prepare the headers
  Map<String, String> headers = {
    'Authorization': 'Bearer $userToken',
    'Cookie': cookie,
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.post(
      Uri.parse('https://test.wetalk.co/wp-json/room/markCardAsDone'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('nextCards---- 200: ${response.body}');
      }
    } else {
      if (kDebugMode) {
        print(
            'Failed to load nextCards: ${response.statusCode}, ${response.reasonPhrase}');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error occurred: $e');
    }
  }
}

Future<void> deleteUserRoom(String userToken, String cookie) async {
  Map<String, String> headers = {
    'Authorization': 'Bearer $userToken',
    'Cookie': cookie,
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.post(
      Uri.parse('https://test.wetalk.co/wp-json/users/leaveRoom'),
      headers: headers,
    );
  } catch (e) {
    if (kDebugMode) {
      print('Error occurred: $e');
    }
  }
}
