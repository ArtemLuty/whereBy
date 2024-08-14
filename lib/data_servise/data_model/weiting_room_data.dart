class WaitingRoomData {
  final int waitingRoomUsers;
  final Map<String, UserSummary> users;
  final Map<String, UserDetail> waitingRoom;
  final List<RoomDetail> rooms;

  WaitingRoomData({
    required this.waitingRoomUsers,
    required this.users,
    required this.waitingRoom,
    required this.rooms,
  });

  factory WaitingRoomData.fromJson(Map<Object?, Object?> json) {
    var totalStatsMap = json['totalStats'] as Map<Object?, Object?>?;
    int waitingRoomUsers = totalStatsMap?['waitingRoomUsers'] as int? ?? 0;

    var usersMap = json['users'] as Map<Object?, Object?>?;
    var users = usersMap?.map((key, value) {
          return MapEntry(key as String,
              UserSummary.fromJson(value as Map<Object?, Object?>));
        }) ??
        {};

    var waitingRoomMap = json['waitingRoom'] as Map<Object?, Object?>?;
    var waitingRoom = waitingRoomMap?.map((key, value) {
          return MapEntry(key as String,
              UserDetail.fromJson(value as Map<Object?, Object?>));
        }) ??
        {};

    // Handle the rooms data
    var roomsList =
        (json['rooms'] as Map<Object?, Object?>?)?.values.map((value) {
              return RoomDetail.fromJson(value as Map<Object?, Object?>);
            }).toList() ??
            <RoomDetail>[];

    return WaitingRoomData(
      waitingRoomUsers: waitingRoomUsers,
      users: users,
      waitingRoom: waitingRoom,
      rooms: roomsList,
    );
  }
}

class UserSummary {
  final bool inWaitingRoom;

  UserSummary({
    required this.inWaitingRoom,
  });

  factory UserSummary.fromJson(Map<Object?, Object?> json) {
    return UserSummary(
      inWaitingRoom: json['inWaitingRoom'] as bool? ?? false,
    );
  }
}

class UserDetail {
  final String id;
  final String name;
  final String avatar;
  final String languageLevel;
  final int addedAt;

  UserDetail({
    required this.id,
    required this.name,
    required this.avatar,
    required this.languageLevel,
    required this.addedAt,
  });

  factory UserDetail.fromJson(Map<Object?, Object?> json) {
    return UserDetail(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      avatar: json['avatar'] as String? ?? '',
      languageLevel: json['languageLevel'] as String? ?? '',
      addedAt: json['addedAt'] as int? ?? 0,
    );
  }
}

class RoomDetail {
  final String nextCardLanguageLevel;
  final int cardsCounter;
  final Map<String, UserDetail> users;
  final String nextCardType;
  final String currentSpeakerId;
  final int cardChangedAt;
  final String cardType;
  final String cardLanguageLevel;
  final String cardId;
  final Map<String, String> lastUsedCardsByLanguageLevel;
  final int createdAt;
  final String nextCardId;

  RoomDetail({
    required this.nextCardLanguageLevel,
    required this.cardsCounter,
    required this.users,
    required this.nextCardType,
    required this.currentSpeakerId,
    required this.cardChangedAt,
    required this.cardType,
    required this.cardLanguageLevel,
    required this.cardId,
    required this.lastUsedCardsByLanguageLevel,
    required this.createdAt,
    required this.nextCardId,
  });

  factory RoomDetail.fromJson(Map<Object?, Object?> json) {
    var usersMap = json['users'] as Map<Object?, Object?>?;
    var users = usersMap?.map((key, value) {
          return MapEntry(key as String,
              UserDetail.fromJson(value as Map<Object?, Object?>));
        }) ??
        {};

    var lastUsedCardsMap =
        json['lastUsedCardsByLanguageLevel'] as Map<Object?, Object?>?;
    var lastUsedCards = lastUsedCardsMap?.map((key, value) {
          return MapEntry(key as String, value as String);
        }) ??
        {};

    return RoomDetail(
      nextCardLanguageLevel: json['nextCardLanguageLevel'] as String? ?? '',
      cardsCounter: json['cardsCounter'] as int? ?? 0,
      users: users,
      nextCardType: json['nextCardType'] as String? ?? '',
      currentSpeakerId: json['currentSpeakerId'] as String? ?? '',
      cardChangedAt: json['cardChangedAt'] as int? ?? 0,
      cardType: json['cardType'] as String? ?? '',
      cardLanguageLevel: json['cardLanguageLevel'] as String? ?? '',
      cardId: json['cardId'] as String? ?? '',
      lastUsedCardsByLanguageLevel: lastUsedCards,
      createdAt: json['createdAt'] as int? ?? 0,
      nextCardId: json['nextCardId'] as String? ?? '',
    );
  }
}
