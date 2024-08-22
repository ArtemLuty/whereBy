// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:flutter_aws_chime/flutter_aws_chime_method_channel.dart';
// // import 'package:flutter_aws_chime/flutter_aws_chime_web.dart';
// import 'package:flutter_aws_chime/models/join_info.model.dart';
// import 'package:flutter_aws_chime/views/meeting.view.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:whereby_app/modules/chime_module/cubit.dart';
// import 'package:whereby_app/modules/chime_module/state.dart';
// // import 'package:flutter_aws_chime/flutter_aws_chime.dart';

// class MeetingViews extends StatefulWidget {
//   final JoinInfo joinInfo;

//   MeetingViews(this.joinInfo);

//   @override
//   _MeetingViewState createState() => _MeetingViewState();
// }

// class _MeetingViewState extends State<MeetingViews> {
//   // late FlutterAwsChime _awsChimePlatform;
//   // late ChimeService _chimeService;
//   // bool _isJoined = false;
//   @override
//   void initState() {
//     super.initState();

//     // _chimeService = ChimeService(
//     //   region: widget.joinInfo.meetingInfo.mediaRegion,
//     // );
//     // _joinMeeting();
//   }

//   // Future<void> _joinMeeting() async {
//   //   try {
//   //     await _chimeService.initialize();
//   //     await _chimeService.joinMeeting(
//   //       meetingId: widget.joinInfo.meetingInfo.meetingId,
//   //       attendeeId: widget.joinInfo.attendeeInfo.attendeeId,
//   //       joinToken: widget.joinInfo.attendeeInfo.joinToken,
//   //     );
//   //     setState(() {
//   //       _isJoined = true;
//   //     });
//   //   } catch (e) {
//   //     print('Failed to join meeting: $e');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SafeArea(
//         child: BlocBuilder<WaitingRoomCubit, WaitingRoomState>(
//           builder: (context, state) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text('Meeting View'),
//               ),
//               body: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   // width: 300,
//                   child: MeetingView(
//                     JoinInfo(
//                       MeetingInfo.fromJson(state.meetingData!),
//                       AttendeeInfo.fromJson(state.attendeeData!),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
