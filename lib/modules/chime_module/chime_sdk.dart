import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/modules/chime_module/chime_screen.dart';
import 'package:whereby_app/modules/chime_module/cubit.dart';
import 'package:whereby_app/modules/chime_module/state.dart';
import 'package:whereby_app/modules/home_module/home_cubit/home_cubit.dart';
import 'package:whereby_app/widgets/app_button.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  Duration duration = const Duration();
  Timer? timer;

  String _meetingId = '';
  String _attendeeId = '';
  List<dynamic> attendeeResponse = [];
  bool _isMeetingJoined = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    context.read<WaitingRoomCubit>().init();
    startTimer();
  }

  void startTimer() {
    final state = context.read<HomeCubit>().state;
    if (state.meetingTime == null) return;
    var countdownDuration = state.meetingTime;
    duration = countdownDuration;
    timer =
        Timer.periodic(const Duration(seconds: 1), (_) => updateCountdown());
  }

  void updateCountdown() {
    if (!mounted) return;
    setState(() {
      final seconds = duration.inSeconds - 1;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WaitingRoomCubit, WaitingRoomState>(
      listener: (context, state) {
        _handleRoomIdChange(context, state);
      },
      child: BlocBuilder<WaitingRoomCubit, WaitingRoomState>(
        builder: (context, state) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: const Color.fromARGB(31, 200, 199, 199),
              appBar: AppBar(
                backgroundColor: Colors.white,
                toolbarHeight: 60,
                leadingWidth: 80,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/png/logo_app_bar.png',
                  ),
                ),
                actions: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/svg/menu.svg',
                    ),
                    onPressed: () {},
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(2.0),
                  child: Container(
                    color: ColorConstants.borderLine,
                    height: 1.0,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Center(
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : _errorMessage.isNotEmpty
                          ? Text(
                              _errorMessage,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 18),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                const Text(
                                  'Next speaking session\nstarts in:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  formatDuration(duration),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                const SizedBox(height: 40),
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<WaitingRoomCubit>()
                                        .deleteUserFromRoom();
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                  ),
                                  child: const Text(
                                    'Back to main',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                              ],
                            ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void _handleRoomIdChange(BuildContext context, WaitingRoomState state) {
  if (state.meetingData != null &&
      state.attendeeData != null &&
      state.readyForCall) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ConnectionScreen(),
        ),
      );
    });
  }
}
