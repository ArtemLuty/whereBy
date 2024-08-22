import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:whereby_app/api/auth_api.dart';
import 'package:whereby_app/app/app_cubit.dart';
import 'package:whereby_app/core/app_locale.dart';
import 'package:whereby_app/core/app_theme.dart';
import 'package:whereby_app/data_servise/repository/secure_storage.dart';
import 'package:whereby_app/data_servise/repository/user_repository.dart';
import 'package:whereby_app/modules/auth_module/auth_cubit.dart';
import 'package:whereby_app/modules/auth_module/screen.dart';
import 'package:whereby_app/modules/chime_module/chime_sdk.dart';
import 'package:whereby_app/modules/chime_module/cubit.dart';
import 'package:whereby_app/modules/home_module/home_cubit/home_cubit.dart';
import 'package:whereby_app/modules/home_module/onboarding_screen.dart';
import 'package:whereby_app/setup.dart';
import 'package:whereby_app/utils/theme_manager.dart';
import 'package:whereby_app/widgets/splash_screen.dart';
import 'package:whereby_app/widgets/system_theme_update_listener.dart';

import 'core/app_router.dart';

class App extends StatelessWidget {
  static BuildContext? context;
  static final navigatorKey = GlobalKey<NavigatorState>();

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return SetupApp(
      builder: (context) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider<SecureStorageManager>(
              create: (context) =>
                  SecureStorageManagerImpl(const FlutterSecureStorage()),
            ),
          ],
          child: SystemThemeUpdateListener(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (BuildContext context) => AuthCubit(
                    SecureStorageManager.of(context),
                    AuthRepository(SecureStorageManager.of(context)),
                  ),
                ),
                BlocProvider(
                  create: (context) => WaitingRoomCubit(
                    AuthRepository(SecureStorageManager.of(context)),
                    FirebaseDatabase.instance.ref(),
                  ),
                  child: const MeetingScreen(),
                ),
                BlocProvider(
                    create: (context) => HomeCubit(
                          UserRepository(),
                        )),
              ],
              child: MaterialApp(
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child!,
                  );
                },
                home: const _StartScreen(),
                locale: context.locale,
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                supportedLocales: context.supportedLocales,
                onGenerateRoute: AppRouter.onGenerateRoute,
                localizationsDelegates: AppLocale.localizationsDelegates,
                themeMode: context.watch<AppCubit>().state.themeMode,
                theme: AppThemes.light,
                // routes: {
                //   '/joinMeeting': (_) => JoinMeetingView(),
                //   '/meeting': (_) => const MeetingView(),
                // },
                darkTheme: AppTheme.darkTheme,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StartScreen extends StatefulWidget {
  const _StartScreen();

  @override
  State<_StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<_StartScreen> {
  bool _previewVisible = true;

  @override
  void initState() {
    super.initState();
    _checkVersion();

    Future.delayed(const Duration(seconds: 2)).then(
      (_) => setState(() => _previewVisible = false),
    );
  }

  Future<void> _checkVersion() async {}

  Widget _buildChild(BuildContext context) {
    final appState = context.watch<AppCubit>().state;

    return const AuthScreen();
    // return const OnboardingScreen();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    App.context = context;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _previewVisible ? SplashScreen.animated() : _buildChild(context),
    );
  }
}
