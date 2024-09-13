import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

void initializeChime() {}

Future<void> joinAwaitingRoom(
  String userToken,
  String cookie,
) async {
  const String joinWaitingRoom =
      'https://test.wetalk.co/wp-json/users/joinWaitingRoom/';
  try {
    var meetingResponse = await http.post(
      Uri.parse(joinWaitingRoom),
      headers: {
        'Authorization': 'Bearer $userToken',
        'Cookie': cookie,
        'Content-Type': 'application/json',
      },
    );

    if (meetingResponse.statusCode == 200) {
      if (meetingResponse.body.isEmpty) {
        if (kDebugMode) {
          print(
              'Successfully joined waiting room, but received an empty response body.');
        }
      } else {
        final responseData = jsonDecode(meetingResponse.body);
        if (kDebugMode) {
          print('Response Data: $responseData');
        }

        await joinMeetingRoom(userToken, cookie);
      }
    } else {
      if (kDebugMode) {
        print(
            'Failed to join waiting room: Status Code ${meetingResponse.statusCode}');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Failed to join meeting: $e');
    }
  }
}

Future<Map<String, dynamic>> joinMeetingRoom(
  String userToken,
  String cookie,
) async {
  const String sessionConfiguration =
      'https://test.wetalk.co/wp-json/room/sessionConfiguration';
  try {
    var sessionResponse = await http.get(
      Uri.parse(sessionConfiguration),
      headers: {
        'Authorization': 'Bearer $userToken',
        'Cookie': '$cookie',
      },
    );

    final responseData = jsonDecode(sessionResponse.body);
    final meetingData = responseData['meeting']['Meeting'];
    final attendeeData = responseData['attendee']['Attendee'];

    return {
      'meeting': meetingData,
      'attendee': attendeeData,
    };
  } catch (e) {
    if (kDebugMode) {
      print('Failed to join meeting room: $e');
    }
    throw Exception('Failed to join meeting room: $e');
  }
}
