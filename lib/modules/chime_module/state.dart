// class WaitingRoomState {
//   final bool isLoading;
//   final Map<String, dynamic>? data;
//   final String errorMessage;

//   const WaitingRoomState({
//     this.isLoading = false,
//     this.data,
//     this.errorMessage = '',
//   });

//   WaitingRoomState copyWith({
//     bool? isLoading,
//     Map<String, dynamic>? data,
//     String? errorMessage,
//   }) {
//     return WaitingRoomState(
//       isLoading: isLoading ?? this.isLoading,
//       data: data ?? this.data,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:whereby_app/data_servise/data_model/card.dart';
import 'package:whereby_app/data_servise/data_model/weiting_room_data.dart';

// class WaitingRoomState {
//   final bool isLoading;
//   final Map<String, dynamic>? data;
//   final List<UserCard>? cards; // Add cards property
//   final String errorMessage;

//   const WaitingRoomState({
//     this.isLoading = false,
//     this.data,
//     this.cards,
//     this.errorMessage = '',
//   });

//   WaitingRoomState copyWith({
//     bool? isLoading,
//     Map<String, dynamic>? data,
//     List<UserCard>? cards,
//     String? errorMessage,
//   }) {
//     return WaitingRoomState(
//       isLoading: isLoading ?? this.isLoading,
//       data: data ?? this.data,
//       cards: cards ?? this.cards,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }
// }
class WaitingRoomState {
  final bool isLoading;
  final String? errorMessage;
  final String? logInUserId;
  final WaitingRoomData? data;
  final List<UserCard>? cards;

  const WaitingRoomState({
    this.isLoading = false,
    this.data,
    this.cards,
    this.logInUserId,
    this.errorMessage = '',
  });

  WaitingRoomState copyWith(
      {bool? isLoading,
      WaitingRoomData? data,
      List<UserCard>? cards,
      String? errorMessage,
      String? logInUserId}) {
    return WaitingRoomState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      cards: cards ?? this.cards,
      logInUserId: logInUserId ?? logInUserId,
    );
  }
}
