import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereby_app/modules/home_module/home_cubit/home_cubit.dart';
import 'package:whereby_app/modules/home_module/home_screen.dart';

//       routes: {
//         '/home': (context) => HomePage(),

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your onboarding content here

            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(80.0),
              child: SizedBox(
                width: 148,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<HomeCubit>().awaitingTime();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                    // Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          24), // Half of height for full rounding
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
    );
  }
}
