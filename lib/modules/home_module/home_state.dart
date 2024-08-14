class HomeState {
  final bool isLoading;
  final meetingTime;

  const HomeState({
    this.isLoading = false,
    this.meetingTime,
  });

  HomeState copyWith({bool? isLoading, meetingTime}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      meetingTime: meetingTime ?? this.meetingTime,
    );
  }
}
