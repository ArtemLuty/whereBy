import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> with HydratedMixin {
  // Timer? _updateTimer;

  AppCubit() : super(const AppState());

  // void onStartApp() {
  // _updateData();
  // _updateTimer = Timer.periodic(
  //   const Duration(minutes: 1),
  //   (_) => _updateData(),
  // );
  // }

  // void onCloseApp() {
  //   // _updateTimer?.cancel();
  // }

  // void _updateData() {}

  // Future<void> authenticate() async {}

  // Future<void> changeLanguage(String language) async {
  //   await AppLocale.changeLanguage(language);
  // }

  // Future<void> logout() async {
  //   try {
  //     AppLocale.resetToSystemLanguage();
  //   } finally {
  //     emit(AppState(themeMode: state.themeMode));
  //   }
  // }

  // Future<void> fetchWeatherData() async {}

  void changeThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }

  @override
  Map<String, dynamic> toJson(AppState state) => state.toJson();

  @override
  AppState fromJson(Map<String, dynamic> json) {
    try {
      return AppState.fromJson(json);
    } catch (_) {}

    return const AppState();
  }
}
