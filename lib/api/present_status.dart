import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class PresenceManager {
  final String userId;
  final DatabaseReference _usersRef = FirebaseDatabase.instance.ref('users');
  final DatabaseReference _waitingRoomRef =
      FirebaseDatabase.instance.ref('waitingRoom');
  late final StreamSubscription<DatabaseEvent> _connectionSubscription;

  PresenceManager(this.userId);

  Future<void> initialize() async {
    // Set the user's presence status when the app starts
    await _setPresenceStatus('online');

    // Listen to connectivity changes
    _connectionSubscription = FirebaseDatabase.instance
        .ref('.info/connected')
        .onValue
        .listen((event) {
      if (event.snapshot.value == true) {
        // User is connected
        _setPresenceStatus('online');
      } else {
        // User is disconnected
        _setPresenceStatus('offline');
      }
    });
  }

  Future<void> _setPresenceStatus(String status) async {
    final currentTime = DateTime.now().toIso8601String();

    // Update the user's presence status in both locations
    await _usersRef.child(userId).update({
      'presenceStatus': status,
      'lastOnlineAt': status == 'offline' ? currentTime : null,
    });

    await _waitingRoomRef.child(userId).update({
      'presenceStatus': status == 'offline' ? null : status,
    });
  }

  Future<void> dispose() async {
    // Set the user's presence status to 'offline' when the app is disposed
    await _setPresenceStatus('offline');
    await _connectionSubscription.cancel();
  }
}
