import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:whereby_app/app.dart';
import 'dart:io' show Platform;

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyANuI9EPh3NAe9jzuimwaj1ud1lrao_CdU',
        appId: '1:620399691169:android:e75c65949a03b12ca7f7e0',
        messagingSenderId: '620399691169',
        projectId: 'wetalk2-server-test',
        storageBucket: 'wetalk2-server-test.appspot.com',
      ),
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp();
  }

  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize other services here if needed
  // await _requestPermission(); // For permissions if required

  runApp(const App());
}


// Future<void> _requestPermission() async {
//   PermissionStatus status = await Permission.microphone.request();
//   if (status.isDenied || status.isPermanentlyDenied) {
//     // Handle the case when the permission is denied
//     print('Microphone permission is required to proceed.');
//   } else if (status.isGranted) {
//     print('Microphone permission granted.');
//   }
// }
