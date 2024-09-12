import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:whereby_app/data_servise/data_model/firebase_user.dart';
import 'package:whereby_app/modules/chime_module/cubit.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final DatabaseReference _database = FirebaseDatabase.instance.ref();

Future<void> signInAnonymously() async {
  try {
    await _auth.signInAnonymously();
  } catch (e) {
    print('Error signing in anonymously: $e');
  }
}

void listenToAuthStateChanges(Function(User?) onAuthStateChanged) {
  _auth.authStateChanges().listen((User? user) {
    onAuthStateChanged(user);
  });
}

User? getCurrentUser() {
  return _auth.currentUser;
}

Future<Map<String, dynamic>> fetchDataFromFirebase() async {
  DatabaseEvent event = await _database.child('/').once();
  if (event.snapshot.value != null) {
    final rawData = event.snapshot.value as Map<Object?, Object?>;
    final data =
        rawData.map((key, value) => MapEntry(key as String, value as dynamic));
    return data;
  } else {
    throw Exception('No data found');
  }
}

Future<void> updatePresenceStatus(
    String userToken, bool online, String logInUserId) async {
  try {
    final presenceStatus = online ? 'online' : 'offline';

    // Update presence in Firebase Realtime Database
    await FirebaseDatabase.instance.ref('users/$logInUserId').update({
      'presenceStatus': presenceStatus,
      'lastOnlineAt': online ? null : ServerValue.timestamp,
    });

    // Optionally update presence in waitingRoom
    await FirebaseDatabase.instance.ref('waitingRoom/$logInUserId').update({
      'presenceStatus': online ? 'online' : null,
    });

    print('Updated presence status to $presenceStatus for user $logInUserId');
  } catch (e) {
    print('Failed to update presence status: $e');
  }
}

void listenToPresenceStatus(String userId) {
  FirebaseDatabase.instance.ref('users/$userId').onValue.listen((event) {
    final data = event.snapshot.value as Map<dynamic, dynamic>?;
    if (data != null) {
      final presenceStatus = data['presenceStatus'] as String?;
      print('User $userId is $presenceStatus');
    }
  });
}

void listenToUserChanges(DatabaseReference database, String userId,
    Function(FirebaseUser) onUserChange) {
  database.child('users/$userId').onValue.listen((event) {
    if (event.snapshot.value != null) {
      FirebaseUser user = FirebaseUser.fromMap(
          Map<String, dynamic>.from(event.snapshot.value as Map));
      onUserChange(user);
    } else {
      onUserChange(FirebaseUser());
    }
  });
}

void listenToUserRoomChanges(
    DatabaseReference database, String userId, WaitingRoomCubit cubit) {
  database.child('users/$userId/roomId').onValue.listen((event) {
    if (event.snapshot.value != null && event.snapshot.value is String) {
      String roomId = event.snapshot.value as String;
      print('Room ID changed to: $roomId');
      cubit.onRoomIdChange(roomId);
    } else {
      cubit.onRoomIdNull();
    }
  });
}

void listenToCardIdChanges(DatabaseReference database, String roomId,
    Function(String) onCardIdChange) {
  String? previousCardId;

  database.child('rooms/$roomId/cardId').onValue.listen((event) {
    if (event.snapshot.value != null) {
      String newCardId = event.snapshot.value as String;

      if (previousCardId != newCardId) {
        previousCardId = newCardId;
        onCardIdChange(newCardId);
      }
    }
  });
}
