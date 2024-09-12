import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> with HydratedMixin {
  AppCubit() : super(const AppState());

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
