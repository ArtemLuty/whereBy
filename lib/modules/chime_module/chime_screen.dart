import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_aws_chime/models/join_info.model.dart';
import 'package:flutter_aws_chime/views/meeting.view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/modules/chime_module/card_widget.dart';
import 'package:whereby_app/modules/chime_module/cubit.dart';
import 'package:whereby_app/modules/chime_module/state.dart';
import 'package:whereby_app/modules/home_module/onboarding_screen.dart';
import 'package:whereby_app/utils/scalable_size.dart';
import 'package:flutter_aws_chime/models/meeting.model.dart';

class ConnectionScreen extends StatefulWidget {
  ConnectionScreen();

  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  bool _isMuted = true;
  late Timer _timer;
  int _seconds = 0;
  late int timeSpend;
  bool _isAudioDeviceSet = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _setDefaultAudioDevice() async {
    if (!_isAudioDeviceSet) {
      try {
        await MeetingModel().listAudioDevices();
        MeetingModel().initialAudioSelection();
        MeetingModel().updateCurrentDevice('Built-in Speaker');
        _toggleMute();
        _isAudioDeviceSet = true;
      } catch (e) {
        print('Error setting audio device: $e');
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // if (_seconds > 0) {
        _seconds++;
        // } else {
        // _timer.cancel();
        // _leaveMeeting(context);
        // }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      MeetingModel().toggleMute(unmute: _isMuted);
    });
  }

  void _leaveMeeting(BuildContext context) {
    context.read<WaitingRoomCubit>().deleteUserFromRoom();
    MeetingModel().stopMeeting();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WaitingRoomCubit, WaitingRoomState>(
        listener: (context, state) {
      _handleRoomIdChange(context, state);
    }, child: BlocBuilder<WaitingRoomCubit, WaitingRoomState>(
      builder: (context, state) {
        if (!_isAudioDeviceSet &&
            state.meetingData != null &&
            state.attendeeData != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _setDefaultAudioDevice();
          });
        }
        if (state.data == null) {
          return const Scaffold(
            body: Center(child: Text('No data available')),
          );
        }

        final createdAt =
            state.data!.rooms.isNotEmpty ? state.userRoom!.createdAt : 0;
        final currentTime = DateTime.now().millisecondsSinceEpoch;
        timeSpend = (currentTime - createdAt) ~/ 1000;
        _seconds = 0 + timeSpend;
        // bool isCurrentSpeaker =
        //     state.userRoom!.currentSpeakerId == state.logInUserId;
        final waitingRoom = state.userRoom!.users ?? {};
        final numberOfUsers = state.userRoom!.users.length ?? 0;
        // final roomId = state.data!.users[state.logInUserId]?.roomId;
        // final cardId = state.userRoom!.cardId;
        // bool isStartCard = state.cards?[0].type == 'start_cards';

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 50),
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                if (state.meetingData != null && state.attendeeData != null)
                  Column(
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: 1,
                        height: 1,
                        child: MeetingView(
                          JoinInfo(
                            MeetingInfo.fromJson(state.meetingData!),
                            AttendeeInfo.fromJson(state.attendeeData!),
                          ),
                        ),
                      ),
                    ],
                  ),
                Scaffold(
                  backgroundColor: Colors.white,
                  body: Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorConstants.borderColor),
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(165, 248, 248, 249),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Spacer(),
                              Spacer(),
                              if (numberOfUsers > 0)
                                ...List.generate(numberOfUsers, (index) {
                                  final userId =
                                      waitingRoom.keys.elementAt(index);
                                  final user = waitingRoom[userId];
                                  final userName = user?.name ?? '';
                                  final userAvatar = user?.avatar ?? '';
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: userAvatar.isNotEmpty
                                                ? Image.network(
                                                    'https://test.wetalk.co$userAvatar',
                                                    scale: 1.0,
                                                    height: 77,
                                                    width: 77,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/png/default_avatar.png',
                                                        height: 77,
                                                        width: 77,
                                                        fit: BoxFit.fill,
                                                      );
                                                    },
                                                  )
                                                : Image.asset(
                                                    'assets/png/default_avatar.png',
                                                    height: 77,
                                                    width: 77,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        softWrap: true,
                                        userName,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  );
                                }),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    child: IconButton(
                                      icon: !MeetingModel().getMuteStatus()
                                          ? Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Icon(
                                                Icons.mic,
                                                color: Color.fromARGB(
                                                    255, 207, 97, 97),
                                                size: 26.0,
                                              ),
                                            )
                                          : Image.asset(
                                              'assets/png/mic_off.png',
                                              height: 40,
                                            ),
                                      onPressed: () {
                                        _toggleMute();
                                      },
                                    ),
                                  ),
                                  IconButton(
                                      icon: Image.asset(
                                        'assets/png/exit.png',
                                        height: 40,
                                      ),
                                      onPressed: () {
                                        _leaveMeeting(context);
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    '${_formatTime(_seconds)}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        Container(
                            color: Colors.white,
                            width: context.getScalableWidth(355),
                            height: context.getScalableHeight(505),
                            child: const CardWidget()),
                        //   ],
                        // ),
                        // const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}

void _handleRoomIdChange(BuildContext context, WaitingRoomState state) {
  if (!state.readyForCall) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()));
    MeetingModel().stopMeeting();
    context.read<WaitingRoomCubit>().deleteUserFromRoom();
  }
}
