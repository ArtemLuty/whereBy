import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereby_app/modules/chime_module/chime_sdk.dart';
import 'package:whereby_app/modules/home_module/home_cubit/home_cubit.dart';
import 'package:whereby_app/modules/home_module/home_state.dart';

class HomeScreen extends StatelessWidget {
  static const path = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return const Scaffold(
          body: MeetingScreen(),
        );
      },
    );
  }
}
