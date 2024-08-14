import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/data_servise/data_model/card.dart';
import 'package:whereby_app/modules/chime_module/card_widget.dart';
import 'package:whereby_app/modules/chime_module/cubit.dart';
import 'package:whereby_app/modules/chime_module/state.dart';
import 'package:whereby_app/modules/home_module/home_screen.dart';
import 'package:whereby_app/utils/fonts.dart';
import 'package:whereby_app/widgets/app_button.dart';

class ConnectionScreen extends StatefulWidget {
  final String meetingId;
  final String attendeeId;
  final List<dynamic> attendees;
  final List<UserCard> cards;

  ConnectionScreen({
    required this.meetingId,
    required this.attendeeId,
    required this.attendees,
    required this.cards,
  });

  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  bool _isMuted = false;
  late Timer _timer;
  int _seconds = 900;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer.cancel();
          Navigator.of(context).pop();
        }
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
    });
  }

  void _leaveMeeting(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaitingRoomCubit, WaitingRoomState>(
      builder: (context, state) {
        if (state.data == null) {
          return const Scaffold(
            body: Center(child: Text('No data available')),
          );
        }
        bool isCurrentSpeaker =
            state.data!.rooms.first.currentSpeakerId == state.logInUserId;
        final waitingRoom = state.data!.rooms.first.users ?? {};
        final numberOfUsers = state.data!.rooms.first.users.length ?? 0;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.borderColor),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(165, 248, 248, 249),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (numberOfUsers > 0)
                        ...List.generate(numberOfUsers, (index) {
                          final userId = waitingRoom.keys.elementAt(index);
                          final user = waitingRoom[userId];
                          final userName = user?.name ?? '';
                          final userAvatar = user?.avatar ?? '';

                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: userAvatar.isNotEmpty
                                      ? Image.network(
                                          'https://test.wtalk.space$userAvatar',
                                          scale: 1.0,
                                          height: 77,
                                          width: 77,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
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
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                userName,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: FontFamily.poppins),
                              ),
                            ],
                          );
                        }),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: _isMuted
                                ? Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.mic,
                                      color: Color.fromARGB(255, 207, 97, 97),
                                      size: 26.0,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/png/mic_off.png',
                                    height: 40,
                                  ),
                            onPressed: _toggleMute,
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
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          child: Text(
                            '${_formatTime(_seconds)}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        color: Colors.amber,
                        width: 350,
                        height: 400,
                        child: const CardWidget()),
                  ],
                ),
                const Spacer(),
                if (isCurrentSpeaker)
                  AppButton('Next',
                      onTap: () {},
                      color: ColorConstants.primaryBlue,
                      textColor: Colors.white,
                      height: 48,
                      width: 500,
                      circular: 4),
              ],
            ),
          ),
        );
      },
    );
  }
}
