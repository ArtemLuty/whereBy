part of 'app_cubit.dart';

class AppState {
  final ThemeMode themeMode;

  const AppState({
    this.themeMode = ThemeMode.system,
  });

  AppState copyWith({
    ThemeMode? themeMode,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'themeMode': ThemeMode.values.indexOf(themeMode),
    };
  }

  factory AppState.fromJson(Map<String, dynamic> map) {
    return AppState(
      themeMode: map['themeMode'] != null
          ? ThemeMode.values[map['themeMode'] as int]
          : ThemeMode.system,
    );
  }
}
