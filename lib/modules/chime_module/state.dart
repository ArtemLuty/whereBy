import 'package:whereby_app/data_servise/data_model/card.dart';
import 'package:whereby_app/data_servise/data_model/weiting_room_data.dart';

class WaitingRoomState {
  final bool isLoading;
  final String? errorMessage;
  final String? logInUserId;
  final WaitingRoomData? data;
  final List<UserCard>? cards;
  final Map<String, dynamic>? meetingData;
  final Map<String, dynamic>? attendeeData;
  final bool readyForCall;
  final RoomDetail? userRoom;

  const WaitingRoomState(
      {this.isLoading = false,
      this.data,
      this.cards,
      this.logInUserId,
      this.errorMessage = '',
      this.meetingData,
      this.attendeeData,
      this.readyForCall = false,
      this.userRoom});

  WaitingRoomState copyWith({
    bool? isLoading,
    WaitingRoomData? data,
    List<UserCard>? cards,
    String? errorMessage,
    String? logInUserId,
    Map<String, dynamic>? meetingData,
    Map<String, dynamic>? attendeeData,
    bool? readyForCall,
    RoomDetail? userRoom,
  }) {
    return WaitingRoomState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      cards: cards ?? this.cards,
      logInUserId: logInUserId ?? this.logInUserId,
      meetingData: meetingData ?? this.meetingData,
      attendeeData: attendeeData ?? this.attendeeData,
      readyForCall: readyForCall ?? this.readyForCall,
      userRoom: userRoom ?? this.userRoom,
    );
  }
}
