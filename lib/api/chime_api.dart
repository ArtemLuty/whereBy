import 'dart:convert';
import 'package:http/http.dart' as http;

void initializeChime() {
  // _chime = Chime(region: 'us-west-2');
}

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

    print('Meeting Response Status Code: ${meetingResponse.statusCode}');
    print('Meeting Response Body: ${meetingResponse.body}');

    if (meetingResponse.statusCode == 200) {
      if (meetingResponse.body.isEmpty) {
        print(
            'Successfully joined waiting room, but received an empty response body.');
      } else {
        final responseData = jsonDecode(meetingResponse.body);
        print('Response Data: $responseData');

        await joinMeetingRoom(userToken, cookie);
      }
    } else {
      print(
          'Failed to join waiting room: Status Code ${meetingResponse.statusCode}');
    }
  } catch (e) {
    print('Failed to join meeting: $e');
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
    print('Failed to join meeting room: $e');
    throw Exception('Failed to join meeting room: $e');
  }
}
