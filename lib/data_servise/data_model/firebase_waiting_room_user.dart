class FirebaseWaitingRoomUser {
  String id;
  String name;
  int addedAt;
  bool? online;

  FirebaseWaitingRoomUser(
      {required this.id,
      required this.name,
      required this.addedAt,
      this.online});

  factory FirebaseWaitingRoomUser.fromMap(Map<String, dynamic> data) {
    return FirebaseWaitingRoomUser(
      id: data['id'],
      name: data['name'],
      addedAt: data['addedAt'],
      online: data['online'],
    );
  }
}
