import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/modules/chime_module/cubit.dart';
import 'package:whereby_app/modules/home_module/home_cubit/home_cubit.dart';
import 'package:whereby_app/modules/home_module/home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 234, 252),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: SvgPicture.asset(
                    'assets/svg/onbord!_image.svg',
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(80.0),
                child: SizedBox(
                  width: 148,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      PermissionStatus status =
                          await Permission.microphone.status;

                      if (status.isDenied || status.isRestricted) {
                        status = await Permission.microphone.request();
                        context.read<HomeCubit>().awaitingTime();
                        context.read<WaitingRoomCubit>().init();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }

                      if (status.isGranted) {
                        context.read<HomeCubit>().awaitingTime();
                        context.read<WaitingRoomCubit>().workCondition();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      } else if (status.isPermanentlyDenied) {
                        // Handle the case where the permission is permanently denied
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: const Text(
                        //         'Microphone permission is permanently denied. Please enable it from settings.'),
                        //     action: SnackBarAction(
                        //       label: 'Settings',
                        //       onPressed: () async {
                        //         // Open app settings
                        //         await openAppSettings();
                        //       },
                        //     ),
                        //   ),
                        // );
                      } else {
                        // Handle other cases like denied but not permanently denied
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Microphone permission is required to proceed.'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
