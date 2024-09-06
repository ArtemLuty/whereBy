import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/modules/chime_module/chime_sdk.dart';
import 'package:whereby_app/modules/home_module/onboarding_screen.dart';
import 'package:whereby_app/modules/message_module/message_screen.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBar(
        elevation: 12,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: ColorConstants.tapColor,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/svg/profil-1.svg',
              color: ColorConstants.tapTextColor,
              height: 24,
            ),
            icon: SvgPicture.asset(
              'assets/svg/profil-1.svg',
              color: ColorConstants.tapTextColor,
              height: 24,
            ),
            label: 'PROFILE',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/svg/social.svg',
              color: ColorConstants.tapTextColor,
              height: 24,
            ),
            icon: SvgPicture.asset(
              'assets/svg/social.svg',
              color: ColorConstants.tapTextColor,
              height: 24,
            ),
            label: 'SOCIAL',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/svg/catalogeu.svg',
              color: ColorConstants.tapTextColor,
              height: 24,
            ),
            icon: SvgPicture.asset(
              'assets/svg/catalogeu.svg',
              color: ColorConstants.tapTextColor,
              height: 24,
            ),
            label: 'CATALOGUE',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/svg/message.svg',
              color: ColorConstants.tapTextColor,
              height: 24,
            ),
            icon: SvgPicture.asset(
              'assets/svg/message.svg',
              color: ColorConstants.tapTextColor,
              height: 24,
            ),
            label: 'MESSAGE',
          ),
        ],
      ),
      body: <Widget>[
        const OnboardingScreen(),
        const MeetingScreen(),
        PageThree(),
        const ChatPage()
      ][currentPageIndex],
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Page'),
    );
  }
}

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Catalogue Page'),
    );
  }
}

class PageFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Message Page'),
    );
  }
}
