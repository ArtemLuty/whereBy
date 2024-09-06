import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereby_app/app/app_cubit.dart';

class AppBloc {
  static late AppCubit appCubit;

  static void init() {
    appCubit = AppCubit();
  }

  static List<BlocProvider> get providers {
    return [BlocProvider<AppCubit>(create: (_) => appCubit)];
  }

  static Widget appBuilder(Widget Function(BuildContext) builder) {
    return MultiBlocProvider(
      providers: providers,
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) => builder(context),
      ),
    );
  }
}
