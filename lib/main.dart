import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:whereby_app/app.dart';

// Future<void> main() async {
//   final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   await Firebase.initializeApp();
//   // Initialize Firebase
//   // await Firebase.initializeApp(
//   //   options: FirebaseOptions(
//   //     apiKey: 'AIzaSyANuI9EPh3NAe9jzuimwaj1ud1lrao_CdU',
//   //     appId: '1:620399691169:android:e75c65949a03b12ca7f7e0',
//   //     messagingSenderId: '620399691169',
//   //     projectId: 'wetalk2-server-test',
//   //     storageBucket: 'wetalk2-server-test.appspot.com',
//   //   ),
//   // );

//   await EasyLocalization.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   HydratedBloc.storage = await HydratedStorage.build(
//       storageDirectory: await getApplicationDocumentsDirectory());
//   runApp(const App());
// }
// import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();

  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // HydratedBloc.storage = await HydratedStorage.build(
  //     storageDirectory: await getApplicationDocumentsDirectory());

  // Request microphone permission
  // await _requestPermission();

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
