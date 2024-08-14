import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> joinAwaitingRoom(
  String login,
  String password,
  String userToken,
  String cookie,
) async {
  const String joinWaitingRoom =
      'https://test.wtalk.space/wp-json/users/joinWaitingRoom/';
  try {
    var meetingResponse = await http.post(
      Uri.parse(joinWaitingRoom),
      headers: {
        'Authorization': 'Bearer $userToken',
        'Cookie': cookie,
        'Content-Type': 'application/json',
      },
    );

    print('Meeting Response Status Code: ${userToken}');
    print('Meeting Response Body: ${meetingResponse.body}');

    if (meetingResponse.statusCode == 200) {
      if (meetingResponse.body.isEmpty) {
        print(
            'Successfully joined waiting room, but received an empty response body.');
      } else {
        final responseData = jsonDecode(meetingResponse.body);
        print('Response Data: $responseData');
      }
    } else {
      print(
          'Failed to join waiting room: Status Code ${meetingResponse.statusCode}');
    }
  } catch (e) {
    print('Failed to join meeting: $e');
  }
}

Future<void> joinMeetingRoom(
  String userToken,
  String cookie,
) async {
  // const String runMatchmaking =
  //     'https://wetalk-2-test-y5rsn.ondigitalocean.app/admin/runMatchmaking/';
  const String sessionConfiguration =
      'https://test.wtalk.space/wp-json/room/sessionConfiguration';

  try {
    var sessionResponse = await http.get(
      Uri.parse(sessionConfiguration),
      headers: {
        // 'Authorization': 'Bearer $userToken',
        'Cookie': '$cookie',
      },
    );
    // Debugging output
    print('Meeting Response Status Code: ${cookie}');
    print('Meeting Response Body: ${sessionResponse.body}');

    if (sessionResponse.statusCode == 200) {
      if (sessionResponse.body.isEmpty) {
        print(
            'Successfully sessionResponse, but received an empty response body.');
      } else {
        final responseData = jsonDecode(sessionResponse.body);
        print('Response Data: $responseData');
      }
    } else {
      // onError('Unexpected status code: ${sessionResponse.statusCode}');
    }

    // Step 3: Meeting Room request
    // var meetingRoomCreds = await http.get(
    //   Uri.parse(runMatchmaking),
//     headers: {
//   'Authorization': 'Bearer $userToken',
//   'Content-Type': 'application/json',
// },
    //   // body: {
    //   //   'login': login,
    //   //   'password': password,
    //   // },
    // );
    // print('meetingRoomCreds: ${meetingRoomCreds.statusCode}');
    // print('meetingRoomCreds Body: ${meetingRoomCreds.body}');
    // print('meetingRoomCreds Headers: ${meetingRoomCreds.headers}');

    // if (meetingRoomCreds.statusCode == 200) {
    //   onSuccess('e87bb490-662c-4c5f-b9ef-e7c2eb543049',
    //       'cf322bad-21a7-c063-185a-92477fec0629');
    // } else {
    //   onError(
    //       'Failed to join meeting: ${meetingRoomCreds.statusCode} ${meetingRoomCreds.body}');
    // }
  } catch (e) {
    // onError('Failed to join meeting: $e');
    print('Failed to join meeting: $e');
  }
}
