// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class HttpClient {
//   static late Dio api;

//   static Future<void> init() async {
//     api = Dio();
//     api.options.baseUrl =
//         'https://develop:\$wissC0nnectI@mob.platform.opigno.cloud';

//     //TODO: check this code
//     // api.interceptors.add(ConnectionInterceptor(api));
//     // api.interceptors.add(UnauthorizedInterceptor());

//     if (kDebugMode) {
//       api.interceptors.add(
//         PrettyDioLogger(
//           error: true,
//           requestBody: true,
//           responseBody: true,
//         ),
//       );
//     }
//   }
// }
