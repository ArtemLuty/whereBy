import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:whereby_app/data_servise/data_model/firebase_user.dart';
import 'package:whereby_app/data_servise/data_model/firebase_waiting_room_user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final DatabaseReference _database = FirebaseDatabase.instance.ref();

// Future<void> signInAnonymously(FirebaseAuth auth) async {
//   await auth.signInAnonymously();
// }

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

    // Convert the raw data to a Map<String, dynamic>
    final data =
        rawData.map((key, value) => MapEntry(key as String, value as dynamic));

    return data;
  } else {
    throw Exception('No data found');
  }
}

void listenToUserRoomChanges(DatabaseReference database, String userId,
    Function(String) onRoomIdChange) {
  database.child('users/$userId/roomId').onValue.listen((event) {
    if (event.snapshot.value != null) {
      onRoomIdChange(event.snapshot.value as String);
    } else {
      onRoomIdChange('');
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
      onUserChange(FirebaseUser()); // Return an empty user if no data found
    }
  });
}

Future<void> addUserToWaitingRoom(
  DatabaseReference database,
  FirebaseWaitingRoomUser user,
) async {
  await database.child('waitingRoom/13083');
  // await database.child('waitingRoom/${user.id}').set(user.toMap());
}

// extension on FirebaseWaitingRoomUser {
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'addedAt': addedAt,
//       'online': online,
//     };
//   }
// }
