class FirebaseUser {
  String? roomId;
  bool? online;
  int? lastOnlineAt;
  int? matchedRoomAt;
  String? attendeeId;
  String? meetingId;

  FirebaseUser(
      {this.roomId,
      this.online,
      this.lastOnlineAt,
      this.matchedRoomAt,
      this.attendeeId,
      this.meetingId});

  factory FirebaseUser.fromMap(Map<String, dynamic> data) {
    return FirebaseUser(
      roomId: data['roomId'],
      online: data['online'],
      lastOnlineAt: data['lastOnlineAt'],
      matchedRoomAt: data['matchedRoomAt'],
      attendeeId: data['attendeeId'],
      meetingId: data['meetingId'],
    );
  }
}
