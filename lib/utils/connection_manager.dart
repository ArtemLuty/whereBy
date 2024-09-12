// import 'dart:io';

// class ConnectionManager {
//   static Future<bool> checkConnection() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       final hasConnection =
//           result.isNotEmpty && result[0].rawAddress.isNotEmpty;

//       return hasConnection;
//     } on SocketException catch (_) {
//       return false;
//     }
//   }
// }
