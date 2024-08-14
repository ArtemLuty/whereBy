import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final String basicAuth =
      'Basic ${base64Encode(utf8.encode('api:UQP0rBvY2IzQOzXqahcn19kz'))}';

  Future<Duration> joinMeetingTime() async {
    final timeResponse = await http.get(
      Uri.parse(
          'https://test.wtalk.space/wp-json/matching/scheduler/executionData'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': basicAuth,
      },
    );

    final responseData = jsonDecode(timeResponse.body);
    final int remainingTimeInSeconds = responseData['remainingTime'];
    final Duration remainingDuration =
        Duration(milliseconds: remainingTimeInSeconds);

    if (kDebugMode) {
      final minutes = remainingDuration.inMinutes.remainder(60);
      final seconds = remainingDuration.inSeconds.remainder(60);
      print('Remaining Time: ${minutes}m ${seconds}s');
    }

    return remainingDuration;
  }
}
